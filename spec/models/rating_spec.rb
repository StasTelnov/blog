require 'rails_helper'

RSpec.describe Rating, type: :model do
  describe 'ActiveRecord associations' do
    it { should belong_to(:article) }
  end
end
