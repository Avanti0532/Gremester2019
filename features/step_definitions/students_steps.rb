def create_student
  @student ||= {username: 'Lily', first_name: 'Lily', last_name: 'Brown', email: 'lilybrown@gmail.com',
                password: 'lily1234', password_confirmation: 'lily1234'}
end

def create_another_student
  @student ||= {username: 'Mike', first_name: 'Mike', last_name: 'Gordan', email: 'mike@gmail.com',
                password: 'mike1234', password_confirmation: 'mike1234'}
end

def moderator
  @moderator = {email: "frank@gmail.com", password: '34567890'}
end


def saved_student_data
  @saved_student_data = {email: 'robin@gmail.com', password: '12345678'}
end

def log_in_student
  visit new_student_session_path
  fill_in 'Email', with: @saved_student_data[:email]
  fill_in 'Password', with: @saved_student_data[:password]
  click_button 'Log in'
end


def log_in_moderator
  visit new_student_session_path
  fill_in 'Email', with: @moderator[:email]
  fill_in 'Password', with: @moderator[:password]
  click_button 'Log in'
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

When /^I log in as a student/ do
  saved_student_data
  log_in_student
end

When /^I login as a student moderator/ do
  moderator
  log_in_moderator
end
Then /^I should see a successful login message/ do
  page.should have_content "You are logged in"
end

When /^I log in with wrong (.*?) email/ do |field|
  case field
  when 'student'
    saved_student_data
    @saved_student_data = @saved_student_data.merge(email: 'robindeb@gmail.com')
    log_in_student
  when 'faculty'
    saved_faculty_data
    @save_faculty = @save_faculty.merge(email: 'alice@uiowa.edu')
    log_in_faculty
  when 'admin'
    create_admin
    @admin = @admin.merge(email: 'linh123@gmail.com')
    log_in_admin
  end
end

Then /^I should see an invalid login message/ do
  page.should have_content "Invalid Email or password"
end

When /^I log in with wrong (.*?) password/ do |field|
  case field
  when 'student'
    saved_student_data
    @saved_student_data = @saved_student_data.merge(password: 'robin123450')
    log_in_student
  when 'faculty'
    saved_faculty_data
    @save_faculty = @save_faculty.merge(password: 'alice98705')
    log_in_faculty
  when 'admin'
    create_admin
    @admin = @admin.merge(password: 'linh563782')
    log_in_admin
  end
end

And /^I click on log out as a student/ do
  page.find_link("Log Out", visible: false).click
end

Then /^I can update my (.*?)$/ do |field|
  current_student = Student.find_by_email(@saved_student_data[:email])
  visit profile_path(current_student.id)
  click_button 'Edit Profile'
  expect(page).to have_current_path(edit_profile_path(current_student.id))
  case field
  when 'toefl score'
    fill_in 'toefl', with: 120
    click_button 'Save Changes'
    current_student.current_profile.toefl.should eq(120)
  when 'undergraduate college'
    select('United States', from: 'country_id')
    select('Massachusetts Institute of Technology', from: 'undergrad_universities')
    select('Computer Science', from: 'major_undergrad')
    select('B.A', from: 'degree_undergrad')
    select('2010', from: 'undergrad_start_year')
    select('2014', from: 'undergrad_end_year')
    select('Standard', from: "grading_scale")
    fill_in "profiles_undergrad_university[cgpa]", with: 3.2
    click_button 'Save Changes'
    undergrad_school = current_student.current_profile.undergrad_universities
    contain = false
    undergrad_school.each do |school|
      if school.university_name.eql?('Massachusetts Institute of Technology')
        contain = true
      end
    end
    contain.should eq(true)
  when 'major'
    fill_in 'interested_major', with: 'Computer Security'
    click_button 'Save Changes'
    current_student.current_profile.interested_major.should eq('Computer Security')
  when 'gre verbal, writing or quant score'
    fill_in 'gre_writing', with: '4.5'
    fill_in 'gre_verbal', with: '158'
    fill_in 'gre_quant', with: '162'
    click_button 'Save Changes'
    current_student.current_profile.gre_writing.should eq(4.5)
    current_student.current_profile.gre_verbal.should eq(158)
    current_student.current_profile.gre_quant.should eq(162)
  when 'intended start term'
    select('Spring', from: 'interested_term')
    select('2022', from:'interested_year')
    click_button 'Save Changes'
    current_student.current_profile.interested_term.should eq('Spring')
    current_student.current_profile.interested_year.should eq(2022)
  when 'work experience'
    select('>10 years', from: 'year_work_exp')
    click_button 'Save Changes'
    current_student.current_profile.year_work_exp.should eq(">10 years")
  when 'last name and first name'
    fill_in 'first_name', with: 'Linh'
    fill_in 'last_name', with: 'Pham'
    click_button 'Save Changes'
    current_student = Student.find_by_email(@saved_student_data[:email])
    current_student.first_name.should eq('Linh')
    current_student.last_name.should eq('Pham')
  when 'resume'
    page.attach_file "profile[resume]", Rails.root + 'public/test.pdf'
    click_button 'Save Changes'
    current_student.current_profile.resume.metadata['filename'].should eq('test.pdf')
  when 'sop'
    page.attach_file "profile[sop]", Rails.root + 'public/test.pdf'
    click_button 'Save Changes'
    current_student.current_profile.sop.metadata['filename'].should eq('test.pdf')
  when 'additional attachment'
    page.attach_file "profile[additional_attachment]", Rails.root + 'public/test.pdf'
    click_button 'Save Changes'
    current_student.current_profile.additional_attachment.metadata['filename'].should eq('test.pdf')
  when 'profile photo'
    page.attach_file "profile[photo_id]", Rails.root + 'public/gradcap.jpg'
    click_button 'Save Changes'
    current_student.current_profile.photo_id.metadata['filename'].should eq('gradcap.jpg')
  when 'citizenship'
    select('United States', from: 'citizenship')
    click_button 'Save Changes'
    current_student.current_profile.country.name.should eq('United States')
  when 'gender'
    select('Female', from: 'gender')
    click_button 'Save Changes'
    current_student.current_profile.gender.should eq('Female')
  when 'degree objective'
    find(:xpath, "//input[@id='degree_objective_phd']").set 2
    find(:xpath, "//input[@id='degree_objective_master']").set 3
    click_button 'Save Changes'
    current_student.current_profile.degree_objective_phd.should eq(2)
    current_student.current_profile.degree_objective_master.should eq(3)
  when 'grading scale'
    select('US News', from: 'grading_scale')
    click_button 'Save Changes'
    current_student.current_profile.grading_scale_type.grading_scale_name.should eq('US News')
  when 'research interest'
    select('Machine Learning', from: 'research_interest')
    click_button 'Save Changes'
    current_student.current_profile.research_interests.first.name.should eq("Machine Learning")
  end
end

Then(/I can add new interest interest if it's not available in the database$/) do
  count = ResearchInterest.count
  current_student = Student.find_by_email(@saved_student_data[:email])
  visit profile_path(current_student.id)
  click_button 'Edit Profile'
  expect(page).to have_current_path(edit_profile_path(current_student.id))
  click_button 'Add new research interest'
  fill_in 'additional_research_interest', with: 'Research 1; Research 2'
  click_button 'Save Changes'
  ResearchInterest.count.should eq(count + 2)
    # current_student.current_profile.research_interests.first.name.should eq("Machine Learning")
end

Then(/I can add new undergrad university with only school name and country$/) do
  undergrad_universities = UndergradUniversity.count
  current_student = Student.find_by_email(@saved_student_data[:email])
  visit profile_path(current_student.id)
  click_button 'Edit Profile'
  select('United States', from: 'country_id')
  select('School not listed', from: 'undergrad_universities')
  click_button 'Add your school'
  fill_in 'undergrad_school_name', with: 'Test New Undergrad'
  find('[name=save_modal_button]').click
  Timeout.timeout(Capybara.default_max_wait_time) do
    loop until page.evaluate_script('jQuery.active').zero?
  end
  UndergradUniversity.count.should eq(undergrad_universities + 1)
end

Then(/I can add new undergrad university with all fields specified$/) do
  undergrad_universities = UndergradUniversity.count
  current_student = Student.find_by_email(@saved_student_data[:email])
  visit profile_path(current_student.id)
  click_button 'Edit Profile'
  select('United States', from: 'country_id')
  select('School not listed', from: 'undergrad_universities')
  click_button 'Add your school'
  Timeout.timeout(Capybara.default_max_wait_time) do
    loop until page.evaluate_script('jQuery.active').zero?
  end
  fill_in 'undergrad_school_name', with: 'Test New Undergrad 2'
  fill_in 'undergrad_acceptance_rate_text', with: '20'
  fill_in 'undergrad_location_text', with: 'test location'
  fill_in 'undergrad_description_text', with: 'test description'
  select('US News', from: 'undergrad_rank_type')
  fill_in 'undergrad_ranking_text', with: '40'
  fill_in 'undergrad_website_text', with: 'test website'
  find('[name=save_modal_button]').click
  Timeout.timeout(Capybara.default_max_wait_time) do
    loop until page.evaluate_script('jQuery.active').zero?
  end
  UndergradUniversity.count.should eq(undergrad_universities + 1)
  new_undergrad = UndergradUniversity.find_by_university_name('Test New Undergrad 2')
  new_undergrad.acceptance_rate.should eq(20.0)
  new_undergrad.location.should eq('test location')
  new_undergrad.university_desc.should eq('test description')
  new_undergrad.country_id.should eq(1)
  new_undergrad.university_link.should eq('test website')
  new_undergrad.rankings[0].rank_type.name.should eq('US News')
  new_undergrad.rankings[0].rank.should eq(40)
end

Then(/^I cannot add undergrad university (.*?)$/) do |field|
  current_student = Student.find_by_email(@saved_student_data[:email])
  visit profile_path(current_student.id)
  click_button 'Edit Profile'
  select('United States', from: 'country_id')
  select('School not listed', from: 'undergrad_universities')
  click_button 'Add your school'
  Timeout.timeout(Capybara.default_max_wait_time) do
    loop until page.evaluate_script('jQuery.active').zero?
  end
  case field
  when "if I don't specify school name"
    fill_in 'undergrad_school_name', with: ''
    find('[name=save_modal_button]').click
    page.should have_content 'Please fill in university name'
  when 'if I fill in negative acceptance rate'
    fill_in 'undergrad_school_name', with: 'Test New Undergrad'
    fill_in 'undergrad_acceptance_rate_text', with: '-20'
    find('[name=save_modal_button]').click
    page.should have_content 'Acceptance rate must be a number greater than 0 and less than 100'
  when 'if I fill in negative ranking'
    fill_in 'undergrad_school_name', with: 'Test New Undergrad 2'
    fill_in 'undergrad_acceptance_rate_text', with: '20'
    fill_in 'undergrad_location_text', with: 'test location'
    fill_in 'undergrad_description_text', with: 'test description'
    select('US News', from: 'undergrad_rank_type')
    fill_in 'undergrad_ranking_text', with: '-40'
    find('[name=save_modal_button]').click
    page.should have_content 'Ranking must be a number greater than 0'
  end

end

Then (/^I can add undergrad university with new rank type if it's not in the list$/) do
  undergrad_universities = UndergradUniversity.count
  current_student = Student.find_by_email(@saved_student_data[:email])
  visit profile_path(current_student.id)
  click_button 'Edit Profile'
  select('United States', from: 'country_id')
  select('School not listed', from: 'undergrad_universities')
  click_button 'Add your school'
  Timeout.timeout(Capybara.default_max_wait_time) do
    loop until page.evaluate_script('jQuery.active').zero?
  end
  fill_in 'undergrad_school_name', with: 'Test New Undergrad 3'
  fill_in 'undergrad_acceptance_rate_text', with: '20'
  fill_in 'undergrad_location_text', with: 'test location'
  fill_in 'undergrad_description_text', with: 'test description'
  select('Ranking type not listed', from: 'undergrad_rank_type')
  fill_in 'new_rank_type', with: 'new rank type'
  fill_in 'undergrad_ranking_text', with: '40'
  fill_in 'undergrad_website_text', with: 'test website'
  find('[name=save_modal_button]').click
  Timeout.timeout(Capybara.default_max_wait_time) do
    loop until page.evaluate_script('jQuery.active').zero?
  end
  UndergradUniversity.count.should eq(undergrad_universities + 1)
  new_undergrad = UndergradUniversity.find_by_university_name('Test New Undergrad 3')
  new_undergrad.acceptance_rate.should eq(20.0)
  new_undergrad.location.should eq('test location')
  new_undergrad.university_desc.should eq('test description')
  new_undergrad.country_id.should eq(1)
  new_undergrad.university_link.should eq('test website')
  new_undergrad.rankings[0].rank_type.name.should eq('new rank type')
  new_undergrad.rankings[0].rank.should eq(40)
end

Then(/^I can add undergrad university together with gpa, degree type, grading scale/) do
  current_student = Student.find_by_email(@saved_student_data[:email])
  visit profile_path(current_student.id)
  click_button 'Edit Profile'
  expect(page).to have_current_path(edit_profile_path(current_student.id))

  select('United States', from: 'country_id')
  select('Stanford University', from: 'undergrad_universities')
  select('Computer Science', from: 'major_undergrad')
  select('B.A', from: 'degree_undergrad')
  select('2010', from: 'undergrad_start_year')
  select('2015', from: 'undergrad_end_year')
  fill_in 'gpa', with: '3.4'
  select('Standard', from: 'grading_scale')
  click_button 'Save Changes'
  contains = false
  current_student.current_profile.undergrad_universities.each do |uni|
    if uni.university_name.eql?('Stanford University')
      contains = true
    end
    contains.should eq(true)
  end

end

Then(/^I can log out of my account from the forum page/) do
  visit thredded_path
  page.find_link("Sign Out").click
  page.should have_content 'Signed out successfully.'
end


Then(/^I can go to the main page from the forum page/) do
  visit thredded_path
  page.find_link("Main Page").click
  expect(page).to have_current_path(root_path)
end

Then(/^I can post my question if I go to any message board/) do
  visit thredded_path
  visit "/discussion_forum/test"
  page.should have_content 'Title'
end

Then(/^I can look at unread message/) do
  visit thredded_path
  visit "/discussion_forum/test"
  page.should have_content 'Unread'
end

Then(/^I can search for topic by keyword/) do
  visit thredded_path
  visit "/discussion_forum/test"
  fill_in "q", with: "First"
  page.should have_content "First Topic"
end

Then(/^I can reply to any post/) do
  visit thredded_path
  visit "/discussion_forum/test/first_topic"
  page.should have_content "Submit Reply"
end

Then(/^I can approve or disapprove message/) do
  visit thredded_path
  click_link "Moderation"
  expect(page).to have_selector(:link_or_button, 'Approve')
  expect(page).to have_selector(:link_or_button, 'Block')
end
