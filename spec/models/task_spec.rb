require 'rails_helper'

RSpec.describe Task, :type => :model do
  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:area) }
    it { should belong_to(:project) }
  end
end
