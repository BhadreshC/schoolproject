class Principle < ApplicationRecord
  belongs_to :school #success
#----------------------try------------------

#----------------------try------------------

 	has_secure_password
  validates :username,
            presence: true
  validates_uniqueness_of :username
  validates :email,
            presence: true,
            uniqueness: true,
            format: {
              with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
            }
end
