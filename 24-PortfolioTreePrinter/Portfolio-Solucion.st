!classDefinition: #PortfolioTest category: #'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:15'!
test08PortfolioTransasctionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/26/2019 18:28:28'!
test16PortfolioHasZeroAsBalanceWhenReportedAccountSummary 

	| account report expectedPrint |
	
	account := Portfolio new.
	report := AccountSummary for: account .
	
	expectedPrint := 'Balance = 0', String newLineString .

	self assert: expectedPrint equals: report print .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/26/2019 18:31:59'!
test17PortfolioWithEmptyAccountHasZeroAsBalanceWhenReportedAccountSummary 

	| account report expectedPrint |
	
	account := Portfolio new.
	account add: ReceptiveAccount new.
	report := AccountSummary for: account .
	
	expectedPrint := 'Balance = 0', String newLineString .

	self assert: expectedPrint equals: report print .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/26/2019 18:42:44'!
test18PortfolioWithAccountWithDepositWhenReportedAccountSummary 

	| account report expectedPrint receptiveAccount |
	
	account := Portfolio new.
	receptiveAccount := ReceptiveAccount new.
	account add: receptiveAccount.
	Deposit register: 100 on: receptiveAccount.
	report := AccountSummary for: account .
	
	expectedPrint := 'Depósito por 100', String newLineString, 'Balance = 100', String newLineString  .

	self assert: expectedPrint equals: report print .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/26/2019 18:47:32'!
test19PortfolioWithTwoAccountsWithTransactionsWhenReportedAccountSummary 

	| account report expectedPrint receptiveAccount1 receptiveAccount2 |
	
	account := Portfolio new.
	receptiveAccount1 := ReceptiveAccount new.
	receptiveAccount2 := ReceptiveAccount new.

	account add: receptiveAccount1.
	account add: receptiveAccount2.
	
	WireTransfer register: 100 from: receptiveAccount1 to: receptiveAccount2.
	report := AccountSummary for: account .
	
	expectedPrint := 'Salida por transferencia de 100', String newLineString, 'Entrada por transferencia de 100', String newLineString, 'Balance = 0', String newLineString  .

	self assert: expectedPrint equals: report print .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/26/2019 18:51:47'!
test20PortfolioHasZeroAsBalanceWhenReportedTransferNet 

	| account report |
	
	account := Portfolio new.
	report := TransferNet for: account .

	self assert: '0' equals: report print .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/26/2019 18:52:18'!
test21PortfolioWithEmptyAccountHasZeroAsBalanceWhenReportedTransferNet

	| account report |
	
	account := Portfolio new.
	account add: ReceptiveAccount new.
	report := TransferNet for: account .

	self assert: '0' equals: report print .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/26/2019 18:53:20'!
test22PortfolioWithAccountWithDepositWhenReportedTransferNet

	| account report receptiveAccount |
	
	account := Portfolio new.
	receptiveAccount := ReceptiveAccount new.
	account add: receptiveAccount.
	Deposit register: 100 on: receptiveAccount.
	report := TransferNet for: account .

	self assert: '0' equals: report print .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/26/2019 18:53:59'!
test23PortfolioWithTwoAccountsWithTransactionsWhenReportedTransferNet

	| account report receptiveAccount1 receptiveAccount2 |
	
	account := Portfolio new.
	receptiveAccount1 := ReceptiveAccount new.
	receptiveAccount2 := ReceptiveAccount new.

	account add: receptiveAccount1.
	account add: receptiveAccount2.
	
	WireTransfer register: 100 from: receptiveAccount1 to: receptiveAccount2.
	report := TransferNet for: account .

	self assert: '0' equals: report print .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/26/2019 18:54:38'!
test24PortfolioWithAccountsWithTransfersWhenReportedTransferNet

	| account report receptiveAccount1 receptiveAccount2 |
	
	account := Portfolio new.
	receptiveAccount1 := ReceptiveAccount new.
	receptiveAccount2 := ReceptiveAccount new.

	account add: receptiveAccount1.
	
	WireTransfer register: 100 from: receptiveAccount1 to: receptiveAccount2.
	report := TransferNet for: account .

	self assert: '-100' equals: report print .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/26/2019 19:50:29'!
test25EmptyPortfolioWhenReportedTreeSummary 

	| account report expectedPrint |
	
	account := Portfolio named: 'Familia'.
	report := TreeSummary  for: account .
	
	expectedPrint := 'Portfolio de Familia', String newLineString .

	self assert: expectedPrint equals: report print .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/26/2019 19:52:51'!
test26PortfolioWithAccountWhenReportedTreeSummary 

	| account report expectedPrint |
	
	account := Portfolio named: 'Familia'.
	account add: (ReceptiveAccount named: 'Forever Alone').
	report := TreeSummary  for: account .
	
	expectedPrint := 'Portfolio de Familia', String newLineString,
						'Cuenta de Forever Alone', String newLineString .

	self assert: expectedPrint equals: report print .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/26/2019 19:54:22'!
test27PortfolioWithAccountAndEmptyPortfolioWhenReportedTreeSummary 

	| account report expectedPrint |
	
	account := Portfolio named: 'Familia'.
	account add: (ReceptiveAccount named: 'Forever Alone'); add: (Portfolio named: 'Amigues').
	report := TreeSummary  for: account .
	
	expectedPrint := 'Portfolio de Familia', String newLineString,
						'Cuenta de Forever Alone', String newLineString,
						'Portfolio de Amigues', String newLineString .

	self assert: expectedPrint equals: report print .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/26/2019 19:57:04'!
test28PortfolioWithAccountAndPortfolioWhenReportedTreeSummary 

	| account report expectedPrint account2 |
	
	account := Portfolio named: 'Familia'.
	account2 := Portfolio named: 'Amigues'.
	account2 add: (ReceptiveAccount named: 'Not Forever Alone').
	account add: (ReceptiveAccount named: 'Forever Alone'); add: account2.
	report := TreeSummary  for: account .
	
	expectedPrint := 'Portfolio de Familia', String newLineString,
						'Cuenta de Forever Alone', String newLineString,
						'Portfolio de Amigues', String newLineString,
						'Cuenta de Not Forever Alone', String newLineString .

	self assert: expectedPrint equals: report print .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/26/2019 19:58:38'!
test29PortfolioWithAccountWithTransactionAndPortfolioWhenReportedTreeSummary 

	| account report expectedPrint account2 receptiveAccount |
	
	account := Portfolio named: 'Familia'.
	account2 := Portfolio named: 'Amigues'.
	receptiveAccount := ReceptiveAccount named: 'Not Forever Alone'.
	Deposit register: 100 on: receptiveAccount.
	account2 add: receptiveAccount.
	account add: (ReceptiveAccount named: 'Forever Alone'); add: account2.
	report := TreeSummary  for: account .
	
	expectedPrint := 'Portfolio de Familia', String newLineString,
						'Cuenta de Forever Alone', String newLineString,
						'Portfolio de Amigues', String newLineString,
						'Cuenta de Not Forever Alone', String newLineString .

	self assert: expectedPrint equals: report print .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/26/2019 20:03:23'!
test30PortfolioHasZeroAsBalanceWhenReportedSpecializedTreeSummary

	| account report expectedPrint |
	
	account := Portfolio named: 'Familia'.
	report := SpecializedTreeSummary for: account .
	
	expectedPrint := 'Portfolio de Familia', String newLineString,
						'Balance = 0', String newLineString .

	self assert: expectedPrint equals: report print .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/26/2019 20:08:51'!
test31PortfolioWithEmptyAccountWhenReportedSpecializedTreeSummary

	| account report expectedPrint receptiveAccount |
	
	receptiveAccount := ReceptiveAccount named: 'Juanito'.
	account := Portfolio named: 'Familia'.
	account  add: receptiveAccount .
	report := SpecializedTreeSummary for: account .
	
	expectedPrint := 'Portfolio de Familia', String newLineString,
						'Cuenta de Juanito', String newLineString,
						'Balance = 0', String newLineString,
						'Balance = 0', String newLineString.
						
	self assert: expectedPrint equals: report print .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/26/2019 20:13:10'!
test32PortfolioWithAccountWithDepositWhenReportedSpecializedTreeSummary

	| account report expectedPrint receptiveAccount |
	
	account := Portfolio named: 'Familia'.
	receptiveAccount := ReceptiveAccount named: 'Juanito'.
	account add: receptiveAccount .
	Deposit register: 100 on: receptiveAccount .
	report := SpecializedTreeSummary for: account .
	
	expectedPrint := 'Portfolio de Familia', String newLineString,
						'Cuenta de Juanito', String newLineString,
						'Depósito por 100', String newLineString,
						'Balance = 100', String newLineString,
						'Balance = 100', String newLineString.
						
	self assert: expectedPrint equals: report print .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/26/2019 20:14:14'!
test33PortfolioWithAccountWithWithdrawWhenReportedSpecializedTreeSummary

	| account report expectedPrint receptiveAccount |
	
	account := Portfolio named: 'Familia'.
	receptiveAccount := ReceptiveAccount named: 'Juanito'.
	account add: receptiveAccount .
	Withdraw register: 100 on: receptiveAccount .
	report := SpecializedTreeSummary for: account .
	
	expectedPrint := 'Portfolio de Familia', String newLineString,
						'Cuenta de Juanito', String newLineString,
						'Extracción por 100', String newLineString,
						'Balance = -100', String newLineString,
						'Balance = -100', String newLineString.
						
	self assert: expectedPrint equals: report print .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/26/2019 20:16:38'!
test34PortfolioWithAccountWithRecievedWireTransferWhenReportedSpecializedTreeSummary

	| account report expectedPrint receptiveAccount receptiveAccount2 |
	
	account := Portfolio named: 'Familia'.
	receptiveAccount := ReceptiveAccount named: 'Juanito'.
	receptiveAccount2 := ReceptiveAccount named: 'Patito'.
	account add: receptiveAccount .

	WireTransfer register: 100 from: receptiveAccount2 to: receptiveAccount .
	report := SpecializedTreeSummary for: account .
	
	expectedPrint := 'Portfolio de Familia', String newLineString,
						'Cuenta de Juanito', String newLineString,
						'Entrada por transferencia de 100', String newLineString,
						'Balance = 100', String newLineString,
						'Balance = 100', String newLineString.
						
	self assert: expectedPrint equals: report print .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/26/2019 20:17:17'!
test35PortfolioWithAccountWithSentWireTransferWhenReportedSpecializedTreeSummary

	| account report expectedPrint receptiveAccount receptiveAccount2 |
	
	account := Portfolio named: 'Familia'.
	receptiveAccount := ReceptiveAccount named: 'Juanito'.
	receptiveAccount2 := ReceptiveAccount named: 'Patito'.
	account add: receptiveAccount .

	WireTransfer register: 100 from: receptiveAccount to: receptiveAccount2 .
	report := SpecializedTreeSummary for: account .
	
	expectedPrint := 'Portfolio de Familia', String newLineString,
						'Cuenta de Juanito', String newLineString,
						'Salida por transferencia de 100', String newLineString,
						'Balance = -100', String newLineString,
						'Balance = -100', String newLineString.
						
	self assert: expectedPrint equals: report print .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/26/2019 20:18:20'!
test36PortfolioWithAccountWithDepositAndWithdrawWhenReportedSpecializedTreeSummary

	| account report expectedPrint receptiveAccount |
	
	account := Portfolio named: 'Familia'.
	receptiveAccount := ReceptiveAccount named: 'Juanito'.
	account add: receptiveAccount .
	
	Deposit register: 100 on: receptiveAccount .
	Withdraw register: 50 on: receptiveAccount .
	report := SpecializedTreeSummary for: account .
	
	expectedPrint := 'Portfolio de Familia', String newLineString,
						'Cuenta de Juanito', String newLineString,
						'Depósito por 100', String newLineString,
						'Extracción por 50', String newLineString,
						'Balance = 50', String newLineString,
						'Balance = 50', String newLineString.
						
	self assert: expectedPrint equals: report print .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/26/2019 20:20:00'!
test37PortfolioWithAccountWithRecievedAndSentSentWireTransferWhenReportedSpecializedTreeSummary

	| account report expectedPrint receptiveAccount receptiveAccount2 |
	
	account := Portfolio named: 'Familia'.
	receptiveAccount := ReceptiveAccount named: 'Juanito'.
	receptiveAccount2 := ReceptiveAccount named: 'Patito'.
	account add: receptiveAccount .

	WireTransfer register: 100 from: receptiveAccount to: receptiveAccount2 .
	WireTransfer register: 50 from: receptiveAccount2 to: receptiveAccount .
	report := SpecializedTreeSummary for: account .
	
	expectedPrint := 'Portfolio de Familia', String newLineString,
						'Cuenta de Juanito', String newLineString,
						'Salida por transferencia de 100', String newLineString,
						'Entrada por transferencia de 50', String newLineString,
						'Balance = -50', String newLineString,
						'Balance = -50', String newLineString.
						
	self assert: expectedPrint equals: report print .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/26/2019 20:21:44'!
test38PortfolioWithAccountWithTransactionsWhenReportedSpecializedTreeSummary

	| account report expectedPrint receptiveAccount receptiveAccount2 |
	
	account := Portfolio named: 'Familia'.
	receptiveAccount := ReceptiveAccount named: 'Juanito'.
	receptiveAccount2 := ReceptiveAccount named: 'Patito'.
	account add: receptiveAccount .
	
	Deposit register: 101 on: receptiveAccount .
	Withdraw register: 50 on: receptiveAccount .
	WireTransfer register: 100 from: receptiveAccount to: receptiveAccount2 .
	WireTransfer register: 50 from: receptiveAccount2 to: receptiveAccount .
	report := SpecializedTreeSummary for: account .
	
	expectedPrint := 'Portfolio de Familia', String newLineString,
						'Cuenta de Juanito', String newLineString,
						'Depósito por 101', String newLineString,
						'Extracción por 50', String newLineString,
						'Salida por transferencia de 100', String newLineString,
						'Entrada por transferencia de 50', String newLineString,
						'Balance = 1', String newLineString,
						'Balance = 1', String newLineString.
						
	self assert: expectedPrint equals: report print .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/26/2019 20:24:55'!
test39PortfolioWithAccountsWithTransactionsWhenReportedSpecializedTreeSummary

	| account report expectedPrint receptiveAccount receptiveAccount2 |
	
	account := Portfolio named: 'Familia'.
	receptiveAccount := ReceptiveAccount named: 'Juanito'.
	receptiveAccount2 := ReceptiveAccount named: 'Patito'.
	account add: receptiveAccount; add: receptiveAccount2 .
	
	Deposit register: 101 on: receptiveAccount .
	Withdraw register: 50 on: receptiveAccount .
	WireTransfer register: 100 from: receptiveAccount to: receptiveAccount2 .
	WireTransfer register: 50 from: receptiveAccount2 to: receptiveAccount .
	report := SpecializedTreeSummary for: account .
	
	expectedPrint := 'Portfolio de Familia', String newLineString,
						'Cuenta de Juanito', String newLineString,
						'Depósito por 101', String newLineString,
						'Extracción por 50', String newLineString,
						'Salida por transferencia de 100', String newLineString,
						'Entrada por transferencia de 50', String newLineString,
						'Balance = 1', String newLineString,
						'Cuenta de Patito', String newLineString,
						'Entrada por transferencia de 100', String newLineString,
						'Salida por transferencia de 50', String newLineString,
						'Balance = 50', String newLineString,
						'Balance = 51', String newLineString.
						
	self assert: expectedPrint equals: report print .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/26/2019 20:27:22'!
test40PortfolioWithAccountAndPortfolioWithTransactionsWhenReportedSpecializedTreeSummary

	| account report expectedPrint receptiveAccount receptiveAccount2 account2 |
	
	account := Portfolio named: 'Familia'.
	receptiveAccount := ReceptiveAccount named: 'Juanito'.
	receptiveAccount2 := ReceptiveAccount named: 'Patito'.
	account2 := Portfolio named: 'Amigues'.
	account add: receptiveAccount; add: account2 .
	account2 add: receptiveAccount2 .
	
	Deposit register: 101 on: receptiveAccount .
	Withdraw register: 50 on: receptiveAccount .
	WireTransfer register: 100 from: receptiveAccount to: receptiveAccount2 .
	WireTransfer register: 50 from: receptiveAccount2 to: receptiveAccount .
	report := SpecializedTreeSummary for: account .
	
	expectedPrint := 'Portfolio de Familia', String newLineString,
						'Cuenta de Juanito', String newLineString,
						'Depósito por 101', String newLineString,
						'Extracción por 50', String newLineString,
						'Salida por transferencia de 100', String newLineString,
						'Entrada por transferencia de 50', String newLineString,
						'Balance = 1', String newLineString,
						'Portfolio de Amigues', String newLineString,
						'Cuenta de Patito', String newLineString,
						'Entrada por transferencia de 100', String newLineString,
						'Salida por transferencia de 50', String newLineString,
						'Balance = 50', String newLineString,
						'Balance = 50', String newLineString,
						'Balance = 51', String newLineString.
						
	self assert: expectedPrint equals: report print .
! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'aa 10/21/2019 20:39:40'!
test08WireTransferIncreasesBalanceOnOneAccountDecreasesOnOtherAccount

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	WireTransfer register: 100 from: account1 to: account2 .
		
	self assert: -100 equals: account1 balance .
	self assert: 100 equals: account2 balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'aa 10/26/2019 17:53:21'!
test09AccountsHaveCorrectTransactionsAfterWireTransfer

	| account1 account2 wireTransfer |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	wireTransfer := WireTransfer register: 100 from: account1 to: account2 .
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: wireTransfer wireTransferOut).
	self assert: 1 equals: account2 transactions size .
	self assert: (account2 transactions includes: wireTransfer wireTransferIn).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'aa 10/26/2019 17:53:21'!
test10AccountsHaveSpecificRegistersAfterWireTransfer

	| account1 account2 wireTransfer |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	wireTransfer := WireTransfer register: 100 from: account1 to: account2 .
	
	self assert: (account1 hasRegistered: wireTransfer wireTransferOut).
	self assert: (account2 hasRegistered: wireTransfer wireTransferIn).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'aa 10/26/2019 17:53:21'!
test11AccountsDoesNotHaveUnknownWireTransferAfterWireTransfer

	| account1 account2 wireTransfer account3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	
	wireTransfer := WireTransfer register: 100 from: account3 to: account2 .
	
	self deny: (account1 hasRegistered: wireTransfer wireTransferIn ).
	self deny: (account1 hasRegistered: wireTransfer wireTransferOut ).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'aa 10/21/2019 21:15:54'!
test12ShouldRaiseErrorWhenWireTransferingZeroValue

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	self should: [WireTransfer register: 0 from: account1 to: account2 ] raise: Error - MessageNotUnderstood
		description: 'No se puede hacer una transferencia con monto cero o negativo o cualquier cosa no positiva. Numeros complejos, abstenerce.'.
	
	self assert: account1 balance equals: 0.
	self assert: account1 transactions isEmpty.
	self assert: account2 balance equals: 0.
	self assert: account2 transactions isEmpty.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'aa 10/21/2019 21:23:28'!
test13ShouldRaiseErrorWhenWireTransferingFromSameAccount

	| account1 |
	
	account1 := ReceptiveAccount new.
	
	self should: [WireTransfer register: 1000 from: account1 to: account1 ] raise: Error - MessageNotUnderstood
		description: 'No se puede hacer una transferencia entre las mismas cuentas. Alter ego, abstenerce'.
	
	self assert: account1 balance equals: 0.
	self assert: account1 transactions isEmpty.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'aa 10/26/2019 18:06:54'!
test14ReceptiveAccountHasZeroAsBalanceWhenReportedAccountSummary 

	| account report expectedPrint |
	
	account := ReceptiveAccount new.
	report := AccountSummary for: account .
	
	expectedPrint := 'Balance = 0', String newLineString .

	self assert: expectedPrint equals: report print .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'aa 10/26/2019 18:10:53'!
test15ReceptiveAccountWithDepositWhenReportedAccountSummary 

	| account report expectedPrint |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	report := AccountSummary for: account .
	
	expectedPrint := 'Depósito por 100', String newLineString, 'Balance = 100', String newLineString  .

	self assert: expectedPrint equals: report print .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'aa 10/26/2019 18:11:29'!
test16ReceptiveAccountWithWithdrawWhenReportedAccountSummary 

	| account report expectedPrint |
	
	account := ReceptiveAccount new.
	Withdraw register: 100 on: account.
	report := AccountSummary for: account .
	
	expectedPrint := 'Extracción por 100', String newLineString, 'Balance = -100', String newLineString  .

	self assert: expectedPrint equals: report print .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'aa 10/26/2019 18:13:03'!
test17ReceptiveAccountWithRecievedWireTransferWhenReportedAccountSummary 

	| account report expectedPrint account2 |
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	WireTransfer register: 100 from: account2 to: account.
	report := AccountSummary for: account .
	
	expectedPrint := 'Entrada por transferencia de 100', String newLineString, 'Balance = 100', String newLineString  .

	self assert: expectedPrint equals: report print .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'aa 10/26/2019 18:13:28'!
test18ReceptiveAccountWithSentWireTransferWhenReportedAccountSummary 

	| account report expectedPrint account2 |
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	WireTransfer register: 100 from: account to: account2.
	report := AccountSummary for: account .
	
	expectedPrint := 'Salida por transferencia de 100', String newLineString, 'Balance = -100', String newLineString  .

	self assert: expectedPrint equals: report print .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'aa 10/26/2019 18:14:58'!
test19ReceptiveAccountWithDepositAndWithdrawWhenReportedAccountSummary 

	| account report expectedPrint |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	report := AccountSummary for: account .
	
	expectedPrint := 'Depósito por 100', String newLineString, 'Extracción por 50', String newLineString, 'Balance = 50', String newLineString  .

	self assert: expectedPrint equals: report print .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'aa 10/26/2019 18:17:47'!
test20ReceptiveAccountWithRecievedAndSentWireTransferWhenReportedAccountSummary 

	| account report expectedPrint account2 |
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	WireTransfer register: 100 from: account to: account2.
	WireTransfer register: 50 from: account2 to: account.
	report := AccountSummary for: account .
	
	expectedPrint := 'Salida por transferencia de 100', String newLineString, 'Entrada por transferencia de 50', String newLineString, 'Balance = -50', String newLineString  .

	self assert: expectedPrint equals: report print .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'aa 10/26/2019 18:20:17'!
test21ReceptiveAccountTransactionsWhenReportedAccountSummary 

	| account report expectedPrint account2 |
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: 101 on: account.
	Withdraw register: 50 on: account.
	WireTransfer register: 100 from: account to: account2.
	WireTransfer register: 50 from: account2 to: account.
	
	report := AccountSummary for: account .
	
	expectedPrint := 'Depósito por 101', String newLineString, 'Extracción por 50', String newLineString,
						'Salida por transferencia de 100', String newLineString, 'Entrada por transferencia de 50', String newLineString,
						'Balance = 1', String newLineString  .

	self assert: expectedPrint equals: report print .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'aa 10/26/2019 18:22:08'!
test22ReceptiveAccountHasZeroAsBalanceWhenReportedTransferNet 

	| account report |
	
	account := ReceptiveAccount new.
	report := TransferNet for: account .

	self assert: '0' equals: report print .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'aa 10/26/2019 18:23:05'!
test23ReceptiveAccountWithDepositWhenReportedTransferNet

	| account report |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	report := TransferNet for: account .

	self assert: '0' equals: report print .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'aa 10/26/2019 18:23:46'!
test24ReceptiveAccountWithWithdrawWhenReportedTransferNet

	| account report |
	
	account := ReceptiveAccount new.
	Withdraw register: 100 on: account.
	report := TransferNet for: account .

	self assert: '0' equals: report print .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'aa 10/26/2019 18:24:27'!
test25ReceptiveAccountWithRecievedWireTransferWhenReportedTransferNet

	| account report account2 |
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	WireTransfer register: 100 from: account2 to: account.
	report := TransferNet for: account .

	self assert: '100' equals: report print .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'aa 10/26/2019 18:25:08'!
test26ReceptiveAccountWithSentWireTransferWhenReportedTransferNet

	| account report account2 |
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	WireTransfer register: 100 from: account to: account2.
	report := TransferNet for: account .

	self assert: '-100' equals: report print .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'aa 10/26/2019 18:26:01'!
test27ReceptiveAccountWithRecievedAndSentWireTransferWhenReportedTransferNet

	| account report account2 |
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	WireTransfer register: 100 from: account to: account2.
	WireTransfer register: 50 from: account2 to: account.
	report := TransferNet for: account .
	
	self assert: '-50' equals: report print .
! !


!classDefinition: #Account category: #'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'accountName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'reporting' stamp: 'aa 10/26/2019 16:59:59'!
reportWith: aReport

	^ self subclassResponsibility .! !


!Account methodsFor: 'initialization' stamp: 'aa 10/26/2019 17:08:50'!
initializeWithName: aName

	accountName := aName.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: #'Portfolio-Solucion'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'instance creation' stamp: 'aa 10/26/2019 19:09:39'!
named: aName
	
	^ self new initializeWithName: aName ! !


!classDefinition: #Portfolio category: #'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'reporting' stamp: 'aa 10/26/2019 18:35:46'!
reportWith: aReport

	aReport reportWithPortfolioName: accountName.
	accounts do: [ :account | account reportWith: aReport ].
	aReport reportWithBalance: self balance.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'reporting' stamp: 'aa 10/26/2019 18:35:55'!
reportWith: aReport
	
	aReport reportWithReceptiveAccountName: accountName.
	self transactions do: [ :transaction | transaction reportWith: aReport ].
	aReport reportWithBalance: self balance.! !


!classDefinition: #AccountTransaction category: #'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'reporting' stamp: 'aa 10/26/2019 16:11:06'!
reportWith: aReport

	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'aa 10/21/2019 20:22:15'!
for: aValue

	^ self new initializeFor: aValue .! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'reporting' stamp: 'aa 10/26/2019 16:23:31'!
reportWith: aReport

	aReport reportDeposit: self value .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #WireTransferIn category: #'Portfolio-Solucion'!
AccountTransaction subclass: #WireTransferIn
	instanceVariableNames: 'wireTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WireTransferIn methodsFor: 'initialization' stamp: 'aa 10/21/2019 20:23:08'!
initializeFor: aWireTransfer

	wireTransfer := aWireTransfer ! !


!WireTransferIn methodsFor: 'reporting' stamp: 'aa 10/26/2019 16:24:27'!
reportWith: aReport

	aReport reportWireTransferIn: self value .! !


!WireTransferIn methodsFor: 'balance' stamp: 'aa 10/26/2019 17:42:05'!
affectBalance: aBalance

	^ aBalance + wireTransfer balance.! !

!WireTransferIn methodsFor: 'balance' stamp: 'aa 10/26/2019 17:57:00'!
value

	^ wireTransfer balance ! !


!classDefinition: #WireTransferOut category: #'Portfolio-Solucion'!
AccountTransaction subclass: #WireTransferOut
	instanceVariableNames: 'wireTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WireTransferOut methodsFor: 'initialization' stamp: 'aa 10/21/2019 20:23:23'!
initializeFor: aWireTransfer

	wireTransfer := aWireTransfer ! !


!WireTransferOut methodsFor: 'reporting' stamp: 'aa 10/26/2019 16:24:45'!
reportWith: aReport

	aReport reportWireTransferOut: self value .! !


!WireTransferOut methodsFor: 'balance' stamp: 'aa 10/26/2019 17:53:58'!
affectBalance: aBalance

	^ aBalance - wireTransfer balance.! !

!WireTransferOut methodsFor: 'balance' stamp: 'aa 10/26/2019 17:57:07'!
value

	^ wireTransfer balance ! !


!classDefinition: #Withdraw category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'reporting' stamp: 'aa 10/26/2019 16:25:02'!
reportWith: aReport

	aReport reportWithdraw: self value .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: #'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: 'account reportString'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'initialization' stamp: 'aa 10/26/2019 16:41:37'!
initialize

	reportString := ''.! !

!Report methodsFor: 'initialization' stamp: 'aa 10/21/2019 21:50:10'!
initializeFor: anAccount

	account := anAccount .! !


!Report methodsFor: 'reporting' stamp: 'aa 10/26/2019 16:31:36'!
print

	account reportWith: self.
	^ reportString! !

!Report methodsFor: 'reporting' stamp: 'aa 10/26/2019 16:17:40'!
reportDeposit: aValue! !

!Report methodsFor: 'reporting' stamp: 'aa 10/26/2019 16:19:46'!
reportWireTransferIn: aValue! !

!Report methodsFor: 'reporting' stamp: 'aa 10/26/2019 16:19:58'!
reportWireTransferOut: aValue! !

!Report methodsFor: 'reporting' stamp: 'aa 10/26/2019 17:18:02'!
reportWithBalance: aName! !

!Report methodsFor: 'reporting' stamp: 'aa 10/26/2019 17:17:28'!
reportWithPortfolioName: aName! !

!Report methodsFor: 'reporting' stamp: 'aa 10/26/2019 17:17:19'!
reportWithReceptiveAccountName: aName! !

!Report methodsFor: 'reporting' stamp: 'aa 10/26/2019 16:19:33'!
reportWithdraw: aValue! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: #'Portfolio-Solucion'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'instance creation' stamp: 'aa 10/21/2019 21:49:42'!
for: anAccount

	^ self new initializeFor: anAccount .! !


!classDefinition: #AccountSummary category: #'Portfolio-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'reporting' stamp: 'aa 10/26/2019 18:37:56'!
print

	super print.
	self reportAccountBalance .
	^ reportString .! !

!AccountSummary methodsFor: 'reporting' stamp: 'aa 10/26/2019 16:51:21'!
reportDeposit: aValue

	reportString  := reportString, 'Depósito por ', aValue asString, String newLineString .! !

!AccountSummary methodsFor: 'reporting' stamp: 'aa 10/26/2019 16:51:30'!
reportWireTransferIn: aValue

	reportString  := reportString, 'Entrada por transferencia de ', aValue asString, String newLineString .! !

!AccountSummary methodsFor: 'reporting' stamp: 'aa 10/26/2019 16:51:42'!
reportWireTransferOut: aValue

	reportString  := reportString, 'Salida por transferencia de ', aValue asString, String newLineString .! !

!AccountSummary methodsFor: 'reporting' stamp: 'aa 10/26/2019 16:51:54'!
reportWithdraw: aValue

	reportString  := reportString, 'Extracción por ', aValue asString, String newLineString .! !


!AccountSummary methodsFor: 'private - reporting' stamp: 'aa 10/26/2019 18:37:36'!
reportAccountBalance

	reportString := reportString, 'Balance = ', account balance asString, String newLineString .! !


!classDefinition: #SpecializedTreeSummary category: #'Portfolio-Solucion'!
Report subclass: #SpecializedTreeSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SpecializedTreeSummary methodsFor: 'reporting' stamp: 'aa 10/26/2019 19:17:47'!
reportDeposit: aValue

	reportString  := reportString, 'Depósito por ', aValue asString, String newLineString .! !

!SpecializedTreeSummary methodsFor: 'reporting' stamp: 'aa 10/26/2019 19:18:12'!
reportWireTransferIn: aValue

	reportString  := reportString, 'Entrada por transferencia de ', aValue asString, String newLineString .! !

!SpecializedTreeSummary methodsFor: 'reporting' stamp: 'aa 10/26/2019 19:18:27'!
reportWireTransferOut: aValue

	reportString  := reportString, 'Salida por transferencia de ', aValue asString, String newLineString .! !

!SpecializedTreeSummary methodsFor: 'reporting' stamp: 'aa 10/26/2019 19:20:08'!
reportWithBalance: aValue

	reportString := reportString, 'Balance = ', aValue asString , String newLineString .! !

!SpecializedTreeSummary methodsFor: 'reporting' stamp: 'aa 10/26/2019 19:19:17'!
reportWithPortfolioName: aName

	reportString := reportString, 'Portfolio de ', aName , String newLineString .! !

!SpecializedTreeSummary methodsFor: 'reporting' stamp: 'aa 10/26/2019 19:19:33'!
reportWithReceptiveAccountName: aName

	reportString := reportString, 'Cuenta de ', aName , String newLineString .! !

!SpecializedTreeSummary methodsFor: 'reporting' stamp: 'aa 10/26/2019 19:18:43'!
reportWithdraw: aValue

	reportString  := reportString, 'Extracción por ', aValue asString, String newLineString .! !


!classDefinition: #TransferNet category: #'Portfolio-Solucion'!
Report subclass: #TransferNet
	instanceVariableNames: 'transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'initialization' stamp: 'aa 10/26/2019 17:29:16'!
initialize
	
	transferNet := 0.! !


!TransferNet methodsFor: 'reporting' stamp: 'aa 10/26/2019 17:58:42'!
print

	super print.
	^ transferNet asString.! !

!TransferNet methodsFor: 'reporting' stamp: 'aa 10/26/2019 17:27:00'!
reportWireTransferIn: aValue

	transferNet := transferNet + aValue.! !

!TransferNet methodsFor: 'reporting' stamp: 'aa 10/26/2019 17:27:32'!
reportWireTransferOut: aValue

	transferNet := transferNet - aValue.! !


!classDefinition: #TreeSummary category: #'Portfolio-Solucion'!
Report subclass: #TreeSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TreeSummary methodsFor: 'reporting' stamp: 'aa 10/26/2019 19:05:39'!
reportWithPortfolioName: aName

	reportString := reportString, 'Portfolio de ', aName , String newLineString .! !

!TreeSummary methodsFor: 'reporting' stamp: 'aa 10/26/2019 19:05:23'!
reportWithReceptiveAccountName: aName

	reportString := reportString, 'Cuenta de ', aName , String newLineString .! !


!classDefinition: #WireTransfer category: #'Portfolio-Solucion'!
Object subclass: #WireTransfer
	instanceVariableNames: 'value wireTransferOut wireTransferIn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WireTransfer methodsFor: 'initialization' stamp: 'aa 10/26/2019 17:51:52'!
initializeFor: aValue from: anAccount to: anotherAccount

	value := aValue .
	wireTransferOut := WireTransferOut register: self on: anAccount .
	wireTransferIn := WireTransferIn register: self on: anotherAccount .! !


!WireTransfer methodsFor: 'balance' stamp: 'aa 10/21/2019 20:51:44'!
balance

	^value .! !


!WireTransfer methodsFor: 'accessing' stamp: 'aa 10/26/2019 17:53:21'!
wireTransferIn

	^wireTransferIn .! !

!WireTransfer methodsFor: 'accessing' stamp: 'aa 10/26/2019 17:52:42'!
wireTransferOut

	^wireTransferOut .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WireTransfer class' category: #'Portfolio-Solucion'!
WireTransfer class
	instanceVariableNames: ''!

!WireTransfer class methodsFor: 'instance creation' stamp: 'aa 10/21/2019 21:24:15'!
register: aValue from: anAccount to: anotherAccount

	aValue < 1 ifTrue: [self error: 'No se puede hacer una transferencia con monto cero o negativo o cualquier cosa no positiva. Numeros complejos, abstenerce.'].
	anAccount == anotherAccount ifTrue: [self error: 'No se puede hacer una transferencia entre las mismas cuentas. Alter ego, abstenerce'].

	^ self new initializeFor: aValue from: anAccount to: anotherAccount .! !
