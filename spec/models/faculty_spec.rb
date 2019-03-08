require 'rails_helper'
require 'spec_helper'

RSpec.describe Faculty, type: :model do
  it { should belong_to(:university) }
  describe 'id_card or weblink method' do
    it 'should return error if id_card and weblink is blank ' do
      @faculty = Faculty.new(:id=> 1,:username => 'Avanti',:first_name => 'Avanti', :last_name=> 'Deshmukh', :email => 'avanti.deshmukh@uiowa.edu',:password=> '12345678', :password_confirmation=> '12345678', :id_card_data => nil, :weblink => nil, :university_id => 1)
      @faculty.valid?
      expect(@faculty.errors.messages).to eq(:id_card_data=>["Either id card or link to faculty is required"])
    end
  end
  describe 'approved method' do
    it 'should return true if faculty is approved by admin ' do
      @faculty = Faculty.new(:id=> 1,:username => 'Avanti',:first_name => 'Avanti', :last_name=> 'Deshmukh', :email => 'avanti.deshmukh@uiowa.edu',:password=> '12345678', :password_confirmation=> '12345678', :id_card_data => 'test', :approved => true, :university_id => 1)
      expect(@faculty.active_for_authentication?).to eq(true)
    end

    it 'return false when faculty got created before getting admin approval' do
      @faculty = Faculty.new(:id=> 1,:username => 'Avanti',:first_name => 'Avanti', :last_name=> 'Deshmukh', :email => 'avanti.deshmukh@uiowa.edu',:password=> '12345678', :password_confirmation=> '12345678', :id_card_data => 'test')
      expect(@faculty.active_for_authentication?).to eq(false)
    end
  end
  describe 'inactive message method' do
    it 'should return not_approved if the faculty is not approved' do
      @faculty = Faculty.new(:id=> 1,:username => 'Avanti',:first_name => 'Avanti', :last_name=> 'Deshmukh', :email => 'avanti.deshmukh@uiowa.edu',:password=> '12345678', :password_confirmation=> '12345678', :id_card_data => 'test', :approved => false)
      expect(@faculty.inactive_message).to eq(:not_approved)
    end
  end
end


