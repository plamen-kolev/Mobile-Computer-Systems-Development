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

        // set size of messages box to the screen size
        var messages_height = $(window).height() - $(".navbar").height() - $("#tools").height() - $("#partner_name").height() - 40 + 'px';
        $("#messages").css('height', messages_height);
        $(".emoticon_container").css('height', messages_height);

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

var setup_onclick_events = false
$('#emoticon_container > img').click(function(){
    if (!setup_onclick_events){
        $(".emoticon_container img").each(function(){
            // add onclick event, enables taking out karma and sending emote to input box
            $(this).on("click", function(){
                // check if parent container is a rude emoticon, if so, trigger karma reduction
                var is_rude_emoticon = ($(this).parent().parent().is('#rude-emoticons-container'));
                
                $('#chat-input').val($('#chat-input').val() + $("#" + this.id).prop('outerHTML'));
                if (is_rude_emoticon){
                    send_negative_emoticon(this.id, "<%= @connection.channel %>")
                }
            });
        });
        
    }
    setup_onclick_events = true;
});
