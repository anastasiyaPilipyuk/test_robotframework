*** Settings ***
Documentation    resource file
Library    SeleniumLibrary

*** Variables ***
${LOGIN URL}    https://scouts.futbolkolektyw.pl/en/
${BROWSER}      CHROME
${SIGNINBUTTON}     xpath=//button[@type='submit']/span
${PAGELOGO}     xpath=//*[@id="__next"]/div[1]/main/div[3]/div[1]/div/div[1]
&{DEFAULTUSER}  login=user07@getnada.com  password=Test-1234

*** Keywords ***
Open login page
    Open Browser        ${LOGIN URL}    ${BROWSER}
    Title Should Be     Scouts panel - sign in
Type in email
    [Arguments]     ${login}
    Input Text    id:login     ${login}
Type in password
    [Arguments]     ${password}
    Input Password    id:password  ${password}
Click on the Sign in button
    Click Element    ${SIGNINBUTTON}
Loggin in
    [Arguments]     ${user}
    Open Login Page
    IF  'login' in $user
        Type In Email   ${user.login}
    END
    IF  'password' in $user
        Type In Password    ${user.password}
    END
    Click On The Sign In Button