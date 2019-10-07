!classDefinition: #MarsRoverTest category: #'MarsRover-Exercise'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'north east west south originVector originPosition'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/7/2019 16:57:15'!
test01MarsRoverStartsAtOrigin

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: north .
	
	self assertMarsRover: rover isAtPosition: originVector andDirection: north.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/7/2019 16:57:21'!
test02MarsRoverRecievesEmptyInstructionsAndDoesNothing

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: north.
	rover doInstructions: ''.
	
	self assertMarsRover: rover isAtPosition: originVector andDirection: north.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/7/2019 16:57:26'!
test03MarsRoverRecievesAnInvalidInstructionAndDoesNothing

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: north.
	rover doInstructions: 'x'.
	
	self assertMarsRover: rover isAtPosition: originVector andDirection: north.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/7/2019 16:57:31'!
test04MarsRoverRecievesFFacingNorthAndShouldMoveForward

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: north.
	rover doInstructions: 'f'.
	
	self assertMarsRover: rover isAtPosition: 0@1 andDirection: north.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/7/2019 16:57:36'!
test05MarsRoverRecievesBFacingNorthAndShouldMoveBackwards

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: north.
	rover doInstructions: 'b'.
	
	self assertMarsRover: rover isAtPosition: 0@-1 andDirection: north.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/7/2019 16:57:41'!
test06MarsRoverRecievesLAndShouldRotateFromNorthToWest

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: north.
	rover doInstructions: 'l'.
	
	self assertMarsRover: rover isAtPosition: originVector andDirection: west.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/7/2019 16:57:47'!
test07MarsRoverRecievesLAndShouldRotateFromWestToSouth

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: west.
	rover doInstructions: 'l'.
	
	self assertMarsRover: rover isAtPosition: originVector andDirection: south.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/7/2019 16:57:52'!
test08MarsRoverRecievesLAndShouldRotateFromSouthToEast

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: south.
	rover doInstructions: 'l'.
	
	self assertMarsRover: rover isAtPosition: originVector andDirection: east.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/7/2019 16:57:57'!
test09MarsRoverRecievesLAndShouldRotateFromEastToNorth

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: east.
	rover doInstructions: 'l'.
	
	self assertMarsRover: rover isAtPosition: originVector andDirection: north.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/7/2019 16:58:01'!
test10MarsRoverRecievesRAndShouldRotateFromNorthToEast

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: north.
	rover doInstructions: 'r'.
	
	self assertMarsRover: rover isAtPosition: originVector andDirection: east.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/7/2019 16:58:06'!
test11MarsRoverRecievesRAndShouldRotateFromEastToSouth

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: east.
	rover doInstructions: 'r'.
	
	self assertMarsRover: rover isAtPosition: originVector andDirection: south.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/7/2019 16:58:11'!
test12MarsRoverRecievesRAndShouldRotateFromSouthToWest

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: south.
	rover doInstructions: 'r'.
	
	self assertMarsRover: rover isAtPosition: originVector andDirection: west.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/7/2019 16:58:55'!
test13MarsRoverRecievesRAndShouldRotateFromWestToNorth

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: west.
	rover doInstructions: 'r'.
	
	self assertMarsRover: rover isAtPosition: originVector andDirection: north.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/7/2019 16:59:01'!
test14MarsRoverRecievesFFacingWestAndShouldMoveForward

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: west.
	rover doInstructions: 'f'.
	
	self assertMarsRover: rover isAtPosition: -1@0 andDirection: west.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/7/2019 16:59:06'!
test15MarsRoverRecievesFFacingSouthAndShouldMoveForward

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: south.
	rover doInstructions: 'f'.
	
	self assertMarsRover: rover isAtPosition: 0@-1 andDirection: south.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/7/2019 16:59:12'!
test16MarsRoverRecievesFFacingEastAndShouldMoveForward

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: east.
	rover doInstructions: 'f'.
	
	self assertMarsRover: rover isAtPosition: 1@0 andDirection: east.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/7/2019 16:59:17'!
test17MarsRoverRecievesBFacingWestAndShouldMoveBackwards

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: west.
	rover doInstructions: 'b'.
	
	
	self assertMarsRover: rover isAtPosition: 1@0 andDirection: west.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/7/2019 16:59:22'!
test18MarsRoverRecievesBFacingSouthAndShouldMoveBackwards

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: south.
	rover doInstructions: 'b'.
	
	self assertMarsRover: rover isAtPosition: 0@1 andDirection: south.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/7/2019 16:59:26'!
test19MarsRoverRecievesBFacingEastAndShouldMoveBackwards

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: east.
	rover doInstructions: 'b'.
	
	self assertMarsRover: rover isAtPosition: -1@0 andDirection: east.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/7/2019 16:59:31'!
test20MarsRoverRecievesDoubleF

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: north.
	rover doInstructions: 'ff'.
	
	self assertMarsRover: rover isAtPosition: 0@2 andDirection: north.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/7/2019 16:59:36'!
test21MarsRoverRecievesF_Invalid_B

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: north.
	rover doInstructions: 'fxb'.
	
	self assertMarsRover: rover isAtPosition: 0@1 andDirection: north.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/7/2019 16:59:41'!
test22MarsRoverRecievesFRF

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: north.
	rover doInstructions: 'frf'.
	
	self assertMarsRover: rover isAtPosition: 1@1 andDirection: east.! !


!MarsRoverTest methodsFor: 'setup' stamp: 'aa 10/7/2019 16:56:34'!
setUp

	originVector := 0@0.
	originPosition := Position withVector: originVector .
	
	north := North.
	east := East.
	west := West.
	south := South.
	! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'aa 10/7/2019 16:54:44'!
assertMarsRover: aRover isAtPosition: aPosition andDirection: aDirection
	
	self assert: aPosition equals: aRover position vector.
	self assert: aDirection equals: aRover direction.! !


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


!classDefinition: #Instruction category: #'MarsRover-Exercise'!
Object subclass: #Instruction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!Instruction methodsFor: 'actions' stamp: 'aa 10/7/2019 16:44:25'!
executeFor: aMarsRover

	^self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Instruction class' category: #'MarsRover-Exercise'!
Instruction class
	instanceVariableNames: ''!

!Instruction class methodsFor: 'instance creation' stamp: 'aa 10/7/2019 16:49:48'!
with: anInstructionCode InvalidInstructionDo: aClosure

	^(self subclasses detect: [ :subclass | subclass canHandle: anInstructionCode ] ifNone: aClosure ) new.! !


!Instruction class methodsFor: 'testing' stamp: 'aa 10/7/2019 16:36:26'!
canHandle: anInstructionCode

	^self subclassResponsibility .! !


!classDefinition: #Backwardsinstruction category: #'MarsRover-Exercise'!
Instruction subclass: #Backwardsinstruction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!Backwardsinstruction methodsFor: 'actions' stamp: 'aa 10/7/2019 16:42:15'!
executeFor: aMarsRover

	aMarsRover moveBackwards .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Backwardsinstruction class' category: #'MarsRover-Exercise'!
Backwardsinstruction class
	instanceVariableNames: ''!

!Backwardsinstruction class methodsFor: 'testing' stamp: 'aa 10/7/2019 16:38:58'!
canHandle: anInstructionCode

	^anInstructionCode = $b.! !


!classDefinition: #Forwardinstruction category: #'MarsRover-Exercise'!
Instruction subclass: #Forwardinstruction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!Forwardinstruction methodsFor: 'actions' stamp: 'aa 10/7/2019 16:43:04'!
executeFor: aMarsRover

	aMarsRover moveForward .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Forwardinstruction class' category: #'MarsRover-Exercise'!
Forwardinstruction class
	instanceVariableNames: ''!

!Forwardinstruction class methodsFor: 'testing' stamp: 'aa 10/7/2019 16:38:07'!
canHandle: anInstructionCode

	^anInstructionCode = $f.! !


!classDefinition: #TurnLeftinstruction category: #'MarsRover-Exercise'!
Instruction subclass: #TurnLeftinstruction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!TurnLeftinstruction methodsFor: 'actions' stamp: 'aa 10/7/2019 16:43:32'!
executeFor: aMarsRover

	aMarsRover turnLeft .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TurnLeftinstruction class' category: #'MarsRover-Exercise'!
TurnLeftinstruction class
	instanceVariableNames: ''!

!TurnLeftinstruction class methodsFor: 'testing' stamp: 'aa 10/7/2019 16:39:28'!
canHandle: anInstructionCode

	^anInstructionCode = $l.! !


!classDefinition: #TurnRightinstruction category: #'MarsRover-Exercise'!
Instruction subclass: #TurnRightinstruction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!TurnRightinstruction methodsFor: 'actions' stamp: 'aa 10/7/2019 16:43:52'!
executeFor: aMarsRover

	aMarsRover turnRight .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TurnRightinstruction class' category: #'MarsRover-Exercise'!
TurnRightinstruction class
	instanceVariableNames: ''!

!TurnRightinstruction class methodsFor: 'testing' stamp: 'aa 10/7/2019 16:40:06'!
canHandle: anInstructionCode

	^anInstructionCode = $r.! !


!classDefinition: #MarsRover category: #'MarsRover-Exercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRover methodsFor: 'initialization' stamp: 'aa 10/7/2019 16:52:22'!
initializeWithPosition: aPosition withDirection: aDirection

	position := aPosition.
	direction := aDirection .! !


!MarsRover methodsFor: 'testing' stamp: 'aa 10/3/2019 21:24:02'!
direction

	^direction! !

!MarsRover methodsFor: 'testing' stamp: 'aa 10/7/2019 16:13:41'!
position

	^position! !


!MarsRover methodsFor: 'actions' stamp: 'aa 10/7/2019 16:51:00'!
doInstruction: instructionCode else: aClosure

	| instruction |

	instruction := Instruction with: instructionCode InvalidInstructionDo: aClosure .
	instruction executeFor: self.
	! !

!MarsRover methodsFor: 'actions' stamp: 'aa 10/7/2019 15:56:49'!
doInstructions: instructions 
	
	instructions do: [ :instruction | self doInstruction: instruction else: [^self] ]! !

!MarsRover methodsFor: 'actions' stamp: 'aa 10/7/2019 16:25:18'!
moveBackwards

	position moveBackwardWithDirection: direction.
	! !

!MarsRover methodsFor: 'actions' stamp: 'aa 10/7/2019 16:23:21'!
moveForward

	position moveFowardWithDirection: direction.
	! !

!MarsRover methodsFor: 'actions' stamp: 'aa 10/7/2019 16:25:57'!
turnLeft

	direction := direction leftDirection .
	! !

!MarsRover methodsFor: 'actions' stamp: 'aa 10/7/2019 16:26:09'!
turnRight

	direction := direction rightDirection .
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'MarsRover-Exercise'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'aa 10/3/2019 21:23:22'!
withPosition: aPosition withDirection: aDirection 

	^self new initializeWithPosition: aPosition withDirection: aDirection! !



!classDefinition: #Position category: #'MarsRover-Exercise'!
Object subclass: #Position
	instanceVariableNames: 'vector'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!Position methodsFor: 'action' stamp: 'aa 10/7/2019 16:07:07'!
moveBackwardWithDirection: aDirection
	vector := vector - aDirection vector! !

!Position methodsFor: 'action' stamp: 'aa 10/7/2019 16:07:07'!
moveFowardWithDirection: aDirection
	vector := vector + aDirection vector! !


!Position methodsFor: 'initialization' stamp: 'aa 10/7/2019 16:07:07'!
initializeWithVector: aPosition

	vector := aPosition ! !


!Position methodsFor: 'testing' stamp: 'aa 10/7/2019 16:07:07'!
vector

	^vector! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Position class' category: #'MarsRover-Exercise'!
Position class
	instanceVariableNames: ''!

!Position class methodsFor: 'class initialization' stamp: 'aa 10/7/2019 16:04:02'!
withVector: aPosition

	^self new initializeWithVector: aPosition! !
