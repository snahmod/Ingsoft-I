!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testBehaviours' stamp: 'aa 9/6/2019 18:02:12'!
createCustomerBookWithCustomer: aCustomerName

	| customerBook |
	
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: aCustomerName.
	^customerBook ! !

!CustomerBookTest methodsFor: 'testBehaviours' stamp: 'aa 9/7/2019 15:08:15'!
verifyCustomerBook: customerBook hasNumberOfActiveCustomers: numberOfActiveCustomers andSuspendedCustomers: numberOfSuspendedCustomers

	self assert: numberOfActiveCustomers equals: customerBook numberOfActiveCustomers.
	self assert: numberOfSuspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: (numberOfActiveCustomers  + numberOfSuspendedCustomers) equals: customerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'testBehaviours' stamp: 'aa 9/6/2019 18:03:07'!
verifyThatClosureDoesNotChangeCustomerBook: closure andRaises: errorType
	
	| customerBook johnLennon |

	johnLennon := 'John Lennon'.
	customerBook := self createCustomerBookWithCustomer: johnLennon .
		
	self should: [closure value: customerBook value: johnLennon ] raise: errorType.
	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: johnLennon)	! !


!CustomerBookTest methodsFor: 'testing' stamp: 'aa 9/2/2019 19:33:33'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assert: (Time millisecondsToRun: [customerBook addCustomerNamed: 'John Lennon']) * millisecond < (50 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'aa 9/6/2019 18:03:47'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |

	paulMcCartney := 'Paul McCartney'.
	customerBook  := self createCustomerBookWithCustomer: paulMcCartney .
	
	self assert: (Time millisecondsToRun: [customerBook removeCustomerNamed: paulMcCartney.]) * millisecond < (100 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'aa 9/2/2019 20:30:56'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self should: [customerBook addCustomerNamed: ''] raise: Error description: CustomerBook customerCanNotBeEmptyErrorMessage.
	self assert: customerBook isEmpty! !

!CustomerBookTest methodsFor: 'testing' stamp: 'aa 9/7/2019 15:11:37'!
test04CanNotRemoveAnInvalidCustomer
	
	self verifyThatClosureDoesNotChangeCustomerBook: [:customerBook :customerName |
		customerBook removeCustomerNamed: 'NOT_A_CUSTOMER'
	] andRaises: NotFound! !

!CustomerBookTest methodsFor: 'testing' stamp: 'aa 9/7/2019 15:08:54'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook  := self createCustomerBookWithCustomer: paulMcCartney .
	
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self verifyCustomerBook: customerBook hasNumberOfActiveCustomers: 0 andSuspendedCustomers: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'aa 9/7/2019 15:09:30'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook  := self createCustomerBookWithCustomer: paulMcCartney .
	
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self verifyCustomerBook: customerBook hasNumberOfActiveCustomers: 0 andSuspendedCustomers: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'aa 9/6/2019 17:58:08'!
test07CanNotSuspendAnInvalidCustomer
	
	self verifyThatClosureDoesNotChangeCustomerBook: [:customerBook :customerName |
		customerBook suspendCustomerNamed: 'NOT_A_CUSTOMER'
	] andRaises: CantSuspend
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'aa 9/6/2019 17:57:54'!
test08CanNotSuspendAnAlreadySuspendedCustomer

	self verifyThatClosureDoesNotChangeCustomerBook: [ :customerBook :customerName |
		2 timesRepeat: [customerBook suspendCustomerNamed: customerName]
	] andRaises: CantSuspend ! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'aa 9/2/2019 19:21:32'!
isEmpty
	
	^self numberOfCustomers == 0! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'aa 9/2/2019 18:57:58'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'aa 9/2/2019 19:01:48'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'aa 9/2/2019 19:11:16'!
removeCustomerNamed: aName 
 
	^active remove: aName ifAbsent: [^suspended remove: aName ifAbsent: [^NotFound signal]].
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'aa 9/2/2019 19:16:37'!
suspendCustomerNamed: aName 
	
	active remove: aName ifAbsent: [^CantSuspend signal].
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/2/2019 14:41:10'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists.'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/2/2019 14:41:16'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty.'! !
