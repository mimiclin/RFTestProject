*** Settings ***
Library           Selenium2Library
Library           collections
Resource          Resources/XH_Resources.robot
Resource          Resources/XH_xpath.robot
Resource          Resources/Login.robot

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
    Input Account    ${EMPTY}
    Input Password    ${EMPTY}
    Submit Login
    Confirm Login Error Message    ${ErrMsg_Empty_Acc}

Verify invalid login with empty account
    [Documentation]    驗證無效登入，使用空帳號
    [Tags]    Login
    Input Account    ${EMPTY}
    Input Password    ${Password}
    Submit Login
    Confirm Login Error Message    ${ErrMsg_Empty_Acc}

Verify invalid login with empty password
    [Documentation]    驗證無效登入，使用空密碼
    [Tags]    Login
    Input Account    ${Account}
    Input Password    ${EMPTY}
    Submit Login
    Confirm Login Error Message    ${ErrMsg_Empty_Pwd}

Verify invalid login with wrong account
    [Documentation]    驗證無效登入，使用不存在的帳號
    [Tags]    Login
    Input Account    noaccount
    Input Password    ${Password}
    Submit Login
    Confirm Login Error Message    ${ErrMsg_Empty_Valid_Code}

Verify invalid login with wrong password
    [Documentation]    驗證無效登入，使用存在的帳號和錯誤的密碼
    [Tags]    Login
    Input Account    ${Account}
    Input Password    wrongpassword
    Submit Login
    Confirm Login Error Message    ${ErrMsg_Empty_Valid_Code}

Verify invalid login with empty captcha code
    [Documentation]    驗證無效登入，使用存在的帳號、密碼和空驗證碼
    [Tags]    Login
    Input Account    ${Account}
    Input Password    ${Password}
    Input ValidCode    ${EMPTY}
    Submit Login
    Confirm Login Error Message    ${ErrMsg_Empty_Valid_Code}

Verify invalid login with wrong captcha code
    [Documentation]    驗證無效登入，使用存在的帳號、密碼和錯誤的驗證碼
    [Tags]    Login
    Input Account    ${Account}
    Input Password    ${Password}
    Input ValidCode    0000
    Submit Login
    Sleep    500ms
    Confirm Login Error Message    ${ErrMsg_Wrong_Valid_Code}

Verify valid login
    [Documentation]    使用測試帳號登入
    [Tags]    Login
    Input Account    ${Account}
    Input Password    ${Password}
    Input ValidCode    ${ValidCode}
    Sleep    8
    Submit Login
    Confirm IntroPage

Test end
    [Documentation]    關閉瀏覽器
    Close Browser

*** Keywords ***
