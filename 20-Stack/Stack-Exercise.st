!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


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

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Eden 9/18/2019 16:58:40'!
test02CreatingASentenceFinderDoesNotChangeAFilledStack

	SentenceFinderByPrefix with: helloStack .
	
	self assert: (helloStack size) = 1.
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

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Eden 9/18/2019 16:50:26'!
test11CantSearchWithEmptyPrefix

	| sentenceFinder |
	
	sentenceFinder := SentenceFinderByPrefix with: fivePrePrefixStack .
	
	self
		should: [ sentenceFinder find: '' ]
		raise: Error - MessageNotUnderstood
		description: SentenceFinderByPrefix prefixIsEmpty.
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Eden 9/18/2019 16:50:12'!
test12CantSearchWithPrefixWithEmptySpaces

	| sentenceFinder randomPrefix |
	
	sentenceFinder := SentenceFinderByPrefix with: fivePrePrefixStack .
	
	randomPrefix := (letters shuffled copyFrom: 1 to: letters size atRandom).
	
	self
		should: [ sentenceFinder find: (randomPrefix, ' ', randomPrefix) ]
		raise: Error - MessageNotUnderstood
		description: SentenceFinderByPrefix prefixHasSpaces .
! !


!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'Eden 9/18/2019 17:06:15'!
setUp

	emptyStack := OOStack new.
	
	helloStack := OOStack new.
	helloStack push: 'Hello'.	
	
	fivePrePrefixList := #('Predicate'  'Prediction' 'Prefix' 'Predicament' 'Previous').
	
	fivePrePrefixStack := OOStack new.	
	fivePrePrefixList do: [:element | fivePrePrefixStack push: element].
	
	
	fivePrePrefixStackCopy := OOStack new.	
	fivePrePrefixList do: [:element | fivePrePrefixStackCopy push: element].
	
	letters := 'abcdefghijklmnopqrstuvxyz'.! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'aa 9/16/2019 21:46:32'!
initialize

	elements := OrderedCollection with: OOStackEmptyElement new.! !


!OOStack methodsFor: 'testing' stamp: 'aa 9/16/2019 19:55:07'!
isEmpty

	^self size = 0! !


!OOStack methodsFor: 'accessing' stamp: 'aa 9/16/2019 21:56:17'!
sendEmptyElement

	self error: OOStack stackEmptyErrorDescription ! !

!OOStack methodsFor: 'accessing' stamp: 'aa 9/16/2019 21:57:04'!
sendNotEmptyElement: aValue

	^aValue ! !

!OOStack methodsFor: 'accessing' stamp: 'aa 9/16/2019 21:48:13'!
size

	^elements size - 1! !

!OOStack methodsFor: 'accessing' stamp: 'aa 9/16/2019 21:58:28'!
top

	^elements first getValue: self! !


!OOStack methodsFor: 'removing' stamp: 'aa 9/16/2019 21:53:13'!
pop

	^elements removeFirst getValue: self .! !


!OOStack methodsFor: 'adding' stamp: 'aa 9/16/2019 21:47:07'!
push: anElement

	^elements addFirst: (OOStackNotEmptyElement with: anElement) .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OOStackElement category: #'Stack-Exercise'!
Object subclass: #OOStackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'accessing' stamp: 'aa 9/16/2019 21:59:55'!
getValue: aStack

	^self subclassResponsibility ! !


!classDefinition: #OOStackEmptyElement category: #'Stack-Exercise'!
OOStackElement subclass: #OOStackEmptyElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackEmptyElement methodsFor: 'accessing' stamp: 'aa 9/16/2019 21:54:37'!
getValue: aStack

	^aStack sendEmptyElement! !


!classDefinition: #OOStackNotEmptyElement category: #'Stack-Exercise'!
OOStackElement subclass: #OOStackNotEmptyElement
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackNotEmptyElement methodsFor: 'initialization' stamp: 'aa 9/16/2019 21:44:25'!
initalizeWith: aValue

	value := aValue ! !


!OOStackNotEmptyElement methodsFor: 'accessing' stamp: 'aa 9/16/2019 21:55:12'!
getValue: aStack

	^aStack sendNotEmptyElement: value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackNotEmptyElement class' category: #'Stack-Exercise'!
OOStackNotEmptyElement class
	instanceVariableNames: ''!

!OOStackNotEmptyElement class methodsFor: 'instance creation' stamp: 'aa 9/16/2019 21:45:52'!
with: aValue

	^self new initalizeWith: aValue ! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'testing' stamp: 'Eden 9/18/2019 17:08:57'!
find: aPrefix

	|elements elementsWithPrefix|.
	
	self validatePrefix:  aPrefix.
	
	elements := self getOrderCollectionFromStack. 
	elementsWithPrefix := elements select: [:element |  element beginsWith: aPrefix].
	self recoverStackFromOrderCollection: elements.

	^elementsWithPrefix
	
	! !

!SentenceFinderByPrefix methodsFor: 'testing' stamp: 'Eden 9/18/2019 16:55:35'!
validatePrefix: aPrefix
	
	'' = aPrefix ifTrue: [self error: SentenceFinderByPrefix prefixIsEmpty ].
	('*',' ', '*' match: aPrefix) ifTrue: [self error: SentenceFinderByPrefix prefixHasSpaces].! !


!SentenceFinderByPrefix methodsFor: 'private' stamp: 'Eden 9/17/2019 20:52:11'!
getOrderCollectionFromStack
	
	|elements|
	
	elements := OrderedCollection new.

	(stack size) timesRepeat: [
		elements addFirst: stack top.
		stack pop
	].
	
	^elements
	

	
! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'Eden 9/18/2019 17:16:38'!
recoverStackFromOrderCollection: anOrderCollection

	(anOrderCollection size) timesRepeat: [
		stack push: anOrderCollection first.
		anOrderCollection removeFirst.
	].
! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'Eden 9/17/2019 20:11:57'!
initializeWithStack: aStack
	stack := aStack! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: 'stack'!

!SentenceFinderByPrefix class methodsFor: 'error description' stamp: 'Eden 9/18/2019 16:38:54'!
prefixHasSpaces
	
	^ 'The prefix has spaces'! !

!SentenceFinderByPrefix class methodsFor: 'error description' stamp: 'Eden 9/18/2019 16:39:31'!
prefixIsEmpty
	
	^ 'Prefix is empty'! !


!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'Eden 9/17/2019 20:10:02'!
with: aStack
	
 	^SentenceFinderByPrefix new initializeWithStack: aStack! !
