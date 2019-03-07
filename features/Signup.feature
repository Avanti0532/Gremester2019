Feature: Allow faculties and students to sign up

  Background: I am on the homepage of Gremester

    Given I am on homepage of Gremester
    And the following universities have been added to University Database:
      |id| rank   | university_name  | university_type | acceptance_rate | tuition |location|weather|university_link|university_desc|
      |1 |1       |Massachusetts Institute of Technology|Private|18|$49,600|Located in Cambridge, Massachusetts, MIT is located on the north shore of the Charles River Basin. The campus is within 3 miles of two major interstate highways, and is less than 6 miles from Logan international airport. The Kendall (or MIT) Station is at a 5 minute walk from the campus. MIT is roughly a 20 minute walk from downtown Boston, and a 30–40 minute walk from Harvard University, which is located just up the river from the MIT campus.|If there’s any negative about MIT, then this is it. The climate here is of the continental type. Massachusetts receives about 40 inches of rain annually, fairly evenly distributed throughout the year, slightly wetter during the winter.Summers are warm with average high temperatures in July about 26.7 °C and overnight lows about 15.5 °C. Winters are pretty cold though, with temperatures often going sub-zero.|http://www.mit.edu/|Although it’ll no doubt be fascinating and highly inspiring to read about MIT, it could also give you a serious inferiority complex. Because Massachusetts Institute of Technology is perhaps the best overall college in the world, and it makes sure its students are no less. To get into MIT, you need to be excellent in everything, and even that probably won’t be enough. MIT is absolutely top-notch in everything, from infrastructure to faculty to extracurriculars to placements to alumni. An interesting bit of trivia: the aggregated revenues of companies founded by MIT alumni would rank as the eleventh largest economy in the world. Now, that's MIT. We associate only one word with MIT - WOW.|
      |2 |2       |Stanford University|Public|17|$16,900|Located 35 miles south of San Francisco and 20 miles north of San Jose, Stanford University is in the heart of Northern California’s dynamic Silicon Valley.|Most students are of the common opinion that the weather at Stanford is pretty good. Apart from the winter months, when it’s slightly cold and wet, the rest of the year is sunny and pleasant. Stanford University area doesn’t receive snowfall and fortunately doesn’t experience extremes of temperature. It’s pretty normal to see people roaming around in shorts and tshirts.|http://www.stanford.edu/|The very famous Stanford University is a private research university with a high output, located in Stanford, California. Simply, if anyone gets into Stanford, she/he takes it blindly, as the acceptance rate is a mere 4.8% and financial aids are among the most generous ones. To get an idea of exactly how competitive Stanford is, you don’t have to look further than the long list of prominent companies founded by Stanford alumni- Google, Hewlett-Packard, LinkedIn, Yahoo, and Sun Microsystems. And that’s not even one tenth of the list. Also, it ranks #3 according to U.S. News' 'Best Global Universities Ranking' list.|

  Scenario: Students sign up with valid details
    When I sign up with valid student details
    Then I should get a message saying confirmation email has been sent

  Scenario: Faculties sign up with valid details
    When I sign up with valid faculties details
    Then I should see a message saying my account is pending for admin approval

  Scenario: Students sign up with blank user name
    When I sign up with blank user name as a student
    Then I should see a blank user name error message

  Scenario: Students sign up with blank first name
    When I sign up with blank first name as a student
    Then I should see a blank first name error message

  Scenario: Faculties sign up with blank first name
    When I sign up with blank first name as a faculty
    Then I should see a blank first name error message

  Scenario: Students sign up with blank last name
    When I sign up with blank last name as a student
    Then I should see a blank last name error message

  Scenario: Faculty sign up with blank user name
    When I sign up with blank user name as a faculty
    Then I should see a blank user name error message

  Scenario: Faculties sign up with blank last name
    When I sign up with blank last name as a faculty
    Then I should see a blank last name error message

  Scenario: Faculties sign up with blank email
    When I sign up with blank email as a faculty
    Then I should see a blank email error message

  Scenario: Students sign up with blank email
    When I sign up with blank email as a student
    Then I should see a blank email error message

  Scenario: Students sign up with blank email
    When I sign up with blank email as a faculty
    Then I should see a blank email error message

  Scenario: Students sign up with invalid password
    When I sign up with invalid password as a student
    Then I should see an invalid password message

  Scenario: Students sign up with duplicate username
    When I sign up with duplicate username as a student
    Then I should see a duplicate username message

  Scenario: Students sign up with duplicate email
    When I sign up with duplicate email as a student
    Then I should see a duplicate email message

  Scenario: Faculty sign up with duplicate username
    When I sign up with duplicate username as a faculty
    Then I should see a duplicate username message

  Scenario: Faculty sign up with duplicate email
    When I sign up with duplicate email as a faculty
    Then I should see a duplicate email message

  Scenario: Faculties sign up with invalid password
    When I sign up with invalid password as a faculty
    Then I should see an invalid password message

  Scenario: Students sign up without password
    When I sign up with blank password as a student
    Then I should see a blank password error message

  Scenario: Faculties sign up with email not ends with edu
    When I sign up with an email that doesn't end with edu
    Then I should see an email error message

  Scenario: Faculties sign up without id card and faculty web page link
    When I sign up without id card and faculty web page link
    Then I should see an error for faculty authentication

  Scenario: Faculties sign up with id card and faculty web page link
    When I sign up with both id card and faculty web page link
    Then I should see a message saying my account is pending for admin approval

  Scenario: Faculty sign up with id card keeping faculty web page link blank
    When I sign up with id card keeping faculty web page link blank
    Then I should see a message saying my account is pending for admin approval


  Scenario: Faculty sign up with faculty web page link keeping id card blank
    When I sign up with faculty web page link keeping id card blank
    Then I should see a message saying my account is pending for admin approval


