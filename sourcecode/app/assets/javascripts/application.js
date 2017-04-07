// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap-sprockets

function send_negative_emoticon(image, channel){
    $.ajax({
        type: "POST",
        url: "http://localhost:3000/send_negative_emoticon",
        data: {
            "emoticon_id" : image,
            "channel" : channel
        },
        dataType: "json",
        success: function(data) {
            $('#karma_val').text(data.karma);
        }
    });
    $('#chat-input').val($('#chat-input').val() + $("#" + this.id).prop('outerHTML'));
}

function render_emoticons(html, element_target){
    
    // show and hide emoticons when toggling the button
    $(element_target + '-container').html(html);
    $(element_target).click(function(){
        if (element_target === "#good-emoticons"){
                $('#rude-emoticons-container').hide();
        } else {
            $('#good-emoticons-container').hide();
        }

        $(element_target + '-container').toggle();
    })

    // add event listeners
    
}