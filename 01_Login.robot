*** Settings ***
Library           Selenium2Library
Library           collections
Resource          Resources/XH_Resources.robot
Resource          Resources/XH_xpath.robot

*** Variables ***

*** Test Cases ***
Open browser and connect to url
    [Documentation]    開啟瀏覽器並連至測試網址
    [Tags]    Login
    Open browser and run

Verify public logo image and title
    [Documentation]    驗證登入頁Logo和Title是否存在
    [Tags]    Login
    Login Page Should Contain Some Elements

Verify invalid login with empty account and password
    [Documentation]    驗證無效登入，使用空帳號和空密碼
    [Tags]    Login
    Invalid login with empty account and password

Verify invalid login with empty account
    [Documentation]    驗證無效登入，使用空帳號
    [Tags]    Login
    Invalid login with empty account

Verify invalid login with empty password
    [Documentation]    驗證無效登入，使用空密碼
    [Tags]    Login
    Invalid login with empty password

Verify invalid login with wrong account
    [Documentation]    驗證無效登入，使用不存在的帳號
    [Tags]    Login
    Invalid login with wrong account

Verify invalid login with wrong password
    [Documentation]    驗證無效登入，使用存在的帳號和錯誤的密碼
    [Tags]    Login
    Invalid login with wrong password

Verify invalid login with empty captcha code
    [Documentation]    驗證無效登入，使用存在的帳號、密碼和空驗證碼
    [Tags]    Login
    Invalid login with empty captcha code

Verify invalid login with wrong captcha code
    [Documentation]    驗證無效登入，使用存在的帳號、密碼和錯誤的驗證碼
    [Tags]    Login
    Invalid login with wrong captcha code

Verify valid login
    [Documentation]    使用測試帳號登入
    [Tags]    Login
    valid login

Test end
    [Documentation]    關閉瀏覽器
    Close Browser

*** Keywords ***
Login Page Should Contain Some Elements
    Wait until page contains element    ${Xpath_LoginLogo}
    Element Should be visible    ${Xpath_LoginLogo}
    Element Should be visible    ${Xpath_LoginTitle}    message=${LoginTitle}

Invalid login with empty account and password
    [Documentation]    未輸入帳號密碼登入
    Wait And Clear    ${Xpath_LoginAcc}
    Wait And Clear    ${Xpath_LoginPwd}
    Wait And Clear    ${Xpath_LoginValidCode}
    Wait And Click    ${Btn_Login}
    Element Should be visible    ${Xpath_LoginErrMsg}
    Element Should Contain    ${Xpath_LoginErrMsg}    ${ErrMsg_Empty_Acc}
    Wait And Click    ${Btn_LoginErrMsg}

Invalid login with empty account
    [Documentation]    未輸入帳號登入
    Wait And Clear    ${Xpath_LoginAcc}
    Wait And Clear Then Input    ${Xpath_LoginPwd}    0912345678
    Wait And Click    ${Btn_Login}
    Element Should be visible    ${Xpath_LoginErrMsg}
    Element Should Contain    ${Xpath_LoginErrMsg}    ${ErrMsg_Empty_Acc}
    Wait And Click    ${Btn_LoginErrMsg}

Invalid login with empty password
    [Documentation]    未輸入密碼登入
    Wait And Clear    ${Xpath_LoginPwd}
    Wait And Clear Then Input    ${Xpath_LoginAcc}    ${Account}
    Wait And Click    ${Btn_Login}
    Element Should be visible    ${Xpath_LoginErrMsg}
    Element Should Contain    ${Xpath_LoginErrMsg}    ${ErrMsg_Empty_Pwd}
    Wait And Click    ${Btn_LoginErrMsg}

Invalid login with wrong account
    [Documentation]    輸入錯誤的帳號、任意存在的密碼，登入
    Wait And Clear Then Input    ${Xpath_LoginAcc}    mitest9999
    Wait And Clear Then Input    ${Xpath_LoginPwd}    ${Password}
    Wait And Click    ${Btn_Login}
    Element Should be visible    ${Xpath_LoginErrMsg}
    Element Should Contain    ${Xpath_LoginErrMsg}    ${ErrMsg_Empty_Valid_Code}
    Wait And Click    ${Btn_LoginErrMsg}

Invalid login with wrong password
    [Documentation]    輸入任意存在的帳號、錯誤的密碼，登入
    Wait And Clear Then Input    ${Xpath_LoginAcc}    ${Account}
    Wait And Clear Then Input    ${Xpath_LoginPwd}    0912345678
    Wait And Click    ${Btn_Login}
    Element Should be visible    ${Xpath_LoginErrMsg}
    Element Should Contain    ${Xpath_LoginErrMsg}    ${ErrMsg_Empty_Valid_Code}
    Wait And Click    ${Btn_LoginErrMsg}

Invalid login with empty captcha code
    [Documentation]    輸入存在的帳號、密碼和空驗證碼
    Wait And Clear Then Input    ${Xpath_LoginAcc}    ${Account}
    Wait And Clear Then Input    ${Xpath_LoginPwd}    ${Password}
    Wait And Clear    ${Xpath_LoginValidCode}
    Wait And Click    ${Btn_Login}
    Element Should be visible    ${Xpath_LoginErrMsg}
    Element Should Contain    ${Xpath_LoginErrMsg}    ${ErrMsg_Empty_Valid_Code}
    Wait And Click    ${Btn_LoginErrMsg}

Invalid login with wrong captcha code
    [Documentation]    輸入存在的帳號、密碼和錯誤的驗證碼
    Wait And Clear Then Input    ${Xpath_LoginAcc}    ${Account}
    Wait And Clear Then Input    ${Xpath_LoginPwd}    ${Password}
    Wait And Clear Then Input    ${Xpath_LoginValidCode}    0000
    Wait And Click    ${Btn_Login}
    Wait Until Element Is Visible    ${Xpath_LoginErrMsg}
    Element Should be visible    ${Xpath_LoginErrMsg}
    Element Should Contain    ${Xpath_LoginErrMsg}    ${ErrMsg_Wrong_Valid_Code}
    Wait And Click    ${Btn_LoginErrMsg}

valid login
    [Documentation]    一般登入；標記Captcha檢查
    Wait And Clear Then Input    ${Xpath_LoginAcc}    ${Account}
    Wait And Clear Then Input    ${Xpath_LoginPwd}    ${Password}
    Wait And Clear Then Input    ${Xpath_LoginValidCode}    ${ValidCode}
    sleep    8
    Wait And Click    ${Btn_Login}
    #Select Frame    xpath=//div[@id='loginRecaptcha']/div/div/iframe
    #Wait And Click    xpath=//div[@class='recaptcha-checkbox-checkmark']
    #Unselect Frame
    Wait And Click    ${Btn_IntroConfirm}
    Element should be visible    ${Page_Main_Header}
