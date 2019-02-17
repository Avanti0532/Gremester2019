require 'rails_helper'

RSpec.describe Faculty, type: :model do
  describe 'approved method' do
    it 'should return true if faculty is approved by admin ' do
      @faculty = Faculty.new(:id=> 1,:username => 'Avanti',:first_name => 'Avanti', :last_name=> 'Deshmukh', :email => 'avanti.deshmukh@uiowa.edu',:password=> '12345678', :password_confirmation=> '12345678', :id_card_data => 'test', :approved => true)
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

