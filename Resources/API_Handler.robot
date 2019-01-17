*** Variables ***
${APIURL}         http://117.27.159.77:11022
${ContentType}    application/x-www-form-urlencoded; charset=UTF-8
${COOKIE}         bh_="2|1:0|10:1547717590|3:bh_|632:eyJyZWdfdGltZSI6ICIyMDE4MTAwODE2MTEwMCIsICJ1c2VyX2lkIjogIjk5NTMzIiwgIm1vbmV5X3R5cGUiOiAiMSIsICJuaWNrX25hbWUiOiAiIiwgIm1vbmV5IjogIjEzODIzNC40MTkiLCAidXNlcl90eXBlIjogIjAiLCAiaGFzX3Byb3h5X2JvbnVzIjogdHJ1ZSwgInBhcmVudF9xcSI6ICIiLCAidGllciI6ICIyIiwgInVzZXJfY29kZSI6ICIxNjI0NyIsICJsb2dpbl9pcCI6ICI1OS4xMjQuMjI0LjI0MyIsICJ1c2VyX25hbWUiOiAibWl0ZXN0MDAwMSIsICJwcmV2X2xvZ2luX3RpbWUiOiAiMjAxOTAxMTcxNzI4MTIiLCAicmVnX2lwIjogIjAuMC4wLjAiLCAicHJldl9sb2dpbl9pcCI6ICI1OS4xMjQuMjI0LjI0MyIsICJsb2dpbl90aW1lIjogIjIwMTkwMTE3MTczMjU2IiwgImVycm9yX2NvZGUiOiAwLCAiaGFzX3Byb3h5X3dhZ2UiOiB0cnVlLCAidV9udW0iOiAiSlFsZVRIU1JnTmF6YU9nNThTbVZ3a21ZMGdyVGR3alQifQ==|1a7299e6d6163c82c2625e9ddf5292bae05d5840636b284973db492612b7a7d2"
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
