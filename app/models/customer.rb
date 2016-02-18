class Customer < ActiveRecord::Base
  validates :email, presence: true, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/, message: "email format not valid" }

  validates :first_name, presence: true
  validates :last_name, presence: true
end
