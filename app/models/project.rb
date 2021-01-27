class Project < ApplicationRecord
  belongs_to :user
  belongs_to :progress, optional: true
  belongs_to :area, optional: true
  belongs_to :parent_project, class_name: 'Project', optional: true
  has_many :sub_projects, class_name: 'Project', foreign_key: 'parent_project_id'
  has_many :tasks

  default_scope { includes(:progress) }
end
