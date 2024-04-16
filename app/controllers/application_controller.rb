class ApplicationController < ActionController::API
    def find_user
        begin
            header = request.headers['Authorization']
            token = header.split(" ")[1]
            decoded_token = JWT.decode(token, Rails.application.secret_key_base)
            expiration = Time.at(decoded_token[0]['expiration'])
            user_id = decoded_token[0]['user_id']
        rescue
            return
        end
        if expiration.past?
            return
        end

        return User.find(user_id)
    end

    def authenticate_request
        @user = find_user
        if @user.nil?
            head :unauthorized and return
        end
    end
end
