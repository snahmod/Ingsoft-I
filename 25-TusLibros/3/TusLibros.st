!classDefinition: #CartTest category: #TusLibros stamp: 'SN 11/17/2019 18:36:20'!
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


!classDefinition: #CashierTest category: #TusLibros stamp: 'SN 11/17/2019 18:36:20'!
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


!classDefinition: #TusLibrosInternalInterfaceTest category: #TusLibros stamp: 'SN 11/17/2019 18:36:20'!
TestCase subclass: #TusLibrosInternalInterfaceTest
	instanceVariableNames: 'edenUser edenPassword userRegistry factory stubbedTime debitBehavior santiUser santiPassword emptyUserRegistry'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInternalInterfaceTest methodsFor: 'clock protocol' stamp: 'Eden Torres 11/11/2019 18:07:09'!
localMillisecondClock
	
	^stubbedTime.! !


!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/14/2019 21:22:08'!
test01CreateCartRaisesErrorWhenNonExistentUser

	| interface |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: emptyUserRegistry. 
	
	self should: [interface createCartFor: edenUser withPassword: edenPassword]
		 raise: Error - MessageNotUnderstood
		 withMessageText: 'Usuario no registrado'.
		
	self assert: interface carts isEmpty.
		 ! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/11/2019 21:16:27'!
test02CreateCartRaisesErrorWhenPasswordDoesNotMatch

	| interface |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry.
	
	self should: [interface createCartFor: edenUser withPassword: 'wrong password']
		 raise: Error - MessageNotUnderstood
		 withMessageText: 'Contraseña incorrecta'.
		
	self assert: interface carts isEmpty.
		 ! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/11/2019 21:16:56'!
test03CreateCartCreatesACartWithValidUser

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry .
	
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
		
	self assert: interface carts size equals: 1.
	self assert: (interface includesCartID: cartID).! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/11/2019 21:17:02'!
test04CreateCartTwiceCreatesTwoCartsWithDifferentIDs

	| interface cartID1 cartID2 |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry .
	
	cartID1 := interface createCartFor: edenUser withPassword: edenPassword.
	cartID2 := interface createCartFor: edenUser withPassword: edenPassword.
		
	self assert: interface carts size equals: 2.
	self assert: (interface includesCartID: cartID1).
	self assert: (interface includesCartID: cartID2).
	self deny: cartID1 = cartID2 .! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/11/2019 21:17:15'!
test05ListCartRaisesErrorWhenCartIDDoesNotExist

	| interface |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry.
		
	self should: [interface listCart: 'INVALID CART ID']
		 raise: Error - MessageNotUnderstood 
		 withMessageText: 'CartID inválido'.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/11/2019 21:17:20'!
test06ListCartListsNothingWhenCartIsJustCreated

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry.
	
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
		
	self assert: (interface listCart: cartID ) isEmpty .! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/11/2019 21:17:28'!
test07AddToCartRaisesErrorWhenCartIDDoesNotExist

	| interface |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry.
		
	self should: [interface addToCart: 'INVALID CART ID' item: factory itemSellByTheStore withQuantity: 1]
		 raise: Error - MessageNotUnderstood 
		 withMessageText: 'CartID inválido'.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/11/2019 21:17:34'!
test08AddToCartRaisesErrorWhenItemIsNotSoldByTheStore

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
		
	self should: [interface addToCart: cartID item: factory itemNotSellByTheStore withQuantity: 1]
		 raise: Error - MessageNotUnderstood 
		 withMessageText: 'Item is not in catalog'.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/11/2019 21:17:46'!
test09AddToCartRaisesErrorWhenQuantityIsZero

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
		
	self should: [interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 0]
		 raise: Error - MessageNotUnderstood 
		 withMessageText: 'Invalid number of items'.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/11/2019 21:17:54'!
test10AddToCartListsOneItem

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
		
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 1.
	
	self assert: ((interface listCart: cartID ) includes: factory itemSellByTheStore ).
	self assert: ((interface listCart: cartID ) occurrencesOf: factory itemSellByTheStore ) equals: 1.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/11/2019 21:18:02'!
test11AddABookTwiceToCartListsTwoItem

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
		
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 2.
	
	self assert: ((interface listCart: cartID ) includes: factory itemSellByTheStore ).
	self assert: ((interface listCart: cartID ) occurrencesOf: factory itemSellByTheStore ) equals: 2.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/11/2019 21:18:08'!
test12AddTwoDifferentBookToCartListsTwoDifferentItems

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
		
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 1.
	interface addToCart: cartID item: factory anotherItemSellByTheStore withQuantity: 1.
	
	self assert: ((interface listCart: cartID ) includes: factory itemSellByTheStore ).
	self assert: ((interface listCart: cartID ) occurrencesOf: factory itemSellByTheStore ) equals: 1.
	
	self assert: ((interface listCart: cartID ) includes: factory anotherItemSellByTheStore ).
	self assert: ((interface listCart: cartID ) occurrencesOf: factory anotherItemSellByTheStore ) equals: 1.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/11/2019 21:18:14'!
test13ListCartDoesNotListItemNotIncludedInCart

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
		
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 1.
	
	self deny: ((interface listCart: cartID ) includes: factory anotherItemSellByTheStore).! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/11/2019 21:18:20'!
test14ShouldRaiseErrorWhenAddingAnItemToAnExpiredCart

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
	
	stubbedTime := stubbedTime + 31 minutes totalMilliseconds.
	
	self should: [interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 1.]
		raise: Error - MessageNotUnderstood
		withMessageText: 'Carrito expirado'. 
	
	self assert: interface carts isEmpty.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/11/2019 21:18:27'!
test15ShouldRaiseErrorWhenListingAnExpiredCart

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
	
	stubbedTime := stubbedTime + 31 minutes totalMilliseconds.
	
	self should: [interface listCart: cartID.]
		raise: Error - MessageNotUnderstood
		withMessageText: 'Carrito expirado'. 
	
	self assert: interface carts isEmpty.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/11/2019 21:18:33'!
test16ShouldNotRaiseErrorWhenAddingAnItemTo30minOldCart

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
	
	stubbedTime := stubbedTime + 30 minutes totalMilliseconds.
	
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 1.
	
	self assert: interface carts size equals: 1.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/11/2019 21:18:40'!
test17ShouldNotRaiseErrorWhenAddingBooksToCartWithLagOf30minutes

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
	
	stubbedTime := stubbedTime + 30 minutes totalMilliseconds.
	
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 1.
	
	stubbedTime := stubbedTime + 30 minutes totalMilliseconds.
	
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 1.
	
	self assert: interface carts size equals: 1.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/14/2019 20:54:55'!
test18CheckoutCartShouldRaiseErrorWithInvalidCartId

	| interface |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry.
		
	self should: [interface checkoutCart: 'invalid id' withCreditCardNumber: factory notExpiredCreditCard number withCreditCardName:
	factory notExpiredCreditCard name withExpritationDate: factory notExpiredCreditCard expirationDate on: factory today] 
		raise: Error - MessageNotUnderstood  
		withMessageText: 'CartID inválido'.

	self assert: interface carts isEmpty.
	self assert: (interface listPurchaseFor: edenUser withPassword: edenPassword) first isEmpty. 
	self assert: (interface listPurchaseFor: edenUser withPassword: edenPassword) second equals: 0. ! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/14/2019 20:55:01'!
test19CheckoutCartShouldRaiseErrorWithEmptyCardName

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 1.
		
	self should: [interface checkoutCart: cartID withCreditCardNumber: factory emptyNameCreditCard number withCreditCardName:
	factory emptyNameCreditCard name withExpritationDate: factory emptyNameCreditCard expirationDate on: factory today] 
		raise: Error - MessageNotUnderstood  
		withMessageText: 'Nombre de la tarjeta inválido'.

	self assert: interface carts size equals: 1.
	self assert: (interface listPurchaseFor: edenUser withPassword: edenPassword) first isEmpty.
	self assert: (interface listPurchaseFor: edenUser withPassword: edenPassword) second equals: 0.  ! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/14/2019 20:55:07'!
test20CheckoutCartShouldRaiseErrorWithTooLongCardName

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 1.
		
	self should: [interface checkoutCart: cartID withCreditCardNumber: factory tooLongNameCreditCard number withCreditCardName:
	factory tooLongNameCreditCard name withExpritationDate: factory tooLongNameCreditCard expirationDate on: factory today] 
		raise: Error - MessageNotUnderstood  
		withMessageText: 'Nombre de la tarjeta inválido'.

	self assert: interface carts size equals: 1.
	self assert: (interface listPurchaseFor: edenUser withPassword: edenPassword) first isEmpty.
	self assert: (interface listPurchaseFor: edenUser withPassword: edenPassword) second equals: 0.  ! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/14/2019 20:55:12'!
test21CheckoutCartShouldRaiseErrorWithExpiredCard

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 1.
		
	self should: [interface checkoutCart: cartID withCreditCardNumber: factory expiredCreditCard number withCreditCardName:
	factory expiredCreditCard name withExpritationDate: factory expiredCreditCard expirationDate on: factory today] 
		raise: Error - MessageNotUnderstood  
		withMessageText: 'Can not charge an expired credit card'.

	self assert: interface carts size equals: 1.
	self assert: (interface listPurchaseFor: edenUser withPassword: edenPassword) first isEmpty. 
	self assert: (interface listPurchaseFor: edenUser withPassword: edenPassword) second equals: 0. ! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/14/2019 20:55:23'!
test22CheckoutCartShouldRaiseErrorWithEmptyCart

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
		
	self should: [interface checkoutCart: cartID withCreditCardNumber: factory notExpiredCreditCard number withCreditCardName:
	factory notExpiredCreditCard name withExpritationDate: factory notExpiredCreditCard expirationDate on: factory today] 
		raise: Error - MessageNotUnderstood  
		withMessageText: 'Can not check out an empty cart'.

	self assert: interface carts size equals: 1.
	self assert: (interface listPurchaseFor: edenUser withPassword: edenPassword) first isEmpty. 
	self assert: (interface listPurchaseFor: edenUser withPassword: edenPassword) second equals: 0. ! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/14/2019 20:56:30'!
test23CheckoutCartWithOneElementListsOnePurchase

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
	
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 1.
		
	interface checkoutCart: cartID withCreditCardNumber: factory notExpiredCreditCard number
			    withCreditCardName: factory notExpiredCreditCard name withExpritationDate: factory notExpiredCreditCard
			    expirationDate on: factory today.


	self assert: interface carts isEmpty.
	self assert: (interface listPurchaseFor: edenUser withPassword: edenPassword) first includes: factory itemSellByTheStore .
	self assert: (interface listPurchaseFor: edenUser withPassword: edenPassword) second equals: factory itemSellByTheStorePrice .  ! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/14/2019 21:00:44'!
test24CheckoutCartWithTwoElementListsTwoPurchase

	| interface cartID listPurchase totalPurchaseAmount |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
	
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 1.
	interface addToCart: cartID item: factory anotherItemSellByTheStore withQuantity: 1.
		
	interface checkoutCart: cartID withCreditCardNumber: factory notExpiredCreditCard number
			    withCreditCardName: factory notExpiredCreditCard name withExpritationDate: factory notExpiredCreditCard
			    expirationDate on: factory today.
			
	totalPurchaseAmount := factory itemSellByTheStorePrice + factory anotherItemSellByTheStorePrice.
	listPurchase := interface listPurchaseFor: edenUser withPassword: edenPassword.

	self assert: interface carts isEmpty.
	self assert: listPurchase first size equals: 2 .
	self assert: listPurchase first includes: factory itemSellByTheStore .
	self assert: listPurchase first includes: factory anotherItemSellByTheStore.
	self assert: listPurchase second equals:  totalPurchaseAmount.  
	! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/14/2019 21:13:36'!
test25CheckoutCartWithTwoEqualElementsListsTwoPurchase

	| interface cartID listPurchase totalPurchaseAmount |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
	
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 2.
		
	interface checkoutCart: cartID withCreditCardNumber: factory notExpiredCreditCard number
			    withCreditCardName: factory notExpiredCreditCard name withExpritationDate: factory notExpiredCreditCard
			    expirationDate on: factory today.
			
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
	
	interface addToCart: cartID item: factory anotherItemSellByTheStore withQuantity: 2.
		
	interface checkoutCart: cartID withCreditCardNumber: factory notExpiredCreditCard number
			    withCreditCardName: factory notExpiredCreditCard name withExpritationDate: factory notExpiredCreditCard
			    expirationDate on: factory today.
			
	totalPurchaseAmount := (factory itemSellByTheStorePrice * 2) + (factory anotherItemSellByTheStorePrice  * 2).
	listPurchase := interface listPurchaseFor: edenUser withPassword: edenPassword.

	self assert: interface carts isEmpty.
	self assert: listPurchase first size equals: 4 .
	self assert: (listPurchase  first  occurrencesOf: factory itemSellByTheStore) equals: 2.
	self assert: (listPurchase  first  occurrencesOf: factory anotherItemSellByTheStore ) equals: 2.
	self assert: listPurchase second equals:  totalPurchaseAmount.  
	! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/14/2019 21:15:20'!
test26CheckoutCartWithOneElementListsOnlySameUserPurchases

	| interface cartID listPurchaseEden listPurchaseSanti |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
	
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 1.
		
	interface checkoutCart: cartID withCreditCardNumber: factory notExpiredCreditCard number
			    withCreditCardName: factory notExpiredCreditCard name withExpritationDate: factory notExpiredCreditCard
			    expirationDate on: factory today.
			
	cartID := interface createCartFor: santiUser withPassword: santiPassword .
	
	interface addToCart: cartID item: factory anotherItemSellByTheStore withQuantity: 1.
		
	interface checkoutCart: cartID withCreditCardNumber: factory notExpiredCreditCard number
			    withCreditCardName: factory notExpiredCreditCard name withExpritationDate: factory notExpiredCreditCard
			    expirationDate on: factory today.
			
	listPurchaseEden := interface listPurchaseFor: edenUser withPassword: edenPassword.
	listPurchaseSanti := interface listPurchaseFor: santiUser withPassword: santiPassword .

	self assert: interface carts isEmpty.
	self assert: listPurchaseEden first size equals: 1.
	self assert: listPurchaseEden first includes: factory itemSellByTheStore .
	self assert: listPurchaseEden second equals: factory itemSellByTheStorePrice .  
	
	self assert: listPurchaseSanti first size equals: 1.
	self assert: listPurchaseSanti first includes: factory anotherItemSellByTheStore .
	self assert: listPurchaseSanti second equals: factory anotherItemSellByTheStorePrice . ! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/14/2019 21:22:36'!
test27ListPurchasesRaisesErrorWhenTheUserDoesNotExist

	| interface |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: emptyUserRegistry .
			
	self should: [interface listPurchaseFor: edenUser withPassword: edenPassword]
		 raise: Error - MessageNotUnderstood 
		 withMessageText: 'Usuario no registrado'.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/14/2019 21:24:06'!
test28ListPurchasesRaisesErrorWhenTheUserAndPasswordDontMatch

	| interface |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry .
			
	self should: [interface listPurchaseFor: edenUser withPassword: santiPassword ]
		 raise: Error - MessageNotUnderstood 
		 withMessageText: 'Contraseña incorrecta'.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/14/2019 21:28:07'!
test29ListPurchasesIsEmptyWhenTheUserDoesntCheckout

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry .
	cartID := interface createCartFor: edenUser withPassword: edenPassword .
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 38.
			
	self assert: (interface listPurchaseFor: edenUser withPassword: edenPassword ) first isEmpty .
	self assert: (interface listPurchaseFor: edenUser withPassword: edenPassword ) second equals: 0 .! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/14/2019 21:39:40'!
test30CheckoutCartShouldRaiseErrorWithExpiredCart

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 38.
	
	stubbedTime := stubbedTime + 31 minutes totalMilliseconds.
		
	self should: [interface checkoutCart: cartID withCreditCardNumber: factory notExpiredCreditCard number withCreditCardName:
	factory notExpiredCreditCard name withExpritationDate: factory notExpiredCreditCard expirationDate on: factory today] 
		raise: Error - MessageNotUnderstood  
		withMessageText: 'Carrito expirado'.

	self assert: interface carts isEmpty.
	self assert: (interface listPurchaseFor: edenUser withPassword: edenPassword) first isEmpty. 
	self assert: (interface listPurchaseFor: edenUser withPassword: edenPassword) second equals: 0. ! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/14/2019 21:42:50'!
test31CheckoutCartShouldRaiseErrorWithMerchantProcessorError

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 38.
	
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
		
	self should: [interface checkoutCart: cartID withCreditCardNumber: factory notExpiredCreditCard number withCreditCardName:
	factory notExpiredCreditCard name withExpritationDate: factory notExpiredCreditCard expirationDate on: factory today] 
		raise: Error - MessageNotUnderstood  
		withMessageText: Cashier creditCardHasNoCreditErrorMessage.

	self assert: interface carts size equals: 1.
	self assert: (interface listPurchaseFor: edenUser withPassword: edenPassword) first isEmpty. 
	self assert: (interface listPurchaseFor: edenUser withPassword: edenPassword) second equals: 0. ! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'SN 11/17/2019 18:28:36'!
test32CheckoutCartWithOneElementHasOneItemInTicket

	| interface cartID ticket |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
	
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 1.
		
	ticket := interface checkoutCart: cartID withCreditCardNumber: factory notExpiredCreditCard number
			    		 withCreditCardName: factory notExpiredCreditCard name withExpritationDate: factory notExpiredCreditCard
			    		 expirationDate on: factory today.


	self assert: interface carts isEmpty.
	self assert: ticket first includes: factory itemSellByTheStore .
	self assert: ticket second equals: factory itemSellByTheStorePrice .  ! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'SN 11/17/2019 18:35:05'!
test33CheckoutCartWithManyElementHasItemsInTicket

	| interface cartID ticket totalPurchaseAmount |

	interface := self createTusLibrosInternalInterfaceWithSalesBook: OrderedCollection new userRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
	
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 3.
	interface addToCart: cartID item: factory anotherItemSellByTheStore withQuantity: 2.
		
	ticket := interface checkoutCart: cartID withCreditCardNumber: factory notExpiredCreditCard number
			    		 withCreditCardName: factory notExpiredCreditCard name withExpritationDate: factory notExpiredCreditCard
			    		 expirationDate on: factory today.

	totalPurchaseAmount := (factory itemSellByTheStorePrice * 3) + (factory anotherItemSellByTheStorePrice * 2).

	self assert: interface carts isEmpty.
	self assert: ticket first size equals: 5.
	self assert: (ticket first occurrencesOf: factory itemSellByTheStore) equals: 3 .
	self assert: (ticket first occurrencesOf: factory anotherItemSellByTheStore ) equals: 2 .
	self assert: ticket second equals: totalPurchaseAmount.	! !


!TusLibrosInternalInterfaceTest methodsFor: 'setUp/tearDown' stamp: 'Eden Torres 11/14/2019 21:22:23'!
setUp

	edenUser := 'eden'.
	edenPassword := '12345678'.
	santiUser := 'santinah'.
	santiPassword := 'the.best'.
	userRegistry := Dictionary new add: edenUser->edenPassword; add: santiUser -> santiPassword ; yourself.
	emptyUserRegistry := Dictionary new.
	factory := StoreTestObjectsFactory new.
	stubbedTime := 1.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!TusLibrosInternalInterfaceTest methodsFor: 'initialization' stamp: 'Eden Torres 11/11/2019 21:12:26'!
createTusLibrosInternalInterface

	! !

!TusLibrosInternalInterfaceTest methodsFor: 'initialization' stamp: 'Eden Torres 11/14/2019 19:57:00'!
createTusLibrosInternalInterfaceWithSalesBook: aSalesBook userRegistry: aUserRegistry

	^TusLibrosInternalInterface withUsers: aUserRegistry withCatalog: factory defaultCatalog 
										withClock: self withAMerchantProcessor: self.! !


!TusLibrosInternalInterfaceTest methodsFor: 'merchant procesor protocol' stamp: 'Eden Torres 11/14/2019 20:00:51'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #Cart category: #TusLibros stamp: 'SN 11/17/2019 18:36:20'!
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

!classDefinition: 'Cart class' category: #TusLibros stamp: 'SN 11/17/2019 18:36:20'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartInterface category: #TusLibros stamp: 'SN 11/17/2019 18:36:20'!
Object subclass: #CartInterface
	instanceVariableNames: 'catalog items cart timeLastModified clock userID'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartInterface methodsFor: 'initialization' stamp: 'Eden Torres 11/14/2019 21:38:11'!
add: anAmount of: anItem

	cart add: anAmount of: anItem.
	timeLastModified := clock localMillisecondClock.! !

!CartInterface methodsFor: 'initialization' stamp: 'Eden Torres 11/14/2019 17:50:26'!
initialiazeWithCatalog: aCatalog withClock: aClock withUserID: aUserID

	cart := Cart acceptingItemsOf: aCatalog.
	timeLastModified := aClock localMillisecondClock.
	clock := aClock. 
	userID := aUserID .! !

!CartInterface methodsFor: 'initialization' stamp: 'Eden Torres 11/14/2019 21:38:17'!
list 
	
	timeLastModified := clock localMillisecondClock.
	^ cart list.! !


!CartInterface methodsFor: 'testing' stamp: 'Eden Torres 11/11/2019 18:42:16'!
IsExpired

	^ timeLastModified + 30 minutes totalMilliseconds < clock localMillisecondClock.! !

!CartInterface methodsFor: 'testing' stamp: 'Eden Torres 11/11/2019 21:51:53'!
isEmpty
	
	^cart isEmpty ! !


!CartInterface methodsFor: 'accessing' stamp: 'Eden Torres 11/14/2019 19:58:58'!
total

	^ cart total .! !

!CartInterface methodsFor: 'accessing' stamp: 'Eden Torres 11/14/2019 18:09:24'!
userID

	^ userID .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartInterface class' category: #TusLibros stamp: 'SN 11/17/2019 18:36:20'!
CartInterface class
	instanceVariableNames: ''!

!CartInterface class methodsFor: 'instance creation' stamp: 'Eden Torres 11/14/2019 17:51:03'!
withCatalog: aCatalog withClock: aClock withUserID: aUserID

	^ self new initialiazeWithCatalog: aCatalog withClock: aClock withUserID: aUserID .! !


!classDefinition: #Cashier category: #TusLibros stamp: 'SN 11/17/2019 18:36:20'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'Eden Torres 11/14/2019 19:56:16'!
createSale

	^ Sale of: total withItems: cart list .
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

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'SN 11/17/2019 18:36:20'!
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


!classDefinition: #CreditCard category: #TusLibros stamp: 'SN 11/17/2019 18:36:20'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'Eden Torres 11/11/2019 20:46:37'!
initializeExpiringOn: aMonth withName: aName withNumber: aNumber
	
	expiration := aMonth.
	number := aNumber. 
	name := aName.! !


!CreditCard methodsFor: 'accessing' stamp: 'Eden Torres 11/11/2019 20:51:30'!
expirationDate

	^expiration.! !

!CreditCard methodsFor: 'accessing' stamp: 'Eden Torres 11/11/2019 20:51:06'!
name

	^name.! !

!CreditCard methodsFor: 'accessing' stamp: 'Eden Torres 11/11/2019 20:51:16'!
number

	^number.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'SN 11/17/2019 18:36:20'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'Eden Torres 11/11/2019 21:57:06'!
expiringOn: aMonth withName: aName withNumber: aNumber

	aName isEmpty ifTrue: [self error: 'Nombre de la tarjeta inválido'].
	aName size > 30 ifTrue: [self error: 'Nombre de la tarjeta inválido'].
	
	^self new initializeExpiringOn: aMonth withName: aName withNumber: aNumber.! !


!classDefinition: #Sale category: #TusLibros stamp: 'SN 11/17/2019 18:36:20'!
Object subclass: #Sale
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

!Sale methodsFor: 'initialization' stamp: 'Eden Torres 11/14/2019 19:55:01'!
initializeTotal: aTotal items: someItems

	total := aTotal.
	items := someItems.! !


!Sale methodsFor: 'items' stamp: 'Eden Torres 11/14/2019 20:10:51'!
items

	^ items.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros stamp: 'SN 11/17/2019 18:36:20'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'Eden Torres 11/14/2019 19:53:58'!
of: aTotal withItems: items

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal items: items.! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros stamp: 'SN 11/17/2019 18:36:20'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'Eden Torres 11/11/2019 16:49:56'!
anotherItemSellByTheStore
	
	^ 'anotherValidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'Eden Torres 11/14/2019 20:59:03'!
anotherItemSellByTheStorePrice
	
	^5! !

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

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'Eden Torres 11/14/2019 20:58:50'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self anotherItemSellByTheStore  put: self anotherItemSellByTheStorePrice; 
		yourself! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'Eden Torres 11/11/2019 21:52:43'!
emptyNameCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1) withName: '' withNumber: '424242424242'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'Eden Torres 11/11/2019 20:48:29'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1) withName: 'Juan Perez' withNumber: '424242424242'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'Eden Torres 11/11/2019 20:48:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1) withName: 'Juan Perez' withNumber: '424242424242'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'Eden Torres 11/11/2019 21:52:49'!
tooLongNameCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1) withName: 'Juan Perez de la Santa Teresita Veregara Cortez' withNumber: '42424242424242'! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!classDefinition: #TusLibrosInternalInterface category: #TusLibros stamp: 'SN 11/17/2019 18:36:20'!
Object subclass: #TusLibrosInternalInterface
	instanceVariableNames: 'userRegistry carts catalog lastCartID clock salesBooks merchantProcessor purchases'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInternalInterface methodsFor: 'initialization' stamp: 'Eden Torres 11/14/2019 19:50:07'!
initializeWithUsers: aUserRegistry withCatalog: aCatalog withClock: aClock withAMerchantProcessor: aMerchantProcessor
	
	userRegistry := aUserRegistry.
	carts := Dictionary new.
	catalog := aCatalog.
	lastCartID := 0.
	clock := aClock.
	salesBooks := Dictionary new.
	merchantProcessor := aMerchantProcessor.
	
	userRegistry keysDo: [ :userID | salesBooks at: userID put: OrderedCollection new].! !


!TusLibrosInternalInterface methodsFor: 'cart managment' stamp: 'Eden Torres 11/11/2019 19:02:08'!
addToCart: aCartID item: anItem withQuantity: anAmount 
	
	self validateCartWith: aCartID. 
	
	(carts at: aCartID ) add: anAmount of: anItem .! !

!TusLibrosInternalInterface methodsFor: 'cart managment' stamp: 'SN 11/17/2019 18:30:35'!
checkoutCart: aCartID withCreditCardNumber: aNumber withCreditCardName: aName withExpritationDate: anExpirationDate on: aDate
	
	| creditCard cart cashier items total |
	
	self validateCartWith: aCartID.
	cart := carts at: aCartID.
	
	creditCard := CreditCard expiringOn: anExpirationDate  withName: aName  withNumber: aNumber.
	cashier := Cashier toCheckout: cart charging: creditCard  throught: merchantProcessor
						 on: aDate registeringOn: (salesBooks at: cart userID ).
	total := cashier checkOut.
	items := cart list .
	
	carts removeKey: aCartID.
	
	^ OrderedCollection with: items with: total.! !

!TusLibrosInternalInterface methodsFor: 'cart managment' stamp: 'Eden Torres 11/14/2019 20:20:04'!
createCartFor: aUserID withPassword: aPassword 
	
	| cartID |

	self authenticateUser: aUserID withPassword: aPassword .

	cartID := self nextCartID .
	carts add: (cartID)->(CartInterface withCatalog: catalog withClock: clock withUserID: aUserID ).

	^cartID.! !

!TusLibrosInternalInterface methodsFor: 'cart managment' stamp: 'Eden Torres 11/11/2019 19:02:16'!
listCart: aCartID 
	
	self validateCartWith: aCartID. 

	^ (carts at: aCartID ) list.! !


!TusLibrosInternalInterface methodsFor: 'testing' stamp: 'SN 11/7/2019 21:06:52'!
includesCartID: aCartID

	^ carts includesKey: aCartID .! !


!TusLibrosInternalInterface methodsFor: 'cart managment - private' stamp: 'SN 11/7/2019 21:11:14'!
nextCartID

	lastCartID := lastCartID + 1.
	
	^ lastCartID.! !

!TusLibrosInternalInterface methodsFor: 'cart managment - private' stamp: 'Eden Torres 11/11/2019 18:43:28'!
validateCartExpiration: aCartID

	(carts at: aCartID) IsExpired ifTrue: [carts removeKey: aCartID. self error: 'Carrito expirado'].! !

!TusLibrosInternalInterface methodsFor: 'cart managment - private' stamp: 'SN 11/7/2019 21:42:02'!
validateCartID: aCartID

	(carts includesKey: aCartID) ifFalse: [self error: 'CartID inválido'].! !

!TusLibrosInternalInterface methodsFor: 'cart managment - private' stamp: 'Eden Torres 11/11/2019 19:01:31'!
validateCartWith: cartID
	
	self validateCartID: cartID. 
	self validateCartExpiration: cartID.
	! !


!TusLibrosInternalInterface methodsFor: 'accessing' stamp: 'SN 11/7/2019 20:51:27'!
carts
	
	^ carts.! !


!TusLibrosInternalInterface methodsFor: 'user management' stamp: 'Eden Torres 11/14/2019 20:21:12'!
listPurchaseFor: aUserID withPassword: aPassword 
	
	| items sales total |
	
	self authenticateUser: aUserID withPassword: aPassword .

	sales := salesBooks at: aUserID .
	items := self itemsInSales: sales.
	total := self totalOfSales: sales.
	^ Array with: items with: total .! !


!TusLibrosInternalInterface methodsFor: 'user management - private' stamp: 'Eden Torres 11/14/2019 20:20:41'!
authenticateUser: aUserID withPassword: aPassword
	
	(userRegistry includesKey: aUserID) ifFalse: [self error: 'Usuario no registrado'].
	((userRegistry at: aUserID) = aPassword) ifFalse: [self error: 'Contraseña incorrecta'].! !

!TusLibrosInternalInterface methodsFor: 'user management - private' stamp: 'Eden Torres 11/14/2019 20:10:04'!
itemsInSales: sales

	^ sales inject: OrderedCollection new into: [:items :sale | items addAll: sale items; yourself]! !

!TusLibrosInternalInterface methodsFor: 'user management - private' stamp: 'Eden Torres 11/14/2019 20:22:19'!
totalOfSales: sales

	^ sales sum: [ :sale| sale total ] ifEmpty: [0].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosInternalInterface class' category: #TusLibros stamp: 'SN 11/17/2019 18:36:20'!
TusLibrosInternalInterface class
	instanceVariableNames: ''!

!TusLibrosInternalInterface class methodsFor: 'instance creation' stamp: 'Eden Torres 11/14/2019 19:47:42'!
withUsers: aUserRegistry withCatalog: aCatalog withClock: aClock withAMerchantProcessor: aMerchantProcessor
	
	^self new initializeWithUsers: aUserRegistry withCatalog: aCatalog withClock: aClock withAMerchantProcessor: aMerchantProcessor.! !
