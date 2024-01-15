require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /index" do
    before do
      FactoryBot.create_list(:user, 10)
      get '/api/v1/users'
    end

    it 'returns all users' do
      expect(JSON.parse(response.body).size).to eq(10)
    end

    it 'returns http ok status' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /show" do
    let!(:my_user) { FactoryBot.create(:user) }

    before do
      get "/api/v1/users/#{my_user.id}"
    end

    it 'returns the username' do
      expect(JSON.parse(response.body)['username']).to eq(my_user.username)
    end

    it 'returns the email' do
      expect(JSON.parse(response.body)['email']).to eq(my_user.email)
    end

    it 'does not return the password' do
      expect(JSON.parse(response.body)).to_not have_key('password_digest')
      expect(JSON.parse(response.body)).to_not have_key('password')
    end

    it 'returns http ok status' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    let!(:my_user) { FactoryBot.build(:user) }
    
    before do
      post "/api/v1/users", params: { user: { username: my_user.username, email: my_user.email, password: my_user.password } }
    end

    it 'returns the username' do
      expect(JSON.parse(response.body)['username']).to eq(my_user.username)
    end

    it 'returns the email' do
      expect(JSON.parse(response.body)['email']).to eq(my_user.email)
    end

    it 'returns a token' do
      expect(JSON.parse(response.body)).to have_key('token')
    end

    it 'does not return the password' do
      expect(JSON.parse(response.body)).to_not have_key('password_digest')
      expect(JSON.parse(response.body)).to_not have_key('password')
    end

    it 'returns http created status' do
      expect(response).to have_http_status(:created)
    end
  end

  describe "PATCH /update" do
    let!(:my_user) { FactoryBot.create(:user) }
    let!(:new_user) { FactoryBot.build(:user) }
    
    context "with the correct password" do
      before do
        patch "/api/v1/users/#{my_user.id}", params: { user: { username: new_user.username, email: new_user.email, password: new_user.password }, password_challenge: my_user.password }
      end
  
      it 'returns the username' do
        expect(JSON.parse(response.body)['username']).to eq(new_user.username)
      end
  
      it 'returns the email' do
        expect(JSON.parse(response.body)['email']).to eq(new_user.email)
      end
  
      it 'does not return the password' do
        expect(JSON.parse(response.body)).to_not have_key('password_digest')
        expect(JSON.parse(response.body)).to_not have_key('password')
      end

      it 'changes the password' do
        expect(User.find(my_user.id).authenticate(new_user.password)).to_not be false
      end
  
      it 'returns http ok status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context "with the wrong password" do
      before do
        patch "/api/v1/users/#{my_user.id}", params: { user: { username: new_user.username, email: new_user.email, password: new_user.password }, password_challenge: new_user.password }
      end
  
      it 'returns http unauthorized status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE /delete" do
    let!(:my_user) { FactoryBot.create(:user) }
    
    context "with the correct password" do
      before do
        delete "/api/v1/users/#{my_user.id}", params: { password_challenge: my_user.password} 
      end

      it 'deletes the user' do
        expect { User.find(my_user.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'returns http no content status' do
        expect(response).to have_http_status(:no_content)
      end
    end
    
    context "with the wrong password" do
      before do
        delete "/api/v1/users/#{my_user.id}", params: { password_challenge: ""} 
      end

      it 'does not delete the user' do
        expect(User.find(my_user.id)).to be_present
      end

      it 'returns http unauthorized status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
