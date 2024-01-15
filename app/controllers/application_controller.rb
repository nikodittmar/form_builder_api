class ApplicationController < ActionController::API
    def authenticate_request
        begin
            header = request.headers['Authorization']
            token = header.split(" ")[1]
            decoded_token = JWT.decode(token, Rails.application.secret_key_base)
            expiration = Time.at(decoded_token[0]['expiration'])
            user_id = decoded_token[0]['user_id']
        rescue
            head :unauthorized and return
        end
        if expiration.past?
            head :unauthorized and return
        end
        @user = User.find(user_id)
    end
end
