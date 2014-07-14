require 'data_mapper'
require 'dm-sqlite-adapter'
require 'bcrypt'
require_relative 'user'
require_relative 'project'
require_relative 'dayentry'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/projects.db")
DataMapper.finalize
DataMapper.auto_upgrade!

# Create a test User
if User.count == 0
  @user = User.create(username: "admin")
  @user.password = "admin"
  @user.save
end