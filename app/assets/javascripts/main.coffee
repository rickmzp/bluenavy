jQuery ->
  # Enable pusher logging - don't include this in production
  Pusher.log = (message)->
    if window.console && window.console.log
      window.console.log(message)

    # Flash fallback logging - don't include this in production
    # WEB_SOCKET_DEBUG = true

  if $("body").is(".in_game")
    window.pusher = new Pusher("7c2f68fae63db3194f00")
    channel_name = "game_#{$("body").data("game-id")}_events"
    window.channel = pusher.subscribe(channel_name)

    if $("body").is(".waiting_for_turn")
      channel.bind "turn_change", (data)->
        window.location.reload()

  $("#offensive_theater.can_attack tbody td").click ->
    $("#attack_target").val($(this).data("point"))
    $("#new_attack").submit()
