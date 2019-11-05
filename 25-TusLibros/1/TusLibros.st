!classDefinition: #CartTest category: #'TusLibros-Exercise' stamp: 'SN 10/31/2019 16:27:50'!
TestCase subclass: #CartTest
	instanceVariableNames: 'book otherBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Exercise'!

!CartTest methodsFor: 'tests' stamp: 'SN 10/31/2019 15:58:36'!
test01NewCartShouldBeEmpty

	| cart |

	cart := Cart new.
	
	self assert: cart isEmpty.
	self assert: 0 equals: cart count.! !

!CartTest methodsFor: 'tests' stamp: 'SN 10/31/2019 16:01:26'!
test02CartWithOneBookShouldNotBeEmpty

	| cart |

	cart := Cart new.
	
	cart add: book.
	
	self deny: cart isEmpty.
	self assert: 1 equals: cart count.! !

!CartTest methodsFor: 'tests' stamp: 'SN 10/31/2019 16:05:58'!
test03CartWithTwoBooksShouldNotBeEmptyAndHaveCountTwo

	| cart |

	cart := Cart new.
	
	cart add: book.
	cart add: otherBook.
	
	self deny: cart isEmpty.
	self assert: 2 equals: cart count.! !

!CartTest methodsFor: 'tests' stamp: 'SN 10/31/2019 16:09:34'!
test04CartWithBookShouldHaveTheBook

	| cart |

	cart := Cart new.
	
	cart add: book.
	
	self assert: (cart has: book).! !

!CartTest methodsFor: 'tests' stamp: 'SN 10/31/2019 16:12:32'!
test05CartWithBookShouldNotHaveOtherBook

	| cart |

	cart := Cart new.
	
	cart add: book.
	
	self deny: (cart has: otherBook).! !

!CartTest methodsFor: 'tests' stamp: 'SN 10/31/2019 16:25:44'!
test06CartWithBookShouldHaveBookOnce

	| cart |

	cart := Cart new.
	
	cart add: book.
	
	self assert: 1 equals: (cart quantityOf: book).! !

!CartTest methodsFor: 'tests' stamp: 'SN 10/31/2019 16:27:19'!
test07CartWithRepeatedBookShouldHaveBookTwice

	| cart |

	cart := Cart new.
	
	2 timesRepeat: [cart add: book].
	
	self assert: 2 equals: (cart quantityOf: book).! !


!CartTest methodsFor: 'set up' stamp: 'SN 10/31/2019 16:07:18'!
setUp

	book := #aBook.
	otherBook := #otherBook.! !


!classDefinition: #Cart category: #'TusLibros-Exercise' stamp: 'SN 10/31/2019 16:27:50'!
Object subclass: #Cart
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Exercise'!

!Cart methodsFor: 'testing' stamp: 'SN 10/31/2019 16:04:26'!
count

	^ books size .! !

!Cart methodsFor: 'testing' stamp: 'SN 10/31/2019 16:11:35'!
has: aBook 
	
	^ books includes: aBook .! !

!Cart methodsFor: 'testing' stamp: 'SN 10/31/2019 16:04:02'!
isEmpty

	^ books isEmpty .! !

!Cart methodsFor: 'testing' stamp: 'SN 10/31/2019 16:26:34'!
quantityOf: aBook

	^ books occurrencesOf: aBook .! !


!Cart methodsFor: 'book adding' stamp: 'SN 10/31/2019 16:03:05'!
add: aBook
	
	books add: aBook .! !


!Cart methodsFor: 'initialization' stamp: 'SN 10/31/2019 16:23:31'!
initialize

	books := Bag new.! !
