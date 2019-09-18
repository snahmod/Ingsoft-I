'From Cuis 5.0 [latest update: #3839] on 18 September 2019 at 4:09:36 pm'!
!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'emptyStack helloStack fivePrePrefixStack fivePrePrefixStackCopy letters fivePrePrefixList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'aa 9/17/2019 20:25:04'!
test01CreatingASentenceFinderDoesNotChangeAnEmptyStack

	SentenceFinderByPrefix with: emptyStack .
	
	self assert: emptyStack isEmpty .! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'aa 9/17/2019 20:27:15'!
test02CreatingASentenceFinderDoesNotChangeAFilledStack

	SentenceFinderByPrefix with: helloStack .
	
	self assert: helloStack size = 1.
	self assert: helloStack top = 'Hello'.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'aa 9/17/2019 20:45:11'!
test03SearchingWithAnEmptyStackReturnsEmptyList

	| sentenceFinder result randomPrefix |
	
	sentenceFinder := SentenceFinderByPrefix with: emptyStack .
	randomPrefix := (letters shuffled copyFrom: 1 to: letters size atRandom).
	
	result := sentenceFinder find: randomPrefix.
	
	self assert: result isEmpty ! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'aa 9/17/2019 20:46:58'!
test04SearchingWithHelloStackAndLongPrefixReturnsEmptyList

	| sentenceFinder result randomLongPrefix |
	
	sentenceFinder := SentenceFinderByPrefix with: helloStack .
	randomLongPrefix := (letters shuffled copyFrom: 1 to: letters size).
	
	result := sentenceFinder find: randomLongPrefix.
	
	self assert: result isEmpty ! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'aa 9/17/2019 20:50:04'!
test05SearchingWithHelloStackAndHellPrefixReturnsHelloList

	| sentenceFinder result |
	
	sentenceFinder := SentenceFinderByPrefix with: helloStack .
	
	result := sentenceFinder find: 'Hell'.
	
	self assert: result size = 1.
	self assert: result includes: 'Hello'.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'aa 9/17/2019 20:50:34'!
test06SearchingWithHelloStackAndLowercaseHellPrefixReturnsEmptyList

	| sentenceFinder result |
	
	sentenceFinder := SentenceFinderByPrefix with: helloStack .
	
	result := sentenceFinder find: 'hell'.
	
	self assert: result isEmpty .! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'aa 9/17/2019 21:01:28'!
test07SearchingWithBigStackAndPrefixForAllFrasesReturnsAllFrases

	| sentenceFinder result |
	
	sentenceFinder := SentenceFinderByPrefix with: fivePrePrefixStack .
	
	result := sentenceFinder find: 'Pre'.
	
	self assert: result size = 5.
	fivePrePrefixList do: [:element | self assert: result includes: element]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'aa 9/17/2019 22:38:37'!
test08SearchingWithBigStackAndPrefixForAllFrasesDoesNotChangeStack

	| sentenceFinder |
	
	sentenceFinder := SentenceFinderByPrefix with: fivePrePrefixStack .
	
	sentenceFinder find: 'Pre'.
	
	self assert: fivePrePrefixStack size = 5.
	5 timesRepeat: [self assert: fivePrePrefixStackCopy pop = fivePrePrefixStack pop]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'aa 9/17/2019 21:05:29'!
test09SearchingWithBigStackAndPrefixForSomeFrasesReturnsThoseFrases

	| sentenceFinder result |
	
	fivePrePrefixStack push: 'NOT_PRE_PREFIX1'.
	fivePrePrefixStack push: 'NOT_PRE_PREFIX2'.
	
	sentenceFinder := SentenceFinderByPrefix with: fivePrePrefixStack .
	
	result := sentenceFinder find: 'Pre'.
	
	self assert: result size = 5.
	fivePrePrefixList do: [:element | self assert: result includes: element]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'aa 9/17/2019 21:08:00'!
test10SearchingWithBigStackAndLowercasePrefixForSomeFrasesReturnsThoseFrases

	| sentenceFinder result |
	
	fivePrePrefixStack push: 'predicate'.
	fivePrePrefixStack push: 'previous'.
	
	sentenceFinder := SentenceFinderByPrefix with: fivePrePrefixStack .
	
	result := sentenceFinder find: 'pre'.
	
	self assert: result size = 2.
	self assert: result includes: 'predicate'.
	self assert: result includes: 'previous'.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'aa 9/17/2019 21:21:28'!
test11CantSearchWithEmptyPrefix

	| sentenceFinder |
	
	sentenceFinder := SentenceFinderByPrefix with: fivePrePrefixStack .
	
	self
		should: [ sentenceFinder find: '' ]
		raise: Error - MessageNotUnderstood
		description: SentenceFinderByPrefix emptyPrefixErrorDescription.
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'aa 9/17/2019 21:34:47'!
test12CantSearchWithPrefixWithEmptySpaces

	| sentenceFinder randomPrefix |
	
	sentenceFinder := SentenceFinderByPrefix with: fivePrePrefixStack .
	
	randomPrefix := (letters shuffled copyFrom: 1 to: letters size atRandom).
	
	self
		should: [ sentenceFinder find: (randomPrefix, ' ', randomPrefix) ]
		raise: Error - MessageNotUnderstood
		description: SentenceFinderByPrefix emptyPrefixErrorDescription.
! !


!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'aa 9/17/2019 22:38:17'!
setup

	emptyStack := OOStack new.
	
	helloStack := OOStack new.
	helloStack push: 'Hola'.	
	
	fivePrePrefixList := #('Predicate'  'Prediction' 'Prefix' 'Predicament' 'Previous').
	
	fivePrePrefixStack := OOStack new.	
	fivePrePrefixList do: [:element | fivePrePrefixStack push: element].
	
	
	fivePrePrefixStackCopy := OOStack new.	
	fivePrePrefixList do: [:element | fivePrePrefixStackCopy push: element].
	
	letters := 'abcdefghijklmnopqrstuvxyz'.! !
