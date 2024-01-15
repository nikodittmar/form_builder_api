class Api::V1::AuthenticationController < ApplicationController
    before_action :authenticate_request, only: :refresh_token

    def login
        @user = params.has_key?(:email) ? User.find_by_email(params[:email]) : User.find_by_username(params[:username])
        unless @user
            head :not_found and return
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
end
