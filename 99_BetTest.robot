*** Settings ***
Library           Selenium2Library
Library           Collections
Library           RequestsLibrary
Library           OperatingSystem
Resource          Resources/XH_Resources.robot
Resource          Resources/XH_Resources_BetTest.robot
Resource          Resources/API_Handler.robot
Resource          Bet.robot
Library           Resources/Crawler.py
Library           Resources/Settle.py

*** Variables ***
${command_id}     521
${Lottery_ID}     30001
${DrawNumber}     201901070733
${WF_ID}          120205
${WagerNumber}    3,32
${path}           controller/user/get/get_user_balance/99533
${CurrentMoney}    0
${MoneyBeforeTesting}    0
${WinningNumber}    0
${InitMultiple}    64
${Multiple}       4
${CurrentMultiple}    1

*** Test Cases ***
System Setup
    [Documentation]    Create header and session for API testing.
    Create header after login
    Create Session    APIURL    ${APIURL}
    Set Global Variable    ${CurrentMultiple}    ${InitMultiple}

Bet 100 times
    Get Init Money
    : FOR    ${i}    IN RANGE    1    3
    \    Log    Run Times = ${i}    level=WARN
    \    Get Current Money Before Betting
    \    Get Current Draw Number
    \    Bet 大小單雙
    \    Get Winning Number
    \    Verify Betting Result
    \    Check WinLose
    \    EXIT FOR LOOP IF    ${MoneyAfterTesting}<40000

Tear Down
    [Documentation]    Delete session.
    #User Logout
    Delete All Sessions
