!classDefinition: #Connection category: #'DesignPatterns-Decorator'!
Object subclass: #Connection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'DesignPatterns-Decorator'!

!Connection methodsFor: 'sending' stamp: 'HAW 9/19/2017 08:55:35'!
send: aPackage

	self subclassResponsibility ! !


!Connection methodsFor: 'closing' stamp: 'HAW 9/19/2017 08:55:43'!
close

	self subclassResponsibility ! !


!classDefinition: #ConnectionDecorator category: #'DesignPatterns-Decorator'!
Connection subclass: #ConnectionDecorator
	instanceVariableNames: 'decoratee'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'DesignPatterns-Decorator'!

!ConnectionDecorator methodsFor: 'closing' stamp: 'HAW 9/19/2017 08:58:28'!
close

	^decoratee close! !


!ConnectionDecorator methodsFor: 'sending' stamp: 'HAW 9/19/2017 08:58:21'!
send: aPackage

	"Recordar que esta clase es opcional. A veces se implementa para dar un comportamiento default a todos
	los decorators de Connection, pero se podria optar por la opcion de que cada decorator implemente explicitamente 
	que desea hacer para cada mensaje - Hernan"
	
	^decoratee send: aPackage ! !


!ConnectionDecorator methodsFor: 'initialization' stamp: 'HAW 9/19/2017 09:09:28'!
initializeDecorating: aConnection 

	decoratee := aConnection ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ConnectionDecorator class' category: #'DesignPatterns-Decorator'!
ConnectionDecorator class
	instanceVariableNames: ''!

!ConnectionDecorator class methodsFor: 'instance creation' stamp: 'HAW 9/19/2017 09:06:21'!
decorating: aConnection 
	
	^self new initializeDecorating: aConnection ! !


!classDefinition: #EncriptedConnectionDecorator category: #'DesignPatterns-Decorator'!
ConnectionDecorator subclass: #EncriptedConnectionDecorator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'DesignPatterns-Decorator'!

!EncriptedConnectionDecorator methodsFor: 'encripting' stamp: 'HAW 9/19/2017 09:23:06'!
encript: aPackage

	"Aca hay que implementar el algoritmo de encriptado - Hernan"
	^ aPackage, '-Encrypted'! !


!EncriptedConnectionDecorator methodsFor: 'sending' stamp: 'HAW 9/19/2017 09:02:49'!
send: aPackage

	^decoratee send: (self encript: aPackage)! !


!classDefinition: #TracedConnectionDecorator category: #'DesignPatterns-Decorator'!
ConnectionDecorator subclass: #TracedConnectionDecorator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'DesignPatterns-Decorator'!

!TracedConnectionDecorator methodsFor: 'tracing' stamp: 'HAW 9/19/2017 09:01:43'!
trace: aString

	Transcript
		show: DateAndTime now printString;
		space;
		show: aString;
		newLine ! !


!TracedConnectionDecorator methodsFor: 'closing' stamp: 'HAW 9/19/2017 09:01:14'!
close

	self trace: 'Closing'.
	^decoratee close! !


!TracedConnectionDecorator methodsFor: 'sending' stamp: 'HAW 9/19/2017 09:00:55'!
send: aPackage

	self trace: 'Sending: [', aPackage printString, ']'.
	
	"Dado que ConnectionDecorator forwardea el mensaje a decoratee, podria implementar esta parte como
	super send: aPackage tambien. Prefiero en este caso hacerlo explicatmente para que no se confundan con
	tener subclasses de TCPConnection donde se envia send: a super - Hernan"
	
	^decoratee send: aPackage ! !


!classDefinition: #ZippedConnectionDecorator category: #'DesignPatterns-Decorator'!
ConnectionDecorator subclass: #ZippedConnectionDecorator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'DesignPatterns-Decorator'!

!ZippedConnectionDecorator methodsFor: 'compresing' stamp: 'HAW 9/19/2017 09:22:48'!
zip: aPackage

	"Aca hay que implementar el algoritmo de compresion - Hernan"
	^ aPackage, '-Zipped'! !


!ZippedConnectionDecorator methodsFor: 'sending' stamp: 'HAW 9/19/2017 09:02:13'!
send: aPackage

	^decoratee send: (self zip: aPackage)! !


!classDefinition: #TCPConnection category: #'DesignPatterns-Decorator'!
Connection subclass: #TCPConnection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'DesignPatterns-Decorator'!

!TCPConnection methodsFor: 'closing' stamp: 'HAW 9/19/2017 08:56:56'!
close

	"Aca habria que cerrar la conexion... - Hernan"! !


!TCPConnection methodsFor: 'sending' stamp: 'HAW 9/19/2017 08:56:42'!
send: aPackage

	"Aca habria que enviar el paquete usando sockets, etc. - Hernan"! !


!classDefinition: #ConnectionDecoratorBuilder category: #'DesignPatterns-Decorator'!
Object subclass: #ConnectionDecoratorBuilder
	instanceVariableNames: 'connection decoratorTypes'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'DesignPatterns-Decorator'!

!ConnectionDecoratorBuilder methodsFor: 'initialization' stamp: 'HAW 9/19/2017 09:15:29'!
initializeFor: aConnection 

	connection := aConnection.
	decoratorTypes := OrderedCollection new.! !


!ConnectionDecoratorBuilder methodsFor: 'building' stamp: 'HAW 9/19/2017 09:20:17'!
build
	
	| product |
	
	product := self sortedDecoratorsToApply
		inject: connection
		into: [ :decoratee :decoratorType | decoratorType decorating: decoratee ].
		
	^product ! !

!ConnectionDecoratorBuilder methodsFor: 'building' stamp: 'HAW 9/19/2017 09:15:12'!
decorateConnectionWith: aConnectionDecoratorClass

	decoratorTypes add: aConnectionDecoratorClass ! !


!ConnectionDecoratorBuilder methodsFor: 'building - private' stamp: 'HAW 9/19/2017 09:21:36'!
decorationOrder
	
	"Este es el orden con el que se debe ir creando la cadena de decoracion.
	El orden de este ejemplo es completamente arbitrario - Hernan"
	
	^ { TracedConnectionDecorator. ZippedConnectionDecorator. EncriptedConnectionDecorator. }.
	
! !

!ConnectionDecoratorBuilder methodsFor: 'building - private' stamp: 'HAW 9/19/2017 09:20:46'!
sortedDecoratorsToApply
	
	^self decorationOrder select: [ :aDecoratorType | decoratorTypes includes: aDecoratorType ].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ConnectionDecoratorBuilder class' category: #'DesignPatterns-Decorator'!
ConnectionDecoratorBuilder class
	instanceVariableNames: ''!

!ConnectionDecoratorBuilder class methodsFor: 'instance creation' stamp: 'HAW 9/19/2017 09:14:24'!
for: aConnection

	^self new initializeFor: aConnection ! !


!classDefinition: #DecoratorExamples category: #'DesignPatterns-Decorator'!
Object subclass: #DecoratorExamples
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'DesignPatterns-Decorator'!

!DecoratorExamples methodsFor: 'examples' stamp: 'HAW 9/19/2017 09:24:51'!
example1DecoracionSimpleConTraceDecorator

	"Recordar de abrir el Transcript para ver que se tracea - Hernan"
	
	| connection |
	
	connection := TracedConnectionDecorator decorating: TCPConnection new.
	
	connection send: 'Hola'.
	connection send: 'Chau'.
	connection close.! !

!DecoratorExamples methodsFor: 'examples' stamp: 'HAW 9/19/2017 09:25:04'!
example2CadenaDeDecoracionCreadaExplicitamente

	"Recordar de abrir el Transcript para ver que se tracea - Hernan"
	
	| connection |
	
	connection := ZippedConnectionDecorator decorating: (TracedConnectionDecorator decorating: TCPConnection new).
	
	connection send: 'Hola'.
	connection send: 'Chau'.
	connection close.! !

!DecoratorExamples methodsFor: 'examples' stamp: 'HAW 9/19/2017 09:25:14'!
example3CadenaDeDecoracionCreadaPorBuilder

	"Ejemplo donde el orden de la cadena de decoracion importa, por lo que uso un Builder - Hernan"
	
	| connection builder |
	
	builder := ConnectionDecoratorBuilder for: TCPConnection new.
	builder 
		decorateConnectionWith: ZippedConnectionDecorator;
		decorateConnectionWith: TracedConnectionDecorator;
		decorateConnectionWith: EncriptedConnectionDecorator.
		
	connection := builder build.
	
	connection send: 'Hola'.
	connection send: 'Chau'.
	connection close.! !
