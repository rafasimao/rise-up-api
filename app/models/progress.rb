class Progress < ApplicationRecord
  include Progressable
  
  has_one :area
  has_one :project

  enum track_type: { tasks: 'tasks', experience: 'experience' }
end
