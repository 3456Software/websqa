class Project < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 50 }
end
