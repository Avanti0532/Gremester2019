def create_university
  @universities ||= {rank: 1, name: 'University of Iowa', type: 'Public',
                     rate: 18, tuition: '$30,000', location: 'Iowa City, Iowa', link: 'https://uiowa.com', desc:'University of Iowa is one of the best universities in USA'}
end

def fill_in_data
  click_link 'Add new'
  fill_in 'university_rank', with: @universities[:rank]
  fill_in 'university_university_name', with: @universities[:name]
  fill_in 'university_university_type', with: @universities[:type]
  fill_in 'university_acceptance_rate', with: @universities[:rate]
  fill_in 'university_tuition', with: @universities[:tuition]
  fill_in 'university_location', with: @universities[:location]
  fill_in 'university_university_link', with: @universities[:link]
  fill_in 'university_university_desc', with: @universities[:desc]
end

Then(/^I can add a university/) do
  create_university
  find('tr', text: 'Universities').click_link 'Universities'
  fill_in_data
  click_button 'Save'
  expect University.where(university_name: 'University of Iowa').exists? == true
end

Then(/^I can edit any university from the university database/) do
  find('tr', text: 'Universities').click_link 'Universities'
  find('tr', text: 'Stanford University').click_link 'Edit'
  fill_in 'university_rank', with: 5
  fill_in 'university_acceptance_rate', with: 20
  click_button 'Save'
  expect((University.find_by(university_name: 'Stanford University')).rank).to eq(5)
  expect((University.find_by(university_name: 'Stanford University')).acceptance_rate).to eq(20)
end

Then(/^I can delete any university from the university database/) do
  find('tr', text: 'Universities').click_link 'Universities'
  find('tr', text: 'Stanford University').click_link 'Delete'
  click_button "Yes, I'm sure"
  expect University.where(university_name: 'Stanford University').exists? == false
end

Then(/^I can add another university and edit it if they click on save and edit/) do
  create_university
  find('tr', text: 'Universities').click_link 'Universities'
  fill_in_data
  click_button 'Save and edit'
  expect University.where(university_name: 'University of Iowa').exists? == true
  page.should have_content('University successfully created')
  expect (find_field('university_rank').value == @universities[:rank])
  expect (find_field('university_university_name').value == @universities[:name])
  expect (find_field('university_university_type').value == @universities[:type])
  expect (find_field('university_acceptance_rate').value == @universities[:rate])
  expect (find_field('university_tuition').value == @universities[:tuition])
  expect (find_field('university_location').value == @universities[:location])
  expect (find_field('university_university_link').value == @universities[:link])
  expect (find_field('university_university_desc').value == @universities[:desc])
end

Then(/^I can add another university if admin clicks on save and add another/) do
  create_university
  find('tr', text: 'Universities').click_link 'Universities'
  fill_in_data
  click_button 'Save and add another'
  expect University.where(university_name: 'University of Iowa').exists? == true
  page.should have_content('University successfully created')
  page.should have_content("Save and add another")
end

And(/^I search universities with (.*?)$/) do |search_field|
  page.execute_script("$('#universitiesTable').DataTable({});")
  page.should have_content('Search:')
  page.fill_in "Search:", with: search_field
end

Then(/^I should see only search result with (.*?)$/) do |search_field|
  University.all.each do |university|
    if !university.university_name.eql?(search_field)
      page.should_not have_content(university.university_name)
    end
  end
  page.should have_content(search_field)
end


