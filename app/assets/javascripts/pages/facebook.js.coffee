window.fbAsyncInit = ->
  FB.init(appId: '1425828961045846', cookie: true)
  
  $('#WT_facebook_connect').click (e) ->
    e.preventDefault()
    FB.login ((response) ->
      console.log(response.authResponse)
      window.location = '/users/auth/facebook/callback' if response.authResponse), scope: "read_friendlists, user_events,friends_photos,email,rsvp_event"