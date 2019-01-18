*** Settings ***
Library           Selenium2Library
Library           collections
Resource          Resources/XH_Resources.robot
Resource          Resources/XH_Resources_Lottery.robot
Resource          Resources/XH_xpath.robot
Resource          Resources/XH_Xpath_Lottery.robot
Resource          Resources/Login.robot

*** Variables ***

*** Test Cases ***
Open browser and connect to url
    [Documentation]    開啟瀏覽器並連至測試網址
    [Tags]    Lottery
    Open browser and run

Verify valid login
    [Documentation]    使用測試帳號登入
    [Tags]    Lottery
    Input Account    ${Account}
    Input Password    ${Password}
    Input ValidCode    ${ValidCode}
    Sleep    8
    Submit Login
    Confirm IntroPage

Verity lottery lobby
    [Documentation]    進入投注大廳
    [Tags]    Lottery
    Ignore Effect Elements
    Wait and click    ${Xpath_Lottery_Entry}

Choose Lottery Kind
    [Documentation]    選擇彩種
    [Tags]    Lottery
    Ignore Effect Elements
    Choose Lottery Kind    67
    Ignore Effect Elements
    Choose Play Method    1

Choose Wager Number Then Wager
    [Documentation]    選擇彩球並投注
    [Tags]    Lottery
    Ignore Effect Elements
    Select Lottery Number
    Confirm Wager

Test end
    [Documentation]    關閉瀏覽器
    [Tags]    Lottery
    Close Browser

*** Keywords ***
