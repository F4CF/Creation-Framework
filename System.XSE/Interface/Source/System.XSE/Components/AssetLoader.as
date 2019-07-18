package Components
{
	import F4SE.XSE;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import System.Diagnostics.Debug;
	import System.Display;
	import System.IO.File;
	import System.IO.FileSystem;
	import System.IO.Path;

	/**
	 * This class is used to load SWF & DDS files.
	 * The files must be loose (unarchived) or they will not be detected by FileSystem.
	 * @see https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/Loader.html
	 * @see https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/net/URLRequest.html
	 */
	public dynamic class AssetLoader extends MovieClip
	{
		// Loader
		private var Ready:Boolean;
		private var MenuName:String;
		private var MountID:String;

		private var Asset:Loader;
		protected function get Content():DisplayObject { return Asset.content; }

		// Files
		private var Value:String;
		public function get FilePath():String { return Value; }

		private var Request:URLRequest;
		public function get Requested():String { return Request.url; }

		// Events
		public static const LOAD_ERROR:String = "Load_Error";
		public static const LOAD_COMPLETE:String = "Load_Complete";


		// Initialize
		//---------------------------------------------

		public function AssetLoader(menuName:String, mountID:String)
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, this.OnAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.OnRemovedFromStage);
			if (menuName == null)
			{
				throw new Error("[Components.AssetLoader] (ctor) The parameter 'menuName' cannot be null.");
			}
			else if (mountID == null)
			{
				throw new Error("[Components.AssetLoader] (ctor) The parameter 'mountID' cannot be null.");
			}
			else
			{
				MenuName = menuName;
				MountID = mountID;
				Ready = false;
				Request = new URLRequest();
				Asset = new Loader();
				Asset.contentLoaderInfo.addEventListener(Event.COMPLETE, this.OnLoadComplete);
				Asset.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.OnLoadError);
			}
		}


		// Events
		//---------------------------------------------

		protected function OnAddedToStage(e:Event):void
		{
			this.addChild(Asset);
		}


		protected function OnRemovedFromStage(e:Event):void
		{
			Unload();
			this.removeChild(Asset);
		}


		protected function OnLoadComplete(e:Event):void
		{
			Debug.WriteLine("[Components.AssetLoader]", "(OnLoadComplete)", "FilePath:"+FilePath);
			this.dispatchEvent(new Event(LOAD_COMPLETE));
		}


		protected function OnLoadError(e:IOErrorEvent):void
		{
			Debug.WriteLine("[Components.AssetLoader]", "(OnLoadError)", "FilePath:"+FilePath, e.toString());
			Unload();
			this.dispatchEvent(new Event(LOAD_ERROR));
		}


		// Methods
		//---------------------------------------------

		/**
		 * The absolute or relative path of the SWF or DDS file to be loaded.
		 * A relative path must be relative to the main SWF file. Filenames cannot include disk drive specifications.
		 * @see https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/Loader.html#load()
		 */
		public function Load(filepath:String):Boolean
		{
			if (!Ready) { Ready = true; }
			Unload();

			if (filepath != null)
			{
				var extension:String = Path.GetExtension(filepath);
				if (extension == File.SWF && File.ExistsIn(FileSystem.Interface, filepath))
				{
					Request.url = filepath;
				}
				else if (extension == File.DDS && File.ExistsIn(FileSystem.Textures, filepath))
				{
					if (MountID != null)
					{
						Mount(filepath);
						Request.url = FileSystem.ImageProtocol+MountID;
					}
					else
					{
						Debug.WriteLine("[Components.AssetLoader]", "(Load)", "The mount ID cannot be null.", "filepath:"+filepath);
						return false;
					}
				}
				else
				{
					Debug.WriteLine("[Components.AssetLoader]", "(Load)", "The file doesnt not exist or is not supported.", "filepath:"+filepath);
					return false;
				}

				var success:Boolean = true;
				try
				{
					Value = filepath;
					Asset.load(Request);
				}
				catch (error:Error)
				{
					Debug.WriteLine("[Components.AssetLoader]", "(Load)", "Error:", error.toString());
					success = false;
				}
				return success;
			}
			else
			{
				Debug.WriteLine("[Components.AssetLoader]", "(Load)", "The filepath cannot be null.");
				return false;
			}
		}


		protected function Mount(filepath:String):Boolean
		{
			if (File.ExistsIn(FileSystem.Textures, filepath))
			{
				Debug.WriteLine("[Components.AssetLoader]", "(Mount)", "filepath:"+filepath, "MountID: "+MountID);
				Unmount(filepath);
				F4SE.XSE.MountImage(MenuName, filepath, MountID);
				return true;
			}
			else
			{
				Debug.WriteLine("[Components.AssetLoader]", "(Mount)", "File does not exist. '"+filepath+"'.");
				return false;
			}
		}


		/**
		 * Removes a child of this Loader object that was loaded by using the load() method.
		 */
		public function Unload():Boolean
		{
			if (!Ready) { return false; }
			Asset.close();

			if (FilePath != null)
			{
				Unmount(FilePath);
				var success:Boolean = true;
				try
				{
					if (Path.GetExtension(FilePath) == File.SWF)
					{
						Asset.unloadAndStop();
					}
					else
					{
						Asset.unload();
					}
				}
				catch (error:Error)
				{
					Debug.WriteLine("[Components.AssetLoader]", "(Unload)", "Error:", error.toString());
					success = false;
				}

				if (success)
				{
					Debug.WriteLine("[Components.AssetLoader]", "(Unload)", "Unloaded content from loader.");
					Value = null;
				}
				return success;
			}
			else
			{
				return false;
			}
		}


		protected function Unmount(filepath:String):Boolean
		{
			if (filepath != null)
			{
				if (Path.GetExtension(filepath) == File.DDS)
				{
					F4SE.XSE.UnmountImage(MenuName, filepath);
					Debug.WriteLine("[Components.AssetLoader]", "(Unmount)", "Unmounted the texture '"+filepath+"' from "+MenuName);
					return true;
				}
				else
				{
					Debug.WriteLine("[Components.AssetLoader]", "(Unmount)", "Only DDS texture files may be unmounted. '"+filepath+"'");
					return false;
				}
			}
			else
			{
				Debug.WriteLine("[Components.AssetLoader]", "(Unmount)", "Cannot unmount a null filepath.");
				return false;
			}
		}


		public function GetInstance():String
		{
			if (Content)
			{
				return Display.GetInstanceFrom(Content, this);
			}
			else
			{
				return null;
			}
		}


		public override function toString():String
		{
			var sResolution = "Resolution: "+stage.width+"x"+stage.height+" ("+this.x+"x"+this.y+")";
			return sResolution+", "+"Requested: '"+Requested+"', FilePath:'"+FilePath+"'";
		}


	}
}
