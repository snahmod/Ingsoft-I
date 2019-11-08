!classDefinition: #CartTest category: #TusLibros stamp: 'SN 11/7/2019 21:58:19'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros stamp: 'SN 11/7/2019 21:58:19'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #TusLibrosInternalInterfaceTest category: #TusLibros stamp: 'SN 11/7/2019 21:58:19'!
TestCase subclass: #TusLibrosInternalInterfaceTest
	instanceVariableNames: 'edenUser edenPassword userRegistry factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'SN 11/7/2019 20:54:11'!
test01CreateCartRaisesErrorWhenNonExistentUser

	| interface emptyUserRegistry |
	
	emptyUserRegistry := Dictionary new.

	interface := TusLibrosInternalInterface withUsers: emptyUserRegistry withCatalog: factory defaultCatalog .
	
	self should: [interface createCartFor: edenUser withPassword: edenPassword]
		 raise: Error - MessageNotUnderstood
		 withMessageText: 'Usuario no registrado'.
		
	self assert: interface carts isEmpty.
		 ! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'SN 11/7/2019 20:55:09'!
test02CreateCartRaisesErrorWhenPasswordDoesNotMatch

	| interface |

	interface := TusLibrosInternalInterface withUsers: userRegistry withCatalog: factory defaultCatalog .
	
	self should: [interface createCartFor: edenUser withPassword: 'wrong password']
		 raise: Error - MessageNotUnderstood
		 withMessageText: 'Contraseña incorrecta'.
		
	self assert: interface carts isEmpty.
		 ! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'SN 11/7/2019 20:55:26'!
test03CreateCartCreatesACartWithValidUser

	| interface cartID |

	interface := TusLibrosInternalInterface withUsers: userRegistry withCatalog: factory defaultCatalog .
	
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
		
	self assert: interface carts size equals: 1.
	self assert: (interface includesCartID: cartID).! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'SN 11/7/2019 21:05:23'!
test04CreateCartTwiceCreatesTwoCartsWithDifferentIDs

	| interface cartID1 cartID2 |

	interface := TusLibrosInternalInterface withUsers: userRegistry withCatalog: factory defaultCatalog .
	
	cartID1 := interface createCartFor: edenUser withPassword: edenPassword.
	cartID2 := interface createCartFor: edenUser withPassword: edenPassword.
		
	self assert: interface carts size equals: 2.
	self assert: (interface includesCartID: cartID1).
	self assert: (interface includesCartID: cartID2).
	self deny: cartID1 = cartID2 .! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'SN 11/7/2019 21:21:26'!
test05ListCartRaisesErrorWhenCartIDDoesNotExist

	| interface |

	interface := TusLibrosInternalInterface withUsers: userRegistry withCatalog: factory defaultCatalog .
		
	self should: [interface listCart: 'INVALID CART ID']
		 raise: Error - MessageNotUnderstood 
		 withMessageText: 'CartID inválido'.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'SN 11/7/2019 21:30:31'!
test06ListCartListsNothingWhenCartIsJustCreated

	| interface cartID |

	interface := TusLibrosInternalInterface withUsers: userRegistry withCatalog: factory defaultCatalog .
	
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
		
	self assert: (interface listCart: cartID ) isEmpty .! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'SN 11/7/2019 21:45:15'!
test07AddToCartRaisesErrorWhenCartIDDoesNotExist

	| interface |

	interface := TusLibrosInternalInterface withUsers: userRegistry withCatalog: factory defaultCatalog .
		
	self should: [interface addToCart: 'INVALID CART ID' item: factory itemSellByTheStore withQuantity: 1]
		 raise: Error - MessageNotUnderstood 
		 withMessageText: 'CartID inválido'.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'SN 11/7/2019 21:40:12'!
test08AddToCartRaisesErrorWhenItemIsNotSoldByTheStore

	| interface cartID |

	interface := TusLibrosInternalInterface withUsers: userRegistry withCatalog: factory defaultCatalog .
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
		
	self should: [interface addToCart: cartID item: factory itemNotSellByTheStore withQuantity: 1]
		 raise: Error - MessageNotUnderstood 
		 withMessageText: 'Item is not in catalog'.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'SN 11/7/2019 21:46:41'!
test09AddToCartRaisesErrorWhenQuantityIsZero

	| interface cartID |

	interface := TusLibrosInternalInterface withUsers: userRegistry withCatalog: factory defaultCatalog .
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
		
	self should: [interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 0]
		 raise: Error - MessageNotUnderstood 
		 withMessageText: 'Invalid number of items'.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'SN 11/7/2019 21:50:32'!
test10AddToCartListsOneItem

	| interface cartID |

	interface := TusLibrosInternalInterface withUsers: userRegistry withCatalog: factory defaultCatalog .
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
		
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 1.
	
	self assert: ((interface listCart: cartID ) includes: factory itemSellByTheStore ).
	self assert: ((interface listCart: cartID ) occurrencesOf: factory itemSellByTheStore ) equals: 1.! !


!TusLibrosInternalInterfaceTest methodsFor: 'setUp/tearDown' stamp: 'SN 11/7/2019 20:54:32'!
setUp

	edenUser := 'eden'.
	edenPassword := '12345678'.
	userRegistry := Dictionary new add: edenUser->edenPassword; yourself.
	factory := StoreTestObjectsFactory new.! !


!classDefinition: #Cart category: #TusLibros stamp: 'SN 11/7/2019 21:58:19'!
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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
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


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'accessing' stamp: 'SN 11/7/2019 21:57:14'!
list

	^items copy .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'SN 11/7/2019 21:58:19'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'SN 11/7/2019 21:58:19'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'SN 11/7/2019 21:58:19'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'SN 11/7/2019 21:58:19'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'SN 11/7/2019 21:58:19'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #Sale category: #TusLibros stamp: 'SN 11/7/2019 21:58:19'!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros stamp: 'SN 11/7/2019 21:58:19'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros stamp: 'SN 11/7/2019 21:58:19'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!classDefinition: #TusLibrosInternalInterface category: #TusLibros stamp: 'SN 11/7/2019 21:58:19'!
Object subclass: #TusLibrosInternalInterface
	instanceVariableNames: 'userRegistry carts catalog lastCartID'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInternalInterface methodsFor: 'initialization' stamp: 'SN 11/7/2019 21:11:25'!
initializeWithUsers: aUserRegistry withCatalog: aCatalog
	
	userRegistry := aUserRegistry.
	carts := Dictionary new.
	catalog := aCatalog.
	lastCartID := 0.! !


!TusLibrosInternalInterface methodsFor: 'cart managment' stamp: 'SN 11/7/2019 21:43:30'!
addToCart: aCartID item: anItem withQuantity: anAmount 
	
	self validateCartID: aCartID .
	
	(carts at: aCartID ) add: anAmount of: anItem .! !

!TusLibrosInternalInterface methodsFor: 'cart managment' stamp: 'SN 11/7/2019 21:13:20'!
createCartFor: aUserID withPassword: aPassword 
	
	| cartID |

	(userRegistry includesKey: aUserID) ifFalse: [self error: 'Usuario no registrado'].
	((userRegistry at: aUserID) = aPassword) ifFalse: [self error: 'Contraseña incorrecta'].

	cartID := self nextCartID .
	carts add: (cartID)->(Cart acceptingItemsOf: catalog).

	^cartID.! !

!TusLibrosInternalInterface methodsFor: 'cart managment' stamp: 'SN 11/7/2019 21:58:09'!
listCart: aCartID 
	
	self validateCartID: aCartID .

	^ (carts at: aCartID ) list.! !


!TusLibrosInternalInterface methodsFor: 'testing' stamp: 'SN 11/7/2019 21:06:52'!
includesCartID: aCartID

	^ carts includesKey: aCartID .! !


!TusLibrosInternalInterface methodsFor: 'cart managment - private' stamp: 'SN 11/7/2019 21:11:14'!
nextCartID

	lastCartID := lastCartID + 1.
	
	^ lastCartID.! !

!TusLibrosInternalInterface methodsFor: 'cart managment - private' stamp: 'SN 11/7/2019 21:42:02'!
validateCartID: aCartID

	(carts includesKey: aCartID) ifFalse: [self error: 'CartID inválido'].! !


!TusLibrosInternalInterface methodsFor: 'accessing' stamp: 'SN 11/7/2019 20:51:27'!
carts
	
	^ carts.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosInternalInterface class' category: #TusLibros stamp: 'SN 11/7/2019 21:58:19'!
TusLibrosInternalInterface class
	instanceVariableNames: ''!

!TusLibrosInternalInterface class methodsFor: 'instance creation' stamp: 'SN 11/7/2019 20:51:05'!
withUsers: aUserRegistry withCatalog: aCatalog
	
	^self new initializeWithUsers: aUserRegistry withCatalog: aCatalog.! !
