require_relative 'user'
require_relative 'project'

class Dayentry
  include DataMapper::Resource

  property :id, Serial
  property :date, Date, :required => true
  property :hours, Numeric
  property :days, Numeric
  property :description, String

  belongs_to :user, key => true
  belongs_to :project, key => true
end