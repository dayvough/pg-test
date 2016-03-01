class User < ActiveRecord::Base
  validates_presence_of :first_name, :last_name
  after_initialize :init, unless: :persisted?

  def init
    self.password ||= "test"
  end
end