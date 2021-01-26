class Progress < ApplicationRecord
  has_one :area
  has_one :project

  enum type: { tasks: 'tasks', experience: 'experience' }
end
