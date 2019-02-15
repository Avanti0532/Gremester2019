def create_student
  @student ||= {username: 'Lily', first_name: 'Lily', last_name: 'Brown', email: 'lilybrown@gmail.com',
             password: 'lily1234', password_confirmation: 'lily1234'}
end

def create_another_student
  @student ||= {username: 'Mike', first_name: 'Mike', last_name: 'Gordan', email: 'mike@gmail.com',
                password: 'mike1234', password_confirmation: 'mike1234'}
end

def sign_up
  visit '/students/sign_up'
  fill_in 'student_username', with: @student[:username]
  fill_in 'student_first_name', with: @student[:first_name]
  fill_in 'student_last_name', with: @student[:last_name]
  fill_in 'student_email', with: @student[:email]
  fill_in 'student_password', with: @student[:password]
  fill_in 'student_password_confirmation', with: @student[:password_confirmation]
  click_button 'Sign up'
end

Given /^I am on homepage of Gremester/ do
  visit root_path
end

When /^I sign up with valid student details/ do
  create_student
  sign_up
end

Then /^I should get a message saying confirmation email has been sent/ do
  page.should have_content 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'
end

When /^I sign up with blank (.*?) as a student$/ do |field|
  create_student
  case field
  when 'user name'
    @student = @student.merge(username: '')
  when 'first name'
    @student = @student.merge(first_name: '')
  when 'last name'
    @student = @student.merge(last_name: '')
  when 'password'
    @student = @student.merge(password: '')
  when 'email'
    @student = @student.merge(email: '')
  end
  sign_up
end

When /^I sign up with duplicate (.*?) as a student$/ do |field|
  create_student
  Student.create(@student)
  create_another_student
  case field
  when 'username'
    @student = @student.merge(username: 'Lily')
  when 'email'
    @student = @student.merge(email: 'lilybrown@gmail.com')
  end

  sign_up
end

Then /^I should see a blank (.*?) error message$/ do |field|
  case field
  when 'user name'
    page.should have_content "Username can't be blank"
  when 'first name'
    page.should have_content "First name can't be blank"
  when 'last name'
    page.should have_content "Last name can't be blank"
  when 'email'
    page.should have_content "Email can't be blank"
  when 'password'
    page.should have_content "Password can't be blank"
  end
end

Then /^I should see a duplicate (.*?) message$/ do |field|
  case field
  when 'user name'
    page.should have_content "Username has already been taken"
  when 'email'
    page.should have_content "Email has already been taken"
  end
end