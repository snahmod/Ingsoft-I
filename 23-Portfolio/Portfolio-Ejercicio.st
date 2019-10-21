!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'Eden 10/17/2019 18:54:04'!
test01PortfolioHaveZeroAsBalanceWhenCreated 

	| portfolio |
	
	portfolio := Portfolio new.

	self assert: 0 equals: portfolio balance .

! !

!PortfolioTest methodsFor: 'tests' stamp: 'Eden 10/17/2019 19:17:17'!
test02PortfolioRegistersAccountAndDepositIncreasesBalanceOnTransactionValue 

	| portfolio account |
	portfolio := Portfolio new.
	account := ReceptiveAccount  new.
	
	portfolio registerAccount: account.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: portfolio balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Eden 10/17/2019 19:17:24'!
test03PortfolioRegistersTwoAccountsAndDepositIncreasesBalanceOnTransactionValue 

	| portfolio account account2 |
	portfolio := Portfolio new.
	account := ReceptiveAccount  new.
	account2 := ReceptiveAccount  new.
	
	portfolio registerAccount: account.
	Deposit register: 100 on: account.
	Deposit register: 300 on: account2.
	portfolio registerAccount: account2.
	
		
	self assert: 400 equals: portfolio balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Eden 10/19/2019 16:16:33'!
test04PortfolioRegistersTwoIdenticalAccountsShouldRaiseError

	| portfolio account |
	portfolio := Portfolio new.
	account := ReceptiveAccount  new.
	
	portfolio registerAccount: account.
	Deposit register: 100 on: account.
	
	self should: [portfolio registerAccount: account] raise: Error - MessageNotUnderstood
		withMessageText: 'Ya existe la cuenta en el portfolio'.
	self assert: (portfolio balance) equals: 100.
	
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Eden 10/17/2019 19:31:02'!
test05PortfolioRegistersTwoAccountsAndWithdrawDecreasesBalanceOnTransactionValue 

	| portfolio account account2 |
	portfolio := Portfolio new.
	account := ReceptiveAccount  new.
	account2 := ReceptiveAccount  new.
	
	portfolio registerAccount: account.
	Withdraw register: 100 on: account.
	Withdraw register: 300 on: account2.
	portfolio registerAccount: account2.
	
		
	self assert: -400 equals: portfolio balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Eden 10/17/2019 20:05:00'!
test06PortfolioHasZeroTransactionsWhenCreated

	| portfolio |
	portfolio := Portfolio new.
		
	self assert: portfolio transactions isEmpty.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Eden 10/17/2019 20:21:12'!
test07PortfolioRegistersAccountAndHasAccountTransaction

	| portfolio account deposit |
	portfolio := Portfolio new.
	account := ReceptiveAccount  new.
	
	portfolio registerAccount: account.
	deposit := Deposit register: 100 on: account.
		
	self assert: (portfolio transactions includes: deposit).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Eden 10/17/2019 20:22:31'!
test08PortfolioRegistersAccountAndHasAccountTransactions

	| portfolio account deposit withdraw |
	portfolio := Portfolio new.
	account := ReceptiveAccount  new.
	
	portfolio registerAccount: account.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 100 on: account.
		
	self assert: (portfolio transactions includes: deposit).
	self assert: (portfolio transactions includes: withdraw).
	self assert: portfolio transactions size equals: 2.
	
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Eden 10/17/2019 20:35:10'!
test09PortfolioRegistersTwoAccountsAndHasAccountTransactions

	| portfolio account deposit withdraw account2 deposit2 withdraw2 |
	portfolio := Portfolio new.
	account := ReceptiveAccount  new.
	
	portfolio registerAccount: account.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 100 on: account.
	
	account2 := ReceptiveAccount  new.
	
	deposit2 := Deposit register: 100 on: account2.
	withdraw2 := Withdraw register: 100 on: account2.
	portfolio registerAccount: account2.
		
	self assert: (portfolio transactions includes: deposit).
	self assert: (portfolio transactions includes: withdraw).
	self assert: (portfolio transactions includes: deposit2).
	self assert: (portfolio transactions includes: withdraw2).
	self assert: portfolio transactions size equals: 4.
	
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Eden 10/17/2019 20:42:53'!
test10EmptyPortfolioShouldNotHaveRegisteredTransactions

	| portfolio account deposit withdraw |
	portfolio := Portfolio new.
	account := ReceptiveAccount  new.
	
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 100 on: account.
	
	self deny: (portfolio hasRegistered: deposit).
	self deny: (portfolio hasRegistered: withdraw).
	
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Eden 10/17/2019 20:45:08'!
test11PortfolioRegistersAccountAndHasSpecificTransactions

	| portfolio account deposit withdraw |
	portfolio := Portfolio new.
	account := ReceptiveAccount  new.
	
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 100 on: account.
	
	portfolio registerAccount: account.
	
	self assert: (portfolio hasRegistered: deposit).
	self assert: (portfolio hasRegistered: withdraw).
	
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Eden 10/17/2019 20:49:54'!
test12PortfolioRegistersAccountAndPortfolioDoesNotHaveAnotherTransaction

	| portfolio account account2 withdraw2 |
	portfolio := Portfolio new.
	account := ReceptiveAccount  new.
	account2 := ReceptiveAccount  new.
	
	Deposit register: 100 on: account.
	Withdraw register: 100 on: account.
	
	portfolio registerAccount: account.
	
	withdraw2 := Withdraw register: 100 on: account2.
	
	self deny: (portfolio hasRegistered: withdraw2).
	
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Eden 10/17/2019 20:49:40'!
test13PortfolioRegistersTwoAccountsAndHasSpecifTransactions

	| portfolio account deposit withdraw account2 withdraw2 deposit2 |
	portfolio := Portfolio new.
	account := ReceptiveAccount  new.
	account2 := ReceptiveAccount  new.
	
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 100 on: account.
	
	portfolio registerAccount: account.
	portfolio  registerAccount: account2. 
	
	withdraw2 := Withdraw register: 100 on: account2.
	deposit2 := Deposit register: 100 on: account2.
	
	self assert: (portfolio hasRegistered: withdraw2).
	self assert: (portfolio hasRegistered: deposit2).
	self assert: (portfolio hasRegistered: withdraw).
	self assert: (portfolio hasRegistered: deposit).
	
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Eden 10/17/2019 21:40:46'!
test14PortfolioRegistersEmptyPorfolioAndBalanceShouldBeZero

	| portfolio portfolio2 |
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	
	portfolio registerPortfolio: portfolio2 .
	self assert: portfolio balance equals: 0.
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'Eden 10/17/2019 21:45:51'!
test15PortfolioRegistersPorfolioWithAccountAndBalanceShouldBeAccounts

	| portfolio account portfolio2 |
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	
	portfolio registerPortfolio: portfolio2 .
	
	account := ReceptiveAccount  new.
	
	portfolio2 registerAccount: account.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: portfolio balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Eden 10/19/2019 16:01:41'!
test16ShouldRaiseErrorWhenAddingAnAccountInsideAPortfolioInsideAPortfolioWithTheSameAccount

	| portfolio account portfolio2 |
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	
	portfolio registerPortfolio: portfolio2 .
	
	account := ReceptiveAccount  new.
	
	portfolio registerAccount: account.
	Deposit register: 100 on: account.
	
	self should: [portfolio2 registerAccount: account] raise: Error - MessageNotUnderstood
		withMessageText: 'Ya existe la cuenta en el portfolio'.
		
	self assert: 100 equals: portfolio balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Eden 10/19/2019 16:26:08'!
test17ShouldRaiseErrorWhenAddingAnAccountInsideAPortfolioThatHasAPortfolioWithSameAccount

	| portfolio account portfolio2 |
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	
	portfolio registerPortfolio: portfolio2 .
	
	account := ReceptiveAccount  new.
	
	portfolio2 registerAccount: account.
	Deposit register: 100 on: account.
	
	self should: [portfolio registerAccount: account] raise: Error - MessageNotUnderstood
		withMessageText: 'Ya existe la cuenta en el portfolio'.
		
	self assert: 100 equals: portfolio balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Eden 10/19/2019 16:26:02'!
test18ShouldRaiseErrorWhenAddingAPortfolioWithAnAccountToSamePortfolio

	| portfolio account|
	portfolio := Portfolio new.
	account := ReceptiveAccount  new.
	
	portfolio registerAccount: account.
	portfolio registerPortfolio: portfolio.

	Deposit register: 100 on: account.
	
	self should: [portfolio registerPortfolio: portfolio.] raise: Error - MessageNotUnderstood
		withMessageText: 'Ya existe la cuenta en el portfolio'.
		
	self assert: 100 equals: portfolio balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Eden 10/19/2019 16:25:55'!
test19ShouldRaiseErrorWhenAddingAnAccountToAPortfolioThatIsInTwoPortfoliosWithSameAccount

	| portfolio portfolio2 portfolio3 account|
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	account := ReceptiveAccount  new.
	
	portfolio registerAccount: account.
	portfolio registerPortfolio: portfolio2.
	
	portfolio3 registerAccount: account.
	portfolio3 registerPortfolio: portfolio2.

	Deposit register: 100 on: account.
	
	self should: [portfolio2 registerAccount: account.] raise: Error - MessageNotUnderstood
		withMessageText: 'Ya existe la cuenta en el portfolio'.
		
	self assert: 100 equals: portfolio balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Eden 10/19/2019 16:25:49'!
test20ShouldRaiseErrorWhenAddingAPortfolioWithAnAccountInAPortfolioWithSameAccount

	| portfolio portfolio2 portfolio3 account|
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	account := ReceptiveAccount  new.
	
	portfolio registerAccount: account.
	portfolio2 registerAccount: account.
	portfolio2 registerPortfolio: portfolio3.

	Deposit register: 100 on: account.
	
	self should: [portfolio3 registerAccount: portfolio.] raise: Error - MessageNotUnderstood
		withMessageText: 'Ya existe la cuenta en el portfolio'.
		
	self assert: 100 equals: portfolio2 balance .
! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'Eden 10/17/2019 18:44:23'!
absoluteValue 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'Eden 10/17/2019 18:44:55'!
absoluteValue

	^ value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'Eden 10/17/2019 18:46:48'!
absoluteValue

	^ value negated ! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'parents children'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'Eden 10/17/2019 21:45:05'!
balance

	^children sum: [ :child | child balance ] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'testing' stamp: 'aa 10/20/2019 20:53:02'!
canAddAccount: anAccount

	self isRoot ifTrue: [^ (self hasAccount: anAccount) not ].
	^ parents allSatisfy: [ :portfolioParent | portfolioParent canAddAccount: anAccount ]! !

!Portfolio methodsFor: 'testing' stamp: 'aa 10/20/2019 20:38:25'!
hasAccount: account
	
	^ children anySatisfy: [ :child | child hasAccount: account]! !

!Portfolio methodsFor: 'testing' stamp: 'Eden 10/17/2019 20:45:45'!
hasRegistered: aTransaction
	^ self transactions includes: aTransaction.! !

!Portfolio methodsFor: 'testing' stamp: 'aa 10/20/2019 20:50:00'!
isRoot

	^ parents isEmpty .! !


!Portfolio methodsFor: 'initialization' stamp: 'Eden 10/19/2019 16:16:12'!
initialize

	children := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'registration' stamp: 'aa 10/20/2019 20:54:34'!
registerAccount: aReceptiveAccount 

	(self canAddAccount: aReceptiveAccount)  ifFalse: [^ self error: 'Ya existe la cuenta en el portfolio'].
	aReceptiveAccount registeredOn: self.
	children add: aReceptiveAccount.! !

!Portfolio methodsFor: 'registration' stamp: 'Eden 10/17/2019 21:41:49'!
registerPortfolio: aPortfolio 

	aPortfolio registeredOn: self.
	children add: aPortfolio .! !

!Portfolio methodsFor: 'registration' stamp: 'Eden 10/17/2019 21:42:39'!
registeredOn: aPortfolio

	parents add: aPortfolio .! !


!Portfolio methodsFor: 'accessing' stamp: 'Eden 10/17/2019 21:41:49'!
transactions
	^ children inject: OrderedCollection new into: [:allTransactions :account |  allTransactions addAll: account transactions. allTransactions ]! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions portfolioParents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'Eden 10/17/2019 21:39:40'!
initialize

	transactions := OrderedCollection new.
	portfolioParents := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'Eden 10/17/2019 18:45:33'!
balance

	^transactions sum: [ :aTransaction | aTransaction absoluteValue ] ifEmpty: [ 0 ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'aa 10/20/2019 20:40:50'!
hasAccount: anAccount

	^ self == anAccount! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'porfolio parents' stamp: 'Eden 10/17/2019 21:39:50'!
registeredOn: aPortfolio

	portfolioParents add: aPortfolio .! !
