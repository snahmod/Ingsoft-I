!classDefinition: #MarsRoverTest category: #'MarsRover-Exercise'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'originDirection originPosition north east west south'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverTest methodsFor: 'tests' stamp: 'Eden 10/6/2019 20:34:32'!
test01MarsRoverStartsAtOrigin

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: north .
	
	self assert: originPosition equals: rover position.
	self assert: north equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Eden 10/6/2019 20:34:27'!
test02MarsRoverRecievesEmptyInstructionsAndDoesNothing

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: north.
	rover doInstructions: ''.
	
	self assert: originPosition equals: rover position.
	self assert: north equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Eden 10/6/2019 20:34:22'!
test03MarsRoverRecievesAnInvalidInstructionAndDoesNothing

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: north.
	rover doInstructions: 'x'.
	
	self assert: originPosition equals: rover position.
	self assert: north equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Eden 10/6/2019 20:49:47'!
test04MarsRoverRecievesFFacingNorthAndShouldMoveForward

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: north.
	rover doInstructions: 'f'.
	
	self assert: 0@1 equals: rover position.
	self assert: north equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Eden 10/6/2019 20:34:58'!
test05MarsRoverRecievesBFacingNorthAndShouldMoveBackwards

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: north.
	rover doInstructions: 'b'.
	
	self assert: 0@-1 equals: rover position.
	self assert: north equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Eden 10/6/2019 21:05:51'!
test06MarsRoverRecievesLAndShouldRotateFromNorthToWest

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: north.
	rover doInstructions: 'l'.
	
	self assert: originPosition equals: rover position.
	self assert: west equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Eden 10/6/2019 20:35:12'!
test07MarsRoverRecievesLAndShouldRotateFromWestToSouth

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: west.
	rover doInstructions: 'l'.
	
	self assert: originPosition equals: rover position.
	self assert: south equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Eden 10/6/2019 20:35:18'!
test08MarsRoverRecievesLAndShouldRotateFromSouthToEast

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: south.
	rover doInstructions: 'l'.
	
	self assert: originPosition equals: rover position.
	self assert: east equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Eden 10/6/2019 20:35:24'!
test09MarsRoverRecievesLAndShouldRotateFromEastToNorth

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: east.
	rover doInstructions: 'l'.
	
	self assert: originPosition equals: rover position.
	self assert: north equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Eden 10/6/2019 20:35:31'!
test10MarsRoverRecievesRAndShouldRotateFromNorthToEast

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: north.
	rover doInstructions: 'r'.
	
	self assert: originPosition equals: rover position.
	self assert: east equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Eden 10/6/2019 20:35:37'!
test11MarsRoverRecievesRAndShouldRotateFromEastToSouth

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: east.
	rover doInstructions: 'r'.
	
	self assert: originPosition equals: rover position.
	self assert: south equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Eden 10/6/2019 20:36:01'!
test12MarsRoverRecievesRAndShouldRotateFromSouthToWest

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: south.
	rover doInstructions: 'r'.
	
	self assert: originPosition equals: rover position.
	self assert: west equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Eden 10/6/2019 20:36:07'!
test13MarsRoverRecievesRAndShouldRotateFromWestToNorth

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: west.
	rover doInstructions: 'r'.
	
	self assert: originPosition equals: rover position.
	self assert: north equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Eden 10/6/2019 20:36:14'!
test14MarsRoverRecievesFFacingWestAndShouldMoveForward

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: west.
	rover doInstructions: 'f'.
	
	self assert: -1@0 equals: rover position.
	self assert: west equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Eden 10/6/2019 20:36:19'!
test15MarsRoverRecievesFFacingSouthAndShouldMoveForward

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: south.
	rover doInstructions: 'f'.
	
	self assert: 0@-1 equals: rover position.
	self assert: south equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Eden 10/6/2019 20:36:28'!
test16MarsRoverRecievesFFacingEastAndShouldMoveForward

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: east.
	rover doInstructions: 'f'.
	
	self assert: 1@0 equals: rover position.
	self assert: east equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Eden 10/6/2019 20:36:44'!
test17MarsRoverRecievesBFacingWestAndShouldMoveBackwards

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: west.
	rover doInstructions: 'b'.
	
	self assert: 1@0 equals: rover position.
	self assert: west equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Eden 10/6/2019 20:36:50'!
test18MarsRoverRecievesBFacingSouthAndShouldMoveBackwards

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: south.
	rover doInstructions: 'b'.
	
	self assert: 0@1 equals: rover position.
	self assert: south equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Eden 10/6/2019 20:36:58'!
test19MarsRoverRecievesBFacingEastAndShouldMoveBackwards

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: east.
	rover doInstructions: 'b'.
	
	self assert: -1@0 equals: rover position.
	self assert: east equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Eden 10/6/2019 20:37:04'!
test20MarsRoverRecievesDoubleF

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: north.
	rover doInstructions: 'ff'.
	
	self assert: 0@2 equals: rover position.
	self assert: north equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Eden 10/6/2019 20:37:11'!
test21MarsRoverRecievesF_Invalid_B

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: north.
	rover doInstructions: 'fxb'.
	
	self assert: 0@1 equals: rover position.
	self assert: north equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Eden 10/6/2019 20:37:18'!
test22MarsRoverRecievesFRF

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: north.
	rover doInstructions: 'frf'.
	
	self assert: 1@1 equals: rover position.
	self assert: east equals: rover direction.! !


!MarsRoverTest methodsFor: 'setup' stamp: 'Eden 10/6/2019 22:06:13'!
setUp

	originPosition := 0@0.
	originDirection := North.
	
	north := North.
	east := East.
	west := West.
	south := South.
	! !


!classDefinition: #Direction category: #'MarsRover-Exercise'!
Object subclass: #Direction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!Direction methodsFor: 'testing' stamp: 'Eden 10/6/2019 19:47:12'!
leftDirection
  ^self subclassResponsibility ! !

!Direction methodsFor: 'testing' stamp: 'Eden 10/6/2019 19:47:23'!
rightDirection
  ^self subclassResponsibility ! !

!Direction methodsFor: 'testing' stamp: 'Eden 10/6/2019 20:11:08'!
vector
  ^self subclassResponsibility ! !


!classDefinition: #East category: #'MarsRover-Exercise'!
Direction subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'East class' category: #'MarsRover-Exercise'!
East class
	instanceVariableNames: ''!

!East class methodsFor: 'testing' stamp: 'Eden 10/6/2019 22:07:14'!
leftDirection

	^North! !

!East class methodsFor: 'testing' stamp: 'Eden 10/6/2019 22:03:08'!
rightDirection

	^South! !

!East class methodsFor: 'testing' stamp: 'Eden 10/6/2019 22:03:19'!
vector

  ^(1@0)! !


!classDefinition: #North category: #'MarsRover-Exercise'!
Direction subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'North class' category: #'MarsRover-Exercise'!
North class
	instanceVariableNames: ''!

!North class methodsFor: 'testing' stamp: 'Eden 10/6/2019 22:03:34'!
leftDirection

	^West! !

!North class methodsFor: 'testing' stamp: 'Eden 10/6/2019 22:03:46'!
rightDirection

	^East! !

!North class methodsFor: 'testing' stamp: 'Eden 10/6/2019 22:03:59'!
vector

	^(0@1)! !


!classDefinition: #South category: #'MarsRover-Exercise'!
Direction subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'South class' category: #'MarsRover-Exercise'!
South class
	instanceVariableNames: ''!

!South class methodsFor: 'testing' stamp: 'Eden 10/6/2019 22:04:15'!
leftDirection

	^East! !

!South class methodsFor: 'testing' stamp: 'Eden 10/6/2019 22:04:23'!
rightDirection

	^West! !

!South class methodsFor: 'testing' stamp: 'Eden 10/6/2019 22:04:33'!
vector
	
	^(0@-1)! !


!classDefinition: #West category: #'MarsRover-Exercise'!
Direction subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'West class' category: #'MarsRover-Exercise'!
West class
	instanceVariableNames: ''!

!West class methodsFor: 'testing' stamp: 'Eden 10/6/2019 22:04:54'!
leftDirection

	^South! !

!West class methodsFor: 'testing' stamp: 'Eden 10/6/2019 22:05:01'!
rightDirection

	^North! !

!West class methodsFor: 'testing' stamp: 'Eden 10/6/2019 22:05:12'!
vector
	
	^(-1@0)! !


!classDefinition: #MarsRover category: #'MarsRover-Exercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRover methodsFor: 'initialization' stamp: 'Eden 10/6/2019 20:16:14'!
initializeWithPosition: aPosition withDirection: aDirection

	position := Position withPosition: aPosition.
	direction := aDirection .! !


!MarsRover methodsFor: 'testing' stamp: 'aa 10/3/2019 21:24:02'!
direction

	^direction! !

!MarsRover methodsFor: 'testing' stamp: 'Eden 10/6/2019 20:17:57'!
position

	^position position! !


!MarsRover methodsFor: 'actions' stamp: 'Eden 10/6/2019 21:01:47'!
doInstruction: instruction

	instruction = $f ifTrue: [position moveFowardWithDirection: direction].
	instruction = $b ifTrue: [position moveBackwardWithDirection: direction].	
	instruction = $l ifTrue: [direction := direction leftDirection].
	instruction = $r ifTrue: [direction := direction rightDirection].! !

!MarsRover methodsFor: 'actions' stamp: 'aa 10/6/2019 02:43:45'!
doInstructions: instructions 
	
	instructions do: [ :instruction |
		(#($f $b $l $r) includes: instruction) ifFalse: [^self].
		self doInstruction: instruction.]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'MarsRover-Exercise'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'aa 10/3/2019 21:23:22'!
withPosition: aPosition withDirection: aDirection 

	^self new initializeWithPosition: aPosition withDirection: aDirection! !


!MarsRover class methodsFor: 'error descriptions' stamp: 'aa 10/3/2019 21:29:58'!
invalidInstructionsErrorDescription

	^'Las instrucciones permitidas son "fblr"'! !


!classDefinition: #Position category: #'MarsRover-Exercise'!
Object subclass: #Position
	instanceVariableNames: 'position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!Position methodsFor: 'action' stamp: 'Eden 10/6/2019 20:39:57'!
moveBackwardWithDirection: aDirection
	position := position - aDirection vector! !

!Position methodsFor: 'action' stamp: 'Eden 10/6/2019 20:39:48'!
moveFowardWithDirection: aDirection
	position := position + aDirection vector! !


!Position methodsFor: 'initialization' stamp: 'Eden 10/6/2019 20:14:45'!
initializeWithPosition: aPosition

	position := aPosition ! !


!Position methodsFor: 'testing' stamp: 'Eden 10/6/2019 20:17:49'!
position

	^position! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Position class' category: #'MarsRover-Exercise'!
Position class
	instanceVariableNames: ''!

!Position class methodsFor: 'class initialization' stamp: 'Eden 10/6/2019 20:15:19'!
withPosition: aPosition

	^self new initializeWithPosition: aPosition! !
