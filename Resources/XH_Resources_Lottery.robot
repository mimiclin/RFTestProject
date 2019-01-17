*** Variables ***
${Lottery_ID}     1
${Xpath_Lottery}    //div

*** Keywords ***
Choose Lottery Kind
    [Arguments]    ${Lottery_ID}
    ${Xpath_Lottery}=    Set Variable    xpath=//div[@class='item br-r']/ul/li[@cp_id='${Lottery_ID}']
    #Wait and click    ${Xpath_Lottery_Type}
    #Execute JavaScript    document.evaluate("//div[@class='item br-r']/ul/li[@cp_id='${Lottery_ID}']",document.body,null,9,null).singleNodeValue.onclick()
    sleep    6s
    Ignore Effect Elements And Guide
    Mouse down    ${Xpath_Lottery_Type}
    sleep    3s
    Mouse Up    ${Xpath_Lottery_Type}
    Ignore Effect Elements And Guide
    Wait and Click    ${Xpath_Lottery}

Get Lottery Xpath
    [Arguments]    ${Lottery_ID}
    ${Xpath_Lottery}=    Set Variable If
    /    ${Lottery_ID} == 1    ${Xpath_Lottery_1}
    /    ${Lottery_ID} == 96    ${Xpath_Lottery_96}

Select Lottery Number
    Wait and click    ${Xpath_Num_0}
    Wait and click    ${Xpath_Num_2}
    Wait and click    ${Xpath_Num_4}
    Wait and click    ${Xpath_Num_6}
    Wait and click    ${Xpath_Num_8}

Confirm Wager
    Wait and Click    ${Xpath_Add_Wager}
    Wait and Click    ${Xpath_Confirm_Wager}
    Wait and Click    ${Btn_Confirm_Wager}
    #Ignore Effect Elements
    #Wait and Click    ${Btn_Confirm_Wager}
    Wait Until Element Is Visible    ${Btn_Confirm_Wager}
    Mouse Down    ${Btn_Confirm_Wager}
    Mouse Up    ${Btn_Confirm_Wager}
    sleep    1s
    Wait Until Element Is Visible    ${Btn_Confirm_Wager}
    Mouse Down    ${Btn_Confirm_Wager}
    Mouse Up    ${Btn_Confirm_Wager}

Ignore Effect Elements And Guide
    [Documentation]    Ignore some invisible elements and pop-up guide page.
    Wait Until Page Does Not Contain Element    xpath=//div[@class='LoadingShade']
    Wait until element is not visible    xpath=//div[@style='height: 100%; background: rgb(0, 0, 0); opacity: 0.5;']
    ${checkStatus}=    Run keyword and return status    element should be visible    xpath=//div[@class='guide guide_new'][@style='display: block;']
    Run Keyword If    ${checkStatus}    Wait and click    xpath=//div[@class='guide-close']

Ignore Effect Elements
    [Documentation]    Ignore some invisible elements.
    Wait Until Page Does Not Contain Element    xpath=//div[@class='LoadingShade']
    Wait until element is not visible    xpath=//div[@style='height: 100%; background: rgb(0, 0, 0); opacity: 0.5;']
