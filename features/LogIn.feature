Feature: Allow students, faculties and admins to login

  Background: I am on the homepage of Gremester
    Given the following students have been added to Student Database:
      | first_name  | last_name  | email          | password  | username          | confirmed_at |
      | Robin       | Hood       | robin@gmail.com  | 12345678    |   robin_hood      | 2019-02-15 02:46:01 UTC |
      | Thomas      | Edison     | thomas@gmail.com  | 23456789    |   thomas_edison   | 2019-02-15 02:46:01 UTC |
      | Frank       | Robert     | frank@gmail.com | 34567890    |   frank_robert    | 2019-02-15 02:46:01 UTC |

    And the following faculties have been added to Faculty Database:
      | first_name  | last_name   | email             | password    |   username          | weblink | approved | confirmed_at | university_id |
      | Alice       | May         | alicen@uiowa.edu  | 12345689    |   alice_may         | http://homepage.cs.uiowa.edu/~alicem/ | true | 2019-02-15 02:46:01 UTC | 1|
      | Lily        | Edison      | lilys@uiowa.edu   | 23456789    |   lily12            | http://homepage.cs.uiowa.edu/~lily12/ | true | 2019-02-15 02:46:01 UTC | 1|
      | Hazel       | Robert      | hazel@uiowa.edu   | 34567890    |   hazel_robert      | http://homepage.cs.uiowa.edu/~hzel/ | false  | 2019-02-15 02:46:01 UTC | 1|


    And the following admins have been added to Admin Database:
      | first_name  | last_name   | email             | password    | password_confirmation |
      | Linh        | Pham         | linh@gmail.com    | 12345689    |  12345689            |
      | Jordan        | Peterson      | jordan@gmail.com   | 23456789    | 23456789         |

    And the following universities have been added to University Database:
      |id| rank  | university_name                     | university_type | acceptance_rate | tuition |location     |weather|university_link|university_desc|
      |1 |1      |Massachusetts Institute of Technology|Private          |18               |$49,600  |Located in Cambridge, Massachusetts, MIT is located on the north shore of the Charles River Basin. The campus is within 3 miles of two major interstate highways, and is less than 6 miles from Logan international airport. The Kendall (or MIT) Station is at a 5 minute walk from the campus. MIT is roughly a 20 minute walk from downtown Boston, and a 30–40 minute walk from Harvard University, which is located just up the river from the MIT campus.|If there’s any negative about MIT, then this is it. The climate here is of the continental type. Massachusetts receives about 40 inches of rain annually, fairly evenly distributed throughout the year, slightly wetter during the winter.Summers are warm with average high temperatures in July about 26.7 °C and overnight lows about 15.5 °C. Winters are pretty cold though, with temperatures often going sub-zero.|http://www.mit.edu/|Although it’ll no doubt be fascinating and highly inspiring to read about MIT, it could also give you a serious inferiority complex. Because Massachusetts Institute of Technology is perhaps the best overall college in the world, and it makes sure its students are no less. To get into MIT, you need to be excellent in everything, and even that probably won’t be enough. MIT is absolutely top-notch in everything, from infrastructure to faculty to extracurriculars to placements to alumni. An interesting bit of trivia: the aggregated revenues of companies founded by MIT alumni would rank as the eleventh largest economy in the world. Now, that's MIT. We associate only one word with MIT - WOW.|
      |2 |2      |Stanford University                  |Public           |17               |$16,900  |Located 35 miles south of San Francisco and 20 miles north of San Jose, Stanford University is in the heart of Northern California’s dynamic Silicon Valley.|Most students are of the common opinion that the weather at Stanford is pretty good. Apart from the winter months, when it’s slightly cold and wet, the rest of the year is sunny and pleasant. Stanford University area doesn’t receive snowfall and fortunately doesn’t experience extremes of temperature. It’s pretty normal to see people roaming around in shorts and tshirts.|http://www.stanford.edu/|The very famous Stanford University is a private research university with a high output, located in Stanford, California. Simply, if anyone gets into Stanford, she/he takes it blindly, as the acceptance rate is a mere 4.8% and financial aids are among the most generous ones. To get an idea of exactly how competitive Stanford is, you don’t have to look further than the long list of prominent companies founded by Stanford alumni- Google, Hewlett-Packard, LinkedIn, Yahoo, and Sun Microsystems. And that’s not even one tenth of the list. Also, it ranks #3 according to U.S. News' 'Best Global Universities Ranking' list.|
      |3 |15     |University of California – Berkeley  |Private          |14               |$28,000  |University of California – Berkeley is located in the Bay Area of California, a very in-demand and rather expensive area. The university is roughly 5 miles from Oakland, and 12 miles from San Francisco. Anyone who knows will tell you that UC Berkeley has a fantastic location, with Tilden Park and Berkeley Marina pretty close by.|Berkeley has a Mediterranean climate, though the temperatures in general are rather lower than what you come to expect in, say, Spain. Summers are cool and dry, while winters are cold and wet. Average temperatures in September (the ‘hottest’ month) are a high of 22.1°C and a low of 13.3°C, while average temperatures in January (the coldest month) are a high of 13.6°C and a low of 6.4°C. Berkeley also experiences rainfall once in a while, mainly during winters, and not much. Snowfall is a rare commodity, and normally takes place only on the peaks of hills.|https://www.berkeley.edu/|UC Berkeley is the flagship institute of the University of California. Statistically, Berkeley (as it’s called) is the most consistently well ranked university in the world. It has the highest number of distinguished graduate programs ranked in the top 10 in their fields by the United States National Research Council. As you can probably gauge, it isn’t easy to get into Berkeley, unless you have an untouchable academic track record. And rightly so – some of the achievements at this institute are fantastic. To give you an idea, UC Berkeley and its researchers are associated with 6 chemical elements of the periodic table. Now that’s something, isn’t it?|


  Scenario: Student logs in with valid credentials
    When I log in as a student
    Then I should see a successful login message

  Scenario: Faculty logs in with valid credentials
    When I log in as a faculty
    Then I should see a successful login message

  Scenario: Admin logs in with valid credentials
    When I log in as an admin
    Then I should see a successful login message

  Scenario: Student logs in with wrong email
    When I log in with wrong student email
    Then I should see an invalid login message

  Scenario: Faculty logs in with wrong email
    When I log in with wrong faculty email
    Then I should see an invalid login message

  Scenario: Admin logs in with wrong email
    When I log in with wrong admin email
    Then I should see an invalid login message

  Scenario: Student logs in with wrong password
    When I log in with wrong student password
    Then I should see an invalid login message

  Scenario: Faculty logs in with wrong password
    When I log in with wrong faculty password
    Then I should see an invalid login message

  Scenario: Admin logs in with wrong password
    When I log in with wrong admin password
    Then I should see an invalid login message

  Scenario: Only one user can log in at one time
    When I log in as an admin
    Then I will receive message saying I'm already logged in if I attempt to go to faculty or student login page
    And I will receive message saying I'm already logged in if I attempt to go to faculty or student signup page

  Scenario: Only one user can log in at one time
    When I log in as a student
    Then I will receive message saying I'm already logged in if I attempt to go to admin or faculty login page
    And I will receive message saying I'm already logged in if I attempt to go to admin or faculty signup page
    And I got redirected to homepage

  Scenario: Only one user can log in at one time
    When I log in as a faculty
    Then I will see message saying that I logged in to the system
    And I will receive message saying I'm already logged in if I attempt to go to admin or student login page
    And I will receive message saying I'm already logged in if I attempt to go to admin or student signup page
    And I got redirected to homepage

