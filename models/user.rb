
# User attributes:
# -- first_name : String
# -- last_name  : String
# -- email      : String
# -- password   : String
# -- api_key    : String
# -- created_at : DateTime
# -- updated_at : DateTime

# Email Validator from ActiveRecord docs, called on "email: true"
class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

# Password specification
PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  (?=.*[[:^alnum:]]) # Must contain a symbol
/x

class User < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :email, :password
  validates :email, email: true, uniqueness: true, on: :create
  validates :password, format: {with: PASSWORD_FORMAT}, on: [:create, :update]

  has_paper_trail
  after_save :init
  
  def init
    self.api_key = self.last_name + self.first_name
  end
end