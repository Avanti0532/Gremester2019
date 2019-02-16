require 'rails_helper'

RSpec.describe Student, type: :model do
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
end

