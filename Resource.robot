*** Settings ***
Library     SeleniumLibrary
Library     Screenshot
Library     String


*** Variables ***
${IMPLICIT_WAIT_TIME}     15 seconds
${BROWSER}                chrome
${URL}                    https://www.gamelab.com/games/daily-quick-crossword
${ACCEPT_PRIVACY}         //button[@mode='primary']
${AD_CARD}                id:ad_position_box
${CLOSE_AD}               id:dismiss-button
${SEARCH_GAMES}           //input[@aria-label='search input']
${DAILY_PUZZLE}           //li[@class='_2BOPctp29PxsHq2CqVoKII _2iAH5VnOWbhlqrKN5CXRpN gameStart_puzzle__UKU36']
${PUZZLE_INFO}            class:game_inlinePuzzleInfo__pkW5W
${REVEAL_BUTTON_MENU}     //button[@data-tip='(Ctrl+V)']
${REVEAL_PUZZLE_BUTTON}   //li[text()='Reveal puzzle']
${GAME_FRAME}             //iframe[@aria-label='canvas box for game']
${REWIEW_ANSWERS_BUTTON}  //button[text()='Review Answers']      
${SHOW_RESULTS}           //button[@class='_2z6oNdXs3eMaLXvIJEbQAi button_button__1KzRn gameEndPopup_showButton__wb73a']  
${SCORE_LOCATOR}          //em[text()='100']
${DAILY_PUZZLE_DAY}       //li[@class="_2BOPctp29PxsHq2CqVoKII _2iAH5VnOWbhlqrKN5CXRpN gameStart_puzzle__UKU36"]//span[@class='_1W5MUfKktWTiJGdxY_x0u2'] 
${GAME_FOOTER_INFO}       //span[@class='game_inlinePuzzleInfo__pkW5W']
${MONTH_YEAR_HOME}        //span[@class='_312DewKheTZsgO7BOdV11C']


*** Keywords ***
Given I Access the Daily Quick Crossword website
    Set Selenium Implicit Wait            ${IMPLICIT_WAIT_TIME}
    Open Browser                          ${URL}        ${BROWSER}
    Maximize Browser Window
    Sleep                                 5 seconds
    Click Button                          ${ACCEPT_PRIVACY}

And I navigate to the daily puzzle
    Select Frame                           ${GAME_FRAME}
    Take Screenshot                        
    ${DAY_VALUE}      Get Text            ${DAILY_PUZZLE_DAY}
    ${MONTH_YEAR_VALUE}    Get Text       ${MONTH_YEAR_HOME}
    Click Element                         ${DAILY_PUZZLE}
    ${FOOTER_VALUE}    Get Text           ${GAME_FOOTER_INFO}
    Should Contain                        ${FOOTER_VALUE}     ${DAY_VALUE}
    ${FOOTER_VALUE}    Remove String      ${FOOTER_VALUE}    ,    Daily Quick Crossword:    
    ${FOOTER_VALUE}    Remove String      ${FOOTER_VALUE}    ,    By Michael Curl
    ${FOOTER_VALUE}    Strip String       ${FOOTER_VALUE} 
    ${FOOTER_VALUE}    Convert To Uppercase      ${FOOTER_VALUE}
    ${COMPLETE_PUZZLE_DATE}    Catenate   ${DAY_VALUE}    ${MONTH_YEAR_VALUE}
    Should Be Equal      ${FOOTER_VALUE}  ${COMPLETE_PUZZLE_DATE}               

When I fill all the words correctly
    Click Button                          ${REVEAL_BUTTON_MENU}
    Click Element                         ${REVEAL_PUZZLE_BUTTON}
    Take Screenshot                                           

And I click the Review Answers button
    Click Button                          ${REWIEW_ANSWERS_BUTTON}
    Take Screenshot                       

Then I should be able to see the completed puzzle 
    ${SCORE_VALUE}    Get Text            ${SCORE_LOCATOR}
    Should Contain                        ${SCORE_VALUE}     100