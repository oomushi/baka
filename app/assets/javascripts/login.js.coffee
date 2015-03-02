# FACEBOOK (https://developers.facebook.com/docs/facebook-login/login-flow-for-web/v2.2)
# This is called with the results from from FB.getLoginStatus().
statusChangeCallback = (response) ->
  console.log 'statusChangeCallback'
  console.log response
  # The response object is returned with a status field that lets the
  # app know the current login status of the person.
  # Full docs on the response object can be found in the documentation
  # for FB.getLoginStatus().
  if response.status == 'connected'
    # Logged into your app and Facebook.
    testAPI()
  else if response.status == 'not_authorized'
    # The person is logged into Facebook, but not your app.
    document.getElementById('status').innerHTML = 'Please log ' + 'into this app.'
  else
    # The person is not logged into Facebook, so we're not sure if
    # they are logged into this app or not.
    document.getElementById('status').innerHTML = 'Please log ' + 'into Facebook.'
  return

# This function is called when someone finishes with the Login
# Button.  See the onlogin handler attached to it in the sample
# code below.
checkLoginState = ->
  FB.getLoginStatus (response) ->
    statusChangeCallback response
    return
  return

# Here we run a very simple test of the Graph API after login is
# successful.  See statusChangeCallback() for when this call is made.

testAPI = ->
  console.log 'Welcome!  Fetching your information.... '
  FB.api '/me', (response) ->
    console.log 'Successful login for: ' + response.name
    document.getElementById('status').innerHTML = 'Thanks for logging in, ' + response.name + '!'
    return
  return

window.fbAsyncInit = ->
  FB.init
    appId: '{your-app-id}'
    cookie: true
    xfbml: true
    version: 'v2.2'
  # Now that we've initialized the JavaScript SDK, we call 
  # FB.getLoginStatus().  This function gets the state of the
  # person visiting this page and can return one of three states to
  # the callback you provide.  They can be:
  #
  # 1. Logged into your app ('connected')
  # 2. Logged into Facebook, but not your app ('not_authorized')
  # 3. Not logged into Facebook and can't tell if they are logged into
  #    your app or not.
  #
  # These three cases are handled in the callback function.
  FB.getLoginStatus (response) ->
    statusChangeCallback response
    return
  return

# Load the SDK asynchronously
((d, s, id) ->
  js = undefined
  fjs = d.getElementsByTagName(s)[0]
  if d.getElementById(id)
    return
  js = d.createElement(s)
  js.id = id
  js.src = '//connect.facebook.net/en_US/sdk.js'
  fjs.parentNode.insertBefore js, fjs
  return
) document, 'script', 'facebook-jssdk'

# GOOGLE (https://github.com/zquestz/omniauth-google-oauth2)
$(document).ready ->
  $.ajax
    url: 'https://apis.google.com/js/client:plus.js?onload=googleInit'
    dataType: 'script'
    cache: true
@googleInit = ->
  $('.googleplus-login').removeAttr('disabled').click (e) ->
    e.preventDefault()
    gapi.auth.authorize {
      immediate: true
      response_type: 'code'
      cookie_policy: 'single_host_origin'
      client_id: '1094586320801-nvg6i4lnlikepj2tl5unqomc1qtm6m5i.apps.googleusercontent.com'
      scope: 'email profile'
    }, (response) ->
      if response and !response.error
        response['user[username]'] = $('#user_username').val()
        response['g-recaptcha-response'] = $('#g-recaptcha-response').val()
        response['authenticity_token'] = $('input[name="authenticity_token"]').val()
        response['utf8'] = $('input[name="utf8"]').val()
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
# YAHOO
# TWITTER
