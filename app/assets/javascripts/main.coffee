jQuery ->
  $("#offensive_theater.can_attack tbody td").click ->
    $("#attack_target").val($(this).data("point"))
    $("#new_attack").submit()
