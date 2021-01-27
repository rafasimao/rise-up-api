class Area < ApplicationRecord
  include Progressable
  
  belongs_to :user
  belongs_to :progress, optional: true
  belongs_to :parent_area, class_name: 'Area', optional: true
  has_many :sub_areas, class_name: 'Area', foreign_key: 'parent_area_id'
  has_many :projects
  has_many :tasks

  default_scope { includes(:progress) }
end
