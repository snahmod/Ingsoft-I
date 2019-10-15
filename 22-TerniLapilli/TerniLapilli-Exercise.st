!classDefinition: #TerniLapilliTest category: #'TerniLapilli-Exercise'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: 'playerX playerO'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliTest methodsFor: 'tests' stamp: 'aa 10/12/2019 16:20:41'!
test01ShouldStartWithEmptyBoardAndPlayerXShouldStart

	| game |
	game := TerniLapilli new.

	self assert: game chipsCount equals: 0.
	self assert: game isPlaying equals: playerX.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'aa 10/12/2019 16:21:50'!
test02PlayerXPlacesFirstChipAndChangesCurrentPlayer

	| game |

	game := TerniLapilli new.
	game putAt: 0@1.

	self assert: game chipsCount equals: 1.
	self assert: game isPlaying equals: playerO .! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'aa 10/12/2019 16:21:59'!
test03ShouldRaiserErrorWhenTwoChipsArePlaceInTheSamePosition

	| game |

	game := TerniLapilli new.
	game putAt: 0@1.

	self should: [game putAt: 0@1.] raise: Error - MessageNotUnderstood
		withMessageText: 'No se puede poner más de una ficha en una posicion'.
	self assert: game chipsCount equals: 1.
	self assert: game  isPlaying equals: playerO .! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'aa 10/12/2019 16:23:51'!
test04ShouldRaiseErrorWhenPutAtInvalidPosition

	| game |

	game := TerniLapilli new.

	self should: [game putAt: 0@99.] raise: Error - MessageNotUnderstood
		withMessageText: 'No existe la posición'.
	self assert: game chipsCount equals: 0.
	self assert: game  isPlaying equals: playerX .! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'aa 10/12/2019 16:24:58'!
test05ShouldPlayPlayerOAfterThreeTurns

	| game |

	game := TerniLapilli new.
	
	game putAt: 0@1.
	game putAt: 0@0.
	game putAt: 0@-1.

	self assert: game chipsCount equals: 3.
	self assert: game  isPlaying equals: playerO .! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'aa 10/12/2019 16:27:19'!
test06ShouldRaiseErrorAfterPlacingMoreThanSixChips

	| game |

	game := TerniLapilli new.
	
	self addSixNonWinningChipsTo: game.
	
	self should: [game putAt: -1@-1.] raise: Error - MessageNotUnderstood
		withMessageText: 'Ya hay 6 fichas en el tablero'.
	self assert: game chipsCount equals: 6.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'aa 10/12/2019 17:03:50'!
test07ShouldRaiseErrorWhenMovingBeforePlacingMoreThanSixChips

	| game |

	game := TerniLapilli new.
	
	game putAt: 0@1.
	game putAt: 1@1.
	
	self should: [game moveFrom: 0@1 to: 0@0.]
		raise: Error - MessageNotUnderstood
		withMessageText: 'No se puede mover la ficha hasta que no haya 6 en el tablero'.
	self assert: game chipsCount equals: 2.
	self assert: game isPlaying equals: playerX.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'aa 10/12/2019 17:03:18'!
test08ShouldRaiseErrorWhenMovingFromEmptyPosition

	| game |

	game := TerniLapilli new.
	
	self addSixNonWinningChipsTo: game .
	
	self should: [game moveFrom: -1@-1 to: -1@0] raise: Error - MessageNotUnderstood
		withMessageText: 'No hay una ficha en esa posición'.
	self assert: game isPlaying equals: playerX.
	self assert: game chipsCount equals: 6.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'aa 10/12/2019 17:03:11'!
test09ShouldRaiseErrorWhenMovingOpponentsChip

	| game |

	game := TerniLapilli new.
	
	self addSixNonWinningChipsTo: game .
	
	self should: [game moveFrom: 0@0 to: -1@0] raise: Error - MessageNotUnderstood
		withMessageText: 'La ficha a mover no pertence al jugador actual'.
	self assert: game isPlaying equals: playerX.
	self assert: game chipsCount equals: 6.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'aa 10/12/2019 17:47:27'!
test10ShouldRaiseErrorWhenMovingToPositionFurtherThanAllowedDistance

	| game |

	game := TerniLapilli new.
	
	self addSixNonWinningChipsTo: game .
	
	self should: [game moveFrom: 0@1 to: -1@-1] raise: Error - MessageNotUnderstood
		withMessageText: 'La ficha se quiere mover a más de distancia uno'.
	self assert: game isPlaying equals: playerX.
	self assert: game chipsCount equals: 6.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'aa 10/12/2019 17:02:59'!
test11ShouldRaiseErrorWhenMovingToOccupiedPosition

	| game |

	game := TerniLapilli new.
	
	self addSixNonWinningChipsTo: game .
	
	self should: [game moveFrom: 0@1 to: 0@0] raise: Error - MessageNotUnderstood
		withMessageText: 'La ficha se quiere mover a una posición ocupada'.
	self assert: game isPlaying equals: playerX.
	self assert: game chipsCount equals: 6.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'aa 10/12/2019 17:02:38'!
test12ShouldRaiseErrorWhenMovingToInvalidPosition

	| game |

	game := TerniLapilli new.
	
	self addSixNonWinningChipsTo: game .
	
	self should: [game moveFrom: 0@1 to: 0@2] raise: Error - MessageNotUnderstood
		withMessageText: 'La ficha se quiere mover a una posición inválida'.
	self assert: game isPlaying equals: playerX.
	self assert: game chipsCount equals: 6.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'aa 10/12/2019 17:02:28'!
test13PlayerXMovesChipAndChangesCurrentPlayer

	| game |

	game := TerniLapilli new.
	
	self addSixNonWinningChipsTo: game .
	game moveFrom: 0@1 to: -1@1.

	self assert: game isPlaying equals: playerO.
	self assert: game chipsCount equals: 6.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'aa 10/12/2019 17:48:42'!
test14PlayerOMovesChipAndChangesCurrentPlayer

	| game |

	game := TerniLapilli new.
	
	self addSixNonWinningChipsTo: game .
	game moveFrom: 0@1 to: -1@1.
	game moveFrom: 0@0 to: 0@1.

	self assert: game isPlaying equals: playerX.
	self assert: game chipsCount equals: 6.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'aa 10/12/2019 17:46:54'!
test15ShouldRaiseErrorWhenPerformingInvalidMovementOfValidDistance

	| game |

	game := TerniLapilli new.
	
	self addSixNonWinningChipsTo: game .
	
	self should: [game moveFrom: 0@1 to: -1@0] raise: Error - MessageNotUnderstood
		withMessageText: 'Movimiento ilegal'.
	self assert: game isPlaying equals: playerX.
	self assert: game chipsCount equals: 6.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'aa 10/12/2019 17:51:06'!
test16PlayerOMovesChipFromCenterToBottomLeftAndChangesCurrentPlayer

	| game |

	game := TerniLapilli new.
	
	self addSixNonWinningChipsTo: game .
	game moveFrom: 0@1 to: -1@1.
	game moveFrom: 0@0 to: -1@-1.

	self assert: game isPlaying equals: playerX.
	self assert: game chipsCount equals: 6.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'aa 10/12/2019 18:40:12'!
test17GameDoesNotEndWhenLessThanFiveChipsArePlaced

	| game |

	game := TerniLapilli new.
	
	game putAt: 0@1.
	game putAt: 0@0.
	game putAt: 0@-1.
	game putAt: 1@1.

	self deny: game isOver.
	self deny: game hasPlayerOWon .	
	self deny: game hasPlayerXWon .! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'aa 10/12/2019 18:40:18'!
test18GameDoesNotEndWhenSixChipsArePlacedInANonWinningManner

	| game |

	game := TerniLapilli new.
	
	self addSixNonWinningChipsTo: game .

	self deny: game isOver.
	self deny: game hasPlayerOWon .	
	self deny: game hasPlayerXWon .! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'aa 10/12/2019 18:22:47'!
test19GameEndsWhenPlayerXWinsByPlacingChipsInAColumn

	| game |

	game := TerniLapilli new.
	
	game putAt: 0@0.
	game putAt: 1@0.
	game putAt: 0@-1.
	game putAt: 1@1.
	game putAt: 0@1.

	self assert: game isOver.
	self assert: game hasPlayerXWon .	
	self deny: game hasPlayerOWon .! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'aa 10/12/2019 18:24:01'!
test20GameEndsWhenPlayerXWinsByPlacingChipsInARow

	| game |

	game := TerniLapilli new.
	
	game putAt: 0@0.
	game putAt: 1@1.
	game putAt: -1@0.
	game putAt: 1@-1.
	game putAt: 1@0.

	self assert: game isOver.
	self assert: game hasPlayerXWon .	
	self deny: game hasPlayerOWon .! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'aa 10/12/2019 18:28:38'!
test21GameEndsWhenPlayerXWinsByPlacingChipsInADiagonal

	| game |

	game := TerniLapilli new.
	
	game putAt: 0@0.
	game putAt: 1@0.
	game putAt: -1@-1.
	game putAt: 1@-1.
	game putAt: 1@1.

	self assert: game isOver.
	self assert: game hasPlayerXWon .	
	self deny: game hasPlayerOWon .! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'aa 10/12/2019 18:38:30'!
test22GameEndsWhenPlayerOWinsByPlacingChipsInADiagonal

	| game |

	game := TerniLapilli new.
	
	game putAt: 1@0.
	game putAt: 0@0.
	game putAt: -1@-1.
	game putAt: 1@-1.
	game putAt: 1@1.
	game putAt: -1@1.

	self assert: game isOver.
	self assert: game hasPlayerOWon .	
	self deny: game hasPlayerXWon .! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'aa 10/12/2019 18:51:33'!
test23GameEndsWhenPlayerXWinsByMovingChipsInAColumn

	| game |

	game := TerniLapilli new.
	
	self addSixNonWinningChipsTo: game.
	game moveFrom: 0@1 to: -1@1.
	game moveFrom: 0@0 to: -1@0.
	game moveFrom: -1@1 to: 0@1.
	game moveFrom: -1@0 to: -1@-1.
	game moveFrom: 1@0 to: 0@0.

	self assert: game isOver.
	self assert: game hasPlayerXWon .	
	self deny: game hasPlayerOWon .! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'aa 10/12/2019 18:57:34'!
test24GameEndsWhenPlayerXWinsByMovingChipsInARow

	| game |

	game := TerniLapilli new.
	
	self addSixNonWinningChipsTo: game.
	game moveFrom: 0@1 to: -1@1.
	game moveFrom: 0@0 to: -1@-1.
	game moveFrom: 0@-1 to: 0@0.
	game moveFrom: 1@1 to: 0@1.
	game moveFrom: -1@1 to: -1@0.

	self assert: game isOver.
	self assert: game hasPlayerXWon .	
	self deny: game hasPlayerOWon .! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'aa 10/12/2019 18:59:30'!
test25GameEndsWhenPlayerOWinsByMovingChipsInADiagonal

	| game |

	game := TerniLapilli new.
	
	self addSixNonWinningChipsTo: game.
	game moveFrom: 0@-1 to: -1@-1.
	game moveFrom: 1@-1 to: 0@-1.
	game moveFrom: -1@-1 to: -1@0.
	game moveFrom: 0@-1 to: -1@-1.

	self assert: game isOver.
	self assert: game hasPlayerOWon .	
	self deny: game hasPlayerXWon .! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'aa 10/12/2019 19:02:43'!
test26ShouldRaiseErrorWhenPlacingChipAfterWinning

	| game |

	game := TerniLapilli new.
	
	game putAt: 0@0.
	game putAt: 1@0.
	game putAt: 0@-1.
	game putAt: 1@1.
	game putAt: 0@1.

	self should: [game putAt: -1@-1.] raise: Error - MessageNotUnderstood
		withMessageText: 'El juego terminó'.
	self assert: game isOver.
	self assert: game chipsCount equals: 5.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'aa 10/12/2019 19:04:51'!
test27ShouldRaiseErrorWhenAskingWhoIsPlayingAfterWinning

	| game |

	game := TerniLapilli new.
	
	game putAt: 0@0.
	game putAt: 1@0.
	game putAt: 0@-1.
	game putAt: 1@1.
	game putAt: 0@1.

	self should: [game isPlaying] raise: Error - MessageNotUnderstood
		withMessageText: 'El juego terminó'.
	self assert: game isOver.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'aa 10/12/2019 19:08:07'!
test28ShouldRaiseErrorWhenMovingChipAfterWinning

	| game |

	game := TerniLapilli new.
	
	game putAt: 1@0.
	game putAt: 0@0.
	game putAt: -1@-1.
	game putAt: 1@-1.
	game putAt: 1@1.
	game putAt: -1@1.

	self should: [game moveFrom: -1@-1 to: 0@-1] raise: Error - MessageNotUnderstood
		withMessageText: 'El juego terminó'.
	self assert: game isOver.! !


!TerniLapilliTest methodsFor: 'setUp/tearDown' stamp: 'aa 10/12/2019 16:28:21'!
addSixNonWinningChipsTo: aGame

	aGame putAt: 0@1.
	aGame putAt: 0@0.
	aGame putAt: 0@-1.
	aGame putAt: 1@1.
	aGame putAt: 1@0.
	aGame putAt: 1@-1.! !

!TerniLapilliTest methodsFor: 'setUp/tearDown' stamp: 'aa 10/14/2019 16:55:17'!
setUp

	playerX := TerniLapilliPlayerX new.
	playerO := TerniLapilliPlayerO new.! !


!classDefinition: #TerniLapilli category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'chipsCount currentPlayer board state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilli methodsFor: 'initialization' stamp: 'aa 10/14/2019 19:23:18'!
initialize
	chipsCount := 0.
	currentPlayer := TerniLapilliPlayerX with: self.
	board := TerniLapilliBoard new.
	state := TerniLapilliMovingChipsState new.! !


!TerniLapilli methodsFor: 'testing' stamp: 'Eden 10/10/2019 18:29:31'!
chipsCount
	^chipsCount.! !

!TerniLapilli methodsFor: 'testing' stamp: 'aa 10/14/2019 21:58:17'!
hasPlayerOWon

	^board hasPlayerOWon ! !

!TerniLapilli methodsFor: 'testing' stamp: 'aa 10/14/2019 21:57:58'!
hasPlayerXWon

	^board hasPlayerXWon ! !

!TerniLapilli methodsFor: 'testing' stamp: 'aa 10/12/2019 18:19:19'!
isOver

	^self hasPlayerOWon or: [self hasPlayerXWon ].! !

!TerniLapilli methodsFor: 'testing' stamp: 'aa 10/12/2019 19:05:16'!
isPlaying

	self isOver ifTrue: [self error: 'El juego terminó'].
	^currentPlayer.! !


!TerniLapilli methodsFor: 'action' stamp: 'aa 10/14/2019 22:14:00'!
moveFrom: fromPoint to: toPoint

	
	(board validPoint: toPoint) ifFalse: [self error: 'La ficha se quiere mover a una posición inválida'].
	
	(TerniLapilliState with: self) validateMovingState.
	
	currentPlayer moveFrom: fromPoint to: toPoint .! !

!TerniLapilli methodsFor: 'action' stamp: 'aa 10/14/2019 22:13:52'!
putAt: aPoint 
	
	(board validPoint: aPoint) ifFalse: [self error: 'No existe la posición'].
	
	(TerniLapilliState with: self) validatePlacingState.

	currentPlayer putAt: aPoint.
	
	! !


!TerniLapilli methodsFor: 'private actions' stamp: 'aa 10/14/2019 19:25:41'!
moveOFrom: fromPoint to: toPoint

	board moveFrom: fromPoint to: toPoint.
	currentPlayer := TerniLapilliPlayerX with: self.! !

!TerniLapilli methodsFor: 'private actions' stamp: 'aa 10/14/2019 19:25:59'!
moveXFrom: fromPoint to: toPoint

	board moveFrom: fromPoint to: toPoint.
	currentPlayer := TerniLapilliPlayerO with: self.! !

!TerniLapilli methodsFor: 'private actions' stamp: 'aa 10/14/2019 22:05:21'!
putOAt: aPoint

	board add: (TerniLapilliPlayerO with: self) to: aPoint .
	
	chipsCount := chipsCount + 1.
	currentPlayer := TerniLapilliPlayerX with: self.! !

!TerniLapilli methodsFor: 'private actions' stamp: 'aa 10/14/2019 22:05:34'!
putXAt: aPoint

	board add: (TerniLapilliPlayerX with: self) to: aPoint .
	
	chipsCount := chipsCount + 1.
	currentPlayer  := TerniLapilliPlayerO with: self.! !


!classDefinition: #TerniLapilliBoard category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilliBoard
	instanceVariableNames: 'board'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliBoard methodsFor: 'initialization' stamp: 'aa 10/14/2019 19:22:27'!
initialize

	board := Dictionary new.
	board add: 0@0 -> TerniLapilliDiagonalPosition new.
	board add: 1@1 -> TerniLapilliDiagonalPosition new.
	board add: -1@-1 -> TerniLapilliDiagonalPosition new.
	board add: 1@-1 -> TerniLapilliDiagonalPosition new.
	board add: -1@1 -> TerniLapilliDiagonalPosition new.
	board add: 0@1 -> TerniLapilliCrossPosition new.
	board add: 1@0 -> TerniLapilliCrossPosition new.
	board add: -1@0 -> TerniLapilliCrossPosition new.
	board add: 0@-1 -> TerniLapilliCrossPosition new.! !


!TerniLapilliBoard methodsFor: 'actions' stamp: 'aa 10/14/2019 19:32:57'!
add: chip to: aPoint

	(board at: aPoint) add: chip.! !

!TerniLapilliBoard methodsFor: 'actions' stamp: 'aa 10/14/2019 20:12:07'!
moveFrom: fromPoint to: toPoint

	(TerniLapilliDistance with: fromPoint and: toPoint ) validateDistance.

	(board at: toPoint ) fetchFrom: (board at: fromPoint ) .! !


!TerniLapilliBoard methodsFor: 'testing' stamp: 'aa 10/14/2019 21:57:12'!
hasPlayerOWon

	^(#(-1 0 1) anySatisfy: [ :column |
		(board keys select: [:position | position x == column and: [(board at: position) isPlayerO]]) size == 3])
	| (#(-1 0 1) anySatisfy: [ :row |
		(board keys select: [:position | position y == row and: [(board at: position) isPlayerO]]) size == 3])
	| ((board keys select: [:position | position y == position x and: [(board at: position) isPlayerO]]) size == 3)
	| ((board keys select: [:position | position y == position x negated and: [(board at: position) isPlayerO]]) size == 3)! !

!TerniLapilliBoard methodsFor: 'testing' stamp: 'aa 10/14/2019 22:12:53'!
hasPlayerXWon

	^(#(-1 0 1) anySatisfy: [ :column |
		(board keys select: [:position | position x == column and: [(board at: position) isPlayerX]]) size == 3])
	| (#(-1 0 1) anySatisfy: [ :row |
		(board keys select: [:position | position y == row and: [(board at: position) isPlayerX]]) size == 3])
	| ((board keys select: [:position | position y == position x and: [(board at: position) isPlayerX]]) size == 3)
	| ((board keys select: [:position | position y == position x negated and: [(board at: position) isPlayerX]]) size == 3)! !


!TerniLapilliBoard methodsFor: 'validators' stamp: 'aa 10/14/2019 22:14:48'!
validPoint: aPoint
	
	^board includesKey: aPoint .! !


!classDefinition: #TerniLapilliDistance category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilliDistance
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliDistance methodsFor: 'validators' stamp: 'aa 10/14/2019 20:02:01'!
validateDistance

	^self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliDistance class' category: #'TerniLapilli-Exercise'!
TerniLapilliDistance class
	instanceVariableNames: ''!

!TerniLapilliDistance class methodsFor: 'instance creation' stamp: 'aa 10/14/2019 19:57:27'!
with: aPoint and: otherPoint

	^(self subclasses detect: [ :distanceClass | distanceClass canHandle: (aPoint dist: otherPoint )]) new.! !


!classDefinition: #TerniLapilliInvalidDistance category: #'TerniLapilli-Exercise'!
TerniLapilliDistance subclass: #TerniLapilliInvalidDistance
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliInvalidDistance methodsFor: 'validators' stamp: 'aa 10/14/2019 20:01:20'!
validateDistance

	self error: 'La ficha se quiere mover a más de distancia uno'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliInvalidDistance class' category: #'TerniLapilli-Exercise'!
TerniLapilliInvalidDistance class
	instanceVariableNames: ''!

!TerniLapilliInvalidDistance class methodsFor: 'instance creation' stamp: 'aa 10/14/2019 19:59:11'!
canHandle: dist

	^dist > 2 sqrt.! !


!classDefinition: #TerniLapilliValidDistance category: #'TerniLapilli-Exercise'!
TerniLapilliDistance subclass: #TerniLapilliValidDistance
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliValidDistance methodsFor: 'validators' stamp: 'aa 10/14/2019 20:01:41'!
validateDistance

	^true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliValidDistance class' category: #'TerniLapilli-Exercise'!
TerniLapilliValidDistance class
	instanceVariableNames: ''!

!TerniLapilliValidDistance class methodsFor: 'instance creation' stamp: 'aa 10/14/2019 19:58:57'!
canHandle: dist

	^dist <= 2 sqrt.! !


!classDefinition: #TerniLapilliPlayer category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilliPlayer
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliPlayer methodsFor: 'initialization' stamp: 'aa 10/14/2019 16:46:40'!
initializeWith: aTerniLapilli

	game := aTerniLapilli .! !


!TerniLapilliPlayer methodsFor: 'actions' stamp: 'aa 10/14/2019 17:00:00'!
moveFrom: fromPoint to: toPoint

	^self subclassResponsibility .! !

!TerniLapilliPlayer methodsFor: 'actions' stamp: 'aa 10/14/2019 16:48:25'!
putAt: aPoint.

	^self subclassResponsibility .! !


!TerniLapilliPlayer methodsFor: 'comparing' stamp: 'aa 10/14/2019 17:07:24'!
= otherPlayer

	^self isPlayerX = otherPlayer isPlayerX .! !


!TerniLapilliPlayer methodsFor: 'testing' stamp: 'aa 10/14/2019 17:04:49'!
isPlayerO

	^self subclassResponsibility .! !

!TerniLapilliPlayer methodsFor: 'testing' stamp: 'aa 10/14/2019 17:04:46'!
isPlayerX

	^self subclassResponsibility .! !


!TerniLapilliPlayer methodsFor: 'validators' stamp: 'aa 10/14/2019 20:53:34'!
validateCurrentPlayer

	self subclassResponsibility .! !

!TerniLapilliPlayer methodsFor: 'validators' stamp: 'aa 10/14/2019 20:57:04'!
validatePlayerO

	self subclassResponsibility .! !

!TerniLapilliPlayer methodsFor: 'validators' stamp: 'aa 10/14/2019 20:57:02'!
validatePlayerX

	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliPlayer class' category: #'TerniLapilli-Exercise'!
TerniLapilliPlayer class
	instanceVariableNames: ''!

!TerniLapilliPlayer class methodsFor: 'instance creation' stamp: 'aa 10/14/2019 16:47:49'!
with: aTerniLapilli

	^self new initializeWith: aTerniLapilli .! !


!classDefinition: #TerniLapilliPlayerO category: #'TerniLapilli-Exercise'!
TerniLapilliPlayer subclass: #TerniLapilliPlayerO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliPlayerO methodsFor: 'actions' stamp: 'aa 10/14/2019 17:00:28'!
moveFrom: fromPoint to: toPoint

	game moveOFrom: fromPoint to: toPoint .! !

!TerniLapilliPlayerO methodsFor: 'actions' stamp: 'aa 10/14/2019 16:48:59'!
putAt: aPoint

	game putOAt: aPoint .! !


!TerniLapilliPlayerO methodsFor: 'testing' stamp: 'aa 10/14/2019 17:05:07'!
isPlayerO

	^true.! !

!TerniLapilliPlayerO methodsFor: 'testing' stamp: 'aa 10/14/2019 17:05:17'!
isPlayerX

	^false.! !


!TerniLapilliPlayerO methodsFor: 'validators' stamp: 'aa 10/14/2019 20:56:22'!
validateCurrentPlayer

	^game isPlaying validatePlayerO! !

!TerniLapilliPlayerO methodsFor: 'validators' stamp: 'aa 10/14/2019 20:56:33'!
validatePlayerO

	^true! !

!TerniLapilliPlayerO methodsFor: 'validators' stamp: 'aa 10/14/2019 20:56:43'!
validatePlayerX

	self error: 'La ficha a mover no pertence al jugador actual'! !


!classDefinition: #TerniLapilliPlayerX category: #'TerniLapilli-Exercise'!
TerniLapilliPlayer subclass: #TerniLapilliPlayerX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliPlayerX methodsFor: 'actions' stamp: 'aa 10/14/2019 17:00:50'!
moveFrom: fromPoint to: toPoint

	game moveXFrom: fromPoint to: toPoint .! !

!TerniLapilliPlayerX methodsFor: 'actions' stamp: 'aa 10/14/2019 16:49:24'!
putAt: aPoint

	game putXAt: aPoint .! !


!TerniLapilliPlayerX methodsFor: 'testing' stamp: 'aa 10/14/2019 17:05:47'!
isPlayerO

	^false.! !

!TerniLapilliPlayerX methodsFor: 'testing' stamp: 'aa 10/14/2019 17:05:56'!
isPlayerX

	^true.! !


!TerniLapilliPlayerX methodsFor: 'validators' stamp: 'aa 10/14/2019 20:55:33'!
validateCurrentPlayer

	^game isPlaying validatePlayerX! !

!TerniLapilliPlayerX methodsFor: 'validators' stamp: 'aa 10/14/2019 20:56:04'!
validatePlayerO

	self error: 'La ficha a mover no pertence al jugador actual'! !

!TerniLapilliPlayerX methodsFor: 'validators' stamp: 'aa 10/14/2019 20:55:47'!
validatePlayerX

	^true! !


!classDefinition: #TerniLapilliPosition category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilliPosition
	instanceVariableNames: 'state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliPosition methodsFor: 'initialization' stamp: 'aa 10/14/2019 19:20:25'!
initialize

	state := TerniLapilliPositionEmptyState new.
	! !


!TerniLapilliPosition methodsFor: 'actions' stamp: 'aa 10/14/2019 19:38:59'!
add: chip

	state := state add: chip .! !

!TerniLapilliPosition methodsFor: 'actions' stamp: 'aa 10/14/2019 20:50:21'!
chipForDiagonal: aPosition

	state := state giveTo: aPosition .! !

!TerniLapilliPosition methodsFor: 'actions' stamp: 'aa 10/14/2019 20:24:23'!
fetchFrom: aPosition

	self subclassResponsibility .! !

!TerniLapilliPosition methodsFor: 'actions' stamp: 'aa 10/14/2019 22:10:38'!
saveChip: chip

	state := state saveChip: chip.! !


!TerniLapilliPosition methodsFor: 'testing' stamp: 'aa 10/14/2019 22:00:58'!
isPlayerO
	
	^state isPlayerO ! !

!TerniLapilliPosition methodsFor: 'testing' stamp: 'aa 10/14/2019 22:01:06'!
isPlayerX
	
	^state isPlayerX! !


!classDefinition: #TerniLapilliCrossPosition category: #'TerniLapilli-Exercise'!
TerniLapilliPosition subclass: #TerniLapilliCrossPosition
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliCrossPosition methodsFor: 'actions' stamp: 'aa 10/14/2019 20:29:14'!
chipForCross: aPosition

	self error: 'Movimiento ilegal'! !

!TerniLapilliCrossPosition methodsFor: 'actions' stamp: 'aa 10/14/2019 20:26:16'!
fetchFrom: aPosition

	aPosition chipForCross: self.! !


!classDefinition: #TerniLapilliDiagonalPosition category: #'TerniLapilli-Exercise'!
TerniLapilliPosition subclass: #TerniLapilliDiagonalPosition
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliDiagonalPosition methodsFor: 'actions' stamp: 'aa 10/14/2019 20:50:53'!
chipForCross: aPosition

	self chipForDiagonal: aPosition .! !

!TerniLapilliDiagonalPosition methodsFor: 'actions' stamp: 'aa 10/14/2019 20:49:46'!
fetchFrom: aPosition

	aPosition chipForDiagonal: self.! !


!classDefinition: #TerniLapilliPositionState category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilliPositionState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliPositionState methodsFor: 'actions' stamp: 'aa 10/14/2019 19:34:50'!
add: chip

	^self subclassResponsibility .! !

!TerniLapilliPositionState methodsFor: 'actions' stamp: 'aa 10/14/2019 20:14:59'!
fetchFrom: aPosition

	^self subclassResponsibility .! !

!TerniLapilliPositionState methodsFor: 'actions' stamp: 'aa 10/14/2019 20:35:35'!
giveTo: aPosition

	self subclassResponsibility .! !

!TerniLapilliPositionState methodsFor: 'actions' stamp: 'aa 10/14/2019 22:11:20'!
saveChip: chip

	self subclassResponsibility .! !


!TerniLapilliPositionState methodsFor: 'testing' stamp: 'aa 10/14/2019 22:01:38'!
isPlayerO

	self subclassResponsibility ! !

!TerniLapilliPositionState methodsFor: 'testing' stamp: 'aa 10/14/2019 22:01:42'!
isPlayerX

	self subclassResponsibility ! !


!classDefinition: #TerniLapilliPositionEmptyState category: #'TerniLapilli-Exercise'!
TerniLapilliPositionState subclass: #TerniLapilliPositionEmptyState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliPositionEmptyState methodsFor: 'actions' stamp: 'aa 10/14/2019 19:36:14'!
add: chip

	^TerniLapilliPositionOccupiedState with: chip.! !

!TerniLapilliPositionEmptyState methodsFor: 'actions' stamp: 'aa 10/14/2019 20:19:43'!
fetchFrom: aPosition

	^TerniLapilliPositionOccupiedState with: aPosition getChip.! !

!TerniLapilliPositionEmptyState methodsFor: 'actions' stamp: 'aa 10/14/2019 20:36:38'!
giveTo: aPosition

	self error: 'No hay una ficha en esa posición'! !

!TerniLapilliPositionEmptyState methodsFor: 'actions' stamp: 'aa 10/14/2019 22:11:44'!
saveChip: chip

	^TerniLapilliPositionOccupiedState with: chip! !


!TerniLapilliPositionEmptyState methodsFor: 'testing' stamp: 'aa 10/14/2019 22:01:59'!
isPlayerO

	^false! !

!TerniLapilliPositionEmptyState methodsFor: 'testing' stamp: 'aa 10/14/2019 22:02:02'!
isPlayerX

	^false! !


!classDefinition: #TerniLapilliPositionOccupiedState category: #'TerniLapilli-Exercise'!
TerniLapilliPositionState subclass: #TerniLapilliPositionOccupiedState
	instanceVariableNames: 'chip'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliPositionOccupiedState methodsFor: 'actions' stamp: 'aa 10/14/2019 19:37:13'!
add: aChip

	self error: 'No se puede poner más de una ficha en una posicion'! !

!TerniLapilliPositionOccupiedState methodsFor: 'actions' stamp: 'aa 10/14/2019 20:16:06'!
fetchFrom: aPosition

	self error: 'La ficha se quiere mover a una posición ocupada'.! !

!TerniLapilliPositionOccupiedState methodsFor: 'actions' stamp: 'aa 10/14/2019 20:47:58'!
giveTo: aPosition

	chip validateCurrentPlayer.
	aPosition saveChip: chip .
	^TerniLapilliPositionEmptyState new.! !

!TerniLapilliPositionOccupiedState methodsFor: 'actions' stamp: 'aa 10/14/2019 22:12:18'!
saveChip: aChip

	self error: 'La ficha se quiere mover a una posición ocupada'.! !


!TerniLapilliPositionOccupiedState methodsFor: 'initialization' stamp: 'aa 10/14/2019 19:38:20'!
initializeWith: aChip

	chip := aChip .! !


!TerniLapilliPositionOccupiedState methodsFor: 'testing' stamp: 'aa 10/14/2019 22:02:27'!
isPlayerO

	^chip isPlayerO ! !

!TerniLapilliPositionOccupiedState methodsFor: 'testing' stamp: 'aa 10/14/2019 22:02:32'!
isPlayerX

	^chip isPlayerX! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliPositionOccupiedState class' category: #'TerniLapilli-Exercise'!
TerniLapilliPositionOccupiedState class
	instanceVariableNames: ''!

!TerniLapilliPositionOccupiedState class methodsFor: 'instance creation' stamp: 'aa 10/14/2019 19:37:57'!
with: aChip

	^self new initializeWith: aChip .! !


!classDefinition: #TerniLapilliState category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilliState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliState methodsFor: 'validators' stamp: 'aa 10/14/2019 17:58:54'!
validateMovingState

	^self subclassResponsibility .! !

!TerniLapilliState methodsFor: 'validators' stamp: 'aa 10/14/2019 17:58:45'!
validatePlacingState

	^self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliState class' category: #'TerniLapilli-Exercise'!
TerniLapilliState class
	instanceVariableNames: ''!

!TerniLapilliState class methodsFor: 'instance creation' stamp: 'aa 10/14/2019 18:05:52'!
with: aTerniLapilli

	^(self subclasses detect: [ :state | state canHandle: aTerniLapilli ]) new.! !


!classDefinition: #TerniLapilliGameOverState category: #'TerniLapilli-Exercise'!
TerniLapilliState subclass: #TerniLapilliGameOverState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliGameOverState methodsFor: 'validators' stamp: 'aa 10/14/2019 17:59:52'!
validateMovingState

	self error: 'El juego terminó'.! !

!TerniLapilliGameOverState methodsFor: 'validators' stamp: 'aa 10/14/2019 17:59:39'!
validatePlacingState

	self error: 'El juego terminó'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliGameOverState class' category: #'TerniLapilli-Exercise'!
TerniLapilliGameOverState class
	instanceVariableNames: ''!

!TerniLapilliGameOverState class methodsFor: 'instance creation' stamp: 'aa 10/14/2019 17:56:10'!
canHandle: aTerniLapilli

	^aTerniLapilli isOver .! !


!classDefinition: #TerniLapilliMovingChipsState category: #'TerniLapilli-Exercise'!
TerniLapilliState subclass: #TerniLapilliMovingChipsState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliMovingChipsState methodsFor: 'validators' stamp: 'aa 10/14/2019 18:02:49'!
validateMovingState

	^true! !

!TerniLapilliMovingChipsState methodsFor: 'validators' stamp: 'aa 10/14/2019 18:02:18'!
validatePlacingState

	self error: 'Ya hay 6 fichas en el tablero'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliMovingChipsState class' category: #'TerniLapilli-Exercise'!
TerniLapilliMovingChipsState class
	instanceVariableNames: ''!

!TerniLapilliMovingChipsState class methodsFor: 'instance creation' stamp: 'aa 10/14/2019 17:57:23'!
canHandle: aTerniLapilli

	^aTerniLapilli isOver not & (aTerniLapilli chipsCount = 6).! !


!classDefinition: #TerniLapilliPlacingChipsState category: #'TerniLapilli-Exercise'!
TerniLapilliState subclass: #TerniLapilliPlacingChipsState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliPlacingChipsState methodsFor: 'validators' stamp: 'aa 10/14/2019 18:04:46'!
validateMovingState

	self error: 'No se puede mover la ficha hasta que no haya 6 en el tablero'! !

!TerniLapilliPlacingChipsState methodsFor: 'validators' stamp: 'aa 10/14/2019 18:03:55'!
validatePlacingState

	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliPlacingChipsState class' category: #'TerniLapilli-Exercise'!
TerniLapilliPlacingChipsState class
	instanceVariableNames: ''!

!TerniLapilliPlacingChipsState class methodsFor: 'instance creation' stamp: 'aa 10/14/2019 17:58:00'!
canHandle: aTerniLapilli

	^aTerniLapilli isOver not & (aTerniLapilli chipsCount < 6).! !
