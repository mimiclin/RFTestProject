*** Variables ***
${Xpath_LoginLogo}    xpath=//div[@class='login-title']/div[@class='wrap']/div[@class='logo']
${Xpath_LoginTitle}    xpath=//div[@class='wrap']/div/p[contains(.,'Fire')]
${Xpath_LoginAcc}    xpath=//div[@id='input_form']/input[@id='user_name']
${Xpath_LoginPwd}    xpath=//div[@id='input_form']/input[@id='password']
${Xpath_LoginValidCode}    xpath=//div[@id='input_form']/input[@id='valid_code']
${Btn_Login}      xpath=//div/button[@class='btn-login']
${Xpath_LoginErrMsg}    xpath=//div[@id='error_show']/div[@class='content']/table/tbody/tr/td/div[@id='error_cnt']
${Btn_LoginErrMsg}    xpath=//div[@id='error_show']/div[@class='close']
${Btn_IntroConfirm}    xpath=//button[@class='aui_state_highlight']
${Page_Main_Header}    xpath=//div[@id='content-wrapper']/div[@id='header']/div/div/div[@class='logo f_left']
