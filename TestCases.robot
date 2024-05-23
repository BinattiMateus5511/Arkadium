*** Settings ***
Resource     Resource.robot
Suite Teardown     Close Browser



*** Test Cases ***
Scenario 1: Complete a puzzle
  Given I Access the Daily Quick Crossword website
  And I navigate to the daily puzzle
  When I fill all the words correctly
  And I click the Review Answers button
  Then I should be able to see the completed puzzle 

