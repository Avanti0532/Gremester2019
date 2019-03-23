def create_faculty
  @faculty ||= {username: 'James', first_name: 'James', last_name: 'Brown', email: 'jamesbrown@uiowa.edu',
                password: 'james1234', password_confirmation: 'james1234', weblink: 'http://homepage.cs.uiowa.edu/~alicem/', university_id: 1}
end

def create_another_faculty
  @faculty ||= {username: 'Mike', first_name: 'Mike', last_name: 'Day', email: 'mikeday@uiowa.edu',
                password: 'mike1234', password_confirmation: 'mike1234', weblink: 'http://homepage.cs.uiowa.edu/~mike/'}
end

def saved_faculty_data
  @save_faculty = {email: 'alicen@uiowa.edu', password: '12345689', university_id: 1 }
end

def sign_up_faculty
  visit '/faculties/sign_up'
  page.attach_file "faculty[id_card]", Rails.root + 'public/favicon.ico'
  fill_data
end

def log_in_faculty
  visit new_faculty_session_path
  fill_in 'Email', with: @save_faculty[:email]
  fill_in 'Password', with: @save_faculty[:password]
  click_button 'Log in'
end

def fill_data
  fill_in 'faculty_username', with: @faculty[:username]
  fill_in 'faculty_first_name', with: @faculty[:first_name]
  fill_in 'faculty_last_name', with: @faculty[:last_name]
  fill_in 'faculty_email', with: @faculty[:email]
  fill_in 'faculty_password', with: @faculty[:password]
  fill_in 'faculty_password_confirmation', with: @faculty[:password_confirmation]
  fill_in 'faculty_weblink', with: @faculty[:weblink]
  select('Massachusetts Institute of Technology', from: 'faculty_university_id')
  click_button 'Sign up'
end

When /^I log in as a faculty/ do
  saved_faculty_data
  log_in_faculty
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

And /^I click on log out as a faculty/ do
  page.find_link("Log Out", visible: false).click
end

Then(/^I should see a sign out message/) do
  page.should have_content 'Signed out successfully.'
end

And (/^I should see a log in button/) do
  expect(page).to have_link("Login", visible: false)
end

Then /^I can see all undergrad universities$/ do
  UndergradUniversity.all.each do |undergrad_university|
    page.should have_content(undergrad_university.university_name)
  end
end

Then /^I can see all research interests$/ do
  ResearchInterest.all.each do |research_interest|
    page.should have_content(research_interest.name)
  end
end

Then /^I can see all applications to my university$/ do
  Application.all.each do |application|
    if (application.university_id == @save_faculty[:university_id])
      page.should have_content(application.profile.student.first_name)
    end
  end
end

When /^I select (.*?) as (.*?)$/ do |option, criteria|
  if criteria == 'research interest'
    find('#research_interests').find(:css, 'option[value="'+ResearchInterest.find_by_name(option).id.to_s+'"]').select_option
  elsif criteria == 'undergrad university'
    find('#undergrad_university').find(:css, 'option[value="'+UndergradUniversity.find_by_university_name(option).id.to_s+'"]').select_option
  end
end

Then /^I can see all applications with (.*?)$/ do |research_interest|
  td3elements = all('table#dtOrderExample tbody tr td:nth-of-type(3)')
  td3elements.each do |td3|
    expect(td3.text).to has_content(research_interest)
  end
end

Then /^I can see all filtering options$/ do
  within 'div#slider-range-cgpa' do
    page.should have_css('div.ui-slider-range')
  end
  within 'div#slider-range-greq' do
    page.should have_css('div.ui-slider-range')
  end
  within 'div#slider-range-grev' do
    page.should have_css('div.ui-slider-range')
  end
  within 'div#slider-range-msob' do
    page.should have_css('div.ui-slider-range')
  end
  within 'div#slider-range-phdo' do
    page.should have_css('div.ui-slider-range')
  end
  within 'form#filterForm' do
    page.should have_css('input[value="Filter"]')
    page.should have_css('input[value="Reset"]')
  end
end

When /^I select Multiple in research interests$/ do
  find('#research_interests').find(:css, 'option[value="multiple"]').select_option
end

Then /^I can see research interests modal$/ do
  expect(page).to have_css('#researchInterestsModal[class="modal fade in"]')
end

When /^I click on (.*?)$/ do |btn|
  if btn == 'x'
    find('#x_btn').click
  else
    click_button btn
  end
end

Then("I should see alert") do
  expect(find('div[role="alert"]').text).to eq("Please select at least one research interest!")
end

Then /^modal should not close$/ do
  expect(page).to have_css('#researchInterestsModal[class="modal fade in"]')
end

When /^modal should close$/ do
  expect(page).to have_css('#researchInterestsModal[class="modal fade"]')
end

Then /^I can see all applications from (.*?)$/ do |undergrad_university|
  td2elements = all('table#dtOrderExample tbody tr td:nth-of-type(2)')
  td2elements.each do |td2|
    expect(td2.text).to has_content(undergrad_university)
  end
end