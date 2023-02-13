*** Settings ***
Library    SeleniumLibrary
Documentation   Suit description #automated test for scout website
Resource    resources/common.resource

*** Variables ***
${EMAIL INPUT}     xpath=//input[@name='email']
${NAME INPUT}      xpath=//input[@name='name']
${SURNAME INPUT}       xpath=//input[@name='surname']
${PHONE INPUT}      xpath=//input[@name='phone']
${WEIGHT INPUT}      xpath=//input[@name='weight']
${HEIGHT INPUT}        xpath=//input[@name='height']
${AGE INPUT}       xpath=//input[@name='age']
${MAINPOS INPUT}      xpath=//input[@name='mainPosition']
${SUBMITBUTTON}     xpath=//*[@type='submit']
${ALERT}        xpath=//*[@role="alert"]
${ADDPLAYERBUTTON}      xpath=(//div[@class='MuiCardContent-root'])[2]/a/button
${PAGETITLE}        xpath=//form/div[1]/div/span
${CLUB INPUT}        xpath=//input[@name='club']
${LEVEL INPUT}        xpath=//input[@name='level']
${SECONDPOSITION INPUT}     xpath=//input[@name='secondPosition']
${DISTRICT INPUT}     xpath=//input[@name='district']
${ARCHIEVEMENTS INPUT}      xpath=// input[@name='achievements']
${WEB LACZY INPUT}      xpath=//input[@name='webLaczy']
${WEB90 INPUT}      xpath=//input[@name='web90']
${WEBFB INPUT}      xpath=//input[@name='webFB']
${REQUIRED MARK}     xpath=//*[text()='Required']

${ADD YOUTUBE BUTTON}   xpath=//div[19]/button
${ADD LANG BUTTON}          xpath = //div[15]/button

${LEG SELECT}      xpath=//input[@id='leg']/parent::div/div
${LEFT LEG EN}     Left leg
${LEFT LEG PL}     Lewa
${LEG MENU RIGHT}     xpath=//*[@id='menu-leg']/div[3]/ul/li[1]
${LEG MENU LEFT}      xpath=//*[@id='menu-leg']/div[3]/ul/li[2]

${DISTRICT TO CLICK}        xpath=//input[@name='district']/parent::div/div
${DISTRICT SILESIA}     xpath=//*[@id='menu-district']/div[3]/ul/li[12]
${SILESIA}      Silesia

*** Test Cases ***
Add new player with max info
    [Documentation]     Test for checking adding a player with entering a maximum of information (English version)
    @{youtubes}=    Create List     https://www.youtube.com/@test1    https://www.youtube.com/@test2
    @{languages}=   Create List     Polish  English
    &{PLAYERINFO}=    Create Dictionary  email=player01@getnada.com  name=Player01Name
    ...                                     surname=Player01Surname
    ...                                     phone=player01Phone
    ...                                     weight=70
    ...                                     height=190
    ...                                     leg=Right leg
    ...                                     age=02/25/1990
    ...                                     club=Player01Club
    ...                                     level=player01Level
    ...                                     mainPosition=player01MainPosition
    ...                                     secondPosition=player01SecondPosition
    ...                                     district=Silesia
    ...                                     achievements=player01Achievements
    ...                                     youtubes=${youtubes}
    ...                                     languages=${languages}
    ...                                     webLaczy=ProfilePlayer01LNP
    ...                                     web90=ProfilePlayer0190M
    ...                                     webFB=NicknamePlayer01FB
    Loggin in   ${DEFAULTUSER}
    Assert dashboard
    Click add player link
    Fill player info  ${PLAYERINFO}
    Click On The Submit Button
    Wait for save be complete   ${PLAYERINFO}    alert_TC_PP_01.png
    [Teardown]    Close Browser

Add new player with min info
    [Documentation]    Test for checking adding a player with entering a minimum of information (English version)
    &{PLAYERINFO}=    Create Dictionary  name=PlayerMin01Name
    ...                                     surname=PlayerMin01Surname
    ...                                     age=02/25/1990
    ...                                     mainPosition=playerMin01MainPosition
    Loggin in   ${DEFAULTUSER}
    Assert dashboard
    Click add player link
    Fill player info  ${PLAYERINFO}
    Click On The Submit Button
    Wait for save be complete   ${PLAYERINFO}    alert_TC_PP_02.png
    [Teardown]    Close Browser

Error on add player with no required info
    [Documentation]    Test for checking adding a player with entering a minimum of information (English version)
    &{PLAYERINFO}=    Create Dictionary  name=PlayerNoSave01Name
    ...                                     surname=PlayerNoSave01Surname

    Loggin in   ${DEFAULTUSER}
    Assert dashboard
    Click add player link
    Fill player info  ${PLAYERINFO}
    Click On The Submit Button
    Click On The Submit Button
    Check for error appear   alert_TC_PP_03.png
    [Teardown]    Close Browser

*** Keywords ***
Assert dashboard
    Wait Until Element Is Visible    ${PAGELOGO}
    Title Should Be    Scouts panel

Click add player link
    Click Element    ${ADDPLAYERBUTTON}

Fill player info
    [Arguments]     ${player}

    Fill Player Email   ${player}
    Fill player name    ${player}
    Fill player surname     ${player}
    Fill player phone   ${player}
    Fill player weight   ${player}
    Fill player height   ${player}
    Fill player age     ${player}
    Fill player leg    ${player}
    Fill player club    ${player}
    Fill player level    ${player}
    Fill player main position   ${player}
    Fill player secondPosition  ${player}
    Fill player achievements    ${player}
    Fill player youtubes   ${player}
    Fill player languages  ${player}
    Fill player district   ${player}
    Fill player web laczy  ${player}
    Fill player web90   ${player}
    Fill player webFB   ${player}

Click On The Submit Button
    Click Element    ${SUBMITBUTTON}

Wait for save be complete
    [Arguments]     ${player}   ${screenshotName}
    ${editMessage}=     Catenate  Edit player ${player.name} ${player.surname}
    Wait Until Element Is Visible   ${ALERT}
    Element Text Should Be      ${PAGETITLE}       ${editMessage}
    Capture Page Screenshot    ${screenshotName}

Check for error appear
    [Arguments]     ${screenshotName}
    Wait Until Element Is Visible   ${REQUIRED MARK}
    Element Text Should Be      ${PAGETITLE}       Add player
    Capture Page Screenshot    ${screenshotName}

Fill player email
    [Arguments]     ${player}
    IF  'email' in $player
        Wait Until Element Is Visible    ${EMAIL INPUT}
        Input Text    ${EMAIL INPUT}    ${player.email}
    END
Fill player name
    [Arguments]     ${player}
    IF  'name' in $player
        Wait Until Element Is Visible    ${NAME INPUT}
        Input Text      ${NAME INPUT}   ${player.name}
    END
Fill player surname
    [Arguments]     ${player}
    IF  'surname' in $player
        Input Text      ${SURNAME INPUT}   ${player.surname}
    END
Fill player age
    [Arguments]     ${player}
    IF  'age' in $player
        Input Text      ${AGE INPUT}   ${player.age}
    END
Fill player main position
    [Arguments]     ${player}
    IF  'mainPosition' in $player
        Input Text      ${MAINPOS INPUT}   ${player.mainPosition}
    END
Fill player phone
    [Arguments]     ${player}
    IF  'phone' in $player
        Input Text      ${PHONE INPUT}  ${player.phone}
    END
Fill player weight
    [Arguments]     ${player}
    IF  'weight' in $player
        Input Text      ${WEIGHT INPUT}  ${player.weight}
    END
Fill player height
    [Arguments]     ${player}
    IF  'height' in $player
        Input Text      ${HEIGHT INPUT}  ${player.height}
    END
Fill player club
    [Arguments]     ${player}
    IF  'club' in $player
        Input Text      ${CLUB INPUT}  ${player.club}
    END
Fill player level
    [Arguments]     ${player}
    IF  'level' in $player
        Input Text      ${LEVEL INPUT}  ${player.level}
    END
Fill player secondPosition
    [Arguments]     ${player}
    IF  'secondPosition' in $player
        Input Text      ${SECONDPOSITION INPUT}  ${player.secondPosition}
    END
Fill player achievements
    [Arguments]     ${player}
    IF  'achievements' in $player
        Input Text      ${ARCHIEVEMENTS INPUT}  ${player.achievements}
    END
Fill player web laczy
    [Arguments]     ${player}
    IF  'webLaczy' in $player
        Input Text      ${WEB LACZY INPUT}  ${player.webLaczy}
    END
Fill player web90
    [Arguments]     ${player}
    IF  'web90' in $player
        Input Text      ${WEB90 INPUT}  ${player.web90}
    END
Fill player webFB
    [Arguments]     ${player}
    IF  'webFB' in $player
        Input Text      ${WEBFB INPUT}  ${player.webFB}
    END

Fill player youtubes
    [Arguments]     ${player}
    IF  'youtubes' in $player
        ${index} =    Set Variable    0
        FOR    ${youtube}    IN    @{player.youtubes}
            #Log To Console   youtube = ${youtube}
            Click Button    ${ADD YOUTUBE BUTTON}
            ${link} =   Catenate    //input[@name='webYT[${index}]']
            #Log To Console   link = ${link}
            Wait Until Element Is Visible    ${link}
            Input Text    ${link}   ${youtube}
            ${index}=    Evaluate    ${index} + 1
        END
    END

Fill player leg
    [Arguments]     ${player}
    IF  'leg' in $player
        Click Element    ${LEG SELECT}
            IF  "${player.leg}" == "${LEFT LEG EN}" or "${player.leg}" == "${LEFT LEG PL}"
                Click Element   ${LEG MENU LEFT}
            ELSE
                Click Element   ${LEG MENU RIGHT}
            END
    END

Fill player district
    [Arguments]     ${player}
    IF  'district' in $player
        Click Element   ${DISTRICT TO CLICK}
        IF  "${player.district}" == "${SILESIA}"
            Wait Until Element Is Visible    ${DISTRICT SILESIA}
            Click Element   ${DISTRICT SILESIA}
        END
    END

Fill player languages
    [Arguments]     ${player}
    IF  'languages' in $player
        ${index} =    Set Variable    0
        FOR    ${languages}    IN    @{player.languages}
            Click Button    ${ADD LANG BUTTON}
            ${link} =   Catenate    //input[@name='languages[${index}]']
            Wait Until Element Is Visible    ${link}
            Input Text    ${link}   ${languages}
            ${index}=    Evaluate    ${index} + 1
        END
    END