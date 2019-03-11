Feature: Allow students, faculties or admin to log out

  Background: User is logged in
    Given the following students have been added to Student Database:
      | first_name  | last_name  | email          | password  | username          | confirmed_at |
      | Robin       | Hood       | robin@gmail.com  | 12345678    |   robin_hood      | 2019-02-15 02:46:01 UTC |
      | Thomas      | Edison     | thomas@gmail.com  | 23456789    |   thomas_edison   | 2019-02-15 02:46:01 UTC |
      | Frank       | Robert     | frank@gmail.com | 34567890    |   frank_robert    | 2019-02-15 02:46:01 UTC |

    And the following faculties have been added to Faculty Database:
      | first_name  | last_name   | email             | password    |   username          | weblink | approved | confirmed_at | university_id |
      | Alice       | May         | alicen@uiowa.edu  | 12345689    |   alice_may         | http://homepage.cs.uiowa.edu/~alicem/ | true | 2019-02-15 02:46:01 UTC | 1|
      | Lily        | Edison      | lilys@uiowa.edu   | 23456789    |   lily12            | http://homepage.cs.uiowa.edu/~lily12/ | true | 2019-02-15 02:46:01 UTC | 1|

    And the following admins have been added to Admin Database:
      | first_name  | last_name   | email             | password    | password_confirmation |
      | Linh        | Pham         | linh@gmail.com    | 12345689    |  12345689            |
      | Jordan        | Peterson      | jordan@gmail.com   | 23456789    | 23456789         |

    And the following universities have been added to University Database:
      |id| rank   | university_name  | university_type | acceptance_rate | tuition |location|weather|university_link|university_desc|
      |1 |1       |Massachusetts Institute of Technology|Private|18|$49,600|Located in Cambridge, Massachusetts, MIT is located on the north shore of the Charles River Basin. The campus is within 3 miles of two major interstate highways, and is less than 6 miles from Logan international airport. The Kendall (or MIT) Station is at a 5 minute walk from the campus. MIT is roughly a 20 minute walk from downtown Boston, and a 30–40 minute walk from Harvard University, which is located just up the river from the MIT campus.|If there’s any negative about MIT, then this is it. The climate here is of the continental type. Massachusetts receives about 40 inches of rain annually, fairly evenly distributed throughout the year, slightly wetter during the winter.Summers are warm with average high temperatures in July about 26.7 °C and overnight lows about 15.5 °C. Winters are pretty cold though, with temperatures often going sub-zero.|http://www.mit.edu/|Although it’ll no doubt be fascinating and highly inspiring to read about MIT, it could also give you a serious inferiority complex. Because Massachusetts Institute of Technology is perhaps the best overall college in the world, and it makes sure its students are no less. To get into MIT, you need to be excellent in everything, and even that probably won’t be enough. MIT is absolutely top-notch in everything, from infrastructure to faculty to extracurriculars to placements to alumni. An interesting bit of trivia: the aggregated revenues of companies founded by MIT alumni would rank as the eleventh largest economy in the world. Now, that's MIT. We associate only one word with MIT - WOW.|
      |2 |2       |Stanford University|Public|17|$16,900|Located 35 miles south of San Francisco and 20 miles north of San Jose, Stanford University is in the heart of Northern California’s dynamic Silicon Valley.|Most students are of the common opinion that the weather at Stanford is pretty good. Apart from the winter months, when it’s slightly cold and wet, the rest of the year is sunny and pleasant. Stanford University area doesn’t receive snowfall and fortunately doesn’t experience extremes of temperature. It’s pretty normal to see people roaming around in shorts and tshirts.|http://www.stanford.edu/|The very famous Stanford University is a private research university with a high output, located in Stanford, California. Simply, if anyone gets into Stanford, she/he takes it blindly, as the acceptance rate is a mere 4.8% and financial aids are among the most generous ones. To get an idea of exactly how competitive Stanford is, you don’t have to look further than the long list of prominent companies founded by Stanford alumni- Google, Hewlett-Packard, LinkedIn, Yahoo, and Sun Microsystems. And that’s not even one tenth of the list. Also, it ranks #3 according to U.S. News' 'Best Global Universities Ranking' list.|

  Scenario: Student logs out
    When I log in as a student
    And I click on log out as a student
    Then I should see a sign out message
    And I should see a log in button

  Scenario: Faculty logs out
    When I log in as a faculty
    And I click on log out as a faculty
    Then I should see a sign out message
    And I should see a log in button

  Scenario: Admin logs out
    When I log in as an admin
    And I click on log out as an admin
    Then I got redirected to homepage
    And I should see a log in button
