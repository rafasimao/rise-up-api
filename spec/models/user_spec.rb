require 'rails_helper'

RSpec.describe User, :type => :model do
  describe "Associations" do
    it { should have_many(:areas) }
    it { should have_many(:projects) }
    it { should have_many(:tasks) }
  end
end
