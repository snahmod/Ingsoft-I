!classDefinition: #CartTest category: #TusLibros stamp: 'SN 11/7/2019 16:59:28'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'SN 11/4/2019 19:26:12'!
test09EmptyCartHasTotalPriceZero

	| cart |
	
	cart := self createCart.
	
	self assert:cart totalPrice equals: 0.! !

!CartTest methodsFor: 'tests' stamp: 'SN 11/4/2019 19:30:43'!
test10CartWithItemsHasTotalPriceSumOfItemsPriceAccordingToCatalog

	| cart |
	
	cart := self createCart.
	
	cart add: 3 of: self itemSellByTheStore .
	
	self assert: cart totalPrice equals: 3 * self priceOfItemSoldByStore .! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'SN 11/4/2019 19:28:14'!
defaultCatalog
	
	^ Dictionary new add: (self itemSellByTheStore)->(self priceOfItemSoldByStore); yourself! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !

!CartTest methodsFor: 'support' stamp: 'SN 11/4/2019 19:28:25'!
priceOfItemSoldByStore	
	
	^ 5.! !


!classDefinition: #CashierTest category: #TusLibros stamp: 'SN 11/7/2019 16:59:28'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'emptyCart aCard emptySalesBook catalog oneItemCart someOldDate someDate someFarDate mockedDebitFrom'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'SN 11/7/2019 16:55:25'!
test01CashierWithEmptyCartRaisesError

	|cashier_build|
	
	cashier_build := [Cashier for: emptyCart withCreditCard: aCard withSalesBook: emptySalesBook withDate: someDate withPaymentProcesor: self].
	
	self should: cashier_build 
		raise: Error - MessageNotUnderstood
		withMessageText: 'No se puede hacer checkout de un carrito vacio'.
	
	self assert: emptySalesBook isEmpty.! !

!CashierTest methodsFor: 'tests' stamp: 'SN 11/7/2019 16:55:31'!
test02CashierWithoneItemCartAndExpiredCartRaisesError

	| expiredCard cashier_build |
	
	expiredCard := CreditCard withNumber: '0000000000000000' withOwnerName: 'Eden Torres' withExpiration: someOldDate.
	
	cashier_build := [Cashier for: oneItemCart withCreditCard: expiredCard withSalesBook: emptySalesBook withDate: someDate withPaymentProcesor: self].
	
	
	self should: cashier_build 
		raise: Error - MessageNotUnderstood
		withMessageText: 'Tarjeta expirada'.
	
	self assert: emptySalesBook isEmpty.! !

!CashierTest methodsFor: 'tests' stamp: 'SN 11/7/2019 16:55:36'!
test03CashierWithoneItemCartAndValidCreditCardRaisesNoError

	| validCard |
	
	validCard := CreditCard withNumber: '0000000000000000' withOwnerName: 'Eden Torres' withExpiration: someFarDate.
	
	Cashier for: oneItemCart withCreditCard: validCard withSalesBook: emptySalesBook withDate: someDate withPaymentProcesor: self.
	
	self assert: emptySalesBook isEmpty.! !

!CashierTest methodsFor: 'tests' stamp: 'SN 11/7/2019 16:57:54'!
test04CashierWithOneItemCartAndValidCreditRaisesErrorAtCheckout

	| validCard cashier salesBook |
	
	salesBook := emptySalesBook .	
	validCard := CreditCard withNumber: '0000000000000000' withOwnerName: 'Eden Torres' withExpiration: someFarDate.
	
	mockedDebitFrom := [self error: 'SOME ERROR'].
	
	cashier := Cashier for: oneItemCart withCreditCard: validCard withSalesBook: salesBook withDate: someDate withPaymentProcesor: self.

	self should: [cashier checkout]
		raise: Error - MessageNotUnderstood 
		withMessageText: 'SOME ERROR'.
	
	self assert: salesBook isEmpty .! !

!CashierTest methodsFor: 'tests' stamp: 'SN 11/7/2019 16:59:20'!
test05CashierWithOneItemCartAndValidCreditRegistersSell

	| validCard cashier salesBook |
	
	salesBook := emptySalesBook .	
	validCard := CreditCard withNumber: '0000000000000000' withOwnerName: 'Eden Torres' withExpiration: someFarDate.
	
	mockedDebitFrom := ['OK'].
	
	cashier := Cashier for: oneItemCart withCreditCard: validCard withSalesBook: salesBook withDate: someDate withPaymentProcesor: self.
	cashier checkout.
	
	self assert: salesBook includes: oneItemCart totalPrice .! !


!CashierTest methodsFor: 'setUp/tearDown' stamp: 'SN 11/7/2019 16:51:51'!
setUp

	emptySalesBook := OrderedCollection new.
	catalog := Dictionary new add: 'validBook'->0; yourself.
	emptyCart := Cart acceptingItemsOf: catalog.
	oneItemCart := (Cart acceptingItemsOf: catalog) add: 'validBook'; yourself.
	someOldDate := GregorianMonthOfYear yearNumber: 1962 month: November.
	someDate := FixedGregorianDate yearNumber: 2020 month: March dayNumber: 20.
	someFarDate := FixedGregorianDate yearNumber: 2050 month: May dayNumber: 3.
	mockedDebitFrom := [].! !


!CashierTest methodsFor: 'mocking' stamp: 'SN 11/7/2019 16:51:32'!
debitFrom: aCreditCard

	^ mockedDebitFrom value.! !


!classDefinition: #Cart category: #TusLibros stamp: 'SN 11/7/2019 16:59:28'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'SN 11/4/2019 19:24:08'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'SN 11/4/2019 19:23:54'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !

!Cart methodsFor: 'testing' stamp: 'SN 11/4/2019 19:37:40'!
totalPrice
	
	^ items sum: [:item | catalog at: item ] ifEmpty: 0.! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'SN 11/7/2019 16:59:28'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'SN 11/7/2019 16:59:28'!
Object subclass: #Cashier
	instanceVariableNames: 'cart creditCard salesBook date amountToCharge paymentProcesor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'SN 11/7/2019 16:54:24'!
initializeFor: aCart withCreditCard: aCreditCard withSalesBook: aSalesBook withDate: aDate withPaymentProcesor: aPaymentProcesor
	
	cart := aCart.
	creditCard := aCreditCard.
	salesBook := aSalesBook .
	date := aDate .
	paymentProcesor := aPaymentProcesor .! !


!Cashier methodsFor: 'cobranding' stamp: 'SN 11/4/2019 20:45:06'!
checkout
	
	amountToCharge := cart totalPrice .
	self debit.
	salesBook add: amountToCharge .! !


!Cashier methodsFor: 'testing' stamp: 'SN 10/31/2019 21:53:00'!
priceCharged
	
	^ 0! !

!Cashier methodsFor: 'testing' stamp: 'SN 10/31/2019 21:53:50'!
soldItems
	
	^ OrderedCollection new.! !


!Cashier methodsFor: 'private cobranding' stamp: 'SN 11/7/2019 16:58:32'!
debit
	
	paymentProcesor debitFrom: creditCard .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'SN 11/7/2019 16:59:28'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'SN 11/7/2019 16:54:56'!
for: aCart withCreditCard: aCreditCard withSalesBook: aSalesBook withDate: aDate withPaymentProcesor: aPaymentProcesor

	aCart isEmpty ifTrue: [self error: 'No se puede hacer checkout de un carrito vacio'].
	
	(aCreditCard expiredAfter: aDate) ifTrue: [self error: 'Tarjeta expirada'].

	^self new initializeFor: aCart withCreditCard: aCreditCard withSalesBook: aSalesBook withDate: aDate withPaymentProcesor: aPaymentProcesor.! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'SN 11/7/2019 16:59:28'!
Object subclass: #CreditCard
	instanceVariableNames: 'number ownerName expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'SN 11/4/2019 20:16:45'!
initializeWithNumber: aNumber withOwnerName: anOwnerName withExpiration: anExpiration 
	
	number := aNumber.
	ownerName := anOwnerName.
	expirationDate := anExpiration.! !


!CreditCard methodsFor: 'testing' stamp: 'SN 11/4/2019 20:19:47'!
expiredAfter: aFixedGregorianDate 
	
	^ expirationDate < aFixedGregorianDate! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'SN 11/7/2019 16:59:28'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'SN 11/4/2019 20:07:11'!
withNumber: aNumber withOwnerName: anOwnerName withExpiration: anExpiration 
	
	^self new initializeWithNumber: aNumber withOwnerName: anOwnerName withExpiration: anExpiration ! !
