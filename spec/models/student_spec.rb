require 'rails_helper'

RSpec.describe Student, type: :model do
  it { should have_one(:profile) }
  it 'valid user' do
    student = Student.new(first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'test12345', username: 'test')
    assert student.valid?
  end

  it 'invalid without email' do
    student = Student.new(first_name: 'John', last_name: 'Doe', password: 'test12345', username: 'test')
    refute student.valid?
  end

  it 'invalid without password' do
    student = Student.new(first_name: 'John', last_name: 'Doe', username: 'test')
    refute student.valid?
  end

  it 'invalid without first name' do
    student = Student.new(last_name: 'Doe', email: 'john@example.com', password: 'test12345', username: 'test')
    refute student.valid?
  end

  it 'invalid without last name' do
    student = Student.new(first_name: 'Doe', email: 'john@example.com', password: 'test12345', username: 'test')
    refute student.valid?
  end

  it "should have a unique name" do
    Student.create!(first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'test12345', username: 'test')
    mock_student = Student.new(first_name: 'Pond', last_name: 'Test', email: 'pond@example.com', password: 'test12345', username: 'test')
    mock_student.should_not be_valid
    mock_student.errors[:username].should include("has already been taken")
  end

  it "should return profile of the student" do
    student = Student.new(id: 1, first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'test12345', username: 'test')
    mock_profile = Profile.new(gre_quant: 150, gre_verbal: 130, gre_writing: 3.0, toefl: 100, interested_term: 'fall', interested_year: 2019)
    student.profile = mock_profile
    assert(student.current_profile.student_id).eql?(1)
    assert(student.current_profile.gre_verbal).eql?(mock_profile.gre_verbal)
    assert(student.current_profile.toefl).eql?(mock_profile.toefl)
    assert(student.current_profile.interested_term).eql?(mock_profile.interested_term)
    assert(student.current_profile.interested_year).eql?(mock_profile.interested_year)
  end

end
