Then(/^I click on delete icon of (.*?)$/) do |university|
  current_student = Student.find_by_email(@saved_student_data[:email])
  profile_id = current_student.current_profile.id
  university_data = University.find_by_university_name(university)
  application = Application.find_by(profile_id: profile_id,university_id: university_data.id)
  td1elements = all('table tbody tr')
  #puts page.html
  #page.find('#trash_2').click
  #page.driver.browser.switch_to.alert
  td1elements.each do |td1|
    words = td1.text.scan(/.*[a-zA-Z]/)
    if words[0] == university
      puts "inside"
      puts page.html
      #td1.find("#trash_#{application.id}").click
      td1.find("#trash_2").click
      sleep 20
      #td1.find("#trash_#{application.id}").trigger('click')
      #sleep 10
      #page.execute_script("$('.trash').on('click')")
      #puts ret_var
      #wait_for_ajax
      #td1.find(:xpath,'//[@id="trash_2"]').trigger('click')
      #puts page.html
    end
  end
end

Then(/^I should not see (.*?) in list of schools$/) do |university|
  #page.should have_content('University is deleted successfully')
  page.should_not have_content(university)
end

And(/^I visit Schools of Interest page$/) do
  find('a', :class => 'dropdown-toggle', :text=> 'Hi, robin_hood', :visible => false).click
  find('a', :class => 'nav-link', :text=> 'View Profile', :visible => false).click
  find('a', :class => 'nav-link', :text=> 'Schools of Interest', :visible => false).click
end

Then(/^I click on add school button and add school details$/) do
  click_button 'Add School'
  fill_in('univ_name', with: 'California Institute Of Technology')
  select('Applied - Accepted', from: 'sel_opt')
  page.execute_script("$('#datetimepicker1').datepicker('setDate', '01/01/2010')")
  click_button 'Save'
end

Then(/^I should be able to add the school successfully$/) do
  page.should have_content('University application successfully added to database')
end