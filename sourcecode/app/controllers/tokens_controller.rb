class TokensController < ApplicationController
    before_action :authenticate_user!

    def get_token
        Twilio::Util::AccessToken.new(
            ENV['ACCOUNT_SID'],
            ENV['API_KEY_SID'],
            ENV['API_KEY_SECRET'],
            3600, 
            current_user.email
        )
    end

    def get_grant 
        grant = Twilio::Util::AccessToken::IpMessagingGrant.new 
        grant.endpoint_id = "Chatty:#{current_user.email.gsub(" ", "_")}:browser"
        grant.service_sid = ENV['IPM_SERVICE_SID']
        grant
    end

    def create
        token = get_token

        grant = get_grant
        token.add_grant(grant)
        puts "\n\n\n\n\n\n\n"
        puts "hello"
        puts ENV['IPM_SERVICE_SID']
        puts token.to_jwt.inspect
        render json: {username: current_user.email, token: token.to_jwt}
    end
end
