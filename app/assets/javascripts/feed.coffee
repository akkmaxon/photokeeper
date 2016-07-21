$(document).ready () ->
  effectTime = 1000

  $('#photos a').click () ->
    $('#feed-links li').removeClass 'active'
    $('#photos').addClass 'active'
    $('.feed_photo').show effectTime
    $('.feed_album').hide effectTime
    $('.feed_comment').hide effectTime

  $('#albums a').click () ->
    $('#feed-links li').removeClass 'active'
    $('#albums').addClass 'active'
    $('.feed_album').show effectTime
    $('.feed_photo').hide effectTime
    $('.feed_comment').hide effectTime

  $('#comments a').click () ->
    $('#feed-links li').removeClass 'active'
    $('#comments').addClass 'active'
    $('.feed_comment').show effectTime
    $('.feed_album').hide effectTime
    $('.feed_photo').hide effectTime

  $('#all a').click () ->
    $('#feed-links li').removeClass 'active'
    $('#all').addClass 'active'
    $('.feed_photo').show effectTime
    $('.feed_album').show effectTime
    $('.feed_comment').show effectTime
