class User < ApplicationRecord
  has_many :areas
  has_many :projects
  has_many :tasks
end
