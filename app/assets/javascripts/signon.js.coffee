@callback = ->
signon = (response, connected,provider) ->
  if connected
    response['provider'] = provider
    response['user[username]'] = $('#user_username').val()
    response['g-recaptcha-response'] = $('#g-recaptcha-response').val()
    response['authenticity_token'] = $('input[name="authenticity_token"]').val()
    response['utf8'] = $('input[name="utf8"]').val()
    delete response.status
    delete response['g-oauth-window']
    jQuery.ajax
      type: 'POST'
      url: '/auth/'+provider+'/callback'
      dataType: 'json'
      data: response
      success: (json) ->
        location.href = '/'
        return
  else
    # google authentication failed
  return
$(document).ready ->
  # FACEBOOK (https://developers.facebook.com/docs/facebook-login/login-flow-for-web/v2.2)
  $.getScript '//connect.facebook.net/en_US/sdk.js', ->
    FB.init
      appId: '456421621175470'
      cookie: true
      xfbml: true
      oauth: true
      version: 'v2.2'
    $('#facebook-login').removeAttr('disabled').click (e) ->
      e.preventDefault()
      FB.login ((response) ->
        signon response.authResponse, response.status == 'connected', 'facebook'
        return
      ), scope: 'email,user_birthday'
      return
    return
  # GOOGLE (https://github.com/zquestz/omniauth-google-oauth2)    
  $.getScript 'https://apis.google.com/js/client:plus.js?onload=googleInit', ->
    $('#googleplus-login').removeAttr('disabled').click (e) ->
      e.preventDefault()
      gapi.auth.authorize {
        immediate: false
        response_type: 'code'
        cookie_policy: 'single_host_origin'
        client_id: '927139304986-e0jefhtuhejh57e6j0v2ct50l4dod52h.apps.googleusercontent.com'
        scope: 'email profile'
      }, (response) ->
        return signon response, response and !response.error ,'google_oauth2'
      return
    return
  # PERSONA
  $.getScript 'https://login.persona.org/include.js', ->
    $('#persona-login').removeAttr('disabled').click (e) ->
      e.preventDefault()
      navigator.id.get (response) ->
        return signon response, response and !response.error ,'browser_id'
      return
    return
  return
