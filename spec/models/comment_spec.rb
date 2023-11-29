require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, author: user) }

  describe '#update_comments_counter' do
    it 'updates the comments_counter after saving a comment' do
      comment = create(:comment, user: user, post: post)

      post.reload
      expect(post.comments_counter).to eq(1), "Expected comments_counter to be 1, but got #{post.comments_counter}"
    end
  end
end
