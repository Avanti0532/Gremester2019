
def create_admin
  @admin ||= {email: 'linh@gmail.com', password: '12345689'}
end

def create_new_admin
  @new_admin = {email: 'admin@gmail.com', password: '12345689', first_name: 'admin', last_name: 'admin', password_confirmation: '12345689'}
end

def log_in_admin
  visit new_admin_session_path
  fill_in 'Email', with: @admin[:email]
  fill_in 'Password', with: @admin[:password]
  click_button 'Log in'
end

Given(/the following (.*?) have been added to (.*?) Database:/) do |user, table_name, user_table|
  case table_name
  when 'Admin'
    user_table.hashes.each do |admin|
      Admin.create(admin)
    end
  when 'Faculty'
    user_table.hashes.each do |faculty|
      Faculty.create(faculty)
    end
  when 'Student'
    user_table.hashes.each do |student|
      Student.create(student)
    end
  when 'University'
    user_table.hashes.each do |university|
      University.create(university)
    end
  when 'Profile'
    user_table.hashes.each do |profile|
      Profile.create(profile)
    end
  when 'Country'
    user_table.hashes.each do |country|
      Country.create(country)
    end
  when 'Application'
    user_table.hashes.each do |application|
      Application.create(application)
    end
  when 'UndergradUniversity'
    user_table.hashes.each do |university|
      UndergradUniversity.create(university)
    end
  when 'GradingScaleType'
    user_table.hashes.each do |grading|
      GradingScaleType.create(grading)
    end
  when 'ResearchInterest'
    user_table.hashes.each do |interest|
      ResearchInterest.create(interest)
    end
  when 'RankType'
    user_table.hashes.each do |rank_type|
      RankType.create(rank_type)
    end
  when 'ResearchInterestsProfile'
    user_table.hashes.each do |research_interests_profile|
      ResearchInterestsProfile.create(research_interests_profile)
    end
  when 'ProfilesUndergradUniversity'
    user_table.hashes.each do |profiles_undergrad_university|
      ProfilesUndergradUniversity.create(profiles_undergrad_university)
    end
  when 'Messageboards'
    user_table.hashes.each do |message_board|
      ThreddedMessageboard.create(message_board)
    end
  when 'Topics'
    user_table.hashes.each do |topic|
      ThreddedTopic.create(topic)
    end
  when 'Posts'
    user_table.hashes.each do |post|
      ThreddedPost.create(post)
    end
  when 'FacultyEvaluation'
    user_table.hashes.each do |faculty_evaluation|
      FacultyEvaluation.create(faculty_evaluation)
    end
  end
end


When(/^I log in as an admin/) do
  create_admin
  log_in_admin
end

Then(/^administrator can log in to verify faculty/) do
  create_admin
  log_in_admin
end

Then(/^I can approve the faculty/) do
  click_on('Faculties', :match => :first)
  click_on('Approve faculty', :match => :first)
end

Then(/^I can see successful approval message/) do
  page.should have_content 'You have approved the faculty titled'
end

Then(/^I will see message saying that I logged in to the system/) do
  page.should have_content 'You are logged in'
end

Then(/^I will receive message saying I'm already logged in if I attempt to go to (.*?) or (.*?) login page/) do |user1, user2|
  if user1.eql?("faculty") or user2.eql?("faculty")
    visit new_faculty_session_path
    page.should have_content 'You are logged in'
    page.should_not have_content 'Log in'
  end
  if user1.eql?("student") or user2.eql?("student")
    visit new_student_session_path
    page.should have_content 'You are logged in'
    page.should_not have_content 'Log in'
  end
  if user1.eql?("admin") or user2.eql?("admin")
    visit new_admin_session_path
    page.should have_content 'You are logged in'
    page.should_not have_content 'Log in'
  end
end


Then(/^I will receive message saying I'm already logged in if I attempt to go to (.*?) or (.*?) signup page/) do |user1, user2|
  if user1.eql?("faculty") or user2.eql?("faculty")
    visit new_faculty_registration_path
    page.should have_content 'You are logged in'
    page.should_not have_content 'Log in'
  end
  if user1.eql?("student") or user2.eql?("student")
    visit new_student_registration_path
    page.should have_content 'You are logged in'
    page.should_not have_content 'Log in'
  end
  if user1.eql?("admin") or user2.eql?("admin")
    visit new_admin_registration_path
    page.should have_content 'You are logged in'
    page.should_not have_content 'Log in'
  end
end


Then(/^I can see all (.*?) in the database$/) do |field|
  visit '/admin/dashboard'
  if field == "faculties"
    find('tr', text: 'Faculties').click_link 'Faculties'
    Faculty.all.each do |faculty|
      page.should have_content faculty.email
    end
  elsif field == "students"
    find('tr', text: 'Students').click_link 'Students'
    Student.all.each do |student|
      page.should have_content student.email
    end
  elsif field == "admins"
    find('tr', text: 'Admins').click_link 'Admins'
    Admin.all.each do |admin|
      page.should have_content admin.email
    end
  elsif field == "universities"
    find('tr', text: 'Universities').click_link 'Universities'
    University.all.each do |university|
      page.should have_content university.university_name
    end
  elsif field == "profiles"
    find('tr', text: 'Profiles').click_link 'Profiles'
    Profile.all.each do |profile|
      page.should have_content profile.student_id
    end
  end
end

Then(/^I cannot edit any student or faculty information$/) do
  visit '/admin/dashboard'
  find('tr', text: 'Faculties').click_link 'Faculties'
  expect(page).to have_no_link('Edit')
  visit '/admin/dashboard'
  find('tr', text: 'Students').click_link 'Students'
  expect(page).to have_no_link('Edit')
end

Then(/^I cannot add any profile in the database$/) do
  visit '/admin/dashboard'
  find('tr', text: 'Profiles').click_link 'Profiles'
  expect(page).to have_no_link('Add new')
end

Then(/^I can approve faculty credential$/) do
  visit '/admin/dashboard'
  find('tr', text: 'Faculties').click_link 'Faculties'
  expect(page).to have_link('Approve faculty')
  # page.should have_content "hehe"
  find('tr', text: 'alicen@uiowa.edu').click_link 'Show'
  expect(page).to have_link('Approve faculty')
  click_link 'Approve faculty'
  @current_faculty = Faculty.find_by_email('alicen@uiowa.edu')
  expect(@current_faculty.approved).to eq true
  expect(page).to have_content('You have approved the faculty titled: Alice')
end

Then(/^I cannot add new faculty or student$/) do
  visit '/admin/dashboard'
  find('tr', text: 'Faculties').click_link 'Faculties'
  expect(page).to have_no_link('Add new')
  visit '/admin/dashboard'
  find('tr', text: 'Students').click_link 'Students'
  expect(page).to have_no_link('Add new')
end

Then(/^I should be directed to the admin site$/) do
  expect(current_path).to eq rails_admin_path
end

Then(/^I can create account for another admin$/) do
  admin_count = Admin.count
  visit '/admin/dashboard'
  find('tr', text: 'Admins').click_link 'Admins'
  expect(page).to have_link('Add new')
  click_link 'Add new'
  create_new_admin
  fill_in 'Email', with: @new_admin[:email]
  fill_in 'Password', with: @new_admin[:password]
  fill_in 'Password confirmation', with: @new_admin[:password]
  fill_in 'First name', with: @new_admin[:first_name]
  fill_in 'Last name', with: @new_admin[:last_name]
  click_button 'Save'
  expect(Admin.count).to eq(admin_count + 1)
end

Then(/^I cannot export (.*?) information$/) do |field|
  visit '/admin/dashboard'
  if field.eql?('student')
    find('tr', text: 'Students').click_link 'Students'
    expect(page).to have_no_link('Export')
  elsif field.eql?('faculty')
    find('tr', text: 'Faculties').click_link 'Faculties'
    expect(page).to have_no_link('Export')
  elsif field.eql?('university')
    find('tr', text: 'Universities').click_link 'Universities'
    expect(page).to have_no_link('Export')
  elsif field.eql?('profile')
    find('tr', text: 'Profiles').click_link 'Profiles'
    expect(page).to have_no_link('Export')
  end
end

Then(/^I can open weblink to validate faculty's credential$/) do
  visit '/admin/dashboard'
  find('tr', text: 'Faculties').click_link 'Faculties'
  expect(page).to have_content('http://homepage.cs.uiowa.edu/~alicem/')
end

Then(/^I will go to homepage of Gremester if I click on Home button on the navigation bar$/) do
  visit '/admin/dashboard'
  click_link 'Home'
  expect(current_path).to eq(root_path)
end

And(/^I got redirected to homepage$/) do
  expect(current_path).to eq(root_path)
end

And(/^I click on log out as an admin$/) do
  click_link 'Log out'
end

Then(/^I cannot edit any profile in the database$/) do
  visit '/admin/dashboard'
  find('tr', text: 'Profiles').click_link 'Profiles'
  expect(page).to have_no_link('Edit')
end

Then(/^I cannot delete profile information$/) do
  visit '/admin/dashboard'
  find('tr', text: 'Profiles').click_link 'Profiles'
  expect(page).to have_no_link('Delete')
end
