!classDefinition: #AdapterExamples category: #'DesignPatterns-Adapter'!
Object subclass: #AdapterExamples
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'DesignPatterns-Adapter'!

!AdapterExamples methodsFor: 'examples' stamp: 'HAW 9/19/2017 08:52:09'!
genericCustomer2DrawableAdapterExample

	"Esta es la manera de instanciar PluggableAdapter para adaptar asDrawable a instancias de Customer
	Recordar de debuggearlo para entenderlo bien - Hernan"
	
	| customer adapter entryField canvas |
	
	customer := Customer new.
	adapter := PluggableAdapter adapting: #asDrawable with: [ customer name, ' ', customer lastName ].
	entryField := EntryField showing: adapter.
	canvas := Canvas new.
	
	entryField drawWith: canvas.! !

!AdapterExamples methodsFor: 'examples' stamp: 'HAW 9/19/2017 08:53:09'!
specificCustomer2DrawableAdapterExample

	"Recordar de debuggearlo para entenderlo - Hernan"
	
	| customer adapter entryField canvas |
	
	customer := Customer new.
	adapter := CustomerToDrawableAdapter adapting: customer.
	entryField := EntryField showing: adapter.
	canvas := Canvas new.
	
	entryField drawWith: canvas.! !


!classDefinition: #Canvas category: #'DesignPatterns-Adapter'!
Object subclass: #Canvas
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'DesignPatterns-Adapter'!

!Canvas methodsFor: 'drawing' stamp: 'HAW 9/19/2017 08:49:35'!
draw: aDrawableObject

	"aca deberia dibujar el objeto en el canvas ... - Hernan"! !


!classDefinition: #Customer category: #'DesignPatterns-Adapter'!
Object subclass: #Customer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'DesignPatterns-Adapter'!

!Customer methodsFor: 'names' stamp: 'HAW 9/18/2017 21:18:41'!
lastName

	^'Wilkinson'! !

!Customer methodsFor: 'names' stamp: 'HAW 9/18/2017 21:18:31'!
name

	^'Hernan'! !


!classDefinition: #CustomerToDrawableAdapter category: #'DesignPatterns-Adapter'!
Object subclass: #CustomerToDrawableAdapter
	instanceVariableNames: 'adaptee'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'DesignPatterns-Adapter'!

!CustomerToDrawableAdapter methodsFor: 'initialization' stamp: 'HAW 9/19/2017 08:53:54'!
initializeAdapting: aCustomer 
	
	adaptee := aCustomer ! !


!CustomerToDrawableAdapter methodsFor: 'drawing' stamp: 'HAW 9/19/2017 08:54:36'!
asDrawable
	
	"Fijarse que hace exactamente lo mismo que el closure de adaptacion en el ejemplo de PluggableAdapter - Hernan"
	
	^adaptee name, ' ', adaptee lastName! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerToDrawableAdapter class' category: #'DesignPatterns-Adapter'!
CustomerToDrawableAdapter class
	instanceVariableNames: ''!

!CustomerToDrawableAdapter class methodsFor: 'instance creation' stamp: 'HAW 9/19/2017 08:53:37'!
adapting: aCustomer 
	
	^self new initializeAdapting: aCustomer ! !


!classDefinition: #EntryField category: #'DesignPatterns-Adapter'!
Object subclass: #EntryField
	instanceVariableNames: 'model'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'DesignPatterns-Adapter'!

!EntryField methodsFor: 'initialization' stamp: 'HAW 9/19/2017 08:50:14'!
initializeShowing: aModel

	model := aModel.! !


!EntryField methodsFor: 'drawing' stamp: 'HAW 9/19/2017 08:48:49'!
drawWith: aCanvas 

	| drawableObject |
	
	drawableObject := model asDrawable.
	aCanvas draw: drawableObject ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EntryField class' category: #'DesignPatterns-Adapter'!
EntryField class
	instanceVariableNames: ''!

!EntryField class methodsFor: 'instance creation' stamp: 'HAW 9/19/2017 08:49:57'!
showing: aModel

	^self new initializeShowing: aModel ! !


!classDefinition: #PluggableAdapter category: #'DesignPatterns-Adapter'!
ProtoObject subclass: #PluggableAdapter
	instanceVariableNames: 'closureBySelectors'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'DesignPatterns-Adapter'!

!PluggableAdapter methodsFor: 'initialization' stamp: 'HAW 9/19/2017 08:40:10'!
initializeAdaptingAll: aClosureBySelectors

	closureBySelectors := aClosureBySelectors ! !


!PluggableAdapter methodsFor: 'message handling' stamp: 'HAW 9/19/2017 08:41:36'!
doesNotUnderstand: aMessage

	| adaptingClosure |
	
	adaptingClosure := closureBySelectors at: aMessage selector ifAbsent: [ ^ super doesNotUnderstand: aMessage ].
	^adaptingClosure value! !


!PluggableAdapter methodsFor: 'inspecting' stamp: 'HAW 10/19/2017 16:47:06'!
inspectorClass
	"Answer the class of the inspector to be used on the receiver.  Called by inspect; 
	use basicInspect to get a normal (less useful) type of inspector."

	^ Inspector! !

!PluggableAdapter methodsFor: 'inspecting' stamp: 'HAW 10/19/2017 16:47:20'!
instVarAt: index put: anObject
	"Primitive. Store a value into a fixed variable in an object. The numbering of the
	 variables corresponds to the named instance variables, followed by the indexed
	 instance variables. Fail if the index is not an Integer or is not the index of a fixed
	 variable. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 174 error: ec>
	self primitiveFailed! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PluggableAdapter class' category: #'DesignPatterns-Adapter'!
PluggableAdapter class
	instanceVariableNames: ''!

!PluggableAdapter class methodsFor: 'instance creation' stamp: 'HAW 9/19/2017 08:38:30'!
adapting: aSelector with: aClosure

	^self adaptingAll: (Dictionary new
		at: aSelector put: aClosure;
		yourself)! !

!PluggableAdapter class methodsFor: 'instance creation' stamp: 'HAW 9/19/2017 08:39:26'!
adaptingAll: aClosuresBySelectors

	^self new initializeAdaptingAll: aClosuresBySelectors ! !
