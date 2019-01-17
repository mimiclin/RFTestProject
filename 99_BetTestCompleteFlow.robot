*** Settings ***
Library           Selenium2Library
Library           Collections
Library           RequestsLibrary
Library           OperatingSystem
Resource          Resources/XH_Resources.robot
Resource          Resources/XH_Resources_BetTest.robot
Resource          Resources/API_Handler.robot
Resource          Resources/Bet.robot
Library           Resources/Crawler.py
Library           Resources/Settle.py

*** Variables ***
${command_id}     521
${Lottery_ID}     29
${DrawNumber}     201901070733
#${WF_ID}          120205
#${BetNumber}    3,32
${WF_ID}          19
#${BetNumber}    12345
${CurrentMoney}    0
${MoneyBeforeTesting}    0
${WinningNumber}    0
${InitMultiple}    10
${Multiple}       1
${CurrentMultiple}    1

*** Test Cases ***
System Setup
    [Tags]  APIDemo
    [Documentation]    Create header and session for API testing.
    Create header after login
    Create Session    APIURL    ${APIURL}
    Set Suite Variable    ${CurrentMultiple}    ${InitMultiple}

Bet Multiple Times
    [Tags]  APIDemo
    Get Init Money
    : FOR    ${i}    IN RANGE    1    3
    \    Log    Run Times = ${i}    level=WARN
    \    Get Current Money Before Betting
    \    Get Current Draw Number
    \    Bet 三星不定位胆-前三一码    12345
    \    Bet 三星不定位胆-前三一码    67890
    \    Get Winning Number
    \    Verify Betting Result
    \    Check WinLose
    \    EXIT FOR LOOP IF    ${MoneyAfterTesting}<40000

Tear Down
    [Tags]  APIDemo
    [Documentation]    Delete session.
    #User Logout
    Delete All Sessions
