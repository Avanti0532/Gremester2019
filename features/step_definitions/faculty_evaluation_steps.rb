And(/^I click on View Evaluations$/) do
  find('a', :text=> 'Hi,', :visible => false).click
  find('a', :class => 'nav-link', :text=> 'View Evaluations', :visible => false).click
end

Then(/^I should see all evaluations for (.*?)$/) do |name|
  case name
  when 'Alice'
    @evaluations = FacultyEvaluation.where(faculty_id: 1)
  when 'Lily'
    @evaluations = FacultyEvaluation.where(faculty_id: 2)
  end
  expected_eval_name = []
  actual_eval_name = []
  @evaluations.each do |eval|
    expected_eval_name << "#{eval.application.profile.student.first_name} #{eval.application.profile.student.last_name}"
  end
  td1elements = all('table tbody tr td:nth-of-type(1)')
  td1elements.each do |td1|
    actual_eval_name << td1.text
  end
  expect(@evaluations.count).to eq(td1elements.count)
  expect(actual_eval_name).to match_array(expected_eval_name)
end

And(/^I search student name with (.*?)$/) do |search_field|
  page.execute_script("$('#facultyEvaluationTable').DataTable({});")
  page.should have_content('Search:')
  page.fill_in "Search:", with: search_field
end

Then(/^I should see entry only for (.*?)$/) do |search_field|
  page.should have_content(search_field)
  td1elements = all('table tbody tr td:nth-of-type(1)')
  expect(td1elements.count).to eq(1)
end

And(/^I click on view other evaluations of (.*?)$/) do |name|
  find(:xpath, "//tr[contains(.,\"#{name}\")]/td/a", :text => 'View other evaluations').click
end

Then(/^I should see all the evaluations of other faculty members$/) do
  td1elements = all('table tbody tr td:nth-of-type(1)')
  @evaluations = FacultyEvaluation.where("faculty_id!= 1 AND application_id = 5")
  expect(@evaluations.count).to eq(td1elements.count)
end

Then(/^I should not see any evaluations of other faculty members$/) do
   page.should have_content('No data available in table')
end

And(/^I click on (.*?) link$/) do |name|
  find(:xpath, "//tr[contains(.,\"#{name}\")]/td/a", :text => "#{name}").click
end

And(/^I fill in evaluations and click submit$/) do
  page.execute_script("$('#fEval_form').submit(function() {
    var c = confirm('This action cannot be undone, confirm all information is correct. Click OK to submit');
      return c; //you can just return c because it will be true or false
    });");
  page.driver.browser.accept_confirm
  fill_in_evaluation
end

def fill_in_evaluation
  select('4 - Good +', from: 'application_score')
  select('1 - Has EE background -', from:'ee_background')
  fill_in 'comment', with: 'Good Profile'
  click_on 'Submit'
end

Then(/^I should see a successful evaluation message$/) do
  page.should have_content('Your evaluation has been submitted!')
end

And(/^I fill in evaluations and click submit and then cancel$/) do
  page.execute_script("$('#fEval_form').submit(function() {
    var c = confirm('This action cannot be undone, confirm all information is correct. Click OK to submit');
      return c; //you can just return c because it will be true or false
    });");
  page.driver.browser.dismiss_confirm
  fill_in_evaluation
end

Then(/^I should be on (.*?) page$/) do |page|
  if page == 'submit evaluation'
     expect(current_path).to eq(faculty_evaluation_path('1'))
  elsif page == 'profile view'
    expect(current_path).to eq(fViewProfile_profiles_path('1'))
  elsif page == 'faculty evaluation'
    expect(current_path).to eq(faculty_evaluations_path)
  else
    expect(current_path).to eq(root_path)
  end
end

Then(/^I should not see Add Evaluation button$/) do
  expect(page).not_to have_selector "#addevaluation"
  page.should have_content(' Evaluation submitted on 04-07-2018')
end