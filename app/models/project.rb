class Project < ApplicationRecord
    belongs_to :user
    has_many :artifacts

    validates :name, presence: true, length: { minimum: 1 }
    validates :path, presence: true, length: { minimum: 2 }
    validates :user, presence: true
end
