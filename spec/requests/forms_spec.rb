require 'rails_helper'
require 'examples.rb'

RSpec.describe "Forms", type: :request do
  describe "GET /index" do
    let!(:my_user) { FactoryBot.create(:user) }

    context "with authorization" do
      before do
        FactoryBot.create_list(:form, 10, user: my_user)
        get '/api/v1/forms', headers: { :Authorization => "bearer #{my_user.token}" }, as: :json
      end

      it 'returns all the forms' do
        expect(JSON.parse(response.body).size).to eq(10)
      end

      it 'does not return the form components' do
        expect(JSON.parse(response.body)[0]['components']).to eq(nil)
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
    let!(:my_published_form) { FactoryBot.create(:form, user: my_user, published: true) }
    

    context "with authorization" do
      context "as owner" do
        context "published" do
          before do
            get "/api/v1/forms/#{my_published_form.id}", headers: { :Authorization => "bearer #{my_user.token}" }
          end

          it 'returns the name' do
            expect(JSON.parse(response.body)['name']).to eq(my_published_form.name)
          end
    
          it 'returns the title' do
            expect(JSON.parse(response.body)['title']).to eq(my_published_form.title)
          end
    
          it 'returns the description' do
            expect(JSON.parse(response.body)['description']).to eq(my_published_form.description)
          end
    
          it 'returns the components' do
            expect(JSON.parse(response.body)['components']).to eq(my_published_form.components)
          end

          it 'returns true for owner' do
            expect(JSON.parse(response.body)['owner']).to be true
          end

          it 'returns published' do
            expect(JSON.parse(response.body)['published']).to be true
          end
      
          it 'returns http ok status' do
            expect(response).to have_http_status(:ok)
          end
        end

        context "not published" do
          before do
            get "/api/v1/forms/#{my_form.id}", headers: { :Authorization => "bearer #{my_user.token}" }
          end

          it 'returns the name' do
            expect(JSON.parse(response.body)['name']).to eq(my_form.name)
          end
    
          it 'returns the title' do
            expect(JSON.parse(response.body)['title']).to eq(my_form.title)
          end
    
          it 'returns the description' do
            expect(JSON.parse(response.body)['description']).to eq(my_form.description)
          end
    
          it 'returns the components' do
            expect(JSON.parse(response.body)['components']).to eq(my_form.components)
          end

          it 'returns true for owner' do
            expect(JSON.parse(response.body)['owner']).to be true
          end

          it 'returns published' do
            expect(JSON.parse(response.body)['published']).to be false
          end
      
          it 'returns http ok status' do
            expect(response).to have_http_status(:ok)
          end
        end
      end

      context "not as owner" do
        let!(:other_user) { FactoryBot.create(:user) }
        let!(:other_form) { FactoryBot.create(:form, user: other_user) }
        let!(:other_published_form ) { FactoryBot.create(:form, user: other_user, published: true )}

        context "published" do
          before do
            get "/api/v1/forms/#{other_published_form.id}", headers: { :Authorization => "bearer #{my_user.token}" }
          end

          it 'returns the name' do
            expect(JSON.parse(response.body)['name']).to eq(other_published_form.name)
          end
    
          it 'returns the title' do
            expect(JSON.parse(response.body)['title']).to eq(other_published_form.title)
          end
    
          it 'returns the description' do
            expect(JSON.parse(response.body)['description']).to eq(other_published_form.description)
          end
    
          it 'returns the components' do
            expect(JSON.parse(response.body)['components']).to eq(other_published_form.components)
          end

          it 'returns false for owner' do
            expect(JSON.parse(response.body)['owner']).to be false
          end

          it 'returns published' do
            expect(JSON.parse(response.body)['published']).to be true
          end
      
          it 'returns http ok status' do
            expect(response).to have_http_status(:ok)
          end
        end

        context "not published" do
          before do
            get "/api/v1/forms/#{other_form.id}", headers: { :Authorization => "bearer #{my_user.token}" }
          end

          it 'returns http unauthorized status' do
            expect(response).to have_http_status(:unauthorized)
          end
        end
      end
    end

    context "without authorization" do
      context "published" do
        before do
          get "/api/v1/forms/#{my_published_form.id}"
        end

        it 'returns the name' do
          expect(JSON.parse(response.body)['name']).to eq(my_published_form.name)
        end
  
        it 'returns the title' do
          expect(JSON.parse(response.body)['title']).to eq(my_published_form.title)
        end
  
        it 'returns the description' do
          expect(JSON.parse(response.body)['description']).to eq(my_published_form.description)
        end
  
        it 'returns the components' do
          expect(JSON.parse(response.body)['components']).to eq(my_published_form.components)
        end

        it 'returns false for owner' do
          expect(JSON.parse(response.body)['owner']).to be false
        end

        it 'returns published' do
          expect(JSON.parse(response.body)['published']).to be true
        end
    
        it 'returns http ok status' do
          expect(response).to have_http_status(:ok)
        end
      end

      context "not published" do
        before do
          get "/api/v1/forms/#{my_form.id}"
        end

        it 'returns http unauthorized status' do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end

  describe "POST /create" do
    let!(:my_user) { FactoryBot.create(:user) }
    let!(:my_form) { FactoryBot.build(:form) }

    context "with valid parameters" do
      before do
        post "/api/v1/forms", params: { form: { name: my_form.name, title: my_form.title, description: my_form.description, components: my_form.components } }, headers: { :Authorization => "bearer #{my_user.token}" }, as: :json
      end
  
      it 'returns the name' do
        expect(JSON.parse(response.body)['name']).to eq(my_form.name)
      end

      it 'returns the title' do
        expect(JSON.parse(response.body)['title']).to eq(my_form.title)
      end

      it 'returns the description' do
        expect(JSON.parse(response.body)['description']).to eq(my_form.description)
      end

      it 'returns the components' do
        expect(JSON.parse(response.body)['components']).to eq(my_form.components)
      end

      it 'returns the default published status' do
        expect(JSON.parse(response.body)['published']).to eq(false)
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
        post "/api/v1/forms", params: { form: { name: my_form.name, title: my_form.title, description: my_form.description, components: INVALID_COMPONENTS } }, headers: { :Authorization => "bearer #{my_user.token}" }, as: :json
      end
  
      it 'returns http unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
    
    context "without authorization" do
      before do
        post "/api/v1/forms", params: { form: { name: my_form.name } }, as: :json
      end
  
      it 'returns http unauthorized status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "PATCH /update" do
    let!(:my_user) { FactoryBot.create(:user) }
    let!(:my_form) { FactoryBot.create(:form, user: my_user) }
    let!(:new_form) { FactoryBot.build(:form, user: my_user, components: VALID_COMPONENTS_ALTERNATE, published: true) }

    context "with valid parameters" do
      before do
        patch "/api/v1/forms/#{my_form.id}", params: { form: { name: new_form.name, title: new_form.title, description: new_form.description, components: new_form.components, published: new_form.published } }, headers: { :Authorization => "bearer #{my_user.token}" }, as: :json
      end

      it 'returns the name' do
        expect(JSON.parse(response.body)['name']).to eq(new_form.name)
      end

      it 'returns the title' do
        expect(JSON.parse(response.body)['title']).to eq(new_form.title)
      end

      it 'returns the description' do
        expect(JSON.parse(response.body)['description']).to eq(new_form.description)
      end

      it 'returns the components' do
        expect(JSON.parse(response.body)['components']).to eq(new_form.components)
      end

      it 'returns the published status' do
        expect(JSON.parse(response.body)['published']).to eq(new_form.published)
      end

      it 'returns http ok status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid parameters" do
      before do
        patch "/api/v1/forms/#{my_form.id}", params: { form: { name: new_form.name, title: new_form.title, description: new_form.description, components: INVALID_COMPONENTS } }, headers: { :Authorization => "bearer #{my_user.token}" }, as: :json
      end
  
      it 'returns http unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "without authorization" do
      before do
        patch "/api/v1/forms/#{my_form.id}", params: { form: { name: new_form.name } }, as: :json
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
