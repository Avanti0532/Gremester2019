
class Profile < ActiveRecord::Base
  belongs_to :country
  belongs_to :student
  has_many :applications
  has_many :profiles_undergrad_universities
  has_many :undergrad_universities, through: :profiles_undergrad_universities
  has_many :research_interests_profiles
  has_many :research_interests, through: :research_interests_profiles
  include ImageUploader::Attachment.new(:photo_id)
  include DocumentUploader::Attachment.new(:sop)
  include DocumentUploader::Attachment.new(:resume)
  include DocumentUploader::Attachment.new(:additional_attachment)
  validates_inclusion_of :gre_quant, :in => 130..170, allow_blank: true, message: 'must be within the range from 130 to 170'
  validates_inclusion_of :gre_verbal, :in => 130..170, allow_blank: true, message: 'must be within the range from 130 to 170'
  validates_inclusion_of :gre_writing, :in => 0..6, allow_blank: true, message: 'must be within the range from 0 to 6.0'
  validates_inclusion_of :toefl, :in => 0..120, allow_blank: true, message: 'must be within the range from 0 to 120'
  validates_presence_of :student_id


  def update_gre_quant(score)
    self.gre_quant = score
  end

  def update_gre_verbal(score)
    self.gre_verbal = score
  end

  def update_gre_writing(score)
    self.gre_writing = score
  end

  def update_toefl(toefl)
    self.toefl = toefl
  end

  def update_interested_term(interested_term)
    self.interested_term = interested_term
  end

  def update_interested_year(interested_year)
    self.interested_year = interested_year
  end

  def update_year_work_experience(year_work_exp)
    self.year_work_exp = year_work_exp
  end


  def update_resume_data(resume_data)
    self.resume_data = resume_data
  end

  def update_sop_data(sop_data)
    self.sop_data = sop_data
  end

  def update_additional_attachment_data(additional_attachment_data)
    self.additional_attachment_data = additional_attachment_data
  end

end
