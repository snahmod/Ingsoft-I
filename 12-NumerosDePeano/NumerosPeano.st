!classDefinition: #I category: #NumerosPeano!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosPeano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #NumerosPeano!
I class
	instanceVariableNames: 'next'!

!I class methodsFor: 'as yet unclassified' stamp: 'aa 8/26/2019 20:40:13'!
* unNumero
	^unNumero ! !

!I class methodsFor: 'as yet unclassified' stamp: 'aa 8/26/2019 18:52:30'!
+ unNumero
	^unNumero next! !

!I class methodsFor: 'as yet unclassified' stamp: 'aa 8/26/2019 20:53:47'!
/ unNumero
	unNumero = I ifFalse: [self error]! !

!I class methodsFor: 'as yet unclassified' stamp: 'aa 8/27/2019 18:11:52'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.! !

!I class methodsFor: 'as yet unclassified' stamp: 'aa 8/26/2019 18:37:55'!
next
	next := II.
	^next! !


!classDefinition: #II category: #NumerosPeano!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosPeano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #NumerosPeano!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'aa 8/26/2019 20:44:14'!
* unNumero
	^self previous * unNumero + unNumero! !

!II class methodsFor: 'as yet unclassified' stamp: 'aa 8/26/2019 18:56:50'!
+ unNumero
	^self previous + unNumero next! !

!II class methodsFor: 'as yet unclassified' stamp: 'aa 8/27/2019 17:54:45'!
- unNumero
	^self previous - ([unNumero previous]
						on: MessageNotUnderstood
						do: [^self previous])! !

!II class methodsFor: 'as yet unclassified' stamp: 'aa 8/27/2019 18:05:04'!
/ unNumero
	self == unNumero ifTrue: [^I].
	^self - unNumero / unNumero + I! !

!II class methodsFor: 'as yet unclassified' stamp: 'aa 8/27/2019 18:11:52'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'aa 8/26/2019 18:58:36'!
next
	next ifNil: [
		next := self cloneNamed: self name, 'I'.
		next previous: self.
	].
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'aa 8/26/2019 18:57:37'!
previous
	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'aa 8/26/2019 19:00:52'!
previous: prev
	previous := prev! !

!II class methodsFor: 'as yet unclassified' stamp: 'aa 8/26/2019 18:42:57'!
removeAllNext
	next ifNotNil:
		[
			next removeAllNext.
			next removeFromSystem.
			next := nil.
		]! !

I initializeAfterFileIn!
II initializeAfterFileIn!