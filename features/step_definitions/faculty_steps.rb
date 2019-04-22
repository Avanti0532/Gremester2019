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
When /^I log_in as a faculty as (.*?)$/ do |name|
  visit new_faculty_session_path
  case name
  when 'Alice'
    fill_in 'Email', with: 'alicen@uiowa.edu'
    fill_in 'Password', with: '12345689'
  when 'Lily'
    fill_in 'Email', with: 'lilys@uiowa.edu '
    fill_in 'Password', with: '23456789'
  end
  click_button 'Log in'
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
  find('a', :text=> 'Hi, alice_may', :visible => false).click
  find('a', :class => 'nav-link', :text=> 'Log Out', :visible => false).click
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

Then /^I can see all applications to my university that do not have admitted or rejected date$/ do
  Application.all.each do |application|
    if (application.university_id == @save_faculty[:university_id] && (application.admitted.blank? and application.rejected.blank?))
      page.should have_content(application.profile.student.first_name)
    end
  end
  page.should_not have_content("Alex Robert")
end

When /^I select (.*?) as undergrad university$/ do |option|
  find('#undergrad_university').find(:css, 'option[value="'+UndergradUniversity.find_by_university_name(option).id.to_s+'"]').select_option
end
When /^I select (.*?) as research interest$/ do |option|
  find('#research_interests').find(:css, 'option[value="'+ResearchInterest.find_by_name(option).id.to_s+'"]').select_option
end

Then /^I can see all applications with (.*?) as research interest$/ do |research_interest|
  td3elements = all('table#dtOrderExample tbody tr td:nth-of-type(3)')
  td3elements.each do |td3|
    expect(td3.text).to have_content(research_interest)
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

When /^I click on (.*?) button$/ do |btn|
  if btn == 'x'
    find('#x_btn').click
  elsif btn == 'Back' || 'Add Evaluation' || 'Back to profile'
    click_on btn
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
    expect(td2.text).to have_content(undergrad_university)
  end
end

When("I slide CGPA to range {int},{int}") do |int, int2|
  page.execute_script("$('#slider-range-cgpa').slider({
  range: true,
      min: 0,
      max: 100,
      step: 1,
      values: ["+int.to_s+", "+int2.to_s+"],
      slide: function(event, ui) {
    $( '#cgpa_score' ).val( ui.values[ 0 ] + ' - ' + ui.values[ 1 ] );
  }
  });

$( '#cgpa_score' ).val($( '#slider-range-cgpa' ).slider( 'values', 0 ) +
  ' - ' + $( '#slider-range-cgpa' ).slider( 'values', 1 ) );");
end

When("I slide GREQ to range {int},{int}") do |int, int2|
  page.execute_script("$('#slider-range-greq').slider({
  range: true,
      min: 130,
      max: 170,
      step: 1,
      values: ["+int.to_s+", "+int2.to_s+"],
      slide: function(event, ui) {
    $( '#greq_score' ).val( ui.values[ 0 ] + ' - ' + ui.values[ 1 ] );
  }
  });

$( '#greq_score' ).val($( '#slider-range-greq' ).slider( 'values', 0 ) +
  ' - ' + $( '#slider-range-greq' ).slider( 'values', 1 ) );");
end

When("I slide GREV to range {int},{int}") do |int, int2|
  page.execute_script("$('#slider-range-grev').slider({
  range: true,
      min: 130,
      max: 170,
      step: 1,
      values: ["+int.to_s+", "+int2.to_s+"],
      slide: function(event, ui) {
    $( '#grev_score' ).val( ui.values[ 0 ] + ' - ' + ui.values[ 1 ] );
  }
  });

$( '#grev_score' ).val($( '#slider-range-grev' ).slider( 'values', 0 ) +
  ' - ' + $( '#slider-range-grev' ).slider( 'values', 1 ) );");
end

When("I slide PHDO to range {int},{int}") do |int, int2|
  page.execute_script("$('#slider-range-phdo').slider({
  range: true,
      min: 0,
      max: 5,
      step: 1,
      values: ["+int.to_s+", "+int2.to_s+"],
      slide: function(event, ui) {
    $( '#phdo_score' ).val( ui.values[ 0 ] + ' - ' + ui.values[ 1 ] );
  }
  });

$( '#phdo_score' ).val($( '#slider-range-phdo' ).slider( 'values', 0 ) +
  ' - ' + $( '#slider-range-phdo' ).slider( 'values', 1 ) );");
end

When("I slide MSOB to range {int},{int}") do |int, int2|
  page.execute_script("$('#slider-range-msob').slider({
  range: true,
      min: 0,
      max: 5,
      step: 1,
      values: ["+int.to_s+", "+int2.to_s+"],
      slide: function(event, ui) {
    $( '#msob_score' ).val( ui.values[ 0 ] + ' - ' + ui.values[ 1 ] );
  }
  });

$( '#msob_score' ).val($( '#slider-range-msob' ).slider( 'values', 0 ) +
  ' - ' + $( '#slider-range-msob' ).slider( 'values', 1 ) );");
end

When("I select all as scale") do
  find('#scale_type').find(:css, 'option[value="all"]').select_option
end

When("I select Standard with A+ as scale") do
  find('#scale_type').find(:css, 'option[value="1"]').select_option
end

When("I select German scale as scale") do
  find('#scale_type').find(:css, 'option[value="5"]').select_option
end

Then("I can see all applications with CGPA in range {int},{int} in German scale") do |int, int2|
  high_score = GradingScale.where("low_percent <= ? AND high_percent >= ? AND grading_scale_type_id = ?", int, int, 1).first.gpa
  low_score = GradingScale.where("low_percent <= ? AND high_percent >= ? AND grading_scale_type_id = ?", int2, int2, 1).first.gpa
  td4elements = all('table#dtOrderExample tbody tr td:nth-of-type(4)')
  td4elements.each do |td4|
    (td4.text.to_s.to_f).should be_between(low_score.to_s.to_f, high_score.to_s.to_f)
  end
end


Then("I can see all applications with CGPA in range {int},{int} in Standard with A+ scale") do |int, int2|
  low_score = GradingScale.where("low_percent <= ? AND high_percent >= ? AND grading_scale_type_id = ?", int, int, 1).first.gpa
  high_score = GradingScale.where("low_percent <= ? AND high_percent >= ? AND grading_scale_type_id = ?", int2, int2, 1).first.gpa
  td4elements = all('table#dtOrderExample tbody tr td:nth-of-type(4)')
  td4elements.each do |td4|
    (td4.text.to_s.to_f).should be_between(low_score.to_s.to_f, high_score.to_s.to_f)
  end
end

Then("I can see all applications with CGPA in range {int},{int}") do |int, int2|
  scalesCount = GradingScaleType.all.size
  cgpa_low = int
  cgpa_high = int2
    scales = Array.new(scalesCount, Array.new(3, 0))
    GradingScaleType.all.each do |type|
      if !(type.id == 5)
        low_score = GradingScale.where("low_percent <= ? AND high_percent >= ? AND grading_scale_type_id = ?", cgpa_low, cgpa_low, type.id.to_s).first.gpa
        high_score = GradingScale.where("low_percent <= ? AND high_percent >= ? AND grading_scale_type_id = ?", cgpa_high, cgpa_high, type.id.to_s).first.gpa
      else
        high_score = GradingScale.where("low_percent <= ? AND high_percent >= ? AND grading_scale_type_id = ?", cgpa_low, cgpa_low, type.id.to_s).first.gpa
        low_score = GradingScale.where("low_percent <= ? AND high_percent >= ? AND grading_scale_type_id = ?", cgpa_high, cgpa_high, type.id.to_s).first.gpa
      end
      scales[type.id-1] = [type.id, low_score, high_score]
    end
  td2elements = all('table#dtOrderExample tbody tr td:nth-of-type(2)')
  college_gpa = Array.new(td2elements.size, Array.new(2, 0))
  counter = 0
  td2elements.each do |td2|
    undergrad_university_id = UndergradUniversity.where("university_name = ?", td2.text).first.id
    college_gpa[counter] = [undergrad_university_id,0]
    counter += 1
  end
  td4elements = all('table#dtOrderExample tbody tr td:nth-of-type(4)')
  counter = 0
  td4elements.each do |td4|
    college_gpa[counter][1] = td4.text.to_s
    counter += 1
  end
  td1elements = all('table#dtOrderExample tbody tr td:nth-of-type(1)')
  profiles_arr = Array.new(td1elements.size, 0)
  counter = 0
  td1elements.each do|td1|
    names = td1.text.to_s.split(' ')
    student_id = Student.where("first_name = ? AND last_name = ?", names[0], names[1]).first.id
    profiles_arr[counter] = Profile.where('student_id = ?', student_id).first.id
    counter += 1
  end
  undegrad_scales = Array.new(profiles_arr.size, 0)
  counter = 0
  college_gpa.each do |college|
    undegrad_scales[counter] = ProfilesUndergradUniversity.where("profile_id = ? AND undergrad_university_id = ?", profiles_arr[counter], college_gpa[counter][0]).first.grading_scale_type_id
    counter += 1
  end
  counter = 0
  college_gpa.each do |gpa|
    gpa[1].to_s.to_f.should be_between(scales[undegrad_scales[counter]][1].to_s.to_f, scales[undegrad_scales[counter]][2].to_s.to_f)
  end
end

Then("I can see all applications with GREQ in range {int},{int}") do |int, int2|
  tdelements = all('table#dtOrderExample tbody tr td:nth-of-type(5)')
  tdelements.each do |td|
    (td.text.to_s.to_f).should be_between(int.to_s.to_f, int2.to_s.to_f)
  end
end

Then("I can see all applications with GREV in range {int},{int}") do |int, int2|
  tdelements = all('table#dtOrderExample tbody tr td:nth-of-type(6)')
  tdelements.each do |td|
    (td.text.to_s.to_f).should be_between(int.to_s.to_f, int2.to_s.to_f)
  end
end

Then("I can see all applications with MSOB in range {int},{int}") do |int, int2|
  tdelements = all('table#dtOrderExample tbody tr td:nth-of-type(7)')
  tdelements.each do |td|
    obj = td.text.split("/")
    (obj[0].to_s.to_f).should be_between(int.to_s.to_f, int2.to_s.to_f)
  end
end

Then("I can see all applications with PHDO in range {int},{int}") do |int, int2|
  tdelements = all('table#dtOrderExample tbody tr td:nth-of-type(7)')
  tdelements.each do |td|
    obj = td.text.split("/")
    (obj[1].to_s.to_f).should be_between(int.to_s.to_f, int2.to_s.to_f)
  end
end

Then("I can see all applications with GREV and GREQ in ranges {int},{int} and {int},{int}") do |int, int2, int3, int4|
  tdelements = all('table#dtOrderExample tbody tr td:nth-of-type(6)')
  tdelements.each do |td|
      (td.text.to_s.to_f).should be_between(int.to_s.to_f, int2.to_s.to_f)
  end
  tdelements = all('table#dtOrderExample tbody tr td:nth-of-type(5)')
  tdelements.each do |td|
    (td.text.to_s.to_f).should be_between(int3.to_s.to_f, int4.to_s.to_f)
  end
end

When("I select any in term") do
  find('#term').find(:css, 'option[value="any"]').select_option
end

When("I select any in year") do
  find('#year').find(:css, 'option[value="any"]').select_option
end

When("I select Fall in term") do
  find('#term').find(:css, 'option[value="fall"]').select_option
end

Then("I can see all applications to my university for Fall") do
  Application.all.each do |application|
    if (application.university_id == @save_faculty[:university_id] and application.term == 'Fall'  and (application.admitted.blank? and application.rejected.blank?))
      page.should have_content(application.profile.student.first_name)
    end
    if (application.university_id == @save_faculty[:university_id] and application.term != 'Fall' and (application.admitted.blank? and application.rejected.blank?))
      page.should have_no_content(application.profile.student.first_name)
    end
  end
end

When("I select {int} in year") do |int|
  find('#year').find(:css, 'option[value="'+int.to_s+'"]').select_option
end

Then("I can see all applications to my university for {int}") do |int|
  Application.all.each do |application|
    if (application.university_id == @save_faculty[:university_id] and application.year == int and (application.admitted.blank? and application.rejected.blank?))
      page.should have_content(application.profile.student.first_name)
    end
    if (application.university_id == @save_faculty[:university_id] and application.year != int and (application.admitted.blank? and application.rejected.blank?))
      page.should have_no_content(application.profile.student.first_name)
    end
  end
end

When("I uncheck and_later") do
  uncheck 'And later terms'
end

Then("I can see all applications to my university for Fall {int}") do |int|
  Application.all.each do |application|
    if (application.university_id == @save_faculty[:university_id] and application.year == int and application.term == 'Fall' and (application.admitted.blank? and application.rejected.blank?))
      page.should have_content(application.profile.student.first_name)
    end
    if (application.university_id == @save_faculty[:university_id] and (application.year != int or application.term != 'Fall') and (application.admitted.blank? and application.rejected.blank?))
      page.should have_no_content(application.profile.student.first_name)
    end
  end
end

When("I check and_later") do
  check 'And later terms'
end

Then("I can see all applications to my university for Fall {int} and later terms") do |int|
  Application.all.each do |application|
    if ((application.university_id == @save_faculty[:university_id] and application.year >= int and (application.term == 'Fall' or application.term == 'Winter') and (application.admitted.blank? and application.rejected.blank?)) or
        (application.university_id == @save_faculty[:university_id] and application.year > int and (application.term == 'Spring' or application.term == 'Summer') and (application.admitted.blank? and application.rejected.blank?)))
      page.should have_content(application.profile.student.first_name)
    end
    if ((application.university_id == @save_faculty[:university_id] and application.year == int and (application.term == 'Summer' or application.term == 'Spring') and (application.admitted.blank? and application.rejected.blank?)) or
        (application.university_id == @save_faculty[:university_id] and application.year < int and (application.admitted.blank? and application.rejected.blank?)))
      page.should have_no_content(application.profile.student.first_name)
    end
  end
end

Then("I can click any student profile if I click on their name in the application table") do
  click_link('Frank Robert')
  page.should have_content("Frank Robert's Profile")
end


