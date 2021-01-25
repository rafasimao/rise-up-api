require 'rails_helper'

RSpec.describe Progress, :type => :model do
  describe "Associations" do
    it { should have_one(:area) }
    it { should have_one(:project) }
  end
end
