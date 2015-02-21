jQuery(function() {
  return $.ajax({
    url: 'https://apis.google.com/js/client:plus.js?onload=gpAsyncInit',
    dataType: 'script',
    cache: true
  });
});
window.gpAsyncInit = function() {
  $('.googleplus-login').removeAttr('disabled').click(function(e) {
    e.preventDefault();
    gapi.auth.authorize({
      immediate: true,
      response_type: 'code',
      cookie_policy: 'single_host_origin',
      client_id: '1094586320801-nvg6i4lnlikepj2tl5unqomc1qtm6m5i.apps.googleusercontent.com',
      scope: 'email profile'
    }, function(response) {
      if (response && !response.error) {
        response["user[username]"]=$("#user_username").val();
        response["recaptcha_response_field"]=$('#recaptcha_response_field').val();
        response["recaptcha_challenge_field"]=$("#recaptcha_response_field").val();
        response["authenticity_token"]=$('input[name="authenticity_token"]').val();
        response["utf8"]=$('input[name="utf8"]').val();
        jQuery.ajax({type: 'POST', url: "/users", dataType: 'json', data: response,
          success: function(json) {
            location.href="/";
          }
        });
      } else {
        // google authentication failed
      }
    });
  });
};
