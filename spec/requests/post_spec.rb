require 'rails_helper'

RSpec.describe PostController, type: :request do
  describe 'GET #index' do
    it 'returns a successful response' do
      get '/users/:user_id/posts'
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get '/users/:user_id/posts'
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get '/users/:user_id/posts'
      expect(response.body).to match('Post 1')
    end
  end

  describe 'GET #show' do
    let(:post) { create(:post, title: 'Post 1') }

    it 'returns a successful response' do
      get '/users/:user_id/posts/:id'
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get '/users/:user_id/posts/:id'
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get '/users/:user_id/posts/:id'
      expect(response.body).to match('Post 1')
    end
  end
end
