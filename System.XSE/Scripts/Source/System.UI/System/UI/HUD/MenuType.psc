ScriptName System:UI:HUD:MenuType Extends System:UI:MenuType Native Const Hidden

; Properties
;---------------------------------------------

Group Root
	string Property TopCenterGroup Hidden
		string Function Get()
			return Root+".TopCenterGroup_mc"
		EndFunction
	EndProperty
	string Property TopRightGroup Hidden
		string Function Get()
			return Root+".TopRightGroup_mc"
		EndFunction
	EndProperty
	string Property CenterGroup Hidden
		string Function Get()
			return Root+".CenterGroup_mc"
		EndFunction
	EndProperty
	string Property LeftMeters Hidden
		string Function Get()
			return Root+".LeftMeters_mc"
		EndFunction
	EndProperty
	string Property BottomCenterGroup Hidden
		string Function Get()
			return Root+".BottomCenterGroup_mc"
		EndFunction
	EndProperty
	string Property RightMeters Hidden
		string Function Get()
			return Root+".RightMeters_mc"
		EndFunction
	EndProperty
	string Property BGSCodeObj Hidden
		string Function Get()
			return Root+".BGSCodeObj"
		EndFunction
	EndProperty
EndGroup

Group EnemyHealthMeter
	string Property EnemyHealthMeter Hidden
		string Function Get()
			return TopCenterGroup+".EnemyHealthMeter_mc"
		EndFunction
	EndProperty
	string Property EnemyHealthMeterLegendaryIcon Hidden
		string Function Get()
			return EnemyHealthMeter+".LegendaryIcon_mc"
		EndFunction
	EndProperty
	string Property EnemyHealthMeterSkullIcon Hidden
		string Function Get()
			return EnemyHealthMeter+".SkullIcon_mc"
		EndFunction
	EndProperty
	string Property EnemyHealthMeterDisplayText Hidden
		string Function Get()
			return EnemyHealthMeter+".DisplayText_tf"
		EndFunction
	EndProperty
	string Property EnemyHealthMeterBracket Hidden
		string Function Get()
			return EnemyHealthMeter+".Bracket_mc"
		EndFunction
	EndProperty
	string Property EnemyHealthMeterBar Hidden
		string Function Get()
			return EnemyHealthMeter+".MeterBar_mc"
		EndFunction
	EndProperty
	string Property EnemyHealthMeterOptional Hidden
		string Function Get()
			return EnemyHealthMeter+".Optional_mc"
		EndFunction
	EndProperty
EndGroup

Group StealthMeter
	string Property StealthMeter Hidden
		string Function Get()
			return TopCenterGroup+".StealthMeter_mc"
		EndFunction
	EndProperty
	string Property StealthMeterBracketLeft Hidden
		string Function Get()
			return StealthMeter+".BracketLeftInstance"
		EndFunction
	EndProperty
	string Property StealthMeterBracketRight Hidden
		string Function Get()
			return StealthMeter+".BracketRightInstance"
		EndFunction
	EndProperty
	string Property StealthMeterText Hidden
		string Function Get()
			return StealthMeter+".StealthTextInstance"
		EndFunction
	EndProperty
EndGroup

Group VaultBoyCondition
	string Property VaultBoyCondition Hidden
		string Function Get()
			return TopRightGroup+".VaultBoyCondition_mc"
		EndFunction
	EndProperty

	string Property ConditionBoy Hidden
		string Function Get()
			return VaultBoyCondition+".ConditionBoy_mc"
		EndFunction
	EndProperty
EndGroup

Group CenterGroup
	string Property RolloverWidget Hidden
		string Function Get()
			return CenterGroup+".RolloverWidget_mc"
		EndFunction
	EndProperty
	string Property HitIndicator Hidden
		string Function Get()
			return CenterGroup+".HitIndicator_mc"
		EndFunction
	EndProperty
	string Property DirectionalHitIndicatorBase Hidden
		string Function Get()
			return CenterGroup+".DirectionalHitIndicatorBase_mc"
		EndFunction
	EndProperty
	string Property ExplosiveIndicatorBase Hidden
		string Function Get()
			return CenterGroup+".ExplosiveIndicatorBase_mc"
		EndFunction
	EndProperty
	string Property HUDCrosshair Hidden
		string Function Get()
			return CenterGroup+".HUDCrosshair_mc"
		EndFunction
	EndProperty
	string Property QuickContainerWidget Hidden
		string Function Get()
			return CenterGroup+".QuickContainerWidget_mc"
		EndFunction
	EndProperty
EndGroup

Group RegionLocation
	string Property RegionLocation Hidden
		string Function Get()
			return LeftMeters+".LocationText_mc"
		EndFunction
	EndProperty
	string Property RegionLocationText Hidden
		string Function Get()
			return RegionLocation+".RegionText"
		EndFunction
	EndProperty
EndGroup

Group RadsMeter
	string Property RadsMeter Hidden
		string Function Get()
			return LeftMeters+".RadsMeter_mc"
		EndFunction
	EndProperty
	string Property RadsMeterNumber Hidden
		string Function Get()
			return RadsMeter+".RadsNumber_tf"
		EndFunction
	EndProperty
	string Property RadsMeterText Hidden
		string Function Get()
			return RadsMeter+".RADS_tf"
		EndFunction
	EndProperty
	string Property RadsMeterIcon Hidden
		string Function Get()
			return RadsMeter+".RadsIcon_mc"
		EndFunction
	EndProperty
EndGroup

Group HPMeter
	string Property HPMeter Hidden
		string Function Get()
			return LeftMeters+".HPMeter_mc"
		EndFunction
	EndProperty
	string Property HPMeterBracket Hidden
		string Function Get()
			return HPMeter+".Bracket_mc"
		EndFunction
	EndProperty
	string Property HPMeterDisplayText Hidden
		string Function Get()
			return HPMeter+".DisplayText_tf"
		EndFunction
	EndProperty
	string Property HPMeterRadsBar Hidden
		string Function Get()
			return HPMeter+".RadsBar_mc"
		EndFunction
	EndProperty
	string Property HPMeterBar Hidden
		string Function Get()
			return HPMeter+".MeterBar_mc"
		EndFunction
	EndProperty
	string Property HPMeterOptional Hidden
		string Function Get()
			return HPMeter+".Optional_mc"
		EndFunction
	EndProperty
EndGroup

Group Subtitle
	string Property Subtitle Hidden
		string Function Get()
			return BottomCenterGroup+".SubtitleText_mc"
		EndFunction
	EndProperty
	string Property SubtitleSpeakerName Hidden
		string Function Get()
			return Subtitle+".SpeakerName_tf"
		EndFunction
	EndProperty
	string Property SubtitleText Hidden
		string Function Get()
			return Subtitle+".SubtitleText_tf"
		EndFunction
	EndProperty
EndGroup

Group PerkVaultBoy
	string Property PerkVaultBoy Hidden
		string Function Get()
			return BottomCenterGroup+".PerkVaultBoy_mc"
		EndFunction
	EndProperty
EndGroup

Group CritMeter
	string Property CritMeter Hidden
		string Function Get()
			return BottomCenterGroup+".CritMeter_mc"
		EndFunction
	EndProperty
	string Property CritMeterDisplayText Hidden
		string Function Get()
			return CritMeter+".DisplayText_tf"
		EndFunction
	EndProperty
	string Property CritMeterBracket Hidden
		string Function Get()
			return CritMeter+".Bracket_mc"
		EndFunction
	EndProperty
	string Property CritMeterBar Hidden
		string Function Get()
			return CritMeter+".MeterBar_mc"
		EndFunction
	EndProperty
	string Property CritMeterStars Hidden
		string Function Get()
			return CritMeter+".CritMeterStars_mc"
		EndFunction
	EndProperty
EndGroup

Group CompassWidget
	string Property CompassWidget Hidden
		string Function Get()
			return BottomCenterGroup+".CompassWidget_mc"
		EndFunction
	EndProperty
	string Property CompassWidgetBar Hidden
		string Function Get()
			return CompassWidget+".CompassBar_mc"
		EndFunction
	EndProperty
	string Property CompassWidgetQuestMask Hidden
		string Function Get()
			return CompassWidget+".QuestMask_mc"
		EndFunction
	EndProperty
	string Property CompassWidgetQuestMarkers Hidden
		string Function Get()
			return CompassWidget+".QuestMarkerHolder_mc"
		EndFunction
	EndProperty
	string Property CompassWidgetOtherMask Hidden
		string Function Get()
			return CompassWidget+".OtherMask_mc"
		EndFunction
	EndProperty
	string Property CompassWidgetOtherMarkers Hidden
		string Function Get()
			return CompassWidget+".OtherMarkerHolder_mc"
		EndFunction
	EndProperty
	string Property CompassWidgetBGHolder Hidden
		string Function Get()
			return CompassWidget+".CompassBGHolder_mc"
		EndFunction
	EndProperty
EndGroup

Group PowerArmorLowBatteryWarning
	string Property PowerArmorLowBatteryWarning Hidden
		string Function Get()
			return RightMeters+".PowerArmorLowBatteryWarning_mc"
		EndFunction
	EndProperty
	string Property PowerArmorLowBatteryWarningTextHolder Hidden
		string Function Get()
			return PowerArmorLowBatteryWarning+".WarningTextHolder_mc"
		EndFunction
	EndProperty
	string Property PowerArmorLowBatteryWarningText Hidden
		string Function Get()
			return PowerArmorLowBatteryWarning+".PowerArmorLowBatteryWarning_tf"
		EndFunction
	EndProperty
EndGroup

Group ExplosiveWidget
	string Property ExplosiveWidget Hidden
		string Function Get()
			return RightMeters+".ExplosiveAmmoCount_mc"
		EndFunction
	EndProperty
	string Property ExplosiveWidgetAvailableCountText Hidden
		string Function Get()
			return ExplosiveWidget+".AvailableCount_tf"
		EndFunction
	EndProperty
	string Property ExplosiveWidgetTypeIcon Hidden
		string Function Get()
			return ExplosiveWidget+".TypeIcon_mc"
		EndFunction
	EndProperty
EndGroup

Group FlashLightWidget
	string Property FlashLightWidget Hidden
		string Function Get()
			return RightMeters+".FlashLightWidget_mc"
		EndFunction
	EndProperty
EndGroup

Group AmmoWidget
	string Property AmmoWidget Hidden
		string Function Get()
			return RightMeters+".AmmoCount_mc"
		EndFunction
	EndProperty
	string Property AmmoWidgetLine Hidden
		string Function Get()
			return AmmoWidget+".AmmoLineInstance"
		EndFunction
	EndProperty
	string Property AmmoWidgetClipCount Hidden
		string Function Get()
			return AmmoWidget+".ClipCount_tf"
		EndFunction
	EndProperty
	string Property AmmoWidgetReserveCount Hidden
		string Function Get()
			return AmmoWidget+".ReserveCount_tf"
		EndFunction
	EndProperty
EndGroup

Group FatigueWidget
	string Property FatigueWidget Hidden
		string Function Get()
			return RightMeters+".FatigueWarning_mc"
		EndFunction
	EndProperty
	string Property FatigueWidgetWarningText Hidden
		string Function Get()
			return FatigueWidget+".FatigueWarning_tf"
		EndFunction
	EndProperty
	string Property FatigueWidgetHead Hidden
		string Function Get()
			return FatigueWidget+".FatigueHead_mc"
		EndFunction
	EndProperty
EndGroup

Group ActionPointMeter
	string Property ActionPointMeter Hidden
		string Function Get()
			return RightMeters+".ActionPointMeter_mc"
		EndFunction
	EndProperty
	string Property ActionPointMeterBracket Hidden
		string Function Get()
			return ActionPointMeter+".Bracket_mc"
		EndFunction
	EndProperty
	string Property ActionPointSegments Hidden
		string Function Get()
			return ActionPointMeter+".ActionPointSegments_mc"
		EndFunction
	EndProperty
	string Property ActionPointDisplayText Hidden
		string Function Get()
			return ActionPointMeter+".DisplayText_tf"
		EndFunction
	EndProperty
	string Property ActionPointMeterBar Hidden
		string Function Get()
			return ActionPointMeter+".MeterBar_mc"
		EndFunction
	EndProperty
	string Property ActionPointMeterOptional Hidden
		string Function Get()
			return ActionPointMeter+".Optional_mc"
		EndFunction
	EndProperty
EndGroup

Group ActiveEffectsWidget
	string Property ActiveEffectsWidget Hidden
		string Function Get()
			return RightMeters+".HUDActiveEffectsWidget_mc"
		EndFunction
	EndProperty
EndGroup
