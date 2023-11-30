require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, author: user) }

  describe '#update_likes_counter' do
    it 'updates the likes_counter after saving a like' do
      create(:like, user: user, post: post)

      expect(post.reload.likes_counter).to eq(1)
    end
  end
end
