*** Keywords ***
Login Page Should Contain Some Elements
    Wait until page contains element    ${Xpath_LoginLogo}
    Element Should be visible    ${Xpath_LoginLogo}
    Element Should be visible    ${Xpath_LoginTitle}    message=${LoginTitle}

Input Account
    [Arguments]    ${Account}
    Wait And Clear Then Input    ${Xpath_LoginAcc}    ${Account}

Input Password
    [Arguments]    ${Password}
    Wait And Clear Then Input    ${Xpath_LoginPwd}    ${Password}

Input Valid Code
    [Arguments]    ${ValidCode}
    Wait And Clear Then Input    ${Xpath_LoginValidCode}    ${ValidCode}

Submit Login
    Wait And Click    ${Btn_Login}

Confirm Login Error Message
    [Arguments]    ${ErrMsg}
    Wait Until Element Is Visible    ${Xpath_LoginErrMsg}
    Element Should Contain    ${Xpath_LoginErrMsg}    ${ErrMsg}
    Wait And Click    ${Btn_LoginErrMsg}

Confirm IntroPage
    Wait Until Element Is Visible    ${Btn_IntroConfirm}
    Wait And Click    ${Btn_IntroConfirm}
