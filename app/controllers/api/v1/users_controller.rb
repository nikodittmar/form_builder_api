class Api::V1::UsersController < ApplicationController
    before_action :verify_password, only: [ :update, :destroy ]
    
    def index
        @users = User.all
        render json: @users
    end

    def show
        @user = User.find(params[:id])
        render json: @user.to_json(:except => [:password_digest, :email])
    end

    def create
        @user = User.new(user_params)
        if @user.save
            render json: @user.to_json(:except => :password_digest, :methods => :token), status: :created
        else
            render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        if @user.update(user_params)
            render json: @user.to_json(:except => :password_digest)
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end

    def destroy
        if @user.destroy
            head :no_content
        else
            render @user.errors, status: :unprocessable_entity
        end
    end

    private
    def user_params
        params.require(:user).permit(:email, :username, :password)
    end

    def verify_password
        @user = User.find(params[:id])
        unless @user.authenticate(params[:password_challenge])
            render json: { error: "unauthorized" }, status: :unauthorized and return
        end
    end
end
