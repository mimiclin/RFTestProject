*** Keywords ***
Get Current Money
    ${RES}    Post Request    APIURL    /controller/user/get/get_user_balance/${UserID}    headers=${HeaderAfterLogin}    timeout=5
    Should Be Equal As Integers    ${RES.status_code}    200
    ${responsedata}    To Json    ${RES.content}
    ${CurrentMoney}=    Get From Dictionary    ${responsedata['data']}    money
    ${CurrentMoney}=    Convert To Number    ${CurrentMoney}    3
    [Return]    ${CurrentMoney}

Get Winning Number by Draw Number
    [Arguments]    ${LotteryID}    ${DrawNumber}
    ${CrawlerNumber}=    getWinningNumberByLotteryAndDrawNumber    ${LotteryID}    ${DrawNumber}
    [Return]    ${CrawlerNumber}

Get Current Draw Number by LotteryID
    [Arguments]    ${LotteryID}
    ${DrawNumber}=    getDrawNumberByLottery    ${LotteryID}
    [Return]    ${DrawNumber}

Create Bet Order
    [Arguments]    ${command_id}    ${Lottery_ID}    ${DrawNumber}    ${Count}    ${WF_ID}    ${WagerNumber}
    ...    ${Multiple}
    [Documentation]    Create a bet order, has to input command_id, Lottery_ID, DrawNumber, Count, WF_ID, WagerNumber, bet_money, Multiple.
    ${Data}=    Create Dictionary    command=lottery_logon_request_transmit_v2    param={"command_id":${command_id},"lottery_id":"${Lottery_ID}","issue":"${DrawNumber}","count":${Count},"bet_info":[{"method_id":"${WF_ID}","number":"${WagerNumber}","rebate_count":91,"multiple":"${Multiple}","mode":0,"bet_money":"10","calc_type":"0"}]}
    ${RES}=    Post Request    APIURL    /controller/lottery/${UserID}    headers=${HeaderAfterLogin}    data=${Data}    timeout=5
    Should Be Equal As Integers    ${RES.status_code}    200
    ${ResData}=    To Json    ${RES.content}
    [Return]    ${ResData}

Get Winning Number by Draw Number Until Generated
    [Arguments]    ${Lottery_ID}    ${DrawNumber}
    : FOR    ${i}    IN RANGE    13
    \    ${WinningNumber}    Get Winning Number by Draw Number    ${Lottery_ID}    ${DrawNumber}
    \    EXIT FOR LOOP IF    ${WinningNumber}!=0
    \    SLEEP    5
    Log    Winning Number is "${WinningNumber}"    level=WARN
    [Return]    ${WinningNumber}

Settle Bet Result
    [Arguments]    ${WF_ID}    ${BetNumber}    ${WinningNumber}
    ${RES}=    SettleBetResultByMethod    ${WF_ID}    ${BetNumber}    ${WinningNumber}
    [Return]    ${RES}
