!classDefinition: #InspectionableProtoObject category: #GenericProxy!
ProtoObject subclass: #InspectionableProtoObject
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GenericProxy'!

!InspectionableProtoObject methodsFor: 'as yet unclassified' stamp: 'HAW 10/19/2017 16:42:28'!
inspectorClass
	"Answer the class of the inspector to be used on the receiver.  Called by inspect; 
	use basicInspect to get a normal (less useful) type of inspector."

	^ Inspector! !

!InspectionableProtoObject methodsFor: 'as yet unclassified' stamp: 'HAW 10/19/2017 16:42:35'!
instVarAt: index put: anObject
	"Primitive. Store a value into a fixed variable in an object. The numbering of the
	 variables corresponds to the named instance variables, followed by the indexed
	 instance variables. Fail if the index is not an Integer or is not the index of a fixed
	 variable. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 174 error: ec>
	self primitiveFailed! !
