*** Variables ***
${InitMoney}      0

*** Keywords ***
Get Init Money
    [Documentation]    Get money before testing.
    [Tags]    API    Wallet
    ${CurrentMoney}=    Get Current Money
    Set Suite variable    ${InitMoney}    ${CurrentMoney}
    Log    Init Wallet = ${CurrentMoney}    level=WARN
    Log    --------------------    level=WARN

Get Current Money Before Betting
    [Documentation]    Get money before betting.
    [Tags]    API    Wallet
    ${CurrentMoney}=    Get Current Money
    Set Temp Variable
    Set Suite variable    ${MoneyBeforeTesting}    ${CurrentMoney}
    Log    Current Wallet Before Betting = ${CurrentMoney}    level=WARN
    Log    Current Multiple = ${CurrentMultiple}    level=WARN

Set Temp Variable
    ${BetOrderList}=    Create Dictionary
    Set Suite variable    ${BetOrderList}    ${BetOrderList}
    ${MoneyAfterBetting}=    Get Current Money
    Set Suite variable    ${MoneyAfterBetting}    ${MoneyAfterBetting}

Get Current Draw Number
    [Documentation]    Get Current "Draw Number" to identity which draw number to bet.
    ${DrawNumber}=    Get Current Draw Number by LotteryID    ${Lottery_ID}
    ${DrawNumber}=    evaluate    ${DrawNumber}+1
    set suite variable    ${DrawNumber}    ${DrawNumber}
    Log    Current draw number is ${DrawNumber}    level=WARN

Bet 大小單雙
    [Documentation]    Bet 大小單雙
    ${ResData}=    Create Bet Order    ${command_id}    ${Lottery_ID}    ${DrawNumber}    1    ${WF_ID}
    ...    ${BetNumber}    ${CurrentMultiple}
    ${CurrentMoney}=    Get Current Money
    Log    Bet Number is "${BetNumber}"    level=WARN
    Log    Current Wallet After Bet = ${CurrentMoney}    level=WARN

Bet 三星不定位胆-前三一码
    [Documentation]    Bet 三星不定位胆-前三一码
    [Arguments]    ${BetNumber}
    ${ResData}=    Create Bet Order    ${command_id}    ${Lottery_ID}    ${DrawNumber}    1    ${WF_ID}
    ...    ${BetNumber}    ${CurrentMultiple}
    Set Suite Variable    ${BetNumber}    ${BetNumber}
    Set Suite Variable    ${WF_ID}    ${WF_ID}
    Verify Bet Order    ${ResData}


Verify Bet Order
    [Documentation]    計算注單金額
    [Arguments]    ${ResData}
    ${OrderID}=    Set Variable    ${ResData['data']['detail'][0]['uniq_order_id']}
    ${OrderMessage}=    Set Variable    ${ResData['data']['detail'][0]['remark']}
    Log    Order message "${OrderMessage}"    level=WARN
    ${CntBetItems}=    getOrderDetailByOrderID    ${OrderID}
    ${RunFlag}=    Set Variable If    ${CntBetItems}>0    1    0
    set suite variable    ${RunFlag}    ${RunFlag}
    ${CurrentMoney}=    Get Current Money
    ${MoneyAfterBetting}=    evaluate    ${MoneyAfterBetting}-(${CntBetItems}*2*${CurrentMultiple})
    ${MoneyAfterBetting}=    Convert To Number    ${MoneyAfterBetting}    3
    Should Be Equal    ${MoneyAfterBetting}    ${CurrentMoney}
    Set Suite variable    ${MoneyAfterBetting}    ${MoneyAfterBetting}
    Run Keyword If    ${RunFlag}==1    Run Keywords    appendToDict    ${BetOrderList}    OrderID=${OrderID}    BetNumber=${BetNumber}    PlayMethodID=${WF_ID}
    ...    AND    Set Suite variable    ${BetOrderList}    ${BetOrderList}
    ...    AND    Log    Bet Number is "${BetNumber}"    level=WARN
    ...    AND    Log    Order ID is "${OrderID}"    level=WARN
    ...    AND    Log    Current Wallet After Bet = ${CurrentMoney}    level=WARN
    ...    ELSE    Log    Bet failed, because "${OrderMessage}".    level=WARN

Get Winning Number
    [Documentation]    Get winning number after winning number generated.
    ${WinningNumber}=    Get Winning Number by Draw Number Until Generated    ${Lottery_ID}    ${DrawNumber}
    set Suite variable  ${WinningNumber}    ${WinningNumber}
    Sleep    10s

Verify Betting Result
    [Documentation]    Verify betting result if bet order created success
    ${CurrentMoney}=    Get Current Money
    Run Keyword If    ${RunFlag}==1    Verify Betting Result If Bet Order Created Success
    ...    ELSE    Set Suite variable    ${MoneyAfterTesting}    ${CurrentMoney}

Verify Betting Result If Bet Order Created Success
    [Documentation]    Check current wallet is correct after winning number generated.
    ${dictLength}=    dictLength    ${BetOrderList}
    : FOR    ${x}    IN RANGE    0    ${dictLength}
    \    ${WinningCount}=    Settle Bet Result    ${BetOrderList[${x}]['PlayMethodID']}    ${BetOrderList[${x}]['BetNumber']}    ${WinningNumber}
    \    Log    Hit Count = ${WinningCount}    level=WARN
    \    ${CurrentMoney}=    Get Current Money
#    \    ${MoneyAfterSettling}=    evaluate    ${MoneyAfterBetting}+(${WinningCount}*6.6*${CurrentMultiple})+9.1
    \    ${MoneyAfterSettling}=    evaluate    ${MoneyAfterBetting}+(${WinningCount}*7.267*${CurrentMultiple})
    \    ${MoneyAfterSettling}=    Convert To Number    ${MoneyAfterSettling}    3
#    \    Should Be Equal    ${MoneyAfterSettling}    ${CurrentMoney}
    \    Set Suite variable    ${MoneyAfterTesting}    ${CurrentMoney}
    Log    Current Wallet After Reward = ${CurrentMoney}    level=WARN

Check WinLose
    ${tmpMultiple}=    evaluate    ${CurrentMultiple}*${Multiple}
    ${WinLose}=    evaluate    ${MoneyAfterTesting}-${InitMoney}
    Run Keyword If    ${MoneyAfterTesting}<${MoneyBeforeTesting}    set global variable    ${CurrentMultiple}    ${tmpMultiple}
    ...    ELSE    set global variable    ${CurrentMultiple}    ${InitMultiple}
    Log    Current WinLose = ${WinLose}    level=WARN
    Log    --------------------    level=WARN
