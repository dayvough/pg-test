
# User attributes:
# -- user_id    : Integer
# -- first_name : String
# -- last_name  : String
# -- email      : String
# -- password   : String
# -- api_key    : String
# -- created_at : DateTime
# -- updated_at : DateTime
# -- version    : Integer

# Email Validator from ActiveRecord docs, called on "email: true"
class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class User < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :email, :password
  validates :email, email: true, uniqueness: true, on: :create
  after_save :init

  def init
    self.user_id = self.id
    self.version = 1
    self.api_key = self.last_name + self.first_name
  end

  # Grabs the current user, creates a duplicate,
  # and increments the duplicated version
  # def update
  # end
end