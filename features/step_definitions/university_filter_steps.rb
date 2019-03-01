And(/^I select (.*?) as type/) do |type|
  find('#type').find(:css, 'option[value$='+type+']').select_option
  click_on 'Filter'
end
Then(/I should see only (.*?) universities/) do |type|
  td3elements = all('table tbody tr td:nth-of-type(3)')
  td3elements.each do |td3|
      expect(td3.text).to eq(type)
  end
end
And(/I should not see (.*?) universities/) do |type|
  td3elements = all('table tbody tr td:nth-of-type(3)')
  td3elements.each do |td3|
    expect(td3.text).not_to eq(type)
  end
end
And(/I select (.*?) as ranking_from and (.*?) as ranking_to/) do |ranking_from, ranking_to|
  find(:css, 'select[id$="ranking_from"] > option', text: ranking_from, exact_text: true).select_option
  find(:css, 'select[id$="ranking_to"] > option', text: ranking_to, exact_text: true).select_option
  click_on 'Filter'
end

Then(/I should see universities with ranks only between (\d*) and (\d*)/) do |int1, int2|
  td1elements = all('table tbody tr td:nth-of-type(1)')
  td1elements.each do |td1|
    td1.text.to_i.should be_between(int1.to_i, int2.to_i)
  end
end

Then(/I should see both (.*?) and (.*?) universities/) do |type1, type2|
  td3elements = all('table tbody tr td:nth-of-type(3)')
  td3elements.each do |td3|
    expect(td3.text).to eq(type1).or eq(type2)
  end
end
