# Debugging in Ruby & ActiveRecord

Debugging is essential in your ability to progress from a problem/task to a solution/implementation. It's all about splitting your problem into smaller pieces and verifying the behavior of each piece.

Often, debugging is thought of us a process that starts when you have a problem, but I like to take a broader approach to thinking about debugging. This is taken from Wikipedia, but I wanted to read it here.

> As software and electronic systems have become generally more complex, the various common debugging techniques have expanded with more methods to detect anomalies, assess impact, and schedule software patches or full updates to a system. The words "anomaly" and "discrepancy" can be used, as being more neutral terms, to avoid the words "error" and "defect" or "bug" where there might be an implication that all so-called errors, defects or bugs must be fixed (at all costs). Instead, an impact assessment can be made to determine if changes to remove an anomaly (or discrepancy) would be cost-effective for the system, or perhaps a scheduled new release might render the change(s) unnecessary. Not all issues are safety-critical or mission-critical in a system. Also, it is important to avoid the situation where a change might be more upsetting to users, long-term, than living with the known problem(s) (where the "cure would be worse than the disease"). Basing decisions of the acceptability of some anomalies can avoid a culture of a "zero-defects" mandate, where people might be tempted to deny the existence of problems so that the result would appear as zero defects. Considering the collateral issues, such as the cost-versus-benefit impact assessment, then broader debugging techniques will expand to determine the frequency of anomalies (how often the same "bugs" occur) to help assess their impact to the overall system.

That's a lot, my simple definition of a bug is: 

>code that's behaving differently from the way you want it to.

We can start off the process of debugging by asking ourselves the following questions:

## Process

- What is our code supposed to do?
- How do we know when it's done?
- How do we split it into smaller pieces?
- How does each piece connect to the next? 
- What should be true at each stage of the process?
- How do we get feedback as we go?

## Techniques/Tools
- adding `binding.pry`
- using `rake console`
- adding `puts` statements

## Important Action Items

- **Study problem/task/deliverable**
  - We'll need to be able to break our tasks into pieces and test each piece individually to make consistent progress. 
- **Set up a scenario**
  - We need to understand the context of our task and any required code we'll need to test it out
  - If we're working on an instance method, we need an instance we can call it on.
  - When we call it, what should happen? What should it return?
- **Set up a debugging/testing environment**
  - The difference between testing our code using automated testing (with rspec) and testing it manually, in the console for example, is not very profound.
  - With automated (`rspec`) tests, we describe a part of our code, set up a scenario and then establish expectations about how it should behave in that scenario. If our expectations are met, we pass the test and see some green, if not we get some errors in red.
  - With manual testing in the console, we jump right into setting up a scenario. Then we write some code that we expect to behave in a certain way, hit enter and see if we get what we expected.
  - The main difference between the two is that `rspec` requires more time/thought/care to set up. Also, tests are files and therefore part of your codebase–so the scenarios that you've used to test your code are actually stored with your code.
  - At this stage, being methodical about how you develop your manual testing/debugging skills in the console will pay off mightily because not only will those skills translate to writing your own tests later on, but there are lots of scenarios where you need quick feedback under time pressure and the console will give you feedback more quickly and directly.

[Discussion HackMD Doc](https://hackmd.io/_aBC2VvuT0mtdbA6Ah4FEQ)

## Example

## What You Already Have

The starter code has migrations and models for the initial `User` and `Bank`
models, and seed data for some `Users` and `Banks`. The schema currently looks
like this:

### Users Table

| Column | Type   |
| ------ | ------ |
| name | string |
| country_of_residence | string |



### Banks Table

| Column              | Type    |
| ------------------- | ------- |
| name | string |
| market_capitalization | integer | 
| country | string |

You will need to create the migration for the `accounts` table using the attributes
specified in the deliverables below.

### Migrations

Before working on the rest of the deliverables, you will need to create a
migration for the `accounts` table.

- An `Account` belongs to a `User`, and an `Account` also belongs to a `Bank`. In
  your migration, create any columns your `accounts` table will need to establish
  these relationships.
- The `accounts` table should also have:
  - A `balance` column that stores a float.
  - A `label` column that stores a string.
  - An `account_type` column that stores a string (one of these: "Checking", "Savings", "Money Market", "IRA")

After creating the `accounts` table using a migration, use the `seeds.rb` file to
create instances of your `Account` class so you can test your code.

**Once you've set up your `accounts` table**, work on building out the following
deliverables.

### Object Relationship Methods

Use Active Record association macros and Active Record query methods where
appropriate (i.e. `has_many`, `has_many through`, and `belongs_to`).

#### Account

- `Account#user`
  - should return the `User` instance for this account
- `Account#bank`
  - should return the `Bank` instance for this account

#### Bank

- `Bank#accounts`
  - returns a collection of all the accounts at that bank
- `Bank#users`
  - returns a collection of all the users who have accounts at that bank

#### User

- `User#accounts`
  - should return a collection of all the accounts this user has created
- `User#banks`
  - should return a collection of all the banks that the user has accounts at

Use `rake console` and check that these methods work before proceeding. For
example, you should be able to call `User.first.banks` and see a list of the
banks for the first user in the database based on the seed data; and
`Account.first.user` should return the User for the first Account in the database.

### Aggregate and Association Methods

#### Account

- `Account#summary`
  - should return a string formatted as follows:
    `"{insert account_label} {insert account_type} account balance: {insert account balance}"`

#### Bank

- `Bank#open_account(user, label, opening_deposit)`
  - takes a `user` (an instance of the `User` class), a `label` (string) for the account, and an `opening_deposit` (integer or float)
    as arguments, and creates a new `account` in
    the database associated with this bank and the `user` passed as an argument.
- `Bank#accounts_summary(user)`
  - takes a `user` (an instance of the `User` class) as an argument and should return an array of strings containing the account summaries for all the given user's accounts with that `bank`
    formatted as follows:
    ["{insert account_label} {insert account_type} account balance: {insert account balance}", "{insert account_label} {insert account_type} account balance: {insert account balance}", ...]
- `Bank#blacklist(user)`
  - takes an `user` (an instance of the `User` class) and terminates their relationship with the bank
  - you will have to delete a row (or rows) from the `accounts` table to get this to work!

#### User

- `User#total_balance`
  - returns the total balance for a user based on the sum total of all of their account balances.
- `User#balance_by_account_type(account_type)`
  - accepts an `account_type` as an argument (one of these: "Checking", "Savings", "Money Market", "IRA") and returns the total balance that user has invested in that type of account.
- `User.number_one`
  - returns _one_ user instance for the user who has the highest total account balances
**Advanced**
- `User#main_banks`
  - returns a collection of all the `Bank` instances the user has invested more than $30,000
- `User#international_funds`
  - returns the total balance the user has in accounts with a bank in another country than their country of residence
