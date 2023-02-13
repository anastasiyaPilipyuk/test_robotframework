*** Settings ***
Library    SeleniumLibrary
Documentation   Tests for loggin page in the scout website
Resource    resources/common.resource

*** Variables ***
${ERRORLOGIN}       xpath=//div[3]/span

*** Test Cases ***
Login to system
    [Documentation]    This test case verifies that the user is able to successfully log in to scout website
    Loggin in   ${DEFAULTUSER}
    Assert dashboard
    [Teardown]    Close Browser

Login to system with empty email
    [Documentation]    This test case verifies that the user is not able to log in to scout website with empty email
    &{USER}=    Create Dictionary  password=Test-1234
    Loggin in   ${USER}
    Assert error login message
    [Teardown]    Close Browser

Login to system with empty password
    [Documentation]    This test case verifies that the user is not able to log in to scout website with empty password
    &{USER}=    Create Dictionary  login=user07@getnada.com
    Loggin in   ${USER}
    Assert error password message
    [Teardown]    Close Browser

Login to system with wrong data
    [Documentation]    This test case verifies that the user is not able to log in to scout website with wrong email and password
    &{USER}=    Create Dictionary  login=incorrect@gmail.com  password=incorrectpass
    Loggin in   ${USER}
    Assert error wrong data
    [Teardown]    Close Browser

*** Keywords ***
Assert dashboard
    Wait Until Element Is Visible    ${PAGELOGO}
    Title Should Be    Scouts panel
    Capture Page Screenshot    alert_TC_LP_01.png
Assert error login message
    Wait Until Element Is Visible    ${ERRORLOGIN}
    Element Text Should Be    ${ERRORLOGIN}     Please provide your username or your e-mail.
    Capture Page Screenshot    alert_TC_LP_02.png
Assert error password message
    Wait Until Element Is Visible    ${ERRORLOGIN}
    Element Text Should Be    ${ERRORLOGIN}     Please provide your password.
    Capture Page Screenshot    alert_TC_LP_03.png
Assert error wrong data
    Wait Until Element Is Visible    ${ERRORLOGIN}
    Element Text Should Be    ${ERRORLOGIN}     Identifier or password invalid.
    Capture Page Screenshot    alert_TC_LP_04.png