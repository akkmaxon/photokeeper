$(document).ready () ->
  $('#avatar-settings-tab a').click () ->
    $('#settings li').removeClass 'active'
    $('#avatar-settings-tab').addClass 'active'
    $('#avatar-settings').slideDown 1000
    $('#login-credentials').slideUp 1000
    $('#danger').slideUp 1000
    $('#submit-button').slideDown 1000

  $('#login-credentials-tab a').click () ->
    $('#settings li').removeClass 'active'
    $('#login-credentials-tab').addClass 'active'
    $('#avatar-settings').slideUp 1000
    $('#login-credentials').slideDown 1000
    $('#danger').slideUp 1000
    $('#submit-button').slideDown 1000

  $('#danger-tab a').click () ->
    $('#settings li').removeClass 'active'
    $('#danger-tab').addClass 'active'
    $('#avatar-settings').slideUp 1000
    $('#login-credentials').slideUp 1000
    $('#danger').slideDown 1000
    $('#submit-button').slideUp 1000
