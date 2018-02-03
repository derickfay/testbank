# testbank
Numbers spreadsheet and AppleScripts for managing multiple choice tests

This spreadsheet is designed to allow for
* creation of a bank of multiple choice questions
* selection or exclusions of questions for a particular test
* generation of multiple versions of a test with questions and answers in different random order, and corresponding answer keys

It's adapted from a FileMaker database and scripts I created years ago.  Because it's a spreadsheet, you do need to be careful in editing not to overwrite formulas or ID fields

v1.0 2018-02-03

The usage instructions are below -- these are also contained within the **testbank.numbers** spreadsheet itself.

**Testbank**

This spreadsheet is designed to be used in conjunction with three AppleScripts, **orderQA.scpt**, **makeTest.scpt** and **makeAnswerKey.scpt** .

**Overview:**
1. Enter your questions and answers in the Questions and Answers tables (see details below)
2. Run **orderQA.scpt** to randomize the order of questions and answers
3. Run **makeTest.scpt** to generate a text file with the test
4. Run **makeAnswerKey.scpt** to generate a text file with the answer key for the test generated in step 3
5. Repeat steps 2-4 as necessary to create multiple versions of the test
6. To reset everything, first sort the Answer table by Answer Order, then sort both tables by Question ID.  This is recommended before adding any new questions to ensure you avoid creating duplicate Question IDs.

Columns with pink shading contain lookup formulas or are dynamically set by the scripts - do not change these.

**Details on Data Entry:**

**Questions** table columns:
- **Question** - the question text itself
- **Question ID** - a unique ID for the question, used to link to its answers - this has to be entered manually initially, but should **not** be subsequently changed
- **Question Order** - where the question will appear in output - this has to be entered manually initially (set to the highest existing value + 1) but should **not** be subsequently changed as it will be set dynamically by the scripts
- **Random** - whether the question’s answers should be randomized (usually **y**, unless you want an “a or b, b or c, all of the above” type question, as in sample question 5)
- **Include?** - whether to include the question in output
- **Keywords** - for filtering (by topic, course, last time the question was used, etc.)

For initial data entry (i.e. the first 5 questions), you can replace the content of the existing data fields (Question, Random, Include? and Keywords) with your own questions.  After that, you should extend the table down and copy the last line and edit it with a new unique Question ID and content.

**Answers** table columns:
- **Question ID** - the ID for the question to which this answer belongs - this has to be entered manually initially, but should **not** be subsequently changed
- **Question Order** - lookup formula from Question table - do not change
- **Random** - lookup formula from Question table - do not change
- **Include** - lookup formula from Question table - do not change
- **Answer Order** - where the answer will appear in output - for questions where **Random **is “y”, this is set dynamically, otherwise it should be set manually
- **Answer** - the answer itself
- **Right?** - contains x if correct, leave blank otherwise

For initial data entry, you can replace the content of the existing data fields (Answer, Right, and Answer Order for non-random questions) with your own answers.  After than, you should extend the table down five lines and copy the last set of answers and edit it with the corresponding Question ID and content.

**Selecting Questions:**

This spreadsheet is designed so it can be used to create a bank of questions.  For example, using the sample data, if you wanted to do a quiz on just kinship questions, you could paste n into every cell of the **Include?** column, so no questions would be included, then filter the **Keywords** column on text contains > kinship , and paste y into the include column.  When you run the scripts, you’d produce a two question test with just the questions on kinship.


