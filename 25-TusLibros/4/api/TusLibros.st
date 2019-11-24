!classDefinition: #CartTest category: #TusLibros stamp: 'SN 11/24/2019 18:12:17'!
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

!CartTest methodsFor: 'tests' stamp: 'SN 11/24/2019 17:56:09'!
test09CanNotRemoveItemsThatDoNotBelongToCart

	| cart |
	
	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore .
	
	self 
		should: [ cart remove: testObjectsFactory anotherItemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Item is not in cart'.
			self deny: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'SN 11/24/2019 18:02:47'!
test10RemoveCorrectItem

	| cart |
	
	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore .
	cart add: testObjectsFactory anotherItemSellByTheStore .
	
	cart remove: testObjectsFactory itemSellByTheStore .
	
	self assert: cart list includes: testObjectsFactory anotherItemSellByTheStore .
	self deny: (cart list includes: testObjectsFactory itemSellByTheStore ).! !

!CartTest methodsFor: 'tests' stamp: 'SN 11/24/2019 18:02:37'!
test11RemoveCorrectItemOnce

	| cart |
	
	cart := testObjectsFactory createCart.
	cart add: 5 of: testObjectsFactory itemSellByTheStore .
	cart add: testObjectsFactory anotherItemSellByTheStore .
	
	cart remove: testObjectsFactory itemSellByTheStore .
	
	self assert: cart list includes: testObjectsFactory anotherItemSellByTheStore .
	self assert: (cart list occurrencesOf: testObjectsFactory itemSellByTheStore ) equals: 4.! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros stamp: 'SN 11/24/2019 18:12:17'!
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


!classDefinition: #TusLibrosInternalInterfaceTest category: #TusLibros stamp: 'SN 11/24/2019 18:12:17'!
TestCase subclass: #TusLibrosInternalInterfaceTest
	instanceVariableNames: 'edenUser edenPassword userRegistry factory stubbedTime debitBehavior santiUser santiPassword emptyUserRegistry'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInternalInterfaceTest methodsFor: 'clock protocol' stamp: 'Eden Torres 11/11/2019 18:07:09'!
localMillisecondClock
	
	^stubbedTime.! !


!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 18:40:15'!
test01CreateCartRaisesErrorWhenNonExistentUser

	| interface |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: emptyUserRegistry. 
	
	self should: [interface createCartFor: edenUser withPassword: edenPassword]
		 raise: Error - MessageNotUnderstood
		 withMessageText: 'Usuario no registrado'.
		
	self assert: interface carts isEmpty.
		 ! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 18:40:19'!
test02CreateCartRaisesErrorWhenPasswordDoesNotMatch

	| interface |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
	
	self should: [interface createCartFor: edenUser withPassword: 'wrong password']
		 raise: Error - MessageNotUnderstood
		 withMessageText: 'Contraseña incorrecta'.
		
	self assert: interface carts isEmpty.
		 ! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 18:40:23'!
test03CreateCartCreatesACartWithValidUser

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry .
	
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
		
	self assert: interface carts size equals: 1.
	self assert: (interface includesCartID: cartID).! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 18:40:29'!
test04CreateCartTwiceCreatesTwoCartsWithDifferentIDs

	| interface cartID1 cartID2 |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry .
	
	cartID1 := interface createCartFor: edenUser withPassword: edenPassword.
	cartID2 := interface createCartFor: edenUser withPassword: edenPassword.
		
	self assert: interface carts size equals: 2.
	self assert: (interface includesCartID: cartID1).
	self assert: (interface includesCartID: cartID2).
	self deny: cartID1 = cartID2 .! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 19:16:53'!
test05ListCartRaisesErrorWhenCartIDDoesNotExist

	| interface |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
		
	self should: [interface listCart: 'INVALID CART ID']
		 raise: Error - MessageNotUnderstood 
		 withMessageText: 'CartID inválido'.
		
	self assert: interface carts isEmpty.
! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 19:15:50'!
test06ListCartListsNothingWhenCartIsJustCreated

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
	
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
		
	self assertThatListCartIsEmtyIn: interface ofCartID: cartID.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 19:17:03'!
test07AddToCartRaisesErrorWhenCartIDDoesNotExist

	| interface |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
		
	self should: [interface addToCart: 'INVALID CART ID' item: factory itemSellByTheStore withQuantity: 1]
		 raise: Error - MessageNotUnderstood 
		 withMessageText: 'CartID inválido'.
		
	self assert: interface carts isEmpty.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 19:16:10'!
test08AddToCartRaisesErrorWhenItemIsNotSoldByTheStore

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
		
	self should: [interface addToCart: cartID item: factory itemNotSellByTheStore withQuantity: 1]
		 raise: Error - MessageNotUnderstood 
		 withMessageText: 'Item is not in catalog'.
		
	self assertThatListCartIsEmtyIn: interface ofCartID: cartID.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 19:16:23'!
test09AddToCartRaisesErrorWhenQuantityIsZero

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
		
	self should: [interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 0]
		 raise: Error - MessageNotUnderstood 
		 withMessageText: 'Invalid number of items'.
		
	self assertThatListCartIsEmtyIn: interface ofCartID: cartID.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 19:13:06'!
test10AddToCartListsOneItem

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
		
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 1.
	
	self assertThatListCartIn: interface ofCartID: cartID includes: factory itemSellByTheStore aNumberOfTimes: 1.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 19:13:13'!
test11AddABookTwiceToCartListsTwoItem

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
		
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 2.
	
	self assertThatListCartIn: interface ofCartID: cartID includes: factory itemSellByTheStore aNumberOfTimes: 2.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 19:17:23'!
test12AddTwoDifferentBookToCartListsTwoDifferentItems

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
		
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 1.
	interface addToCart: cartID item: factory anotherItemSellByTheStore withQuantity: 1.
	
	self assertThatListCartIn: interface ofCartID: cartID includes: factory itemSellByTheStore aNumberOfTimes: 1.
	self assertThatListCartIn: interface ofCartID: cartID includes: factory anotherItemSellByTheStore aNumberOfTimes: 1.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 18:41:08'!
test13ListCartDoesNotListItemNotIncludedInCart

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
		
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 1.
	
	self deny: ((interface listCart: cartID ) includes: factory anotherItemSellByTheStore).! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 18:49:55'!
test14ShouldRaiseErrorWhenAddingAnItemToAnExpiredCart

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
	
	self addExpiredTime.
	
	self should: [interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 1.]
		raise: Error - MessageNotUnderstood
		withMessageText: 'Carrito expirado'. 
	
	self assert: interface carts isEmpty.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 18:50:10'!
test15ShouldRaiseErrorWhenListingAnExpiredCart

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
	
	self addExpiredTime.
	
	self should: [interface listCart: cartID.]
		raise: Error - MessageNotUnderstood
		withMessageText: 'Carrito expirado'. 
	
	self assert: interface carts isEmpty.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 18:50:25'!
test16ShouldNotRaiseErrorWhenAddingAnItemTo30minOldCart

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
	
	self addUnexpiredTime .
	
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 1.
	
	self assert: interface carts size equals: 1.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 18:51:19'!
test17ShouldNotRaiseErrorWhenAddingBooksToCartWithLagOf30minutes

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
	
	self addUnexpiredTime .
	
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 1.
	
	self addUnexpiredTime .
	
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 1.
	
	self assert: interface carts size equals: 1.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 19:07:15'!
test18CheckoutCartShouldRaiseErrorWithInvalidCartId

	| interface |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
		
	self should: [interface checkoutCart: 'invalid id' withCreditCardNumber: factory notExpiredCreditCard number withCreditCardName:
	factory notExpiredCreditCard name withExpritationDate: factory notExpiredCreditCard expirationDate on: factory today] 
		raise: Error - MessageNotUnderstood  
		withMessageText: 'CartID inválido'.

	self assert: interface carts isEmpty.
	self assertThatListPurchaseIn: interface isEmptyWithUsername: edenUser withPassword: edenPassword. ! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 19:02:58'!
test19CheckoutCartShouldRaiseErrorWithEmptyCardName

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 1.
		
	self should: [interface checkoutCart: cartID withCreditCardNumber: factory emptyNameCreditCard number withCreditCardName:
	factory emptyNameCreditCard name withExpritationDate: factory emptyNameCreditCard expirationDate on: factory today] 
		raise: Error - MessageNotUnderstood  
		withMessageText: 'Nombre de la tarjeta inválido'.

	self assertOnlyCartIn: interface wasNotCheckoutWithUsername: edenUser withPassword: edenPassword. ! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 19:02:51'!
test20CheckoutCartShouldRaiseErrorWithTooLongCardName

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 1.
		
	self should: [interface checkoutCart: cartID withCreditCardNumber: factory tooLongNameCreditCard number withCreditCardName:
	factory tooLongNameCreditCard name withExpritationDate: factory tooLongNameCreditCard expirationDate on: factory today] 
		raise: Error - MessageNotUnderstood  
		withMessageText: 'Nombre de la tarjeta inválido'.

	self assertOnlyCartIn: interface wasNotCheckoutWithUsername: edenUser withPassword: edenPassword. ! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 19:02:45'!
test21CheckoutCartShouldRaiseErrorWithExpiredCard

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 1.
		
	self should: [interface checkoutCart: cartID withCreditCardNumber: factory expiredCreditCard number withCreditCardName:
	factory expiredCreditCard name withExpritationDate: factory expiredCreditCard expirationDate on: factory today] 
		raise: Error - MessageNotUnderstood  
		withMessageText: 'Can not charge an expired credit card'.

	self assertOnlyCartIn: interface wasNotCheckoutWithUsername: edenUser withPassword: edenPassword.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 19:02:38'!
test22CheckoutCartShouldRaiseErrorWithEmptyCart

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
		
	self should: [interface checkoutCart: cartID withCreditCardNumber: factory notExpiredCreditCard number withCreditCardName:
	factory notExpiredCreditCard name withExpritationDate: factory notExpiredCreditCard expirationDate on: factory today] 
		raise: Error - MessageNotUnderstood  
		withMessageText: 'Can not check out an empty cart'.

	self assertOnlyCartIn: interface wasNotCheckoutWithUsername: edenUser withPassword: edenPassword. ! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 19:27:20'!
test23CheckoutCartWithOneElementListsOnePurchase

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
	
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 1.
		
	interface checkoutCart: cartID withCreditCardNumber: factory notExpiredCreditCard number
			    withCreditCardName: factory notExpiredCreditCard name withExpritationDate: factory notExpiredCreditCard
			    expirationDate on: factory today.

	self assertThatListPurchaseIn: interface withUsername: edenUser withPassword: edenPassword includesOneItem: factory itemSellByTheStore withPrice: factory itemSellByTheStorePrice. ! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 18:42:07'!
test24CheckoutCartWithTwoElementListsTwoPurchase

	| interface cartID listPurchase totalPurchaseAmount |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
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

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 18:42:11'!
test25CheckoutCartWithTwoEqualElementsListsTwoPurchase

	| interface cartID listPurchase totalPurchaseAmount |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
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

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 19:26:57'!
test26CheckoutCartWithOneElementListsOnlySameUserPurchases

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
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
			
	self assertThatListPurchaseIn: interface withUsername: edenUser withPassword: edenPassword includesOneItem: factory itemSellByTheStore withPrice: factory itemSellByTheStorePrice .
	
	self assertThatListPurchaseIn: interface withUsername: santiUser withPassword: santiPassword includesOneItem: factory anotherItemSellByTheStore withPrice: factory anotherItemSellByTheStorePrice . ! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 18:42:18'!
test27ListPurchasesRaisesErrorWhenTheUserDoesNotExist

	| interface |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: emptyUserRegistry .
			
	self should: [interface listPurchaseFor: edenUser withPassword: edenPassword]
		 raise: Error - MessageNotUnderstood 
		 withMessageText: 'Usuario no registrado'.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 18:42:22'!
test28ListPurchasesRaisesErrorWhenTheUserAndPasswordDontMatch

	| interface |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry .
			
	self should: [interface listPurchaseFor: edenUser withPassword: santiPassword ]
		 raise: Error - MessageNotUnderstood 
		 withMessageText: 'Contraseña incorrecta'.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 19:00:46'!
test29ListPurchasesIsEmptyWhenTheUserDoesntCheckout

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry .
	cartID := interface createCartFor: edenUser withPassword: edenPassword .
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 38.
			
	self assertOnlyCartIn: interface wasNotCheckoutWithUsername: edenUser withPassword: edenPassword.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 19:06:57'!
test30CheckoutCartShouldRaiseErrorWithExpiredCart

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 38.
	
	self addExpiredTime.
		
	self should: [interface checkoutCart: cartID withCreditCardNumber: factory notExpiredCreditCard number withCreditCardName:
	factory notExpiredCreditCard name withExpritationDate: factory notExpiredCreditCard expirationDate on: factory today] 
		raise: Error - MessageNotUnderstood  
		withMessageText: 'Carrito expirado'.

	self assert: interface carts isEmpty.
	self assertThatListPurchaseIn: interface isEmptyWithUsername: edenUser withPassword: edenPassword.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'Eden Torres 11/18/2019 18:57:38'!
test31CheckoutCartShouldRaiseErrorWithMerchantProcessorError

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 38.
	
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
		
	self should: [interface checkoutCart: cartID withCreditCardNumber: factory notExpiredCreditCard number withCreditCardName:
	factory notExpiredCreditCard name withExpritationDate: factory notExpiredCreditCard expirationDate on: factory today] 
		raise: Error - MessageNotUnderstood  
		withMessageText: Cashier creditCardHasNoCreditErrorMessage.
		
	self assertOnlyCartIn: interface wasNotCheckoutWithUsername: edenUser withPassword: edenPassword.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'SN 11/18/2019 19:52:39'!
test32CheckoutCartWithOneElementHasOneItemInTicket

	| interface cartID ticket |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.

	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 1.

	ticket := interface checkoutCart: cartID withCreditCardNumber: factory notExpiredCreditCard number
			    		 withCreditCardName: factory notExpiredCreditCard name withExpritationDate: factory notExpiredCreditCard
			    		 expirationDate on: factory today.


	self assert: interface carts isEmpty.
	self assert: ticket first includes: factory itemSellByTheStore .
	self assert: ticket second equals: factory itemSellByTheStorePrice .! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'SN 11/18/2019 19:55:38'!
test33CheckoutCartWithManyElementHasItemsInTicket

	| interface cartID ticket totalPurchaseAmount |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
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
	self assert: ticket second equals: totalPurchaseAmount.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'SN 11/24/2019 17:32:42'!
test34RemoveFromCartRaisesErrorWhenCartIDDoesNotExist

	| interface |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
		
	self should: [interface removeFromCart: 'INVALID CART ID' item: factory itemSellByTheStore]
		 raise: Error - MessageNotUnderstood 
		 withMessageText: 'CartID inválido'.
		
	self assert: interface carts isEmpty.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'SN 11/24/2019 17:37:33'!
test35RemoveFromCartCartRaisesErrorWhenItemIsNotInCart

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 1.
		
	self should: [interface removeFromCart: cartID item: factory itemNotSellByTheStore]
		 raise: Error - MessageNotUnderstood 
		 withMessageText: 'Item is not in cart'.
		
	self assertThatListCartIn: interface ofCartID: cartID includes: factory itemSellByTheStore aNumberOfTimes: 1.! !

!TusLibrosInternalInterfaceTest methodsFor: 'tests' stamp: 'SN 11/24/2019 17:47:40'!
test36RemoveFromCartRemovesCorrectItemFromCart

	| interface cartID |

	interface := self createTusLibrosInternalInterfaceWithUserRegistry: userRegistry.
	cartID := interface createCartFor: edenUser withPassword: edenPassword.
	
	interface addToCart: cartID item: factory itemSellByTheStore withQuantity: 1.
	interface addToCart: cartID item: factory anotherItemSellByTheStore withQuantity: 1.
	
	interface removeFromCart: cartID item: factory anotherItemSellByTheStore .
	
	self assertThatListCartIn: interface ofCartID: cartID includes: factory itemSellByTheStore aNumberOfTimes: 1.
	self denyThatListCartIn: interface ofCartID: cartID includes: factory anotherItemSellByTheStore .! !


!TusLibrosInternalInterfaceTest methodsFor: 'setUp/tearDown' stamp: 'Eden Torres 11/18/2019 18:47:21'!
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


!TusLibrosInternalInterfaceTest methodsFor: 'initialization' stamp: 'Eden Torres 11/18/2019 18:39:40'!
createTusLibrosInternalInterfaceWithUserRegistry: aUserRegistry

	^TusLibrosInternalInterface withUsers: aUserRegistry withCatalog: factory defaultCatalog 
										withClock: self withAMerchantProcessor: self.! !


!TusLibrosInternalInterfaceTest methodsFor: 'clock protocol - private' stamp: 'Eden Torres 11/18/2019 18:49:19'!
addExpiredTime
	stubbedTime := stubbedTime + 31 minutes totalMilliseconds.! !

!TusLibrosInternalInterfaceTest methodsFor: 'clock protocol - private' stamp: 'Eden Torres 11/18/2019 18:49:28'!
addUnexpiredTime
	stubbedTime := stubbedTime + 30 minutes totalMilliseconds.! !


!TusLibrosInternalInterfaceTest methodsFor: 'merchant procesor protocol' stamp: 'Eden Torres 11/14/2019 20:00:51'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!TusLibrosInternalInterfaceTest methodsFor: 'assertions' stamp: 'Eden Torres 11/18/2019 19:06:09'!
assertOnlyCartIn: interface wasNotCheckoutWithUsername: aUserID withPassword: aPassword
	 
	self assert: interface carts size equals: 1.
	self assertThatListPurchaseIn: interface isEmptyWithUsername: aUserID  withPassword: aPassword.
	 ! !

!TusLibrosInternalInterfaceTest methodsFor: 'assertions' stamp: 'Eden Torres 11/18/2019 19:11:54'!
assertThatListCartIn: interface ofCartID: cartID includes: aBook aNumberOfTimes: aNumberOfOcurrences

	|listCart |
	
	listCart := interface listCart: cartID.
	
	self assert: listCart includes: aBook.
	self assert: (listCart occurrencesOf: aBook ) equals: aNumberOfOcurrences .! !

!TusLibrosInternalInterfaceTest methodsFor: 'assertions' stamp: 'Eden Torres 11/18/2019 19:14:50'!
assertThatListCartIsEmtyIn: interface ofCartID: cartID

	|listCart |
	
	listCart := interface listCart: cartID.
	
	self assert: listCart isEmpty.! !

!TusLibrosInternalInterfaceTest methodsFor: 'assertions' stamp: 'Eden Torres 11/18/2019 19:05:40'!
assertThatListPurchaseIn: interface isEmptyWithUsername: aUserID withPassword: aPassword

	| listPurchase |
	
	listPurchase := interface listPurchaseFor: aUserID withPassword: aPassword.
	self assert: listPurchase first isEmpty. 
	self assert: listPurchase second equals: 0. ! !

!TusLibrosInternalInterfaceTest methodsFor: 'assertions' stamp: 'Eden Torres 11/18/2019 19:25:13'!
assertThatListPurchaseIn: interface withUsername: aUserID withPassword: aPassword includesOneItem: aItem withPrice: aPrice

	| listPurchase |
	
	listPurchase := interface listPurchaseFor: aUserID withPassword: aPassword.
	
	self assert: interface carts isEmpty.
	self assert: listPurchase first size equals: 1.
	self assert: listPurchase first includes: aItem .
	self assert: listPurchase second equals: aPrice.! !

!TusLibrosInternalInterfaceTest methodsFor: 'assertions' stamp: 'SN 11/24/2019 17:46:23'!
denyThatListCartIn: interface ofCartID: cartID includes: aBook

	|listCart |
	
	listCart := interface listCart: cartID.
	
	self deny: (listCart includes: aBook).! !


!classDefinition: #Cart category: #TusLibros stamp: 'SN 11/24/2019 18:12:17'!
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


!Cart methodsFor: 'as yet unclassified' stamp: 'SN 11/24/2019 18:00:40'!
remove: anItem 
	
	items remove: anItem ifAbsent: [self error: 'Item is not in cart'.].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'SN 11/24/2019 18:12:17'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartInterface category: #TusLibros stamp: 'SN 11/24/2019 18:12:17'!
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

!CartInterface methodsFor: 'initialization' stamp: 'SN 11/24/2019 17:53:27'!
remove: anItem

	cart remove: anItem.
	timeLastModified := clock localMillisecondClock.! !


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

!classDefinition: 'CartInterface class' category: #TusLibros stamp: 'SN 11/24/2019 18:12:17'!
CartInterface class
	instanceVariableNames: ''!

!CartInterface class methodsFor: 'instance creation' stamp: 'Eden Torres 11/14/2019 17:51:03'!
withCatalog: aCatalog withClock: aClock withUserID: aUserID

	^ self new initialiazeWithCatalog: aCatalog withClock: aClock withUserID: aUserID .! !


!classDefinition: #Cashier category: #TusLibros stamp: 'SN 11/24/2019 18:12:17'!
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

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'SN 11/24/2019 18:12:17'!
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


!classDefinition: #CreditCard category: #TusLibros stamp: 'SN 11/24/2019 18:12:17'!
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

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'SN 11/24/2019 18:12:17'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'Eden Torres 11/11/2019 21:57:06'!
expiringOn: aMonth withName: aName withNumber: aNumber

	aName isEmpty ifTrue: [self error: 'Nombre de la tarjeta inválido'].
	aName size > 30 ifTrue: [self error: 'Nombre de la tarjeta inválido'].
	
	^self new initializeExpiringOn: aMonth withName: aName withNumber: aNumber.! !


!classDefinition: #MerchantProcessorStub category: #TusLibros stamp: 'SN 11/24/2019 18:12:17'!
Object subclass: #MerchantProcessorStub
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorStub methodsFor: 'merchant processor protocol' stamp: 'SN 11/23/2019 20:47:53'!
debit: aValue from: aCard
! !


!classDefinition: #Sale category: #TusLibros stamp: 'SN 11/24/2019 18:12:17'!
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

!classDefinition: 'Sale class' category: #TusLibros stamp: 'SN 11/24/2019 18:12:17'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'Eden Torres 11/14/2019 19:53:58'!
of: aTotal withItems: items

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal items: items.! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros stamp: 'SN 11/24/2019 18:12:17'!
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


!classDefinition: #TusLibrosController category: #TusLibros stamp: 'SN 11/24/2019 18:12:17'!
Object subclass: #TusLibrosController
	instanceVariableNames: 'webServer port tusLibros req'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosController methodsFor: 'service managment' stamp: 'SN 11/21/2019 20:02:34'!
destroy
	
	webServer ifNotNil:[webServer destroy].! !

!TusLibrosController methodsFor: 'service managment' stamp: 'SN 11/21/2019 20:01:55'!
startListening
	
	webServer startListener.

	^ 'Listening on port: ', self port asString.
	! !

!TusLibrosController methodsFor: 'service managment' stamp: 'SN 11/21/2019 20:02:40'!
stopListening
	
	webServer stopListener.
	
	^'Stopped listening from port: ', self port asString! !


!TusLibrosController methodsFor: 'initialization' stamp: 'SN 11/21/2019 21:51:22'!
catalog

	^Dictionary new at: '9789500763035' put: 3020;
					   at: '0201558025' put: 260;
					   yourself.! !

!TusLibrosController methodsFor: 'initialization' stamp: 'SN 11/24/2019 18:04:11'!
initializeWith: aListeningPort

	tusLibros := TusLibrosInternalInterface withUsers: self userList withCatalog: self catalog withClock: Time withAMerchantProcessor: self merchantProcessor.
	
	port := aListeningPort .
	
	webServer := WebServer new listenOn: aListeningPort .
	
	webServer addService: '/helloWorld' action: (self handleWith: #helloWorld).
	webServer addService: '/createCart' action: (self handleWith: #createCart).
	webServer addService: '/getCatalog' action: (self handleWith: #getCatalog).
	webServer addService: '/addToCart' action: (self handleWith: #addToCart).
	webServer addService: '/listCart' action: (self handleWith: #listCart).
	webServer addService: '/checkoutCart' action: (self handleWith: #checkoutCart).
	webServer addService: '/listPurchases' action: (self handleWith: #listPurchases).
	webServer addService: '/removeFromCart' action: (self handleWith: #removeFromCart).! !

!TusLibrosController methodsFor: 'initialization' stamp: 'SN 11/23/2019 20:48:11'!
merchantProcessor

	^ MerchantProcessorStub new.! !

!TusLibrosController methodsFor: 'initialization' stamp: 'SN 11/21/2019 20:03:59'!
port
	
	^port ifNil: [port:=8080].
	
	! !

!TusLibrosController methodsFor: 'initialization' stamp: 'SN 11/21/2019 20:35:24'!
userList

	^Dictionary new at: 'Eden' put: '12345678';
					   at: 'Santi' put: '12345678';
					   yourself.! !


!TusLibrosController methodsFor: 'services - private' stamp: 'SN 11/23/2019 20:18:23'!
addToCart
	
	| bookISBN cartID quantity |

	cartID := req fields at: 'cartID' ifAbsent: self badRequestResponse.
	bookISBN := req fields at: 'isbn' ifAbsent: self badRequestResponse.
	quantity := req fields at: 'quantity' ifAbsent: self badRequestResponse.
	
	tusLibros addToCart: cartID asInteger item: bookISBN withQuantity: quantity asInteger .
	^ self successResponse .! !

!TusLibrosController methodsFor: 'services - private' stamp: 'SN 11/24/2019 17:07:01'!
checkoutCart

	| cartID cardExpiration ticket |
	
	cartID := req fields at: 'cartID' ifAbsent: self badRequestResponse.
	
	cardExpiration := Month month: DateAndTime now monthIndex year: DateAndTime now yearNumber + 1.
	ticket := tusLibros checkoutCart: cartID asInteger withCreditCardNumber: '4444444444444444' withCreditCardName: 'Eden Torres' withExpritationDate: cardExpiration on: DateAndTime now.
	
	^ self listItems: ticket .! !

!TusLibrosController methodsFor: 'services - private' stamp: 'SN 11/23/2019 19:29:15'!
createCart

	| password userID cartID |

	userID := req fields at: 'userID' ifAbsent: self badRequestResponse.
	password := req fields at: 'password' ifAbsent: self badRequestResponse.

	cartID := tusLibros createCartFor: userID withPassword: password .
	^ self jsonSimpleResponseWithKey: 'cartID' value:  cartID.! !

!TusLibrosController methodsFor: 'services - private' stamp: 'SN 11/24/2019 16:48:36'!
getCatalog

	^ self render: (WebUtils jsonEncode: (self catalog associations collect: [:item | Dictionary new at: 'isbn' put: item key; at: 'price' put: item value; yourself ])).! !

!TusLibrosController methodsFor: 'services - private' stamp: 'SN 11/24/2019 16:48:50'!
helloWorld

	^ self render: 'Hello World!!'.! !

!TusLibrosController methodsFor: 'services - private' stamp: 'SN 11/24/2019 16:49:01'!
listCart

	| cartID items itemsResponse |

	cartID := req fields at: 'cartID' ifAbsent: self badRequestResponse.
	
	items := tusLibros listCart: cartID asInteger .

	itemsResponse := items asSet asArray collect: [:item | Dictionary new at: 'isbn' put: item; at: 'quantity' put: (items occurrencesOf: item) ; yourself ].
	^ self render: (WebUtils jsonEncode: (Dictionary new at: 'items' put: itemsResponse ; at: 'total_quantity' put: items size; yourself )) .! !

!TusLibrosController methodsFor: 'services - private' stamp: 'SN 11/24/2019 17:09:00'!
listPurchases

	| password userID purchases |

	userID := req fields at: 'userID' ifAbsent: self badRequestResponse.
	password := req fields at: 'password' ifAbsent: self badRequestResponse.
	
	purchases := tusLibros listPurchaseFor: userID withPassword: password .
	^ self listItems: purchases.! !

!TusLibrosController methodsFor: 'services - private' stamp: 'SN 11/24/2019 18:07:03'!
removeFromCart

	
	| bookISBN cartID |

	cartID := req fields at: 'cartID' ifAbsent: self badRequestResponse.
	bookISBN := req fields at: 'isbn' ifAbsent: self badRequestResponse.
	
	tusLibros removeFromCart: cartID asInteger item: bookISBN .
	^ self successResponse .! !


!TusLibrosController methodsFor: 'rendering - private' stamp: 'SN 11/23/2019 19:24:04'!
badRequestResponse

	^ [ ^ req send400Response. ]! !

!TusLibrosController methodsFor: 'rendering - private' stamp: 'SN 11/24/2019 16:48:00'!
jsonSimpleResponseWithKey: aKey value: aValue

	^ self render: (WebUtils jsonEncode: (Dictionary new at: aKey put: aValue; yourself )).! !

!TusLibrosController methodsFor: 'rendering - private' stamp: 'SN 11/24/2019 17:06:36'!
listItems: aTicket

	| items itemsResponse |

	items := aTicket first.
	
	itemsResponse := items asSet asArray collect: [:item | Dictionary new at: 'isbn' put: item; at: 'quantity' put: (items occurrencesOf: item); at: 'price' put: (self catalog at: item); yourself ].
	^ self render: (WebUtils jsonEncode: (Dictionary new at: 'items' put: itemsResponse ; at: 'total_amount' put: aTicket second; yourself )).! !

!TusLibrosController methodsFor: 'rendering - private' stamp: 'SN 11/24/2019 16:52:21'!
render: aResponse

	^ req send200Response: aResponse
		   contentType: 'application/json; charset=utf-8'
		   do: [:resp |  resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]! !

!TusLibrosController methodsFor: 'rendering - private' stamp: 'SN 11/24/2019 16:47:52'!
successResponse

	^ self jsonSimpleResponseWithKey: 'message' value: 'success'.! !


!TusLibrosController methodsFor: 'dispatching - private' stamp: 'SN 11/24/2019 16:45:43'!
handleWith: aSelector

	^ [ :request |
		| response |
		
		req := request.
		self safeSend: aSelector.
	].! !

!TusLibrosController methodsFor: 'dispatching - private' stamp: 'SN 11/24/2019 18:10:35'!
safeSend: aSelector

	^ [ aSelector sendTo: self ]
	   on: Error 
	   do: [ :anError |
			req send404Response: (self jsonSimpleResponseWithKey: 'message' value: anError messageText) ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosController class' category: #TusLibros stamp: 'SN 11/24/2019 18:12:17'!
TusLibrosController class
	instanceVariableNames: ''!

!TusLibrosController class methodsFor: 'instance creation' stamp: 'SN 11/21/2019 19:59:43'!
listeningOn: aPortNumber

	^self new initializeWith: aPortNumber.! !


!classDefinition: #TusLibrosInternalInterface category: #TusLibros stamp: 'SN 11/24/2019 18:12:17'!
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

!TusLibrosInternalInterface methodsFor: 'cart managment' stamp: 'SN 11/18/2019 19:53:54'!
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

!TusLibrosInternalInterface methodsFor: 'cart managment' stamp: 'SN 11/24/2019 18:03:18'!
removeFromCart: aCartID item: anItem 
	
	self validateCartWith: aCartID.
	
	(carts at: aCartID ) remove: anItem.! !


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

!classDefinition: 'TusLibrosInternalInterface class' category: #TusLibros stamp: 'SN 11/24/2019 18:12:17'!
TusLibrosInternalInterface class
	instanceVariableNames: ''!

!TusLibrosInternalInterface class methodsFor: 'instance creation' stamp: 'Eden Torres 11/14/2019 19:47:42'!
withUsers: aUserRegistry withCatalog: aCatalog withClock: aClock withAMerchantProcessor: aMerchantProcessor
	
	^self new initializeWithUsers: aUserRegistry withCatalog: aCatalog withClock: aClock withAMerchantProcessor: aMerchantProcessor.! !
