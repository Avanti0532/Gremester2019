require 'rails_helper'
require 'spec_helper'

RSpec.describe Profile, type: :model do
  it { should belong_to(:student) }
  it { should have_many(:applications) }
  it { should validate_presence_of(:student_id) }
  it { should validate_inclusion_of(:gre_quant).in_range(130..170).with_message("GRE Quantitative score must be within the range from 130 to 170")}
  it { should validate_inclusion_of(:gre_verbal).in_range(130..170).with_message("GRE Verbal score must be within the range from 130 to 170")}
  it { should validate_inclusion_of(:gre_writing).in_range(0..6).with_message("GRE Writing score must be within the range from 0 to 6.0")}
  it { should validate_inclusion_of(:toefl).in_range(0..120).with_message("TOEFL score must be within the range from 0 to 120")}
  it { should validate_numericality_of(:cgpa).is_greater_than_or_equal_to(0).with_message("GPA must be greater than or equal to 0")}
  it { should validate_numericality_of(:year_work_exp).is_greater_than_or_equal_to(0).with_message("Years of experience must be greater than or equal to 0")}
  it { should validate_numericality_of(:month_work_exp).is_greater_than_or_equal_to(0).with_message("Months of experience must be greater than or equal to 0")}

  context "Updating profile field" do
    it "should update gre quant field of the profile" do
      student = Student.new(id: 1, first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'test12345', username: 'test')
      mock_profile = Profile.new(gre_quant: 150, gre_verbal: 130, gre_writing: 3.0, toefl: 100, cgpa: 3.4, interested_major: 'Computer Science', interested_term: 'fall', interested_year: 2019)
      mock_profile.update_gre_quant(170)
      student.profile = mock_profile
      assert(student.current_profile.gre_quant).eql?(170)
    end

    it "should update gre writing field of the profile" do
      student = Student.new(id: 1, first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'test12345', username: 'test')
      mock_profile = Profile.new(gre_quant: 150, gre_verbal: 130, gre_writing: 3.0, toefl: 100, cgpa: 3.4, interested_major: 'Computer Science', interested_term: 'fall', interested_year: 2019)
      mock_profile.update_gre_writing(4.0)
      student.profile = mock_profile
      assert(student.current_profile.gre_writing).eql?(4.0)
    end

    it "should update gre verbal field of the profile" do
      student = Student.new(id: 1, first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'test12345', username: 'test')
      mock_profile = Profile.new(gre_quant: 150, gre_verbal: 130, gre_writing: 3.0, toefl: 100, cgpa: 3.4, interested_major: 'Computer Science', interested_term: 'fall', interested_year: 2019)
      mock_profile.update_gre_verbal(140)
      student.profile = mock_profile
      assert(student.current_profile.gre_quant).eql?(140)
    end

    it "should update toefl field of the profile" do
      student = Student.new(id: 1, first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'test12345', username: 'test')
      mock_profile = Profile.new(gre_quant: 150, gre_verbal: 130, gre_writing: 3.0, toefl: 100, cgpa: 3.4, interested_major: 'Computer Science', interested_term: 'fall', interested_year: 2019)
      mock_profile.update_toefl(120)
      student.profile = mock_profile
      assert(student.current_profile.toefl).eql?(120)
    end

    it "should update cgpa field of the profile" do
      student = Student.new(id: 1, first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'test12345', username: 'test')
      mock_profile = Profile.new(gre_quant: 150, gre_verbal: 130, gre_writing: 3.0, toefl: 100, cgpa: 3.4, interested_major: 'Computer Science', interested_term: 'fall', interested_year: 2019)
      mock_profile.update_cgpa(4.0)
      student.profile = mock_profile
      assert(student.current_profile.cgpa).eql?(4.0)
    end
    #
    it "should update month of exeprience field of the profile" do
      student = Student.new(id: 1, first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'test12345', username: 'test')
      mock_profile = Profile.new(gre_quant: 150, gre_verbal: 130, gre_writing: 3.0, toefl: 100, cgpa: 3.4, interested_major: 'Computer Science', interested_term: 'fall', interested_year: 2019, month_work_exp: 4)
      mock_profile.update_month_work_experience(12)
      student.profile = mock_profile
      assert(student.current_profile.month_work_exp).eql?(12)
    end

    it "should update year of experience field of the profile" do
      student = Student.new(id: 1, first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'test12345', username: 'test')
      mock_profile = Profile.new(gre_quant: 150, gre_verbal: 130, gre_writing: 3.0, toefl: 100, cgpa: 3.4, interested_major: 'Computer Science', interested_term: 'fall', interested_year: 2019, year_work_exp: 0)
      mock_profile.update_year_work_experience(4)
      student.profile = mock_profile
      assert(student.current_profile.year_work_exp).eql?(4)
    end

    it "should update interested major field of the profile" do
      student = Student.new(id: 1, first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'test12345', username: 'test')
      mock_profile = Profile.new(gre_quant: 150, gre_verbal: 130, gre_writing: 3.0, toefl: 100, cgpa: 3.4, interested_major: 'Computer Science', interested_term: 'fall', interested_year: 2019)
      mock_profile.update_interested_major("Computer Engineering")
      student.profile = mock_profile
      assert(student.current_profile.interested_major).eql?("Computer Engineering")
    end

    it "should update interested term field of the profile" do
      student = Student.new(id: 1, first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'test12345', username: 'test')
      mock_profile = Profile.new(gre_quant: 150, gre_verbal: 130, gre_writing: 3.0, toefl: 100, cgpa: 3.4, interested_major: 'Computer Science', interested_term: 'fall', interested_year: 2019)
      mock_profile.update_interested_term("Fall")
      student.profile = mock_profile
      assert(student.current_profile.interested_term).eql?("Fall")
    end

    it "should update interested year field of the profile" do
      student = Student.new(id: 1, first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'test12345', username: 'test')
      mock_profile = Profile.new(gre_quant: 150, gre_verbal: 130, gre_writing: 3.0, toefl: 100, cgpa: 3.4, interested_major: 'Computer Science', interested_term: 'fall', interested_year: 2019)
      mock_profile.update_interested_year(2020)
      student.profile = mock_profile
      assert(student.current_profile.interested_term).eql?(2020)
    end

    it "should update sop field of the profile" do
      student = Student.new(id: 1, first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'test12345', username: 'test')
      mock_profile = Profile.new(gre_quant: 150, gre_verbal: 130, gre_writing: 3.0, toefl: 100, cgpa: 3.4, interested_major: 'Computer Science', interested_term: 'fall', interested_year: 2019, sop_data: 'sop')
      mock_profile.update_sop_data("testing sop")
      student.profile = mock_profile
      assert(student.current_profile.sop_data.eql?("testing sop"))
    end

    it "should update resume field of the profile" do
      student = Student.new(id: 1, first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'test12345', username: 'test')
      mock_profile = Profile.new(gre_quant: 150, gre_verbal: 130, gre_writing: 3.0, toefl: 100, cgpa: 3.4, interested_major: 'Computer Science', interested_term: 'fall', interested_year: 2019, resume_data: 'resume')
      mock_profile.update_resume_data("testing resume")
      student.profile = mock_profile
      assert(student.current_profile.resume_data.eql?("testing resume"))
    end


    it "should update additional text field of the profile" do
      student = Student.new(id: 1, first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'test12345', username: 'test')
      mock_profile = Profile.new(gre_quant: 150, gre_verbal: 130, gre_writing: 3.0, toefl: 100, cgpa: 3.4, interested_major: 'Computer Science', interested_term: 'fall', interested_year: 2019, additional_attachment_data: 'additional_attachment')
      mock_profile.update_additional_attachment_data("testing additional attachment")
      student.profile = mock_profile
      assert(student.current_profile.additional_attachment_data.eql?("testing additional attachment"))
    end

    it "should update college field of the profile" do
      student = Student.new(id: 1, first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'test12345', username: 'test')
      mock_profile = Profile.new(gre_quant: 150, gre_verbal: 130, gre_writing: 3.0, toefl: 100, cgpa: 3.4, interested_major: 'Computer Science', interested_term: 'fall', interested_year: 2019, college: 'University of Iowa')
      mock_profile.update_college("Iowa State")
      student.profile = mock_profile
      assert(student.current_profile.college.eql?("Iowa State"))
    end

  end
end
