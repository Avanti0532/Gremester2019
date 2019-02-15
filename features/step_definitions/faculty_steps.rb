def create_faculty
  @faculty ||= {username: 'James', first_name: 'James', last_name: 'Brown', email: 'jamesbrown@uiowa.edu',
                password: 'james1234', password_confirmation: 'james1234', weblink: 'http://homepage.cs.uiowa.edu/~alicem/'}
end

def create_another_faculty
  @faculty ||= {username: 'Mike', first_name: 'Mike', last_name: 'Day', email: 'mikeday@uiowa.edu',
                password: 'mike1234', password_confirmation: 'mike1234', weblink: 'http://homepage.cs.uiowa.edu/~mike/'}
end

def sign_up_faculty
  visit '/faculties/sign_up'
  page.attach_file "faculty[id_card_data]", Rails.root + 'public/favicon.ico'
  fill_data
end

def fill_data
  fill_in 'faculty_username', with: @faculty[:username]
  fill_in 'faculty_first_name', with: @faculty[:first_name]
  fill_in 'faculty_last_name', with: @faculty[:last_name]
  fill_in 'faculty_email', with: @faculty[:email]
  fill_in 'faculty_password', with: @faculty[:password]
  fill_in 'faculty_password_confirmation', with: @faculty[:password_confirmation]
  fill_in 'faculty_weblink', with: @faculty[:weblink]
  click_button 'Sign up'
end

When /^I sign up with valid faculties details/ do
  create_faculty
  sign_up_faculty
end

When /^I sign up with blank (.*?) as a faculty$/ do |field|
  create_faculty
  case field
  when 'user name'
    @faculty = @faculty.merge(username: '')
  when 'first name'
    @faculty = @faculty.merge(first_name: '')
  when 'last name'
    @faculty = @faculty.merge(last_name: '')
  when 'password'
    @faculty = @faculty.merge(password: '')
  when 'email'
    @faculty = @faculty.merge(email: '')
  end
  sign_up_faculty
end

When /^I sign up with an email that doesn't end with edu/ do
  create_faculty
  @faculty = @faculty.merge(email: 'jamesbrown@gmail.com')
  sign_up_faculty
end

When /^I sign up without id card and faculty web page link/ do
  create_faculty
  @faculty = @faculty.merge(weblink: '')
  visit '/faculties/sign_up'
  fill_data
end

When /^I sign up with both id card and faculty web page link/ do
  create_faculty
  sign_up_faculty
end

When /^I sign up with id card keeping faculty web page link blank/ do
  create_faculty
  @faculty = @faculty.merge(weblink: '')
  sign_up_faculty
end

When /^I sign up with faculty web page link keeping id card blank/ do
  create_faculty
  visit '/faculties/sign_up'
  fill_data
end

When /^I sign up with invalid password as a (.*?)/ do |field|
  if field == 'faculty'
    create_faculty
    @faculty = @faculty.merge(password: 'james12')
    @faculty = @faculty.merge(password_confirmation: 'james12')
    sign_up_faculty
  else
    create_student
    @student = @student.merge(password: 'lily12')
    @student = @student.merge(password_confirmation: 'lily12')
    sign_up
  end
end

When /^I sign up with duplicate (.*?) as a faculty$/ do |field|
  create_faculty
  Faculty.create(@faculty)
  create_another_faculty
  case field
  when 'username'
    @faculty = @faculty.merge(username: 'James')
  when 'email'
    @faculty = @faculty.merge(email: 'jamesbrown@uiowa.edu')
  end
  sign_up_faculty
end

Then /^I should see an error for faculty authentication/ do
  page.should have_content 'Either id card or link to faculty is required'
end

Then /^I should see an email error message/ do
  page.should have_content 'Please provide an university email'
end

Then /^I should see a message saying my account is pending for admin approval/ do
  page.should have_content 'You have signed up successfully but your account has not been approved by your administrator yet'
end

Then /^I should see an invalid password message/ do
  page.should have_content 'Password is too short (minimum is 8 characters)'
end


