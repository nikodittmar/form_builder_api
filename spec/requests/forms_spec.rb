require 'rails_helper'

RSpec.describe "Forms", type: :request do
  describe "GET /index" do
    let!(:my_user) { FactoryBot.create(:user) }

    context "with authorization" do
      before do
        FactoryBot.create_list(:form, 10, user: my_user)
        get '/api/v1/forms', headers: { :Authorization => "bearer #{my_user.token}" }
      end

      it 'returns all the forms' do
        expect(JSON.parse(response.body).size).to eq(10)
      end

      it 'returns http ok status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context "without authorization" do
      before do
        FactoryBot.create_list(:form, 10, user: my_user)
        get '/api/v1/forms'
      end

      it 'returns http unauthorized status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "GET /show" do
    let!(:my_user) { FactoryBot.create(:user) }
    let!(:my_form) { FactoryBot.create(:form, user: my_user) }

    context "with valid parameters" do
      before do
        get "/api/v1/forms/#{my_form.id}", headers: { :Authorization => "bearer #{my_user.token}" }
      end
  
      it 'returns the name' do
        expect(JSON.parse(response.body)['name']).to eq(my_form.name)
      end
  
      it 'returns http ok status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context "without authorization" do
      before do
        get "/api/v1/forms/#{my_form.id}"
      end

      it 'returns http unauthorized status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "POST /create" do
    let!(:my_user) { FactoryBot.create(:user) }
    let!(:my_form) { FactoryBot.build(:form) }

    context "with valid parameters" do
      before do
        post "/api/v1/forms", params: { form: { name: my_form.name } }, headers: { :Authorization => "bearer #{my_user.token}" }
      end
  
      it 'returns the name' do
        expect(JSON.parse(response.body)['name']).to eq(my_form.name)
      end
  
      it 'is accociated with the user' do
        expect(my_user.forms.length).to eq(1)
        expect(JSON.parse(response.body)['id']).to eq(my_user.forms[0].id)
      end
  
      it 'returns http created status' do
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      before do
        post "/api/v1/forms", params: { form: { name: nil } }, headers: { :Authorization => "bearer #{my_user.token}" }
      end
  
      it 'returns http unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
    
    context "without authorization" do
      before do
        post "/api/v1/forms", params: { form: { name: my_form.name } }
      end
  
      it 'returns http unauthorized status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "PATCH /update" do
    let!(:my_user) { FactoryBot.create(:user) }
    let!(:my_form) { FactoryBot.create(:form, user: my_user) }
    let!(:new_form) { FactoryBot.build(:form, user: my_user) }

    context "with valid parameters" do
      before do
        patch "/api/v1/forms/#{my_form.id}", params: { form: { name: new_form.name } }, headers: { :Authorization => "bearer #{my_user.token}" }
      end

      it 'returns the name' do
        expect(JSON.parse(response.body)['name']).to eq(new_form.name)
      end

      it 'returns http ok status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid parameters" do
      before do
        patch "/api/v1/forms/#{my_form.id}", params: { form: { name: "" } }, headers: { :Authorization => "bearer #{my_user.token}" }
      end

      it 'returns http unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "without authorization" do
      before do
        patch "/api/v1/forms/#{my_form.id}", params: { form: { name: new_form.name } }
      end

      it 'returns http unauthorized status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DESTROY /delete" do
    let!(:my_user) { FactoryBot.create(:user) }
    let!(:my_form) { FactoryBot.create(:form, user: my_user) }

    context "with authorization" do
      before do
        delete "/api/v1/forms/#{my_form.id}", headers: { :Authorization => "bearer #{my_user.token}" }
      end

      it 'deletes the form' do
        expect { Form.find(my_form.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'returns http no content status' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context "without authorization" do
      before do
        delete "/api/v1/forms/#{my_form.id}"
      end

      it 'returns http unauthorized status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

end
