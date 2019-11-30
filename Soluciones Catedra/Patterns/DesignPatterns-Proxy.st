!classDefinition: #AddressBook category: #'DesignPatterns-Proxy'!
Object subclass: #AddressBook
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'DesignPatterns-Proxy'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AddressBook class' category: #'DesignPatterns-Proxy'!
AddressBook class
	instanceVariableNames: ''!

!AddressBook class methodsFor: 'querying' stamp: 'HAW 9/26/2017 08:16:52'!
addressesFor: aCustomer

	^Array new! !


!classDefinition: #PhoneBook category: #'DesignPatterns-Proxy'!
Object subclass: #PhoneBook
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'DesignPatterns-Proxy'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PhoneBook class' category: #'DesignPatterns-Proxy'!
PhoneBook class
	instanceVariableNames: ''!

!PhoneBook class methodsFor: 'quering' stamp: 'HAW 9/26/2017 08:13:39'!
phonesFor: aCustomer 

	^Array new! !


!classDefinition: #Provider category: #'DesignPatterns-Proxy'!
Object subclass: #Provider
	instanceVariableNames: 'phones adresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'DesignPatterns-Proxy'!

!Provider methodsFor: 'initialization' stamp: 'HAW 9/26/2017 08:20:56'!
initialize

	phones := LazyInitProxy instantiatingProxeeWith: [ PhoneBook phonesFor: self ].
	adresses := LazyInitProxy instantiatingProxeeWith: [ AddressBook addressesFor: self ].! !


!Provider methodsFor: 'accessing' stamp: 'HAW 9/25/2017 18:45:01'!
addresses

	^adresses 
	
	! !

!Provider methodsFor: 'accessing' stamp: 'HAW 9/25/2017 18:45:06'!
phones

	^phones ! !


!classDefinition: #LazyInitProxy category: #'DesignPatterns-Proxy'!
ProtoObject subclass: #LazyInitProxy
	instanceVariableNames: 'initClosure value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'DesignPatterns-Proxy'!

!LazyInitProxy methodsFor: 'initialization' stamp: 'HAW 9/26/2017 08:22:10'!
initializeInstantiatingProxeeWith: aClosure

	initClosure := aClosure.! !


!LazyInitProxy methodsFor: 'proxee' stamp: 'HAW 9/25/2017 18:39:00'!
value

	value isNil ifTrue: [ value := initClosure value].
	^value 
	
	! !


!LazyInitProxy methodsFor: 'message handling' stamp: 'HAW 9/26/2017 08:17:50'!
doesNotUnderstand: aMessage

	"Implementacion con desproxeo de Proxy
	self value become: self.
	^aMessage sendTo: self
	"
	
	"Implementacion de Proxy generico sin desproxeo"
	^aMessage sendTo: self value! !


!LazyInitProxy methodsFor: 'inspecting' stamp: 'HAW 10/19/2017 16:44:49'!
inspectorClass
	"Answer the class of the inspector to be used on the receiver.  Called by inspect; 
	use basicInspect to get a normal (less useful) type of inspector."

	^ Inspector! !

!LazyInitProxy methodsFor: 'inspecting' stamp: 'HAW 10/19/2017 16:45:07'!
instVarAt: index put: anObject
	"Primitive. Store a value into a fixed variable in an object. The numbering of the
	 variables corresponds to the named instance variables, followed by the indexed
	 instance variables. Fail if the index is not an Integer or is not the index of a fixed
	 variable. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 174 error: ec>
	self primitiveFailed! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LazyInitProxy class' category: #'DesignPatterns-Proxy'!
LazyInitProxy class
	instanceVariableNames: ''!

!LazyInitProxy class methodsFor: 'instance creation' stamp: 'HAW 9/26/2017 08:22:15'!
instantiatingProxeeWith: aClosure

	^ self new initializeInstantiatingProxeeWith: aClosure.! !
