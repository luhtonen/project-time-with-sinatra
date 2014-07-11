require_relative 'project'

class User
  include DataMapper::Resource
  include BCrypt

  property :id, Serial, :key => true
  property :username, String, :required => true, :length => 3..50, :unique => true
  property :password, BCryptHash, :required => true
  property :name, String, :required => true
  property :email, String, :required => true
  property :active, Boolean
  property :createdAt, DateTime, :default => lambda{ |p,s| DateTime.now}
  property :updatedAt, DateTime

  has n, :projects

  def authenticate(attempted_password)
    if self.password == attempted_password
      true
    else
      false
    end
  end
end