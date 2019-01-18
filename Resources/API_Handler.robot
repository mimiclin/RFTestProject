*** Variables ***
${APIURL}         http://117.27.159.77:11022
${ContentType}    application/x-www-form-urlencoded; charset=UTF-8
${COOKIE}         bh_="2|1:0|10:1547792455|3:bh_|632:eyJyZWdfdGltZSI6ICIyMDE4MTAwODE2MTEwMCIsICJyZWdfaXAiOiAiMC4wLjAuMCIsICJtb25leV90eXBlIjogIjEiLCAibmlja19uYW1lIjogIiIsICJtb25leSI6ICIxMzgwNzkuMTI5IiwgInVzZXJfdHlwZSI6ICIwIiwgImhhc19wcm94eV9ib251cyI6IHRydWUsICJwYXJlbnRfcXEiOiAiIiwgInRpZXIiOiAiMiIsICJ1c2VyX2NvZGUiOiAiMTYyNDciLCAibG9naW5faXAiOiAiNTkuMTI0LjIyNC4yNDMiLCAidXNlcl9uYW1lIjogIm1pdGVzdDAwMDEiLCAicHJldl9sb2dpbl90aW1lIjogIjIwMTkwMTE4MTQxOTEyIiwgInVzZXJfaWQiOiAiOTk1MzMiLCAicHJldl9sb2dpbl9pcCI6ICI1OS4xMjQuMjI0LjI0MyIsICJsb2dpbl90aW1lIjogIjIwMTkwMTE4MTQyMDUyIiwgImVycm9yX2NvZGUiOiAwLCAiaGFzX3Byb3h5X3dhZ2UiOiB0cnVlLCAidV9udW0iOiAiS2RsVE1JVkVXUWVjdlk2TWo2U0V1WDBKdmQ4RTRIV2cifQ==|85419a110b00f71d16a85b2d71f42bfb16f379a5d8d857e77a901f3a615236b7"
${UserID}         99533

*** Keywords ***
Create header before login
    ${Header}    Create Dictionary    Content-Type=${ContentType}    k-token=${TOKEN}
    Set Global Variable    ${HeaderBeforeLogin}    ${Header}

Create header after login
    [Documentation]    Create header after login
    ${Header}    Create Dictionary    Content-Type=${ContentType}    Cookie=${COOKIE}
    Set Global Variable    ${HeaderAfterLogin}    ${Header}

Login With Account and Password
    [Arguments]    ${user}    ${pwd}
    #${EncryptedPWD}    Encrypt Password    ${pwd}    ${KEY}
    Create Session    APIURL    ${URL}
    ${DATA}    Create Dictionary    user=${user}    pwd=${pwd}
    ${response}    Post Request    APIURL    login    data=${DATA}    headers=${HeaderBeforeLogin}
    [Return]    ${response}

Valid Login
    ${RES}    Login With Account and Password    ${USERNAME}    ${PASSWORD}
    Should Be Equal As Integers    ${RES.status_code}    200
    ${responsedata}    To Json    ${RES.content}
    Dictionary Should Contain Key    ${responsedata["data"]}    session
    ${session}    Get From Dictionary    ${responsedata["data"]}    session
    Create header after login    ${session}
    Set Global Variable    ${rsession}    ${rsession}

User Logout
    Create Session    APIURL    ${URL}
    ${DATA}    Create Dictionary    rsession=${rsession}
    ${RES}    Post Request    APIURL    user/logout    headers=${HeaderAfterLogin}    data=${DATA}
    Should Be Equal As Integers    ${RES.status_code}    204
