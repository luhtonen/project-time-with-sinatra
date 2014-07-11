class Project
  include DataMapper::Resource

  property :id, Serial
  property :title, String, :required => true
  property :number, String
  property :location, String
  property :position, String
  property :mandays, Numeric
  property :approver, String
  property :active, Boolean
  property :startdate, Date
  property :enddate, Date

  belongs_to :user, key => true
end