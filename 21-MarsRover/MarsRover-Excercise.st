!classDefinition: #MarsRoverTest category: #'MarsRover-Exercise'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'originDirection originPosition'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/3/2019 21:24:50'!
test01MarsRoverStartsAtOrigin

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: originDirection .
	
	self assert: originPosition equals: rover position.
	self assert: originDirection equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/3/2019 21:20:19'!
test02MarsRoverRecievesEmptyInstructionsAndDoesNothing

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: #North.
	rover doInstructions: ''.
	
	self assert: originPosition equals: rover position.
	self assert: originDirection equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/4/2019 17:24:25'!
test03MarsRoverRecievesAnInvalidInstructionAndDoesNothing

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: #North.
	rover doInstructions: 'x'.
	
	self assert: originPosition equals: rover position.
	self assert: originDirection equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/6/2019 02:23:23'!
test04MarsRoverRecievesFFacingNorthAndShouldMoveForward

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: #North.
	rover doInstructions: 'f'.
	
	self assert: 0@1 equals: rover position.
	self assert: originDirection equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/6/2019 02:23:41'!
test05MarsRoverRecievesBFacingNorthAndShouldMoveBackwards

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: #North.
	rover doInstructions: 'b'.
	
	self assert: 0@-1 equals: rover position.
	self assert: originDirection equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/5/2019 20:57:42'!
test06MarsRoverRecievesLAndShouldRotateFromNorthToWest

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: #North.
	rover doInstructions: 'l'.
	
	self assert: originPosition equals: rover position.
	self assert: #West equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/5/2019 21:03:00'!
test07MarsRoverRecievesLAndShouldRotateFromWestToSouth

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: #West.
	rover doInstructions: 'l'.
	
	self assert: originPosition equals: rover position.
	self assert: #South equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/5/2019 21:03:23'!
test08MarsRoverRecievesLAndShouldRotateFromSouthToEast

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: #South.
	rover doInstructions: 'l'.
	
	self assert: originPosition equals: rover position.
	self assert: #East equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/5/2019 21:03:46'!
test09MarsRoverRecievesLAndShouldRotateFromEastToNorth

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: #East.
	rover doInstructions: 'l'.
	
	self assert: originPosition equals: rover position.
	self assert: #North equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/5/2019 21:06:00'!
test10MarsRoverRecievesRAndShouldRotateFromNorthToEast

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: #North.
	rover doInstructions: 'r'.
	
	self assert: originPosition equals: rover position.
	self assert: #East equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/5/2019 21:06:21'!
test11MarsRoverRecievesRAndShouldRotateFromEastToSouth

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: #East.
	rover doInstructions: 'r'.
	
	self assert: originPosition equals: rover position.
	self assert: #South equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/5/2019 21:06:42'!
test12MarsRoverRecievesRAndShouldRotateFromSouthToWest

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: #South.
	rover doInstructions: 'r'.
	
	self assert: originPosition equals: rover position.
	self assert: #West equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/5/2019 21:07:06'!
test13MarsRoverRecievesRAndShouldRotateFromWestToNorth

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: #West.
	rover doInstructions: 'r'.
	
	self assert: originPosition equals: rover position.
	self assert: #North equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/6/2019 02:24:48'!
test14MarsRoverRecievesFFacingWestAndShouldMoveForward

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: #West.
	rover doInstructions: 'f'.
	
	self assert: -1@0 equals: rover position.
	self assert: #West equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/6/2019 02:26:25'!
test15MarsRoverRecievesFFacingSouthAndShouldMoveForward

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: #South.
	rover doInstructions: 'f'.
	
	self assert: 0@-1 equals: rover position.
	self assert: #South equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/6/2019 02:27:17'!
test16MarsRoverRecievesFFacingEastAndShouldMoveForward

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: #East.
	rover doInstructions: 'f'.
	
	self assert: 1@0 equals: rover position.
	self assert: #East equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/6/2019 02:33:16'!
test17MarsRoverRecievesBFacingWestAndShouldMoveBackwards

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: #West.
	rover doInstructions: 'b'.
	
	self assert: 1@0 equals: rover position.
	self assert: #West equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/6/2019 02:33:52'!
test18MarsRoverRecievesBFacingSouthAndShouldMoveBackwards

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: #South.
	rover doInstructions: 'b'.
	
	self assert: 0@1 equals: rover position.
	self assert: #South equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/6/2019 02:34:24'!
test19MarsRoverRecievesBFacingEastAndShouldMoveBackwards

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: #East.
	rover doInstructions: 'b'.
	
	self assert: -1@0 equals: rover position.
	self assert: #East equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/6/2019 02:38:17'!
test20MarsRoverRecievesDoubleF

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: #North.
	rover doInstructions: 'ff'.
	
	self assert: 0@2 equals: rover position.
	self assert: #North equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/6/2019 02:44:57'!
test21MarsRoverRecievesF_Invalid_B

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: #North.
	rover doInstructions: 'fxb'.
	
	self assert: 0@1 equals: rover position.
	self assert: #North equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/6/2019 02:46:58'!
test22MarsRoverRecievesFRF

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: #North.
	rover doInstructions: 'frf'.
	
	self assert: 1@1 equals: rover position.
	self assert: #East equals: rover direction.! !


!MarsRoverTest methodsFor: 'setup' stamp: 'aa 10/3/2019 21:24:57'!
setUp

	originPosition := 0@0.
	originDirection := #North.! !


!classDefinition: #MarsRover category: #'MarsRover-Exercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRover methodsFor: 'initialization' stamp: 'aa 10/3/2019 21:19:51'!
initializeWithPosition: aPosition withDirection: aDirection

	position := aPosition .
	direction := aDirection .! !


!MarsRover methodsFor: 'testing' stamp: 'aa 10/3/2019 21:24:02'!
direction

	^direction! !

!MarsRover methodsFor: 'testing' stamp: 'aa 10/3/2019 21:22:27'!
position

	^position ! !


!MarsRover methodsFor: 'actions' stamp: 'aa 10/6/2019 02:48:13'!
doInstruction: instruction

	"Sorry Eden :|" "TDD me es hermoso"
	(instruction = $f and: [direction = #North]) ifTrue: [position := position + (0@1). ^self].
	(instruction = $f and: [direction = #West]) ifTrue: [position := position + (-1@0). ^self].
	(instruction = $f and: [direction = #South]) ifTrue: [position := position + (0@-1). ^self].
	(instruction = $f and: [direction = #East]) ifTrue: [position := position + (1@0). ^self].
	
	(instruction = $b and: [direction = #North]) ifTrue: [position := position - (0@1). ^self].
	(instruction = $b and: [direction = #West]) ifTrue: [position := position - (-1@0). ^self].
	(instruction = $b and: [direction = #South]) ifTrue: [position := position - (0@-1). ^self].
	(instruction = $b and: [direction = #East]) ifTrue: [position := position - (1@0). ^self].
	
	(instruction = $l and: [direction = #North]) ifTrue: [direction := #West. ^self].
	(instruction = $l and: [direction = #West]) ifTrue: [direction := #South. ^self].
	(instruction = $l and: [direction = #South]) ifTrue: [direction := #East. ^self].
	(instruction = $l and: [direction = #East]) ifTrue: [direction := #North. ^self].
	
	(instruction = $r and: [direction = #North]) ifTrue: [direction := #East. ^self].
	(instruction = $r and: [direction = #West]) ifTrue: [direction := #North. ^self].
	(instruction = $r and: [direction = #South]) ifTrue: [direction := #West. ^self].
	(instruction = $r and: [direction = #East]) ifTrue: [direction := #South. ^self].! !

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
