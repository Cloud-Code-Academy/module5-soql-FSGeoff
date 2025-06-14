 /**
 * The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
 * It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
 *
 * This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
 * a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
 * records, and manage data volume using the LIMIT keyword.
 *
 * Topics covered in this class include:
 * - Understanding the structure of a SOQL query.
 * - Crafting basic SELECT statements in SOQL.
 * - Applying filters using the WHERE clause in SOQL.
 * - Fetching related records using Relationship queries.
 * - Controlling the amount of data retrieved using the LIMIT keyword.
 *
 * Users of this class can expect to gain a solid understanding of SOQL in Apex and
 * be prepared to handle data retrieval tasks in Salesforce development.
 *
 * @author Your Name
 */

public with sharing class SOQL {
	/**
	 * Question 1
	 * Update/Uncomment the template code to create a method
	 * Returns all leads from Salesforce Org
	 * @return List of all leads with Id, LastName, Company, Phone, Email
	 * Update the corresponding test class and testGetAllLeads method to cover this method
	 */
	public static List<Lead> getAllLeads () {
		List<Lead> leadList = [
				SELECT Id, LastName, Company, Phone, Email
				FROM Lead
		];
		return leadList;
	}

	/**
	 * Question 2
	 * Update/Uncomment the template code to create a method
	 * Returns all contacts with first name of John.
	 * @return A list of Contact records.
	 * Update the corresponding test class and testGetContactsByFirstName method to cover this method
	 */
	public static  List<Contact> getContactsByFirstName  () {
		List<Contact> contactList = [
				SELECT Id, LastName, FirstName, Phone, Email
				FROM Contact
				WHERE FirstName = 'John'
		];
		return contactList;
	}

	/**
	 * Question 3
	 * Update/Uncomment the template code to create a method
	 * Returns the Contact Id for all contacts with last name of Smith or Jones
	 * @return A list of Contact Ids.
	 * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
	 */
	public static List<Id> GetContactIdsByLastName () {
		List<Id> idList = new List<Id>();
		List<Contact> contactIds = [
				SELECT Id
				FROM Contact
				WHERE LastName = 'Smith' OR LastName =  'Jones'
		];
		//Loop thru contacts and add their Ids to the list
		for (Contact con: contactIds) {
			idList.add(con.Id);
		}
		return idList;
	}


	/**
	 * Question 4
	 * Update/Uncomment the template code to create a method
	 * Returns List of closed won opportunities for a specific Account.
	 * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A list of Opportunities with important opportunities fields
	 * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
	 */
	public static List<Opportunity> GetClosedWonOpportunityCountByAccount (Id accountId) {
		List<Opportunity> oppList = [
				SELECT Name, CloseDate, StageName, Amount, AccountId
				FROM Opportunity
				WHERE StageName  = 'Closed Won'
				AND AccountId = :accountId
		];
		return  oppList;
	}

	/**
	 * Question 5
	 * Update/Uncomment the template code to create a method
	 * Returns the total count of Account records.
	 * @return The Integer count of Account records.
	 * Update the corresponding test class and testGetAccountCount method to cover this method
	 */
	public static Integer getAccountCount() {
		Integer accountCount =  (Integer) [
				SELECT COUNT()
				FROM Account
		];
		return accountCount;
	}

	/**
	 * Question 6
	 * Update/Uncomment the template code to create a method
	 * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
	 * @return A map of Task Ids to Task records.
	 * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
	 */
	public static Map<Id, Task> getTasksDueNextWeek() {
		Map<Id, Task> tasksDueNextWeek = new Map<Id, Task>();
		Date today =  Date.today();
		Date sevenDaysOut = today.addDays(7);

		List<Task> taskList = [
				SELECT Id, Status, ActivityDate, Subject, Priority
				FROM Task
				WHERE ActivityDate >= :sevenDaysOut
		];
		 for (Task task: taskList) {
			 tasksDueNextWeek.put(task.Id, task);
		 }
	return tasksDueNextWeek;
	}

	/**
	 * Question 7
	 * Update/Uncomment the template code to create a method
	 * Retrieves all Contacts that have a example.com domain in their Email.
	 * @return A list of Contact records.
	 * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
	 */
	public static List<Contact> getContactsByEmailDomain() {

		List<Contact> contactList = [
				SELECT Email, Name,AccountId
				FROM Contact
				WHERE Email
				LIKE '%example.com'
		];
		return contactList;
 	}

	/**
	 * Question 8
	 * Retrieves all Opportunities that have a specific keyword in their Name.
	 * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
	 * @param keyword The keyword to search for in the Opportunity Name.
	 * @return A list of Opportunity records.
	 */
	public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {

		List<Opportunity> oppsByKeyword = [
				SELECT Name, StageName, CloseDate, AccountId
				FROM Opportunity
				WHERE Name
				LIKE :('%'+ keyword + '%')
		];
		return oppsByKeyword; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 9
	 * Retrieves all Cases that Case Origin is not Web or Email or Blank
	 * @return A list of Case records.
	 */
	public static List<Case> getFilterCaseOrigins() {
		List<Case> filteredCases = [
				SELECT Status, AccountId, Origin
				FROM Case
				WHERE Origin
				NOT IN ('Web', 'Email', '')
		];
		return filteredCases; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 10
	 * Update/Uncomment the template code to create a method
	 * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
	 * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
	 * @param leadSource The Lead Source to search for.
	 * @param keyword The keyword to search for in the Lead Title.
	 * @return A list of Lead records.
	 * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
	 */
	public static List<Lead> getLeadsBySourceOrTitle(String source, String title) {
		List<Lead> sourcedLeads = [
				SELECT LastName, Company, Phone, Email, LeadSource, Title
				FROM Lead
				WHERE Title LIKE :('%'+ title + '%') OR LeadSource = :source
		];
		return sourcedLeads;
	}

	/**
	 * Question 11
	 * Returns the names of all Contacts associated with an Account.
	 * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A list of Contact LastName.
	 */
	public static List<String> getContactNamesByAccount(Id accountId) {
		// Create a list to hold the Contact LastNames
		List<String> contactLastNames = new List<String>();

		List<Contact> contacts = [
				SELECT FirstName, LastName,  AccountId
				FROM Contact
				WHERE AccountId = :accountId
		];

		for (Contact contact: contacts) {
			contactLastNames.add(contact.LastName);
		}

		// Return the list of Contact LastNames
		return contactLastNames; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 12
	 * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
	 * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for the found opportunities
	 * @param stage The Stage value to filter Opportunities.
	 * @return The total revenue.
	 */
	public static Decimal getTotalRevenueByStage(String stage) {
		// Use AggregateQuery to get the total revenue
		List<AggregateResult> totalRevenue = [
				SELECT SUM(Amount) totalRev
				FROM Opportunity
				WHERE StageName = :stage
		];
		// Debugging output
		System.debug('Stage: ' + stage);
		System.debug('Total Revenue Results: ' + totalRevenue);

	if (totalRevenue.size() > 0) {
		return (Decimal)totalRevenue[0].get('totalRev');
	} else {
		return 0;
		}
	}

	/**
	 * Question 13
	 * Retrieves the first 10 Accounts ordered by Name.
	 * @return A list of the first 10 Accounts ordered by Name.
	 */
	public static List<Account> getFirstTenAccounts() {
		List<Account> firstTen = [
				SELECT Name, Type, Phone
				FROM Account
				ORDER BY Name
				LIMIT 10
		];
		return firstTen; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 14
	 * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
	 * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
	 */
	public static List<Opportunity> getHighValueOpportunities() {
		List<Opportunity> highValueOpps = [
				SELECT Name, CloseDate, StageName, Amount
				FROM Opportunity
				WHERE Amount > 100000
				LIMIT 5
		];
		return highValueOpps; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 15
	 * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
	 * @return A list of Contacts
	 */
	public static List<Contact> getBirthdateContacts() {
		Date today = System.today();
		List<Contact> birthdayContacts = [
				SELECT LastName, AccountId, Birthdate
				FROM Contact
				WHERE Birthdate < :today
				ORDER BY Birthdate DESC
				LIMIT 3
		];
		return birthdayContacts; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 16
	 * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
	 * @return A list of Cases
	 */
	public static List<Case> getCasesWithStatus() {
		List<Case> caseList = [
				SELECT Id, Subject, Status, CreatedDate
				FROM Case
				WHERE Status = 'Open'
				ORDER BY CreatedDate
				LIMIT 10
				OFFSET 5
		];
		return caseList; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 17
	 * Returns Set of Case Ids for a specific Account.
	 * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A set of Case Ids.
	 */
	public static Set<Id> getCaseIdsByAccount(Id accountId) {
		// Create a set to hold the Case Ids
		Set<Id> caseIds = new Set<Id>();
		// Query the Cases
		List<Case> caseList = [
				SELECT Id, Subject, Status
				FROM Case
				WHERE AccountId = :accountId
		];
		// Loop through each Case and add the Id to the set
		for (Case eachCase: caseList) {
			caseIds.add(eachCase.Id);
		}

		return caseIds; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 18
	 * Return Map of Account Ids to Account Names Not in a specific Country.
	 * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
	 * @param country The country to filter Accounts.
	 * @return A map of Account Ids to Account Names.
	 */
	public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
		// Create a map to hold the Account Ids to Account Names
		Map<Id, String> accountIdsToNames = new Map<Id, String>();

		// Query the Accounts
		List<Account> accountList = [
				SELECT Id, Name, BillingCountry, ShippingCountry
				FROM Account
				WHERE BillingCountry != :country
		];
		// Loop through each Account and add the Id and Name to the map
		if(accountList.size() > 0) {
			for (Account acc: accountList) {
				accountIdsToNames.put(acc.Id, acc.Name);
			}
		} else {
			return null;
		}
		return accountIdsToNames; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 19
	 * Retrieves the Account Name for a given Contact.
	 * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
	 * @param contactId The Id of the Contact.
	 * @return The Account Name of the Contact.
	 */
	public static String getAccountNameForContact(String contactId) {
		List<Contact> accNameForContact = [
				SELECT Id, Account.Name, LastName
				FROM Contact
				WHERE Id = :contactId
		];

		String result = accNameForContact[0].Account.Name;
		return result; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 20
	 * Returns single Account that has related opportunities in the same query
	 * Example: getAccountAndOpportunitiesFromAccountId('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
	 * @param accountId The ID of the Account.
	 * @return An Account record with related Opportunities.
	 */
	public static Account getAccountAndOpportunitiesFromAccountId(Id accountId) {
		List<Account> AccountAndOpportunitiesFromAccountId = [
				SELECT Id, Name, (SELECT Id, Name, Amount, StageName, CloseDate FROM Opportunities)
				FROM Account
				WHERE Id = :accountId
		];
		return AccountAndOpportunitiesFromAccountId[0]; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 21
	 * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
	 * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
	 * @param Account Id
	 * @return List of contacts with the same Mailing State as the Account Billing State
	 */
	public static List<Contact> getAccountsWithContactsByState(Id accountId) {
		// Query the Account
		List<Account> accountList = [
				SELECT Id, Name, BillingState
				FROM Account
				WHERE Id = :accountId
		];

		// Store the Account's BillingState
		String accountBillingState = accountList[0].BillingState;
		// Query the Contacts
		List<Contact> contactList = [
				SELECT Id, FirstName, LastName, Email, Account.BillingState
				FROM Contact
				WHERE MailingState = :accountBillingState
		];

		return contactList; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 22
	 * Extracts email domains from the leads, then finds Accounts with matching website domains
	 * If Lead Email = test@test.com return account with website = www.test.com
	 * Example: findAccountsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
	 * @param A set of Lead Ids.
	 * @return A list of Accounts with matching email domains.
	 */
	public static List<Account> findAccountsByLeadEmailDomains(Set<Id> leadIds) {
		// Query the Leads
		List<Lead> leadList
		 = [
				SELECT Id, FirstName, Company, Email
				FROM Lead
				WHERE Id
				IN :leadIds
		];
		// Create a set of email domains from the Leads
		Set<String> emailDomains = new Set<String>();

		// Loop through each Lead
		if(leadList.size() > 0) {// Check if the email is not null
			for (Lead ld: leadList) {
				emailDomains.add(ld.Email);// Get the email from the Lead - Add the email domain to the set
			}
		} else {
			return null;
		}
		System.debug(emailDomains);
		// Query the Accounts
		List<Account> accounts = [
				SELECT Name, Website
				FROM Account
				WHERE Website
				IN :emailDomains
		];

		return accounts; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 23
	 * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
	 * Adds a randomized number between 1 to 3 to the quantity of each line item.
	 * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
	 * @param Original Opportunity Id
	 * @param List of cloned Opportunity Ids
	 */
	public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
		// Query the original Opportunity Line Items
		List<OpportunityLineItem> oppLineItems = [
				SELECT Id, OpportunityId, Quantity, UnitPrice
				FROM OpportunityLineItem
				WHERE OpportunityId = :origOppId
		];
		// Create a list to hold the new line items
		List<OpportunityLineItem> newOppLineItems = new List<OpportunityLineItem>();

		// Loop through each cloned Opportunity Id
		if(oppLineItems.size() > 0) {
			for (Id clonedOppId: cloneOppIds) {
				// Loop through each original line item
				for (OpportunityLineItem oppLineItem: oppLineItems) {
					// Generate a random number between 1 and 3
					Integer randomNumber = (Integer)(Math.random() * 3) + 1;
					// Clone the original line item and add the random number to the quantity
					OpportunityLineItem newOppLineItem = oppLineItem.clone();
					newOppLineItem.OpportunityId = clonedOppId;
					newOppLineItem.Quantity += randomNumber;

					// Insert the new line items
					newOppLineItems.add(newOppLineItem);
				}
			}
		}
	}

	/**
	 * Question 24
	 * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
	 * @return A list of filtered Opportunity
	 */
	public static List<Opportunity> getOpportunityDetailsForClosedWon() {
		List<Opportunity> oppsClosedWon = [
				SELECT Id, Name, AccountId, Owner.Name
				FROM Opportunity
				WHERE StageName = 'Closed Won'
		];
		return oppsClosedWon; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 25
	 * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to the Contact on the associated Account with the alphabetically first first name.
	 * Example: if there are two Contacts on the Account, "Billy" and "Abby," the 'Primary_Contact__c' will be set to "Abby."
	 */
	public static void setPrimaryContact() {
		//Use the getOpportunityDetailsForClosedWon() method to get the Opportunities
		List<Opportunity> closedWonOpps = getOpportunityDetailsForClosedWon();

		// Create a set of Account Ids from the Opportunities
		Set<Id> accountIds =new Set<Id>();
		if(closedWonOpps.size() > 0) {
			for(Opportunity opp: closedWonOpps) {
				accountIds.add(opp.Id);
			}
		}
		// Query the Contacts
		List<Contact> contactList = [
				SELECT Id, LastName, FirstName, AccountId
				FROM Contact
				WHERE AccountId IN :accountIds
		];

		// Loop through each Contact and add the Account Id and Contact to the map
		Map<Id, Contact> idMap = new Map<Id, Contact>();
		if (contactList.size() > 0) {
			for (Contact con: contactList) {
				idMap.put(con.Id, con);

				// Loop through each Opportunity
				if (closedWonOpps.size() > 0) {
					for(Opportunity opp: closedWonOpps) {
						// Update the Opportunity primary contact from accountToContactMap
						opp.Primary_Contact__c = con.FirstName;
					}
				}
			}

		}
		// Update the Opportunities
		update closedWonOpps;
	}
}
