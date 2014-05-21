class Task
  include Mongoid::Document
  include Mongoid::Timestamps
  

  field :name, type: String
  field :priority, type: Integer
  field :deadline, type: Time
  field :is_completed, type: Mongoid::Boolean
  field :already_tallied, type: Mongoid::Boolean, default: false
  field :points, type:Integer


  # validates_inclusion_of :transmission, in:["auto","manual"]
  # validates :year, numericality: { less_than_or_equal_to: 2014, greater_than_or_equal_to: 1900}na
  # validates_presence_of :name, :model, :year, :price, :transmission, message: "missing a field"

  # field :task_completed, type: Mongoid:: Boolean


  # field :work, type: Mongoid::Boolean
  # field :sleep, type: Mongoid::Boolean
  def time
    deadline
  end

  def time=(value)
    raise value.inspect
    deadline = (Time.new(deadline.year, deadline.month, deadline.day, time.hour, time.minute) + 7.hours)
  end
    
  embedded_in :user
end 
