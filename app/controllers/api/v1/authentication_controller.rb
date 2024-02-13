class Api::V1::AuthenticationController < ApplicationController
    before_action :authenticate_request, only: [:refresh_token, :account]

    def login
        @user = User.find_by_email(params[:identifier])

        unless @user
            @user = User.find_by_username(params[:identifier])
        end
        
        unless @user
            head :unauthorized and return
        end

        if @user.authenticate(params[:password])
            render json: @user.to_json(:except => :password_digest, :methods => :token)
        else
            head :unauthorized
        end
    end

    def refresh_token
        render json: { token: @user.token }
    end

    def account
        render json: @user.to_json(:except => :password_digest)
    end
end
