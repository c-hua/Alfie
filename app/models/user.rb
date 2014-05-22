require "bcrypt"
class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :email, type: String
  field :password_digest, type: String
  field :zipcode, type: Integer
  field :level, type: Integer, default: 0
  field :points, type: Integer, default: 5000


  #field :image, type: Image

  def password
    @password
  end

  def password=(new_password)
    @password = new_password
    self.password_digest = BCrypt::Password.create(new_password)
  end

  def authenticate(test_password)
    if BCrypt::Password.new(self.password_digest) == test_password
      self
    else
      false
    end
  end


  embeds_many :tasks

  def tally_points
    self.tasks.each do |task|
      if task.deadline > Time.now && task.already_tallied == false
        point_change = 0
        if task.is_completed && task.already_tallied == false
          if task.priority == 1
            point_change = 1000
          elsif task.priority == 2
            point_change = 700
          elsif task.priority == 3
            point_change = 500
          # task.is_completed.push
        else
          point_change = -700        
        end
        # task already tallied
        task.already_tallied = true
        self.points += point_change
        task.update(points: point_change)
        task.user.save
      end
    end

    self.save
  end 


  def level_up
    self.points.each do |point|
      if points == 3000
          self.level += 1 && self.points = 0
        end
      end

  # def priority_points
  #   self.priority.each do |p|
  #     if p = 1
    







  end
end
end
