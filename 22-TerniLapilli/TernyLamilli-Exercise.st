!classDefinition: #TernyLamilliTest category: #'TernyLamilli-Exercise'!
TestCase subclass: #TernyLamilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TernyLamilli-Exercise'!

!TernyLamilliTest methodsFor: 'tests' stamp: 'Eden 10/10/2019 18:21:09'!
test01ShouldStartWithEmptyBoardAndPlayerXShouldStart

| ternyLamilli |
ternyLamilli := TernyLamilli new.

self assert: ternyLamilli chipsCount equals: 0.
self assert: ternyLamilli isPlaying equals: #PlayerX.! !

!TernyLamilliTest methodsFor: 'tests' stamp: 'Eden 10/10/2019 20:20:06'!
test02PlayerXPlacesFirstChipAndChangesCurrentPlayer

| ternyLamilli |
ternyLamilli := TernyLamilli new.
ternyLamilli putAt: 0@1.

self assert: ternyLamilli chipsCount equals: 1.
self assert: ternyLamilli isPlaying equals: #PlayerO.! !

!TernyLamilliTest methodsFor: 'tests' stamp: 'Eden 10/10/2019 21:07:02'!
test03ShouldRaiserErrorWhenTwoChipsArePlaceInTheSamePosition

	| ternyLamilli |
	ternyLamilli := TernyLamilli new.
	ternyLamilli putAt: 0@1.

	self should: [ternyLamilli putAt: 0@1.] raise: Error - MessageNotUnderstood
		withMessageText: 'No se puede poner más de una ficha en una posicion'.
	self assert: ternyLamilli chipsCount equals: 1.
	self assert: ternyLamilli  isPlaying equals: #PlayerO.! !

!TernyLamilliTest methodsFor: 'tests' stamp: 'Eden 10/10/2019 21:10:16'!
test04ShouldRaiseErrorWhenPutAtInvalidPosition

	| ternyLamilli |
	ternyLamilli := TernyLamilli new.

	self should: [ternyLamilli putAt: 0@99.] raise: Error - MessageNotUnderstood
		withMessageText: 'No existe la posición'.
	self assert: ternyLamilli chipsCount equals: 0.
	self assert: ternyLamilli  isPlaying equals: #PlayerX.! !

!TernyLamilliTest methodsFor: 'tests' stamp: 'Eden 10/10/2019 21:17:38'!
test05ShouldPlayPlayerOAfterThreeTurns

	| ternyLamilli |
	ternyLamilli := TernyLamilli new.
	
	ternyLamilli putAt: 0@1.
	ternyLamilli putAt: 0@0.
	ternyLamilli putAt: 0@-1.

	self assert: ternyLamilli chipsCount equals: 3.
	self assert: ternyLamilli  isPlaying equals: #PlayerO.! !

!TernyLamilliTest methodsFor: 'tests' stamp: 'Eden 10/10/2019 21:19:20'!
test06ShouldRaiseErrorAfterPlacingMoreThanSixChips

	| ternyLamilli |
	ternyLamilli := TernyLamilli new.
	
	ternyLamilli putAt: 0@1.
	ternyLamilli putAt: 0@0.
	ternyLamilli putAt: 0@-1.
	ternyLamilli putAt: 1@1.
	ternyLamilli putAt: 1@0.
	ternyLamilli putAt: 1@-1.
	
	self should: [ternyLamilli putAt: -1@-1.] raise: Error - MessageNotUnderstood
		withMessageText: 'Ya hay 6 fichas en el tablero'.
	self assert: ternyLamilli chipsCount equals: 6.! !

!TernyLamilliTest methodsFor: 'tests' stamp: 'Eden 10/10/2019 21:27:08'!
test07ShouldRaiseErrorWhenMovingBeforePlacingMoreThanSixChips

	| ternyLamilli |
	ternyLamilli := TernyLamilli new.
	
	ternyLamilli putAt: 0@1.
	ternyLamilli putAt: 1@1.
	
	self should: [ternyLamilli moveFrom: 0@1 to: 0@0.] raise: Error - MessageNotUnderstood
		withMessageText: 'No se puede mover la ficha hasta que no haya 6 en el tablero'.
	self assert: ternyLamilli chipsCount equals: 2.
	self assert: ternyLamilli isPlaying equals: #PlayerX.! !


!classDefinition: #TernyLamilli category: #'TernyLamilli-Exercise'!
Object subclass: #TernyLamilli
	instanceVariableNames: 'chipsCount currentPlayer board'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TernyLamilli-Exercise'!

!TernyLamilli methodsFor: 'initialization' stamp: 'Eden 10/10/2019 20:31:20'!
initialize
	chipsCount := 0.
	currentPlayer := #PlayerX.
	board := Dictionary new.! !


!TernyLamilli methodsFor: 'testing' stamp: 'Eden 10/10/2019 18:29:31'!
chipsCount
	^chipsCount.! !

!TernyLamilli methodsFor: 'testing' stamp: 'Eden 10/10/2019 18:51:16'!
isPlaying
	^currentPlayer.! !


!TernyLamilli methodsFor: 'action' stamp: 'Eden 10/10/2019 21:26:52'!
moveFrom: aPoint to: aPoint2 
	chipsCount  < 6 ifTrue: [self error:'No se puede mover la ficha hasta que no haya 6 en el tablero']! !

!TernyLamilli methodsFor: 'action' stamp: 'Eden 10/10/2019 21:21:07'!
putAt: aPoint 
	
	(#(-1 0 1) includes: aPoint  x) ifFalse: [self error: 'No existe la posición'].
	(#(-1 0 1) includes: aPoint  y) ifFalse: [self error: 'No existe la posición'].
	(board includesKey: aPoint) ifTrue: [self error: 'No se puede poner más de una ficha en una posicion'].
	chipsCount = 6 ifTrue: [self error: 'Ya hay 6 fichas en el tablero'].
	board add: aPoint -> currentPlayer.
	
	chipsCount := chipsCount + 1.
	currentPlayer = #PlayerX ifTrue: [currentPlayer:= #PlayerO. ^self].
	currentPlayer  = #PlayerO ifTrue: [currentPlayer := #PlayerX. ^self].! !
