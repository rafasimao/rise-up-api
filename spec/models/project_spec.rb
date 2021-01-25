require 'rails_helper'

RSpec.describe Project, :type => :model do
  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:progress) }
    it { should belong_to(:area) }
    it { should belong_to(:parent_project) }
    it { should have_many(:sub_projects) }
    it { should have_many(:tasks) }
  end
end
