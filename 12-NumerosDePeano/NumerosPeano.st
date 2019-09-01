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

!I class methodsFor: 'as yet unclassified' stamp: 'aa 9/1/2019 15:08:32'!
- unNumero
	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados! !

!I class methodsFor: 'as yet unclassified' stamp: 'aa 9/1/2019 15:07:48'!
/ unNumero
	unNumero = I ifFalse: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor]! !

!I class methodsFor: 'as yet unclassified' stamp: 'aa 9/1/2019 15:26:29'!
< unNumero
	^ (self == unNumero) not! !

!I class methodsFor: 'as yet unclassified' stamp: 'aa 9/1/2019 15:07:01'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un número mayor'! !

!I class methodsFor: 'as yet unclassified' stamp: 'aa 9/1/2019 15:06:05'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Números negativos no soportados'! !

!I class methodsFor: 'as yet unclassified' stamp: 'aa 9/1/2019 15:58:45'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.! !

!I class methodsFor: 'as yet unclassified' stamp: 'aa 8/26/2019 18:37:55'!
next
	next := II.
	^next! !

!I class methodsFor: 'as yet unclassified' stamp: 'aa 9/1/2019 15:08:53'!
previous
	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados! !


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

!II class methodsFor: 'as yet unclassified' stamp: 'aa 9/1/2019 15:17:13'!
- unNumero
	^self previous - ([unNumero previous] on: Error do: [^self previous])! !

!II class methodsFor: 'as yet unclassified' stamp: 'aa 9/1/2019 15:47:54'!
/ unNumero
	self == unNumero ifTrue: [^I].
	self < unNumero ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	^self - unNumero / unNumero + I! !

!II class methodsFor: 'as yet unclassified' stamp: 'aa 9/1/2019 15:38:49'!
< unNumero
	(I < unNumero) ifTrue: [^self previous < unNumero previous].
	^false! !

!II class methodsFor: 'as yet unclassified' stamp: 'aa 9/1/2019 15:20:48'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un número mayor'! !

!II class methodsFor: 'as yet unclassified' stamp: 'aa 9/1/2019 15:21:05'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Números negativos no soportados'! !

!II class methodsFor: 'as yet unclassified' stamp: 'aa 9/1/2019 15:58:45'!
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