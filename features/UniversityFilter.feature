Feature: Student can view/search universities
  Background:
    Given the following universities have been added to University Database:
      | rank  | university_name  | university_type | acceptance_rate | tuition |location|weather|university_link|university_desc|
      |1|Massachusetts Institute of Technology|Private|18|$49,600|Located in Cambridge, Massachusetts, MIT is located on the north shore of the Charles River Basin. The campus is within 3 miles of two major interstate highways, and is less than 6 miles from Logan international airport. The Kendall (or MIT) Station is at a 5 minute walk from the campus. MIT is roughly a 20 minute walk from downtown Boston, and a 30–40 minute walk from Harvard University, which is located just up the river from the MIT campus.|If there’s any negative about MIT, then this is it. The climate here is of the continental type. Massachusetts receives about 40 inches of rain annually, fairly evenly distributed throughout the year, slightly wetter during the winter.Summers are warm with average high temperatures in July about 26.7 °C and overnight lows about 15.5 °C. Winters are pretty cold though, with temperatures often going sub-zero.|http://www.mit.edu/|Although it’ll no doubt be fascinating and highly inspiring to read about MIT, it could also give you a serious inferiority complex. Because Massachusetts Institute of Technology is perhaps the best overall college in the world, and it makes sure its students are no less. To get into MIT, you need to be excellent in everything, and even that probably won’t be enough. MIT is absolutely top-notch in everything, from infrastructure to faculty to extracurriculars to placements to alumni. An interesting bit of trivia: the aggregated revenues of companies founded by MIT alumni would rank as the eleventh largest economy in the world. Now, that's MIT. We associate only one word with MIT - WOW.|
      |2|Stanford University|Public|17|$16,900|Located 35 miles south of San Francisco and 20 miles north of San Jose, Stanford University is in the heart of Northern California’s dynamic Silicon Valley.|Most students are of the common opinion that the weather at Stanford is pretty good. Apart from the winter months, when it’s slightly cold and wet, the rest of the year is sunny and pleasant. Stanford University area doesn’t receive snowfall and fortunately doesn’t experience extremes of temperature. It’s pretty normal to see people roaming around in shorts and tshirts.|http://www.stanford.edu/|The very famous Stanford University is a private research university with a high output, located in Stanford, California. Simply, if anyone gets into Stanford, she/he takes it blindly, as the acceptance rate is a mere 4.8% and financial aids are among the most generous ones. To get an idea of exactly how competitive Stanford is, you don’t have to look further than the long list of prominent companies founded by Stanford alumni- Google, Hewlett-Packard, LinkedIn, Yahoo, and Sun Microsystems. And that’s not even one tenth of the list. Also, it ranks #3 according to U.S. News' 'Best Global Universities Ranking' list.|
      |15|University of California – Berkeley|Private|14|$28,000|University of California – Berkeley is located in the Bay Area of California, a very in-demand and rather expensive area. The university is roughly 5 miles from Oakland, and 12 miles from San Francisco. Anyone who knows will tell you that UC Berkeley has a fantastic location, with Tilden Park and Berkeley Marina pretty close by.|Berkeley has a Mediterranean climate, though the temperatures in general are rather lower than what you come to expect in, say, Spain. Summers are cool and dry, while winters are cold and wet. Average temperatures in September (the ‘hottest’ month) are a high of 22.1°C and a low of 13.3°C, while average temperatures in January (the coldest month) are a high of 13.6°C and a low of 6.4°C. Berkeley also experiences rainfall once in a while, mainly during winters, and not much. Snowfall is a rare commodity, and normally takes place only on the peaks of hills.|https://www.berkeley.edu/|UC Berkeley is the flagship institute of the University of California. Statistically, Berkeley (as it’s called) is the most consistently well ranked university in the world. It has the highest number of distinguished graduate programs ranked in the top 10 in their fields by the United States National Research Council. As you can probably gauge, it isn’t easy to get into Berkeley, unless you have an untouchable academic track record. And rightly so – some of the achievements at this institute are fantastic. To give you an idea, UC Berkeley and its researchers are associated with 6 chemical elements of the periodic table. Now that’s something, isn’t it?|
      |16|California Institute Of Technology|Public|9|$48,200|Like you probably just read, Caltech is located in Pasadena, which fortunately is just about 18km away from downtown Los Angeles. Sounds like the Best of Both Worlds? Definitely.|Berkeley has a Mediterranean climate, though the temperatures in general are rather lower than what you come to expect in, say, Spain. Summers are cool and dry, while winters are cold and wet. Average temperatures in September (the ‘hottest’ month) are a high of 22.1°C and a low of 13.3°C, while average temperatures in January (the coldest month) are a high of 13.6°C and a low of 6.4°C. Berkeley also experiences rainfall once in a while, mainly during winters, and not much. Snowfall is a rare commodity, and normally takes place only on the peaks of hills.|http://www.caltech.edu/|The highly renowned California Institute of Technology is a private research university started in the year 1891. Located in Pasadena, Caltech has gained a reputation as one of the best technological institutes in the world. Understandably, it receives a massive number of applications from all over the world, including thousands from India. However, it isn’t easy to get in. In fact, Caltech is arguably one of the toughest universities to get into; call it bias, prejudice, or racism, Caltech just doesn’t seem to admit enough Indians. Though we think this perhaps has something to do with the extremely high levels of expectation here, and not much else.|
      |22|University of Michigan - Ann Arbor|Private|25|$47,894|University of Michigan is a 45 minute drive from Detroit, the main city of Michigan. Apart from the University, Ann Arbor is pretty boring but fortunately Detroit is quite accessible.|The one downside of studying at Ann Arbor could be the climate. It snows almost for 8-9 months of the year, making it terribly cold. During fall, you can expect to see sunrays once in a while which is a ‘feel good factor’ for students. It can get pretty gloomy most of the year.|https://umich.edu/|University of Michigan, Ann Arbor, is a public research university which was founded in 1817. UMich is very famous for its research work and has one of the largest research expenditures amongst American Universities.  It is one of the high ranking universities in the States, and thus it’s clearly not easy to get in. Many students still apply, though, putting it in the ‘ambitious’ category, and keeping their fingers firmly crossed.|
      |23|University of Texas at Arlington|Public|55|$25,200|As the name suggests, the university is situated in the large city of Arlington and the enormously huge state of Texas which is densely populated. Arlington is approximately 20 miles from the very famous Dallas and is the seventh largest city in Texas. Being a large city and surrounded by many institutions in the nearby vicinity, Arlington is generally preferred by students from all backgrounds.|Arlington is one of the cities in the US of A where you experience extremely hot summers. The Fall period i.e. July to early October, the climate is pretty hot and humid. Boys are generally seen in shorts and t-shirts while girls (hold your breath boys) don skirts/shorts and spaghettis. Arlington is not one of the places where the winters are something to look for. It snows rarely and is quite bearable yet Indians find it cold. Spring and autumn bring pleasant weather in the city.|https://www.uta.edu/uta/|Founded in 1895, University of Texas at Arlington fondly called as UT Arlington or UTA, is a public research university located in the state of Texas. Even though the university is part of the same group, ‘University of Texas’, the institution is ranked pretty low in the US of A. With the likes of the extremely ambitious Texas Austin and TAMU, followed by the hot favourite Texas at Dallas, Arlington looses out on the big league of Institutions. In spite of this, the college is preferred by a lot of Asians, especially Indians, with just an about average profile for Electrical and Telecomm courses majorly.|

    Given the following students have been added to Student Database:
      | first_name  | last_name  | email          | password  | username          | confirmed_at |
      | Robin       | Hood       | robin@gmail.com  | 12345678    |   robin_hood      | 2019-02-15 02:46:01 UTC |
      | Thomas      | Edison     | thomas@gmail.com  | 23456789    |   thomas_edison   | 2019-02-15 02:46:01 UTC |
      | Frank       | Robert     | frank@gmail.com | 34567890    |   frank_robert    | 2019-02-15 02:46:01 UTC |

  Scenario: Student should not see private universities when public is selected
    When I log in as a student
    And I select Public as type
    Then I should see only Public universities
    And I should not see Private universities

  Scenario: Student should see both private and public universities when all is selected
    When I log in as a student
    And I select All as type
    Then I should see both Public and Private universities

  Scenario: Student should not see universities outside the rank range selected
    When I log in as a student
    And I select 10 as ranking_from and 25 as ranking_to
    Then I should see universities with ranks only between 10 and 25

  Scenario: Student should not see Private universities or outside the rank range when Public and rank range are selected
    When I log in as a student
    And I select Public as type
    And I select 10 as ranking_from and 25 as ranking_to
    Then I should see universities with ranks only between 10 and 25
    And I should see only Public universities
    And I should not see Private universities

  @javascript
  Scenario: Student can search universities do
    When I log in as a student
    And I search universities with Stanford University
    Then I should see only search result with Stanford University


  @javascript
  Scenario: Student should see university information when show button is clicked
    When I log in as a student
    And I search universities with University of Texas at Arlington
    Then I should see only search result with University of Texas at Arlington


