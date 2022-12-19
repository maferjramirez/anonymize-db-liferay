/* ORACLE DB*/


/* 1.Create a SQL script; set the username column for all tables to a dummy value (e.g. "Test") */
DECLARE CURSOR
all_my_tables IS SELECT table_name FROM SYS.USER_TAB_COLUMNS utc WHERE COLUMN_NAME LIKE 'USERNAME'
order by TABLE_NAME;
varchar_count integer;
l_max number;
BEGIN
	FOR my_list IN all_my_tables LOOP
		 execute IMMEDIATE 'UPDATE ' || my_list.table_name || ' SET username = :1' USING 'Test';
	END LOOP;
END;

/* 2. Create a SQL script that will anonymize user data: */

/* 2.1 Contact_ table
 *		firstName, lastName, middleName, userName, emailAddress.
 *		Add other columns as desired, except: contactId, userId, classNameId, classPK
 */
UPDATE Contact_ SET 
	firstName = 'Test', 
	lastName = 'Test', 
	middleName = 'Test', 
	userName = 'Test', 
	emailAddress = 'Test'
WHERE emailAddress NOT LIKE 'default%';

/* 2.2 User_ table
 *		firstName, middleName, lastName,
 *		Add other columns as desired, except: screenName, emailAddress
 */
UPDATE User_ SET 
	firstName = 'Test', 
	middleName = 'Test', 
	lastName = 'Test',
	reminderqueryquestion = NULL,
	reminderqueryanswer = NULL,
	greeting = 'Welcome Test Test!'
WHERE emailAddress NOT LIKE 'default%';

/* 2.3 Address table
 *		Street1, street2, street3, city, zip
 */
UPDATE Address SET 
	street1 = 'Test', 
	street2 = 'Test', 
	street3 = 'Test',
	zip = 'Test';

/* 2.4 Emailaddress table
 * 		Address
 */
UPDATE Emailaddress SET 
	Address = 'Test';

/* 3 Create a SQL script that will reset User passwords
 *		Update User_.password_ to a dummy value (e.g. "test")
 *		Update User_.passwordEncrypted to 0 (setting to "0" ensures a users' password is not encrypted)
 */
UPDATE User_ SET 
	password_ = 'test', 
	passwordEncrypted = 0
WHERE emailAddress NOT LIKE 'default%';

/* 4. Reset User_.screenName (value must be unique)
	Iterate through users and set screenname to unique dummy data (e.g. screenName = screenName + userId).
*/
UPDATE User_ SET 
	screenName = 'screenName' || userid
WHERE userid = userid AND emailAddress NOT LIKE 'default%';


/* 5. Reset User_.emailAddress (value must be unique)
 *		Iterate through users and set email address to unique dummy data (e.g. emailAddress = "test" + userId + "@test.com").
 */
UPDATE User_ SET 
	emailAddress = 'test' || userid || '@test.com'
WHERE userid = userid AND emailAddress NOT LIKE 'default%';
