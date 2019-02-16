require 'rails_helper'
require 'spec_helper'

describe Faculty do
  describe 'id_link method' do
    it 'should return error if id_card and weblink is blank ' do
      @faculty = Faculty.new(:id=> 1,:username => 'Avanti',:first_name => 'Avanti', :last_name=> 'Deshmukh', :email => 'avanti.deshmukh@uiowa.edu',:password=> '12345678', :password_confirmation=> '12345678', :id_card_data => nil, :weblink => nil)
      @faculty.valid?
      expect(@faculty.errors.messages).to eq(:id_card_data=>["Either id card or link to faculty is required"])
    end
  end
end