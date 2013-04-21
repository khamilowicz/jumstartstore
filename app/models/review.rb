require 'active_model'

class Review 
  include ActiveModel::Validations

  attr_accessor :title, :body, :note, :user

  validates :note, inclusion: {in: (1..5)}

  def reviewer_name
    user.display_name
  end
end