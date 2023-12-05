require 'rails_helper'

RSpec.describe UserController, type: :request do
  describe 'GET #index' do
    let(:user) { create(:user) }

    it 'returns a successful response' do
      get '/'
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get '/'
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get '/'
      expect(response.body).to match('Number of posts')
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user, name: 'Assem Zhorabay') }

    it 'returns a successful response' do
      get '/users/:id'
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get '/users/:id'
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get '/users/:id'
      expect(response.body).to match('Bio')
    end
  end
end
