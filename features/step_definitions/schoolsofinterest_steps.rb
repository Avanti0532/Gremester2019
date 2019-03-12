Then(/^I click on delete icon of (.*?)$/) do |university|
  td1elements = all('table tbody tr')
  td1elements.each do |td1|
    words = td1.text.scan(/.*[a-zA-Z]/)
    if words[0] == university
      td1.find("#trash").click
    end
  end
end

Then(/^I should not see (.*?) in list of schools$/) do |university|
  page.should have_content('University is deleted successfully')
  page.should_not have_content(university)
end

And(/^I visit Schools of Interest page$/) do

  find('a', :class => 'dropdown-toggle', :text=> 'Hi, robin_hood', :visible => false).click
  find('a', :class => 'nav-link', :text=> 'View Profile', :visible => false).click
  find('a', :class => 'nav-link', :text=> 'Schools of Interest', :visible => false).click
end

Then(/^I click on add school button and add school details$/) do
  click_button 'Add School'
  sleep 10
  fill_in('univ_name', with: 'California Institute Of Technology')
  select('Applied - Accepted', from: 'sel_opt')
  page.execute_script("$('#datetimepicker1').datepicker('setDate', '01/01/2010')")
  click_button 'Save'
end

Then(/^I should be able to add the school successfully$/) do
  page.should have_content('University application successfully added to database')
end