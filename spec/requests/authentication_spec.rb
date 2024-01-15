require 'rails_helper'

RSpec.describe "Authentications", type: :request do
  describe "POST /login" do
    let!(:my_user) { FactoryBot.create(:user) }
    
    context 'with the username' do
      before do
        post '/api/v1/auth/login', params: { username: my_user.username, password: my_user.password }
      end
  
      it 'returns the email' do
        expect(JSON.parse(response.body)['email']).to eq(my_user.email)
      end
  
      it 'returns the username' do
        expect(JSON.parse(response.body)['username']).to eq(my_user.username)
      end
  
      it 'returns the id' do
        expect(JSON.parse(response.body)['id']).to eq(my_user.id)
      end
  
      it 'returns a token' do
        expect(JSON.parse(response.body)).to have_key('token')
      end
  
      it 'returns http ok status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with the email' do 
      before do
        post '/api/v1/auth/login', params: { email: my_user.email, password: my_user.password }
      end
  
      it 'returns the email' do
        expect(JSON.parse(response.body)['email']).to eq(my_user.email)
      end
  
      it 'returns the username' do
        expect(JSON.parse(response.body)['username']).to eq(my_user.username)
      end
  
      it 'returns the id' do
        expect(JSON.parse(response.body)['id']).to eq(my_user.id)
      end
  
      it 'returns a token' do
        expect(JSON.parse(response.body)).to have_key('token')
      end
  
      it 'returns http ok status' do
        expect(response).to have_http_status(:ok)
      end
    end
    
    context 'with both the email and username' do
      before do
        post '/api/v1/auth/login', params: { email: my_user.email, username: my_user.username, password: my_user.password }
      end
  
      it 'returns the email' do
        expect(JSON.parse(response.body)['email']).to eq(my_user.email)
      end
  
      it 'returns the username' do
        expect(JSON.parse(response.body)['username']).to eq(my_user.username)
      end
  
      it 'returns the id' do
        expect(JSON.parse(response.body)['id']).to eq(my_user.id)
      end
  
      it 'returns a token' do
        expect(JSON.parse(response.body)).to have_key('token')
      end
  
      it 'returns http ok status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'without a username or email' do
      before do
        post '/api/v1/auth/login', params: { password: my_user.password }
      end

      it 'returns http not found status' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'with the wrong password' do
      before do
        post '/api/v1/auth/login', params: { email: my_user.email, username: my_user.username, password: "" }
      end

      it 'returns http unauthorized status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "POST /refresh-token" do
    let!(:my_user) { FactoryBot.create(:user) }
      context 'with a valid token' do
        let!(:token) { JWT.encode({ :user_id => my_user.id, :expiration => 5.days.from_now.to_i }, Rails.application.secret_key_base) }
        before do
          post '/api/v1/auth/refresh-token', params: { }, headers: { :Authorization => "bearer #{token}" }
        end

        it 'returns a new token' do
          expect(JSON.parse(response.body)['token']).to_not eq(token)
        end

        it 'returns a token with a later expiration date' do
          new_token = JSON.parse(response.body)['token']
          decoded_new_token = JWT.decode(new_token, Rails.application.secret_key_base)
          decoded_old_token = JWT.decode(token, Rails.application.secret_key_base)
          expect(decoded_old_token[0]['expiration'] < decoded_new_token[0]['expiration']).to be true
        end
      end

      context 'with an expired token' do
        let!(:token) { JWT.encode({ :user_id => my_user.id, :expiration => 2.days.ago.to_i }, Rails.application.secret_key_base) }
        before do
          post '/api/v1/auth/refresh-token', params: { }, headers: { :Authorization => "bearer #{token}" }
        end

        it 'returns http unauthorized status' do
          expect(response).to have_http_status(:unauthorized)
        end
      end

      context 'with a fake token' do
        before do
          post '/api/v1/auth/refresh-token', params: { }, headers: { :Authorization => "bearer notatoken" }
        end

        it 'returns http unauthorized status' do
          expect(response).to have_http_status(:unauthorized)
        end
      end

      context 'with no token' do
        before do
          post '/api/v1/auth/refresh-token'
        end

        it 'returns http unauthorized status' do
          expect(response).to have_http_status(:unauthorized)
        end
      end
  end
end
