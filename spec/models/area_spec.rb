require 'rails_helper'

RSpec.describe Area, :type => :model do
  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:progress) }
    it { should belong_to(:parent_area) }
    it { should have_many(:sub_areas) }
    it { should have_many(:projects) }
    it { should have_many(:tasks) }
  end
end
