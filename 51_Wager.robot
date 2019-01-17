*** Settings ***
Library           Selenium2Library
Library           Collections
Library           RequestsLibrary
Library           OperatingSystem
Resource          Resources/XH_Resources.robot
Resource          Resources/API_Handler.robot
Resource          Bet.robot
Library           Resources/decode.py
Library           Resources/Crawler.py
Library           Resources/Settle.py

*** Variables ***
${command_id}     521
${Lottery_ID}     96
${DrawNumber}     201810231493
${WF_ID}          19
${WagerNumber}    09876
${path}           controller/user/get/get_user_balance/99665
${CurrentMoney}    0
${MoneyBeforeTesting}    0
${WinningNumber}    0

*** Test Cases ***
System Setup
    [Documentation]    Create header and session for API testing.
    Create header after login
    Create Session    APIURL    ${APIURL}

Get Current Money Before Betting
    [Documentation]    Get money before testing.
    [Tags]    API    Wallet
    ${CurrentMoney}=    Get Current Money
    Set suite variable    ${MoneyBeforeTesting}    ${CurrentMoney}
    Log    Init Wallet = ${CurrentMoney}    level=WARN

Get Current Draw Number
    [Documentation]    Get current "Draw Number" to identity which draw number to bet.
    ${DrawNumber}=    Get Current Draw Number by LotteryID    ${Lottery_ID}
    ${DrawNumber}=    evaluate    ${DrawNumber}+1
    set suite variable    ${DrawNumber}    ${DrawNumber}
    Log    Current draw number is ${DrawNumber}    level=WARN

Wager Command 521
    [Documentation]    Bet 不定位 前三一碼
    ${ResData}=    Create Bet Order    ${command_id}    ${Lottery_ID}    ${DrawNumber}    1    ${WF_ID}
    ...    ${WagerNumber}    1
    ${ResMessage}    Get From Dictionary    ${ResData}    message
    ${CurrentMoney}=    Get Current Money
    Log    Wager Number is "${WagerNumber}"    level=WARN
    Log    Current Wallet After Wager = ${CurrentMoney}    level=WARN

Get Winning Number
    [Documentation]    Get winning number after winning number generated.
    ${WinningNumber}=    Get Winning Number by Draw Number Until Generated    ${Lottery_ID}    ${DrawNumber}

Verify Betting Result
    [Documentation]    Check current wallet is correct after winning number generated.
    ${WinningCount}=    Settle Wager Result    ${WF_ID}    ${WagerNumber}    ${WinningNumber}
    Log    Hit Count = ${WinningCount}    level=WARN
    ${CurrentMoney}=    Get Current Money
    Log    Current Wallet After Reward = ${CurrentMoney}    level=WARN

Tear Down
    [Documentation]    Delete session.
    #User Logout
    Delete All Sessions
