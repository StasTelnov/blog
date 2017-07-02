require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ActiveRecord associations' do
    it { should have_many(:articles).dependent(:destroy) }
  end
end
