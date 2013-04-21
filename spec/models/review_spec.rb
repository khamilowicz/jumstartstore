require "rspec/autorun"
require_relative "../../app/models/review"

describe "Review" do

  subject{Review.new}
  

  it "has title" do
    subject.title = "Review title"
    subject.title.should == "Review title"
  end

  it "has body" do
    subject.body = "I liked it very much"
    subject.body.should =="I liked it very much"
  end

  it "has note" do
   subject.note = 5
   subject.note.should == 5
 end

 it "note should be number from 1 to 5" do
   subject.note = 0
   subject.should_not be_valid
   subject.note = 6
   subject.should_not be_valid
   subject.note = 1
   subject.should be_valid
 end


 it "has name of the reviewer" do
  user = double("User")
  user.stub(:display_name).and_return("John Smith")
  subject.user = user
  subject.reviewer_name.should == "John Smith"
end
end