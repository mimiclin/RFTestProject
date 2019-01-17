*** Variables ***
${URL}            http://117.27.159.77:11022
${Account}        mitest0001
${Password}       lf123456
${ValidCode}      1
${LoginTitle}     About New Fire bet
${ErrMsg_Login}    错误的用户名或密码!
${ErrMsg_Empty_Acc}    用户名不能为空
${ErrMsg_Empty_Pwd}    密码不能为空
${ErrMsg_Empty_Valid_Code}    验证码不能为空
${ErrMsg_Wrong_Valid_Code}    验证码错误

*** Keywords ***
Element should have class
    [Arguments]    ${element}    ${className}
    [Documentation]    檢查Elements中的class
    Wait until page contains element    ${element}[contains(@class, '${className}')]

Wait And Clear
    [Arguments]    ${locator}
    [Documentation]    清空Input Field
    Wait Until Element Is Visible    ${locator}
    Clear Element Text    ${locator}
    Press Key    ${Xpath_LoginPwd}    1
    Press Key    ${Xpath_LoginPwd}    \\8

Wait And Input
    [Arguments]    ${locator}    ${text}
    [Documentation]    於Input Field輸入資料(不清空輸入欄)
    Wait Until Element Is Visible    ${locator}
    Input Text    ${locator}    t ${text}

Wait And Clear Then Input
    [Arguments]    ${locator}    ${text}
    [Documentation]    於Input Field輸入資料(清空輸入欄)
    Wait Until Element Is Visible    ${locator}
    Clear Element Text    ${locator}
    Input Text    ${locator}    ${text}

Wait And Click
    [Arguments]    ${locator}
    [Documentation]    點擊指定容器
    Wait Until Element Is Visible    ${locator}
    Click Element    ${locator}

Open browser and run
    Open Browser    ${URL}    chrome
    wait until page contains    ${LoginTitle}
    Maximize Browser Window
    #Set Selenium Implicit Wait    6 seconds

ScreenShot
    Set Screenshot Directory    C://PythonProject/RobotFramework/Test/Screenshot
    Capture Page Screenshot
