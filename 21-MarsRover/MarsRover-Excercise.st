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

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/4/2019 17:31:21'!
test04MarsRoverRecievesFAndShouldMoveForward

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: #North.
	rover doInstructions: 'f'.
	
	self assert: 0@1 equals: rover position.
	self assert: originDirection equals: rover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/4/2019 17:36:25'!
test05MarsRoverRecievesBAndShouldMoveBackwards

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: #North.
	rover doInstructions: 'b'.
	
	self assert: 0@-1 equals: rover position.
	self assert: originDirection equals: rover direction.! !


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


!MarsRover methodsFor: 'actions' stamp: 'aa 10/4/2019 17:38:27'!
doInstructions: instructions 

	instructions isEmpty ifTrue: [^self].
	(#($f $b $l $r) includes: instructions first) ifFalse: [^self].
	
	(instructions first = $f) ifTrue: [position := position + (0@1)].
	(instructions first = $b) ifTrue: [position := position - (0@1)]! !


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
