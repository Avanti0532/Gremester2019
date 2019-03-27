class Application < ActiveRecord::Base
  belongs_to :profile
  belongs_to :university

  def self.add_school!(id, univ_id, option, date, term,year)
    new_date = Date.strptime(date, '%m/%d/%Y')
    case option
    when "Applied - Accepted"
      @application = Application::create(profile_id: id, university_id: univ_id, admitted: 'T', admitted_date: new_date,term: term,year: year)
    when "Applied - Rejected"
      @application = Application::create(profile_id: id, university_id: univ_id, rejected: 'T', rejected_date:new_date,term: term,year: year)
    when "Applied - Pending Decision"
      @application = Application::create(profile_id: id, university_id: univ_id, applied: 'T', applied_date: new_date,term: term,year: year)
    end
  end
end
