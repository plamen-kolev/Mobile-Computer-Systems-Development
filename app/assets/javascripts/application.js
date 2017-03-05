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

function load_messages(url, current_user){
    messages = [];
    $.ajax({
        dataType: "json",
        url: url,
        data: 'data',
        success: function(e){

            if(!e.length){
                $("#load_more_messages_button").hide();
            }

            for(var i = 0; i < e.length; i++){
                var styling;

                if(current_user == e[i].user_id){
                    styling = 'alert-info pull-right justify-right';
                } else {
                    styling = 'alert-success pull-left justify-left';
                }

                var message =   '<div class="alert message '+styling+'">\
                                    <p>' + e[i].body + '</p>\
                                    <span>2017-02-13 21:10:26 UTC</span>\
                                </div>'
                $( "#conversation_container" ).prepend( message );
            }
        }
    }).fail(function(e) {
        
    });

    
    

    
}