drop database if exists virtualATM;
create database virtualATM;
use virtualATM;

/*table keeps track of ATM transaction history*/
CREATE TABLE TransactionHistory (
    Transaction_Id int UNSIGNED NOT NULL PRIMARY KEY,
    ATM_ID int UNSIGNED NOT NULL,
    Transaction_Type enum('Deposit', 'Withdrawal', 'Balance Inquiry') NOT NULL,
    Transaction_Date DATETIME NOT NULL,
    Transaction_Amount DOUBLE UNSIGNED NOT NULL,
    Additional_Charges DOUBLE UNSIGNED NOT NULL default 0.00,
    Card_No binary(36) NOT NULL,    
    CONSTRAINT ATM_fk1 FOREIGN KEY (ATM_ID)
        REFERENCES ATMInfo (ATM_ID),
    CONSTRAINT Card_fk4 FOREIGN KEY (Card_No)
        REFERENCES CardDetails (Card_No)
);

/*table allocated for customer information*/
CREATE TABLE CustomerDetails (
    Customer_Id bigint(9) unsigned NOT NULL PRIMARY KEY,
    First_Name VARCHAR(100),
    Last_Name VARCHAR(100) NOT NULL,
    Street_Address TEXT NOT NULL,
    City VARCHAR(300) NOT NULL,
    Zipcode CHAR(5) NOT NULL,
    State VARCHAR(90) NOT NULL,
    Bank_Id int not null,
    CONSTRAINT Bank_fk4 FOREIGN KEY (Bank_Id)
        REFERENCES BankDetails (Bank_Id)
);

/*table dedicated to customer credit card information*/
CREATE TABLE CardDetails (
    Card_No BINARY(36) NOT NULL PRIMARY KEY,     
    PIN CHAR(4) NOT NULL UNIQUE,
    Withdrawal_Limit DOUBLE UNSIGNED NOT NULL,
    Card_Expiration_Date datetime not null, 
    Customer_Id BIGINT ZEROFILL UNSIGNED NOT NULL,
    Bank_Id INT NOT NULL,
    Cust_Account_No BIGINT(9) ZEROFILL UNSIGNED NOT NULL,
    CONSTRAINT Account_fk1 FOREIGN KEY (Cust_Account_No)
        REFERENCES AccountDetails (Acct_No),
    CONSTRAINT Bank_fk1 FOREIGN KEY (Bank_Id)
        REFERENCES BankDetails (Bank_Id),
    CONSTRAINT Customer_fk1 FOREIGN KEY (Customer_Id)
        REFERENCES CustomerDetails (Customer_Id)
);

/*table dedicated to customer account details*/
CREATE TABLE AccountDetails (
	Acct_Unique_Id int not null PRIMARY KEY auto_increment,
    Acct_No BIGINT(9) ZEROFILL UNSIGNED NOT NULL unique,
    Customer_Id BIGINT ZEROFILL UNSIGNED NOT NULL, /*foreign key*/    
    Acct_Balance DOUBLE NOT NULL default 0.00,
    Acct_Type ENUM('Checkings', 'Savings'),
    Account_Status ENUM('VIP', 'REGULAR'),
    Date_Created DATETIME NOT NULL,
    Bank_Id INT NOT NULL, /*foreign key*/
    CONSTRAINT Customer_fk10 FOREIGN KEY (Customer_Id)
        REFERENCES CustomerDetails (Customer_Id),
    CONSTRAINT Bank_fk10 FOREIGN KEY (Bank_Id)
        REFERENCES BankDetails (Bank_Id)
);

/*table dedicated to bank information*/
CREATE TABLE BankDetails (
    Bank_Id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Bank_Name TEXT NOT NULL,
    Street_Address TEXT NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL,
    Zipcode CHAR(5) NOT NULL
);

/*table dedicated to atm information*/
CREATE TABLE ATMInfo (
    ATM_ID int UNSIGNED NOT NULL PRIMARY KEY,
	Street_Address TEXT NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL,
    Zipcode CHAR(5) NOT NULL,
    Bank_Id INT NOT NULL,
    ATM_Balance DOUBLE UNSIGNED NOT NULL default 0.00,
    Manufacturer_Id INT UNSIGNED NOT NULL,
    Provider_Id INT UNSIGNED NOT NULL,
    CONSTRAINT Bank_fk2 FOREIGN KEY (Bank_Id)
        REFERENCES BankDetails (Bank_Id),
    CONSTRAINT Manufacturer_fk FOREIGN KEY (Manufacturer_Id)
        REFERENCES ManufacturerDetails (Manufacturer_Id),
    CONSTRAINT Provider_fk FOREIGN KEY (Provider_Id)
        REFERENCES ATMServiceProvider (Manufacturer_Id)
);

/*table dedicated to manufacturer information*/
CREATE TABLE ManufacturerDetails (
    Manufacturer_Id INT UNSIGNED NOT NULL PRIMARY KEY,
    Manufacturer_Name VARCHAR(250) NOT NULL,
    Street_Address TEXT NOT NULL,
    City VARCHAR(100) NOT NULL,
    Zipcode CHAR(5) NOT NULL,
    Telephone_No BIGINT(10) UNSIGNED NOT NULL
);


CREATE TABLE ATMServiceProvider (
    Provider_Id INT UNSIGNED NOT NULL PRIMARY KEY,
    Provider_Agency_Name VARCHAR(250) NOT NULL,
    Service_Fee DOUBLE UNSIGNED NOT NULL,	/*yearly fee charged by provider agency*/
    Street_Address TEXT NOT NULL,
    City VARCHAR(100) NOT NULL,
    Zipcode CHAR(5) NOT NULL,
    Phone_No CHAR(10) NOT NULL UNIQUE,
    Provider_Email_Address text not null,
    Manufacturer_Id int unsigned,
    CONSTRAINT Manufacturer_fk1 FOREIGN KEY (Manufacturer_Id)
        REFERENCES ManufacturerDetails (Manufacturer_Id)
);



/*trigger to turn every new cutomer id to UUID to ensure uniqueness*/
CREATE TRIGGER BeforeInsertCardDetails
  BEFORE INSERT ON CardDetails
  FOR EACH ROW
	SET new.Card_No = uuid();	
    
    
create trigger BeforeStoringPin
	after insert on CardDetails
    For each row
		set new.pin = encode(new.pin, new.CardNo);
    
SHOW ENGINE INNODB STATUS;
describe atminfo;


explain select * from atminfo;


/*keeps track of customer login details
CREATE TABLE LoginDetails (
    Login_Position BIGINT ZEROFILL AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Email VARCHAR(250) NOT NULL,
    Backup_Email VARCHAR(250) NOT NULL,
    User_Name VARCHAR(20) NOT NULL,
    User_Password CHAR(8) NOT NULL,
    Recovery_Phrase VARCHAR(100) NOT NULL,
    Login_Attempts BIGINT DEFAULT 0,
    Customer_Id BIGINT UNSIGNED NOT NULL,
    ATM_Serial_No BIGINT UNSIGNED NOT NULL,
    CONSTRAINT Customer_fk4 FOREIGN KEY (Customer_Id)
        REFERENCES CustomerDetails (Customer_Id),
    CONSTRAINT ATM_fk4 FOREIGN KEY (ATM_Serial_No)
        REFERENCES atminfo (ATM_Serial_No)
);



In order to main a simple yet elegant database model, certain assumptions were applied to the model above

Only first 5 characters of zip codes are accounted for
Only bank ATM transactions (deposit/withdrawal) are modeled by this database. In bank transactions as well as third party ATM vendor transactions are not accounted for
All transactions will be conducted within United States.
Credit cards can’t be used to perform an ATM transaction, Therefore all cards are “debit cards”
Besides typical checkings and savings privileges, this model does not account for the different types of individual accounts and the benefits (“superpowers”) they may posses. 

*/
