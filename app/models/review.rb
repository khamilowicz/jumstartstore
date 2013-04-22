require 'active_model'

class Review 
  include ActiveModel::Validations

  attr_accessor :title, :body, :note, :user

  validates :note, inclusion: {in: (1..5)}

  def initialize attributes={}
    @title = attributes[:title]
    @body = attributes[:body]
    @note = attributes[:note]
    @user = attributes[:user]
  end

  def reviewer_name
    user.display_name
  end
end