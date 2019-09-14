!classDefinition: #NumeroTest category: #'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:26'!
test27EnteroSubstractsEnteroCorrectly

	self assert: two - one equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: #'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'aa 9/14/2019 16:02:50'!
addAFraction: anAdder

	^self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'aa 9/14/2019 16:00:26'!
addAnEntero: anEntero 
	
	^self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'aa 9/14/2019 16:04:15'!
divideAFraction: aDivisor 
	
	^self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'aa 9/14/2019 16:04:43'!
divideAnEntero: anEntero 
	
	^self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'aa 9/14/2019 16:05:42'!
multiplyAFraction: aMultiplier 
	
	^self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !

!Numero methodsFor: 'arithmetic operations' stamp: 'aa 9/14/2019 16:06:09'!
subtractFromAFraction: aSubtrahend 
	
	^self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'aa 9/14/2019 16:06:35'!
subtractFromEntero: aSubtrahend 
	
	^ self subclassResponsibility ! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: #'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:45'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/8/2019 02:58:13'!
invalidNumberTypeErrorDescription
	^ 'Tipo de número inválido'! !


!classDefinition: #Entero category: #'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'aa 9/12/2019 21:03:51'!
* aMultiplier 
	
	^aMultiplier multiplyAnEntero: self
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'aa 9/12/2019 21:20:08'!
+ anAdder 
	
	^anAdder addAnEntero: self
	
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'aa 9/12/2019 20:53:15'!
- aSubtrahend 
	
	^ aSubtrahend subtractFromEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'aa 9/12/2019 21:12:29'!
/ aDivisor 
	
	^aDivisor divideAnEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'aa 9/12/2019 21:39:00'!
addAFraction: anAdder

	| newNumerator |
	
	newNumerator := (self * anAdder denominator) + anAdder numerator.
	
	^newNumerator / anAdder denominator.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'aa 9/12/2019 21:19:56'!
addAnEntero: anEntero 
	
	^self class with: value + anEntero integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'aa 9/12/2019 21:41:28'!
divideAFraction: aDivisor 
	
	^aDivisor numerator / (self * aDivisor denominator)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'aa 9/12/2019 21:12:46'!
divideAnEntero: anEntero 
	
	^Fraccion with: anEntero over: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'aa 9/14/2019 20:19:54'!
fibonacci

	| one two |
	
	one := Uno initalize.
	two := Positivo with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'aa 9/12/2019 21:39:51'!
multiplyAFraction: aMultiplier 
	
	^(self * aMultiplier numerator) / aMultiplier denominator
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'aa 9/12/2019 21:03:29'!
multiplyAnEntero: aMultiplier 
	
	^self class with: value * aMultiplier integerValue
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'aa 9/12/2019 21:42:48'!
subtractFromAFraction: aSubtrahend 
	
	| newNumerator |
	
	newNumerator := aSubtrahend numerator - (self * aSubtrahend denominator).
	
	^newNumerator / aSubtrahend denominator
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'aa 9/12/2019 21:01:58'!
subtractFromEntero: aSubtrahend 
	
	^ self class with: aSubtrahend integerValue - value! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 20:09'!
initalizeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'aa 9/14/2019 17:49:17'!
isNegative
	
	^self subclassResponsibility! !

!Entero methodsFor: 'testing' stamp: 'aa 9/14/2019 17:49:59'!
isOne
	
	^self subclassResponsibility ! !

!Entero methodsFor: 'testing' stamp: 'aa 9/14/2019 17:50:09'!
isZero
	
	^self subclassResponsibility ! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: #'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/8/2019 02:57:57'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos'! !

!Entero class methodsFor: 'instance creation' stamp: 'aa 9/14/2019 18:58:43'!
with: aValue 
	
	|cero uno|
	
	cero := Cero initalize.
	uno := Uno initalize .

	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	aValue = cero integerValue ifTrue: [^cero ].
	aValue = uno integerValue ifTrue: [^uno ].
	aValue  < (cero integerValue) ifTrue: [^Negativo new initalizeWith: aValue ].
	^Positivo new initalizeWith: aValue.! !


!classDefinition: #Cero category: #'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'testing' stamp: 'aa 9/14/2019 18:22:57'!
isNegative

	^false! !

!Cero methodsFor: 'testing' stamp: 'aa 9/14/2019 18:23:05'!
isOne

	^false! !

!Cero methodsFor: 'testing' stamp: 'aa 9/14/2019 19:01:01'!
isZero

	^true! !


!Cero methodsFor: 'initialization' stamp: 'aa 9/14/2019 20:15:28'!
divide: aDividend

	^Fraccion with: aDividend overCero: self! !

!Cero methodsFor: 'initialization' stamp: 'aa 9/14/2019 20:15:37'!
dividedByNegativo: aDivisor

	^Fraccion withCero: self overNegativo: aDivisor ! !

!Cero methodsFor: 'initialization' stamp: 'aa 9/14/2019 20:15:43'!
dividedByPositivo: aDivisor

	^Fraccion withCero: self overPositivo: aDivisor ! !


!Cero methodsFor: 'arithmetic operations' stamp: 'aa 9/14/2019 20:20:36'!
fibonacci

	^Uno initalize ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cero class' category: #'Numero-Exercise'!
Cero class
	instanceVariableNames: ''!

!Cero class methodsFor: 'instance creation' stamp: 'aa 9/14/2019 18:27:16'!
initalize

	^self new initalizeWith: 0 ! !


!classDefinition: #Negativo category: #'Numero-Exercise'!
Entero subclass: #Negativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Negativo methodsFor: 'initialization' stamp: 'aa 9/14/2019 20:15:49'!
divide: aDividend

	^Fraccion with: aDividend overNegativo: self.! !

!Negativo methodsFor: 'initialization' stamp: 'aa 9/14/2019 20:15:53'!
dividedByNegativo: aDivisor

	^Fraccion withNegativo: self overNegativo: aDivisor ! !

!Negativo methodsFor: 'initialization' stamp: 'aa 9/14/2019 20:15:58'!
dividedByPositivo: aDivisor

	^Fraccion withNegativo: self overPositivo: aDivisor ! !


!Negativo methodsFor: 'testing' stamp: 'aa 9/14/2019 17:51:59'!
isNegative

	^true! !

!Negativo methodsFor: 'testing' stamp: 'aa 9/14/2019 17:52:22'!
isOne

	^false! !

!Negativo methodsFor: 'testing' stamp: 'aa 9/14/2019 17:51:51'!
isZero

	^false! !


!Negativo methodsFor: 'arithmetic operations' stamp: 'aa 9/14/2019 20:18:57'!
fibonacci

	self error: Entero negativeFibonacciErrorDescription! !


!classDefinition: #Positivo category: #'Numero-Exercise'!
Entero subclass: #Positivo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Positivo methodsFor: 'testing' stamp: 'aa 9/14/2019 17:53:27'!
isNegative

	^false! !

!Positivo methodsFor: 'testing' stamp: 'aa 9/14/2019 17:54:36'!
isOne

	^false! !

!Positivo methodsFor: 'testing' stamp: 'aa 9/14/2019 17:54:46'!
isZero

	^false! !


!Positivo methodsFor: 'initialization' stamp: 'aa 9/14/2019 20:16:05'!
divide: aDividend

	^Fraccion with: aDividend overPositivo: self.! !

!Positivo methodsFor: 'initialization' stamp: 'aa 9/14/2019 20:16:09'!
dividedByNegativo: aDivisor

	^Fraccion withPositivo: self overNegativo: aDivisor ! !

!Positivo methodsFor: 'initialization' stamp: 'aa 9/14/2019 20:16:14'!
dividedByPositivo: aDivisor

	^Fraccion withPositivo: self overPositivo: aDivisor ! !


!classDefinition: #Uno category: #'Numero-Exercise'!
Positivo subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'testing' stamp: 'aa 9/14/2019 17:55:17'!
isOne

	^true! !


!Uno methodsFor: 'initialization' stamp: 'aa 9/14/2019 20:16:19'!
divide: aDividend

	^Fraccion with: aDividend overUno: self.! !

!Uno methodsFor: 'initialization' stamp: 'aa 9/14/2019 20:16:24'!
dividedByNegativo: aDivisor

	^Fraccion withUno: self overNegativo: aDivisor ! !

!Uno methodsFor: 'initialization' stamp: 'aa 9/14/2019 20:16:29'!
dividedByPositivo: aDivisor

	^Fraccion withUno: self overPositivo: aDivisor ! !


!Uno methodsFor: 'arithmetic operations' stamp: 'aa 9/14/2019 20:19:22'!
fibonacci

	^self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Uno class' category: #'Numero-Exercise'!
Uno class
	instanceVariableNames: ''!

!Uno class methodsFor: 'instance creation' stamp: 'aa 9/14/2019 18:28:31'!
initalize

	^self new initalizeWith: 1! !


!classDefinition: #Fraccion category: #'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'aa 9/12/2019 21:23:49'!
* aMultiplier 
	
	^aMultiplier multiplyAFraction: self
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'aa 9/12/2019 21:22:25'!
+ anAdder 
	
	^anAdder addAFraction: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'aa 9/12/2019 21:26:21'!
- aSubtrahend 
	
	^aSubtrahend subtractFromAFraction: self
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'aa 9/12/2019 21:28:34'!
/ aDivisor 
	
	^aDivisor divideAFraction: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'aa 9/12/2019 21:21:34'!
addAFraction: anAdder 
	
	| newNumerator newDenominator |
	
	newNumerator := (numerator * anAdder denominator) + (denominator * anAdder numerator).
	newDenominator := denominator * anAdder denominator.
	
	^newNumerator / newDenominator ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'aa 9/12/2019 21:53:49'!
addAnEntero: anAdder

	^anAdder addAFraction: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'aa 9/14/2019 15:46:25'!
divideAFraction: aDivisor

	^(denominator * aDivisor numerator) / (numerator * aDivisor denominator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'aa 9/14/2019 15:51:10'!
divideAnEntero: aDivisor

	^(denominator * aDivisor) / numerator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'aa 9/12/2019 21:23:18'!
multiplyAFraction: aMultiplier 
	
	^(numerator * aMultiplier numerator) / (denominator * aMultiplier denominator)
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'aa 9/12/2019 21:55:33'!
multiplyAnEntero: aMultiplier

	^aMultiplier multiplyAFraction: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'aa 9/12/2019 21:25:34'!
subtractFromAFraction: aSubtrahend 
	
	| newNumerator newDenominator |
	
	newNumerator := (denominator * aSubtrahend numerator) - (numerator * aSubtrahend denominator).
	newDenominator := denominator * aSubtrahend denominator.
	
	^newNumerator / newDenominator 
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'aa 9/14/2019 16:14:06'!
subtractFromEntero: aSubtrahend 
	
	^ aSubtrahend + self negated! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: #'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'aa 9/14/2019 20:07:37'!
reduceWith: aDividend over: aDivisor

	|greatestCommonDivisor numerator denominator|
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].
	
	^self new initializeWith: numerator over: denominator! !

!Fraccion class methodsFor: 'intance creation' stamp: 'aa 9/14/2019 19:16:34'!
with: aDividend over: aDivisor
	
	^aDivisor divide: aDividend
	! !

!Fraccion class methodsFor: 'intance creation' stamp: 'aa 9/14/2019 19:14:02'!
with: aDividend overCero: aDivisor
	
	^self error: self canNotDivideByZeroErrorDescription
	! !

!Fraccion class methodsFor: 'intance creation' stamp: 'aa 9/14/2019 20:01:28'!
with: aDividend overNegativo: aDivisor
	
	^aDividend dividedByNegativo: aDivisor 
	! !

!Fraccion class methodsFor: 'intance creation' stamp: 'aa 9/14/2019 20:01:20'!
with: aDividend overPositivo: aDivisor
	
	^aDividend dividedByPositivo: aDivisor 
	! !

!Fraccion class methodsFor: 'intance creation' stamp: 'aa 9/14/2019 20:09:41'!
with: aDividend overUno: aDivisor
	
	^aDividend
	! !

!Fraccion class methodsFor: 'intance creation' stamp: 'aa 9/14/2019 19:58:41'!
withCero: aDividend overNegativo: aDivisor
	
	^aDividend 
	! !

!Fraccion class methodsFor: 'intance creation' stamp: 'aa 9/14/2019 19:44:59'!
withCero: aDividend overPositivo: aDivisor
	
	^aDividend 
	! !

!Fraccion class methodsFor: 'intance creation' stamp: 'aa 9/14/2019 19:47:29'!
withNegativo: aDividend overNegativo: aDivisor
	
	^aDividend negated / aDivisor negated! !

!Fraccion class methodsFor: 'intance creation' stamp: 'aa 9/14/2019 20:12:00'!
withNegativo: aDividend overPositivo: aDivisor
	
	^self reduceWith: aDividend over: aDivisor ! !

!Fraccion class methodsFor: 'intance creation' stamp: 'aa 9/14/2019 19:47:16'!
withPositivo: aDividend overNegativo: aDivisor
	
	^aDividend negated / aDivisor negated! !

!Fraccion class methodsFor: 'intance creation' stamp: 'aa 9/14/2019 20:06:40'!
withPositivo: aDividend overPositivo: aDivisor
	
	^self reduceWith: aDividend over: aDivisor ! !

!Fraccion class methodsFor: 'intance creation' stamp: 'aa 9/14/2019 19:47:02'!
withUno: aDividend overNegativo: aDivisor
	
	^aDividend negated / aDivisor negated! !

!Fraccion class methodsFor: 'intance creation' stamp: 'aa 9/14/2019 19:56:02'!
withUno: aDividend overPositivo: aDivisor
	
	^self new initializeWith: aDividend over: aDivisor! !
