$(function() {
  $("form").keypress(function (e) {  
    if ((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)) {  
      $(this).find('.default_btn').click();  
      return false;  
    } else {  
      return true;  
    }  
  });
     
  $('#search_field').click(function() {
    $(this).attr("value", "");
    $(this).removeClass('idle_field');
  });
  
  $('#search_field').blur(function() {
    $(this).addClass('idle_field');
  });
    
  if ($.address.path() != '/') {
    $('#main_view').addClass('hide');
    
    $('#sidebar a').removeClass('current');
    $('#sidebar a[rel="'+$.address.path()+'"]').addClass('current');
  
    var href = $.address.path();
    $.get(href,
      function(data) {
        $('#main_view').html(data);
        $('#main_view').removeClass('hide');
      });
  }
  
  $('.show_chinese').toggle(
    function() {
      $(this).css({'background': 'url(/images/chinese_hover.gif) no-repeat'});
      var ch = $(this).parents('.project').find('.chinese_description');
      ch.slideDown();
      var top = ch.offset().top - 200;
      $('html,body').animate({scrollTop: top}, 1000);
    },
    function() {
      $(this).css({'background': 'url(/images/chinese.gif) no-repeat'});
      $(this).parents('.project').find('.chinese_description').slideUp();
    }
  );
  
  $('#sidebar .project a').click(function() {
    $('#sidebar a').removeClass('current');
    $(this).addClass('current');
    
    var href = $(this).attr('href');
    $.address.value(href);
    $.get(href,
      function(data) {
        $('#main_view').html(data);
      });
    return false;
  });
  
  $('#sign_in_link').toggle(
    function() {
      $('#client_login .login_panel').fadeIn();
      return false;
    },
    function() {
      $('#client_login .login_panel').fadeOut();
      return false;
    }
  );
  
  $('#client_login form').submit(function() {
    var action = $(this).attr('action');
    $.post(action,
      $("#client_login form").serialize(),
      function(data) {
        if (data == 'Wrong username/password')
          $('#client_login .msg').html(data);
        else
          window.location = data
      });
    return false;
  });
});