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