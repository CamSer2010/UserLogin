sub init()
    'Roku IP 192.168.0.15
    ?"init()"

    m.label = m.top.findnode("labelWelcome")
    m.userTextEditBox = m.top.findnode("userTextEditBox")
    m.passwordTextEditBox = m.top.findnode("passwordTextEditBox")
    m.userKeyboard = m.top.findnode("userKeyboard")
    m.passwordKeyboard = m.top.findnode("passwordKeyboard")
    m.loginButton = m.top.findnode("loginButton")
    m.signUpLabel = m.top.findnode("signUpLabel")
    m.forgetLabel = m.top.findnode("forgetLabel")

    m.userTextEditBox.observeField("focusedChild", "onFocusChain")
    m.passwordTextEditBox.observeField("focusedChild", "onFocusChain")
    m.userKeyboard.observeField("focusedChild", "onFocusChain")
    m.signUpLabel.observeField("focusedChild", "onFocusChain")
    m.forgetLabel.observeField("focusedChild", "onFocusChain")
    m.passwordKeyboard.observeField("focusedChild", "onFocusChain")
    m.loginButton.observeField("buttonSelected", "onLoginButtonSelected") 


    m.userTextEditBox.setFocus(true)

endsub

sub onFocusChain()

    if  m.userTextEditBox.isInFocusChain() then
        m.userTextEditBox.active = "true"       
        m.userTextEditBox.backgrounduri = "pkg:/images/yellowfont.png"
        m.passwordTextEditBox.backgrounduri = "pkg:/images/greyfont.png"
        m.userTextEditBox.opacity = "0.7"
        m.userTextEditBox.textColor = "0xFFFFFF"
    elseif m.passwordTextEditBox.isInFocusChain()
        m.passwordTextEditBox.active = "true"        
        m.passwordTextEditBox.backgrounduri = "pkg:/images/yellowfont.png"
        m.userTextEditBox.backgrounduri = "pkg:/images/greyfont.png"
        m.passwordTextEditBox.opacity = "0.7"
        m.passwordTextEditBox.textColor = "0xFFFFFF"
    elseif m.userKeyboard.isInFocusChain()
        m.userTextEditBox.text = m.userKeyboard.text
    elseif m.passwordKeyboard.isInFocusChain()
        m.passwordTextEditBox.text = m.passwordKeyboard.text
    elseif m.signUpLabel.isInFocusChain()
        m.signUpLabel.color = "0xFFFFFF"
        m.forgetLabel.color = "0xFFC300"
    elseif m.forgetLabel.isInFocusChain()
        m.forgetLabel.color = "0xFFFFFF"
        m.signUpLabel.color = "0xFFC300"
    else
        m.label.color = "0xFFC300"
        m.passwordTextEditBox.backgrounduri = "pkg:/images/greyfont.png"
        m.userTextEditBox.backgrounduri = "pkg:/images/greyfont.png"
    end if 

end sub

sub onLoginButtonSelected()
    ?">>WELCOME" 
end sub

sub onRegisterButtonSelected()
    ?">>WAIT PLEASE"
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean

    handled = true
    ?">>key ";key;">>press ";press
    
    if press then
                  
        if key = "down" then 

            if  m.userTextEditBox.isInFocusChain() then
                m.passwordTextEditBox.setFocus(true)
                ?"## user to password"
            elseif m.passwordTextEditBox.isInFocusChain()
                m.loginButton.setFocus(true)
                ?"## password to login"   
            elseif m.loginButton.isInFocusChain()
                m.signUpLabel.setFocus(true)
                ?"## login to signup"   
            elseif m.signUpLabel.isInFocusChain()
                m.forgetLabel.setFocus(true)
                ?"## signup to forget"                         
            end if          
                   
        elseif key = "up"
                
            if m.loginButton.isInFocusChain()
                m.passwordTextEditBox.setFocus(true)
                ?"## login to password"
            elseif m.passwordTextEditBox.isInFocusChain()
                m.userTextEditBox.setFocus(true)
                ?"## password to user"
            elseif m.signUpLabel.isInFocusChain()
                m.loginButton.setFocus(true)
                m.signUpLabel.color = "0xFFC300"
                ?"## signup to login" 
            elseif m.forgetLabel.isInFocusChain()
                m.signUpLabel.setFocus(true)
                ?"## forget to signup"       
            end if     

        elseif key = "back"

            m.forgetLabel.visible = "true"
            m.signUpLabel.visible = "true"
            m.loginButton.visible = "true"
                
            if  m.userKeyboard.isInFocusChain() then
                m.userTextEditBox.setFocus(true)
                m.userKeyboard.visible = "false"
                ?"## keyboard to login"
            elseif m.passwordKeyboard.isInFocusChain()
                m.passwordTextEditBox.setFocus(true)
                m.passwordKeyboard.visible = "false"
                ?"## KEYBORD to password"
            end if  
        
        elseif key = "OK"
            if  m.userTextEditBox.isInFocusChain() then
                m.userKeyboard.setFocus(true)
                m.userKeyboard.visible = "true"
                m.forgetLabel.visible = "false"
                m.signUpLabel.visible = "false"
                m.userTextEditBox.hintText = ""
            elseif m.passwordTextEditBox.isInFocusChain()
                m.passwordKeyboard.setFocus(true)
                m.passwordKeyboard.visible = "true"
                m.forgetLabel.visible = "false"
                m.signUpLabel.visible = "false"
                m.loginButton.visible = "false"
                m.passwordTextEditBox.hintText = ""
            end if

        end if
        
    end if
   return handled
end function



