class User < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :email, :password
  after_initialize :init, unless: :persisted?

  def init
    self.user_id    = self.id
    self.version    = 1
  end

  
end