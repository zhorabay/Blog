require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, author: user) }

  describe '#update_comments_counter' do
    it 'updates the comments_counter after saving a comment' do
      comment = Comment.new(user: user, post: post, content: 'This is a comment.')

      expect { comment.save }.to change { post.comments_counter }.by(1)
    end
  end
end
