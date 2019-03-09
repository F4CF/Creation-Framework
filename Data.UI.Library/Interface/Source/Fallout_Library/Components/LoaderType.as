package Components
{
	import F4SE.Extensions;
	import F4SE.ICodeObject;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import System.Diagnostics.Debug;
	import System.IO.File;
	import System.IO.FileSystem;
	import System.IO.Path;

	/**
	 * The Loader class is used to load SWF & DDS files.
	 * TODO: Check `MenuName` for nulls.
	 * @see https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/Loader.html
	 * @see https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/net/URLRequest.html
	 */
	public dynamic class LoaderType extends MovieClip implements F4SE.ICodeObject
	{
		// F4SE
		protected var XSE:*;

		// Loader
		private var Ready:Boolean;
		private var MenuName:String;
		private var MountID:String;

		// Files
		private var Value:String;
		public function get FilePath():String { return Value; }

		private var Request:URLRequest;
		public function get Requested():String { return Request.url; }

		// Loader
		private var ContentLoader:Loader;
		protected function get Content():DisplayObject { return ContentLoader.content; }

		// Events
		public static const CODEOBJECT_READY:String = "CodeObject_Ready";
		public static const LOAD_ERROR:String = "Load_Error";
		public static const LOAD_COMPLETE:String = "Load_Complete";


		// Initialize
		//---------------------------------------------

		public function LoaderType(menuName:String, mountID:String)
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, this.OnAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.OnRemovedFromStage);
			Ready = false;
			MenuName = menuName;
			MountID = mountID;
			Request = new URLRequest();
			ContentLoader = new Loader();
			ContentLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.OnLoadComplete);
			ContentLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.OnLoadError);
		}


		// @F4SE.ICodeObject
		public function onF4SEObjCreated(codeObject:*):void
		{
			if (codeObject != null)
			{
				XSE = codeObject;
				Debug.WriteLine("[Components.LoaderType]", "(onF4SEObjCreated)", "Received the F4SE code object.");
				this.dispatchEvent(new Event(CODEOBJECT_READY));
			}
			else
			{
				Debug.WriteLine("[Components.LoaderType]", "(onF4SEObjCreated)", "The F4SE object was null.");
			}
		}


		// Events
		//---------------------------------------------

		protected function OnAddedToStage(e:Event):void
		{
			this.addChild(ContentLoader);
		}


		protected function OnRemovedFromStage(e:Event):void
		{
			Unload();
			this.removeChild(ContentLoader);
		}


		protected function OnLoadComplete(e:Event):void
		{
			Debug.WriteLine("[Components.LoaderType]", "(OnLoadComplete)", "FilePath:"+FilePath);
			this.dispatchEvent(new Event(LOAD_COMPLETE));
		}


		protected function OnLoadError(e:IOErrorEvent):void
		{
			Debug.WriteLine("[Components.LoaderType]", "(OnLoadError)", "FilePath:"+FilePath, e.toString());
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
				if (extension == File.SWF && File.ExistsIn(XSE, FileSystem.Interface, filepath))
				{
					Request.url = filepath;
				}
				else if (extension == File.DDS && File.ExistsIn(XSE, FileSystem.Textures, filepath))
				{
					if (MountID != null)
					{
						Mount(filepath);
						Request.url = FileSystem.ImageProtocol+MountID;
					}
					else
					{
						Debug.WriteLine("[Components.LoaderType]", "(Load)", "The mount ID cannot be null.", "filepath:"+filepath);
						return false;
					}
				}
				else
				{
					Debug.WriteLine("[Components.LoaderType]", "(Load)", "The file doesnt not exist or is not supported.", "filepath:"+filepath);
					return false;
				}

				var success:Boolean = true;
				try
				{
					Value = filepath;
					ContentLoader.load(Request);
				}
				catch (error:Error)
				{
					Debug.WriteLine("[Components.LoaderType]", "(Load)", "Error:", error.toString());
					success = false;
				}
				return success;
			}
			else
			{
				Debug.WriteLine("[Components.LoaderType]", "(Load)", "The filepath cannot be null.");
				return false;
			}
		}


		protected function Mount(filepath:String):Boolean
		{
			if (File.ExistsIn(XSE, FileSystem.Textures, filepath))
			{
				Debug.WriteLine("[Components.LoaderType]", "(Mount)", "filepath:"+filepath, "MountID: "+MountID);
				Unmount(filepath);
				F4SE.Extensions.MountImage(XSE, MenuName, filepath, MountID);
				return true;
			}
			else
			{
				Debug.WriteLine("[Components.LoaderType]", "(Mount)", "File does not exist. '"+filepath+"'.");
				return false;
			}
		}


		/**
		 * Removes a child of this Loader object that was loaded by using the load() method.
		 */
		public function Unload():Boolean
		{
			if (!Ready) { return false; }
			ContentLoader.close();

			if (FilePath != null)
			{
				Unmount(FilePath);
				var success:Boolean = true;
				try
				{
					if (Path.GetExtension(FilePath) == File.SWF)
					{
						ContentLoader.unloadAndStop();
					}
					else
					{
						ContentLoader.unload();
					}
				}
				catch (error:Error)
				{
					Debug.WriteLine("[Components.LoaderType]", "(Unload)", "Error:", error.toString());
					success = false;
				}

				if (success)
				{
					Debug.WriteLine("[Components.LoaderType]", "(Unload)", "Unloaded content from loader.");
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
					F4SE.Extensions.UnmountImage(XSE, MenuName, filepath);
					Debug.WriteLine("[Components.LoaderType]", "(Unmount)", "Unmounted the texture '"+filepath+"' from "+MenuName);
					return true;
				}
				else
				{
					Debug.WriteLine("[Components.LoaderType]", "(Unmount)", "Only DDS texture files may be unmounted. '"+filepath+"'");
					return false;
				}
			}
			else
			{
				Debug.WriteLine("[Components.LoaderType]", "(Unmount)", "Cannot unmount a null filepath.");
				return false;
			}
		}


		public override function toString():String
		{
			var sResolution = "Resolution: "+stage.width+"x"+stage.height+" ("+this.x+"x"+this.y+")";
			return sResolution+", "+"Requested: '"+Requested+"', FilePath:'"+FilePath+"'";
		}


	}
}
