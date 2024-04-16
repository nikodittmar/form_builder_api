class Api::V1::FormsController < ApplicationController
    before_action :authenticate_request, except: :show

    def index
        @forms = @user.forms
        render json: @forms.to_json(:except => [:components])
    end

    def show
        @form = Form.find(params[:id])
        @user = find_user
        
        if !@user.nil? && @user.id == @form.user_id
            render json: @form.as_json.merge({ owner: true })
        elsif @form.published
            render json: @form.as_json.merge({ owner: false })
        else
            head :unauthorized
        end
    end

    def create
        @form = Form.new(form_params.merge({ user_id: @user.id }))
        if @form.save
            render json: @form, status: :created
        else
            render json: { errors: @form.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        @form = Form.find(params[:id])
        if @form.update(form_params)
            render json: @form
        else
            render json: @form.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @form = Form.find(params[:id])
        if @form.destroy
            head :no_content
        else
            render @form.errors, status: :unprocessable_entity
        end
    end

    private
    def form_params
        params.require(:form).permit(
            :name, 
            :title, 
            :description,
            :published,
            components: [ 
                :id, 
                :name, 
                :required, 
                :helper, 
                :placeholder, 
                :type, 
                :min_value, 
                :max_value, 
                choices: [ 
                    :id, 
                    :name 
                ] 
            ]
        )
    end
end
