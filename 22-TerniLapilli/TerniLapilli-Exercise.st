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

!TerniLapilliTest methodsFor: 'setUp/tearDown' stamp: 'aa 10/12/2019 16:24:43'!
setUp

	playerX := #PlayerX.
	playerO := #PlayerO.! !


!classDefinition: #TerniLapilli category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'chipsCount currentPlayer board'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilli methodsFor: 'initialization' stamp: 'Eden 10/10/2019 20:31:20'!
initialize
	chipsCount := 0.
	currentPlayer := #PlayerX.
	board := Dictionary new.! !


!TerniLapilli methodsFor: 'testing' stamp: 'Eden 10/10/2019 18:29:31'!
chipsCount
	^chipsCount.! !

!TerniLapilli methodsFor: 'testing' stamp: 'aa 10/12/2019 18:36:34'!
hasPlayerOWon

	^(#(-1 0 1) anySatisfy: [ :column |
		(board keys select: [:position | position x == column and: [(board at: position) == #PlayerO]]) size == 3])
	| (#(-1 0 1) anySatisfy: [ :row |
		(board keys select: [:position | position y == row and: [(board at: position) == #PlayerO]]) size == 3])
	| ((board keys select: [:position | position y == position x and: [(board at: position) == #PlayerO]]) size == 3)
	| ((board keys select: [:position | position y == position x negated and: [(board at: position) == #PlayerO]]) size == 3)! !

!TerniLapilli methodsFor: 'testing' stamp: 'aa 10/12/2019 18:36:55'!
hasPlayerXWon

	^(#(-1 0 1) anySatisfy: [ :column |
		(board keys select: [:position | position x == column and: [(board at: position) == #PlayerX]]) size == 3])
	| (#(-1 0 1) anySatisfy: [ :row |
		(board keys select: [:position | position y == row and: [(board at: position) == #PlayerX]]) size == 3])
	| ((board keys select: [:position | position y == position x and: [(board at: position) == #PlayerX]]) size == 3)
	| ((board keys select: [:position | position y == position x negated and: [(board at: position) == #PlayerX]]) size == 3)! !

!TerniLapilli methodsFor: 'testing' stamp: 'aa 10/12/2019 18:19:19'!
isOver

	^self hasPlayerOWon or: [self hasPlayerXWon ].! !

!TerniLapilli methodsFor: 'testing' stamp: 'aa 10/12/2019 19:05:16'!
isPlaying

	self isOver ifTrue: [self error: 'El juego terminó'].
	^currentPlayer.! !


!TerniLapilli methodsFor: 'action' stamp: 'aa 10/12/2019 19:08:44'!
moveFrom: fromPoint to: toPoint

	self isOver ifTrue: [self error: 'El juego terminó'].
	chipsCount  < 6 ifTrue: [self error:'No se puede mover la ficha hasta que no haya 6 en el tablero'].
	(board includesKey: fromPoint) ifFalse: [self error: 'No hay una ficha en esa posición'.].
	(board includesKey: toPoint ) ifTrue: [self error: 'La ficha se quiere mover a una posición ocupada'.].
	((board at: fromPoint) == currentPlayer) ifFalse: [self error: 'La ficha a mover no pertence al jugador actual'].
	(fromPoint dist: toPoint) > 2 sqrt ifTrue: [self error: 'La ficha se quiere mover a más de distancia uno'].
	(#(-1 0 1) includes: toPoint  x) ifFalse: [self error: 'La ficha se quiere mover a una posición inválida'].
	(#(-1 0 1) includes: toPoint  y) ifFalse: [self error: 'La ficha se quiere mover a una posición inválida'].
	(fromPoint x isZero xor: (fromPoint y isZero)) & (toPoint x isZero xor: (toPoint y isZero)) ifTrue: [self error: 'Movimiento ilegal'].
	
	board add: toPoint -> (board removeKey: fromPoint ).
	
	currentPlayer = #PlayerX ifTrue: [currentPlayer:= #PlayerO. ^self].
	currentPlayer  = #PlayerO ifTrue: [currentPlayer := #PlayerX. ^self].! !

!TerniLapilli methodsFor: 'action' stamp: 'aa 10/12/2019 19:03:21'!
putAt: aPoint 
	
	self isOver ifTrue: [self error: 'El juego terminó'].
	(#(-1 0 1) includes: aPoint  x) ifFalse: [self error: 'No existe la posición'].
	(#(-1 0 1) includes: aPoint  y) ifFalse: [self error: 'No existe la posición'].
	(board includesKey: aPoint) ifTrue: [self error: 'No se puede poner más de una ficha en una posicion'].
	chipsCount = 6 ifTrue: [self error: 'Ya hay 6 fichas en el tablero'].
	board add: aPoint -> currentPlayer.
	
	chipsCount := chipsCount + 1.
	currentPlayer = #PlayerX ifTrue: [currentPlayer:= #PlayerO. ^self].
	currentPlayer  = #PlayerO ifTrue: [currentPlayer := #PlayerX. ^self].! !
