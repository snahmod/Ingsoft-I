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

!MarsRoverTest methodsFor: 'tests' stamp: 'aa 10/3/2019 21:45:14'!
test03MarsRoverRecievesInvalidInstructionsAndRaisesError

	| rover |
	
	rover := MarsRover withPosition: originPosition withDirection: #North.
	
	self should: [rover doInstructions: 'x'] raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: error messageText equals: MarsRover invalidInstructionsErrorDescription.
			self assert: originPosition equals: rover position.
			self assert: originDirection equals: rover direction.]! !


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


!MarsRover methodsFor: 'actions' stamp: 'aa 10/3/2019 21:38:14'!
doInstructions: instructions 

	(self areValidInstructions: instructions) ifFalse: [self error: self class invalidInstructionsErrorDescription ].! !


!MarsRover methodsFor: 'private' stamp: 'aa 10/3/2019 21:40:44'!
areValidInstructions: instructions

	^instructions allSatisfy: [ :instruction | #($f $b $l $r) includes: instruction ]! !

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
