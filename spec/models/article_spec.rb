require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'ActiveRecord associations' do
    it { should have_many(:ratings).dependent(:destroy) }
    it { should belong_to(:user) }
  end
end
