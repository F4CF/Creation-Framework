ScriptName System:Havok:Actors:Raider:Behaviors:DialogueBehavior Extends Quest Native
{Actors\Character\Behaviors\DialogueBehavior.xml}


Group Events
	string Property idleStop = "idleStop" AutoReadOnly Hidden
	string Property dlg_listen = "dlg_listen" AutoReadOnly Hidden
	string Property dlg_talk = "dlg_talk" AutoReadOnly Hidden
	string Property PickNewIdle = "PickNewIdle" AutoReadOnly Hidden
	string Property dlg_positive = "dlg_positive" AutoReadOnly Hidden
	string Property dlg_neutral = "dlg_neutral" AutoReadOnly Hidden
	string Property dlg_question = "dlg_question" AutoReadOnly Hidden
	string Property dlg_negative = "dlg_negative" AutoReadOnly Hidden
	string Property g_archetypeDialogueStateStart = "g_archetypeDialogueStateStart" AutoReadOnly Hidden
	string Property HeadTrackingOff = "HeadTrackingOff" AutoReadOnly Hidden
	string Property HeadTrackingOn = "HeadTrackingOn" AutoReadOnly Hidden
	string Property dyn_Talk = "dyn_Talk" AutoReadOnly Hidden
	string Property Pose_to_PoseB = "Pose_to_PoseB" AutoReadOnly Hidden
	string Property to_PoseA = "to_PoseA" AutoReadOnly Hidden
	string Property to_PoseB = "to_PoseB" AutoReadOnly Hidden
	string Property __00NextClip = "00NextClip" AutoReadOnly Hidden
	string Property Pose_to_PoseA = "Pose_to_PoseA" AutoReadOnly Hidden
	string Property SoundPlay = "SoundPlay" AutoReadOnly Hidden
	string Property SoundStop = "SoundStop" AutoReadOnly Hidden
	string Property dyn_DoNotInterrupt = "dyn_DoNotInterrupt" AutoReadOnly Hidden
	string Property countDownTick = "countDownTick" AutoReadOnly Hidden
	string Property dyn_Flavor = "dyn_Flavor" AutoReadOnly Hidden
	string Property IdleFlavor = "IdleFlavor" AutoReadOnly Hidden
	string Property _EventForSelfTransition = "_EventForSelfTransition" AutoReadOnly Hidden
	string Property startSyncIdle00 = "startSyncIdle00" AutoReadOnly Hidden
	string Property AnimObjUnequip = "AnimObjUnequip" AutoReadOnly Hidden
	string Property startSyncIdle01 = "startSyncIdle01" AutoReadOnly Hidden
	string Property syncIdleStart = "syncIdleStart" AutoReadOnly Hidden
	string Property syncIdleStop = "syncIdleStop" AutoReadOnly Hidden
	string Property idleStopEating = "idleStopEating" AutoReadOnly Hidden
	string Property FurnitureDoneEating = "FurnitureDoneEating" AutoReadOnly Hidden
	string Property idleTalkAndUseItem = "idleTalkAndUseItem" AutoReadOnly Hidden
	string Property FurnitureTalkingToEatIdles = "FurnitureTalkingToEatIdles" AutoReadOnly Hidden
	string Property idleEatStart = "idleEatStart" AutoReadOnly Hidden
	string Property FurnitureNextClip = "FurnitureNextClip" AutoReadOnly Hidden
	string Property SyncLeft = "SyncLeft" AutoReadOnly Hidden
	string Property AnimObjLoad = "AnimObjLoad" AutoReadOnly Hidden
	string Property SyncRight = "SyncRight" AutoReadOnly Hidden
	string Property SyncCycleEnd = "SyncCycleEnd" AutoReadOnly Hidden
	string Property AnimObjDraw = "AnimObjDraw" AutoReadOnly Hidden
	string Property ExitDynamicTalk = "ExitDynamicTalk" AutoReadOnly Hidden
	string Property CharFXOff = "CharFXOff" AutoReadOnly Hidden
	string Property CharFXOn = "CharFXOn" AutoReadOnly Hidden
	string Property fillingRed = "fillingRed" AutoReadOnly Hidden
	string Property FaceEmotion = "FaceEmotion" AutoReadOnly Hidden
	string Property CharFXOffWild = "CharFXOffWild" AutoReadOnly Hidden
	string Property weaponAssemblyFull = "weaponAssemblyFull" AutoReadOnly Hidden
	string Property weaponAssemblyPartial = "weaponAssemblyPartial" AutoReadOnly Hidden
	string Property DefaultRefPose = "DefaultRefPose" AutoReadOnly Hidden
	string Property DynamicRefPose = "DynamicRefPose" AutoReadOnly Hidden
	string Property Flavor1 = "Flavor1" AutoReadOnly Hidden
	string Property ReevaluateGraphState = "ReevaluateGraphState" AutoReadOnly Hidden
	string Property dyn_NoInterrupt_Manual = "dyn_NoInterrupt_Manual" AutoReadOnly Hidden
	string Property InstantExitClip = "InstantExitClip" AutoReadOnly Hidden
	string Property exhale = "exhale" AutoReadOnly Hidden
	string Property cigOn = "cigOn" AutoReadOnly Hidden
	string Property cigLight = "cigLight" AutoReadOnly Hidden
	string Property cigDrag = "cigDrag" AutoReadOnly Hidden
	string Property cigOff = "cigOff" AutoReadOnly Hidden
	string Property matOn = "matOn" AutoReadOnly Hidden
	string Property matStrike = "matStrike" AutoReadOnly Hidden
	string Property matOff = "matOff" AutoReadOnly Hidden
	string Property LeftHandIKActivate = "LeftHandIKActivate" AutoReadOnly Hidden
	string Property LeftHandIKDeactivate = "LeftHandIKDeactivate" AutoReadOnly Hidden
	string Property dyn_talkGeneric = "dyn_talkGeneric" AutoReadOnly Hidden
	string Property FootLeft = "FootLeft" AutoReadOnly Hidden
	string Property FootRight = "FootRight" AutoReadOnly Hidden
	string Property Play01 = "Play01" AutoReadOnly Hidden
	string Property CharFXBurstA = "CharFXBurstA" AutoReadOnly Hidden
	string Property StartVoice = "StartVoice" AutoReadOnly Hidden
	string Property LoopingActivate = "LoopingActivate" AutoReadOnly Hidden
	string Property StartAnimatedCamera = "StartAnimatedCamera" AutoReadOnly Hidden
	string Property EndAnimatedCamera = "EndAnimatedCamera" AutoReadOnly Hidden
	string Property vatsSpinningStartSlave = "vatsSpinningStartSlave" AutoReadOnly Hidden
	string Property attackReleaseSlave = "attackReleaseSlave" AutoReadOnly Hidden
	string Property idleLoopingStart = "idleLoopingStart" AutoReadOnly Hidden
	string Property idleLoopingExit = "idleLoopingExit" AutoReadOnly Hidden
	string Property furnitureEnterSlavePA = "furnitureEnterSlavePA" AutoReadOnly Hidden
	string Property furnitureIdleSlavePA = "furnitureIdleSlavePA" AutoReadOnly Hidden
	string Property furnitureIdleFlavor2Slave = "furnitureIdleFlavor2Slave" AutoReadOnly Hidden
	string Property furnitureIdleFlavor1Slave = "furnitureIdleFlavor1Slave" AutoReadOnly Hidden
	string Property furnitureIdleSlave = "furnitureIdleSlave" AutoReadOnly Hidden
	string Property furnitureExitSlave = "furnitureExitSlave" AutoReadOnly Hidden
	string Property furnitureEnterSlave = "furnitureEnterSlave" AutoReadOnly Hidden
	string Property CullBone = "CullBone" AutoReadOnly Hidden
	string Property UncullBone = "UncullBone" AutoReadOnly Hidden
	string Property AnimObjUnequipAlt = "AnimObjUnequipAlt" AutoReadOnly Hidden
	string Property dyn_ProcessAll_idle = "dyn_ProcessAll_idle" AutoReadOnly Hidden
	string Property Pose_to_PoseC = "Pose_to_PoseC" AutoReadOnly Hidden
	string Property Pose_to_PoseD = "Pose_to_PoseD" AutoReadOnly Hidden
	string Property FemaleAtMirror = "FemaleAtMirror" AutoReadOnly Hidden
	string Property MaleAtMirror = "MaleAtMirror" AutoReadOnly Hidden
	string Property ActivateIsInFlavor = "ActivateIsInFlavor" AutoReadOnly Hidden
	string Property DeactivateIsInFlavor = "DeactivateIsInFlavor" AutoReadOnly Hidden
	string Property Pose_to_PoseE = "Pose_to_PoseE" AutoReadOnly Hidden
	string Property Pose_to_PoseF = "Pose_to_PoseF" AutoReadOnly Hidden
	string Property to_PoseE = "to_PoseE" AutoReadOnly Hidden
	string Property CameraOverrideStart = "CameraOverrideStart" AutoReadOnly Hidden
	string Property CameraOverrideStop = "CameraOverrideStop" AutoReadOnly Hidden
	string Property BodyCameraEnte = "BodyCameraEnte" AutoReadOnly Hidden
	string Property BodyCameraEnter = "BodyCameraEnter" AutoReadOnly Hidden
	string Property BodyCameraExit = "BodyCameraExit" AutoReadOnly Hidden
	string Property dyn_FlavorLooping = "dyn_FlavorLooping" AutoReadOnly Hidden
	string Property LoopCounter = "LoopCounter" AutoReadOnly Hidden
	string Property initiateEnd = "initiateEnd" AutoReadOnly Hidden
	string Property initiateStart = "initiateStart" AutoReadOnly Hidden
	string Property idleReadingStart = "idleReadingStart" AutoReadOnly Hidden
	string Property idleReadingStop = "idleReadingStop" AutoReadOnly Hidden
	string Property PCapEnter = "PCapEnter" AutoReadOnly Hidden
	string Property PCapExit = "PCapExit" AutoReadOnly Hidden
	string Property FurnitureDoneReading = "FurnitureDoneReading" AutoReadOnly Hidden
	string Property Event00 = "Event00" AutoReadOnly Hidden
	string Property RandomClipStart = "RandomClipStart" AutoReadOnly Hidden
	string Property BasePoseEnter = "BasePoseEnter" AutoReadOnly Hidden
	string Property Talk01 = "Talk01" AutoReadOnly Hidden
	string Property Talk02 = "Talk02" AutoReadOnly Hidden
	string Property Talk03 = "Talk03" AutoReadOnly Hidden
	string Property Talk04 = "Talk04" AutoReadOnly Hidden
	string Property Talk05 = "Talk05" AutoReadOnly Hidden
	string Property Talk06 = "Talk06" AutoReadOnly Hidden
	string Property Talk07 = "Talk07" AutoReadOnly Hidden
	string Property Talk08 = "Talk08" AutoReadOnly Hidden
	string Property Talk09 = "Talk09" AutoReadOnly Hidden
	string Property Talk10 = "Talk10" AutoReadOnly Hidden
	string Property Talk11 = "Talk11" AutoReadOnly Hidden
	string Property Talk12 = "Talk12" AutoReadOnly Hidden
	string Property PoseA_to_PoseB = "PoseA_to_PoseB" AutoReadOnly Hidden
	string Property PoseB_to_PoseA = "PoseB_to_PoseA" AutoReadOnly Hidden
	string Property DoNotInterrupt = "DoNotInterrupt" AutoReadOnly Hidden
	string Property Talk13 = "Talk13" AutoReadOnly Hidden
	string Property Talk14 = "Talk14" AutoReadOnly Hidden
	string Property Talk15 = "Talk15" AutoReadOnly Hidden
	string Property HandFXOpen = "HandFXOpen" AutoReadOnly Hidden
	string Property HandFXClose = "HandFXClose" AutoReadOnly Hidden
	string Property HandFXOpenLeft = "HandFXOpenLeft" AutoReadOnly Hidden
	string Property HandFXOpenRight = "HandFXOpenRight" AutoReadOnly Hidden
	string Property HandFXCloseLeft = "HandFXCloseLeft" AutoReadOnly Hidden
	string Property HandFXCloseRight = "HandFXCloseRight" AutoReadOnly Hidden
	string Property BlockPOVSwitchStart = "BlockPOVSwitchStart" AutoReadOnly Hidden
	string Property BlockPOVSwitchStop = "BlockPOVSwitchStop" AutoReadOnly Hidden
	string Property to_IdleLoop = "to_IdleLoop" AutoReadOnly Hidden
	string Property Ragdoll = "Ragdoll" AutoReadOnly Hidden
	string Property KillActor = "KillActor" AutoReadOnly Hidden
	string Property ActivateAnimObjUnequip = "ActivateAnimObjUnequip" AutoReadOnly Hidden
	string Property SoundPlayAt = "SoundPlayAt" AutoReadOnly Hidden
	string Property Stage01 = "Stage01" AutoReadOnly Hidden
	string Property Stage02 = "Stage02" AutoReadOnly Hidden
	string Property Stage03 = "Stage03" AutoReadOnly Hidden
	string Property Stage04 = "Stage04" AutoReadOnly Hidden
	string Property Stage05 = "Stage05" AutoReadOnly Hidden
	string Property Stage06 = "Stage06" AutoReadOnly Hidden
	string Property Stage07 = "Stage07" AutoReadOnly Hidden
	string Property Stage08 = "Stage08" AutoReadOnly Hidden
	string Property Stage09 = "Stage09" AutoReadOnly Hidden
	string Property Stage10 = "Stage10" AutoReadOnly Hidden
	string Property Stage11 = "Stage11" AutoReadOnly Hidden
	string Property Stage12 = "Stage12" AutoReadOnly Hidden
	string Property Stage13 = "Stage13" AutoReadOnly Hidden
	string Property Stage14 = "Stage14" AutoReadOnly Hidden
	string Property Stage15 = "Stage15" AutoReadOnly Hidden
	string Property Stage16 = "Stage16" AutoReadOnly Hidden
	string Property Stage17 = "Stage17" AutoReadOnly Hidden
	string Property weaponDraw = "weaponDraw" AutoReadOnly Hidden
	string Property weaponSheathe = "weaponSheathe" AutoReadOnly Hidden
	string Property Stage18 = "Stage18" AutoReadOnly Hidden
	string Property Stage19 = "Stage19" AutoReadOnly Hidden
	string Property Stage20 = "Stage20" AutoReadOnly Hidden
	string Property muzzleFlash = "muzzleFlash" AutoReadOnly Hidden
EndGroup


Group Variables
	string Property bAllowHeadTracking = "bAllowHeadTracking" AutoReadOnly Hidden
	string Property LookAtOutsideLimit = "LookAtOutsideLimit" AutoReadOnly Hidden
	string Property camerafromx = "camerafromx" AutoReadOnly Hidden
	string Property camerafromy = "camerafromy" AutoReadOnly Hidden
	string Property camerafromz = "camerafromz" AutoReadOnly Hidden
	string Property bForceIdleStop = "bForceIdleStop" AutoReadOnly Hidden
	string Property Pose = "Pose" AutoReadOnly Hidden
	string Property bAnimationDriven = "bAnimationDriven" AutoReadOnly Hidden
	string Property bDoNotInterrupt = "bDoNotInterrupt" AutoReadOnly Hidden
	string Property bFreezeSpeedUpdate = "bFreezeSpeedUpdate" AutoReadOnly Hidden
	string Property bAllowRotation = "bAllowRotation" AutoReadOnly Hidden
	string Property Direction = "Direction" AutoReadOnly Hidden
	string Property LookAtSpine2_Enabled = "LookAtSpine2_Enabled" AutoReadOnly Hidden
	string Property LookAtChest_Enabled = "LookAtChest_Enabled" AutoReadOnly Hidden
	string Property LookAtLimitAngleDeg = "LookAtLimitAngleDeg" AutoReadOnly Hidden
	string Property LookAtChest_LimitAngleDeg = "LookAtChest_LimitAngleDeg" AutoReadOnly Hidden
	string Property LookAtNeck_LimitAngleDeg = "LookAtNeck_LimitAngleDeg" AutoReadOnly Hidden
	string Property LookAtHead_LimitAngleDeg = "LookAtHead_LimitAngleDeg" AutoReadOnly Hidden
	string Property LookAtHead_OnGain = "LookAtHead_OnGain" AutoReadOnly Hidden
	string Property LookAtAdditive = "LookAtAdditive" AutoReadOnly Hidden
	string Property bEnableRoot_IsActiveMod = "bEnableRoot_IsActiveMod" AutoReadOnly Hidden
	string Property IsNPC = "IsNPC" AutoReadOnly Hidden
	string Property LookAtOnGain = "LookAtOnGain" AutoReadOnly Hidden
	string Property LookAtOffGain = "LookAtOffGain" AutoReadOnly Hidden
	string Property bTalkableWithItem = "bTalkableWithItem" AutoReadOnly Hidden
	string Property iTalkGenerator = "iTalkGenerator" AutoReadOnly Hidden
	string Property bFreezeRotationUpdate = "bFreezeRotationUpdate" AutoReadOnly Hidden
	string Property bManualGraphChange = "bManualGraphChange" AutoReadOnly Hidden
	string Property iPcapTalkGenerator = "iPcapTalkGenerator" AutoReadOnly Hidden
	string Property SpeedSmoothed = "SpeedSmoothed" AutoReadOnly Hidden
	string Property TurnDeltaSmoothed = "TurnDeltaSmoothed" AutoReadOnly Hidden
	string Property bIsInFlavor = "bIsInFlavor" AutoReadOnly Hidden
EndGroup