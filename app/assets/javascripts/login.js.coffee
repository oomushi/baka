@callback = ->
$(document).ready ->
  # FACEBOOK (https://developers.facebook.com/docs/facebook-login/login-flow-for-web/v2.2)
  $.getScript '//connect.facebook.net/en_US/sdk.js', ->
    $('#facebook-login').removeAttr('disabled').click (e) ->
      e.preventDefault()
      FB.init
        appId: '449175338566765'
        cookie: true
        xfbml: true
        version: 'v2.2'
      FB.getLoginStatus (response) ->
        if response.status == 'connected' # Logged into your app and Facebook.
          testAPI()
        else if response.status == 'not_authorized' # The person is logged into Facebook, but not your app.
          document.getElementById('status').innerHTML = 'Please log ' + 'into this app.'
        return
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
        if response and !response.error
          response['user[username]'] = $('#user_username').val()
          response['g-recaptcha-response'] = $('#g-recaptcha-response').val()
          response['authenticity_token'] = $('input[name="authenticity_token"]').val()
          response['utf8'] = $('input[name="utf8"]').val()
          delete response.status
          delete response['g-oauth-window']
          jQuery.ajax
            type: 'POST'
            url: '/auth/google_oauth2/callback'
            dataType: 'json'
            data: response
            success: (json) ->
              location.href = '/'
              return
        else
          # google authentication failed
        return
      return
    return
  return
# YAHOO
# TWITTER
