require 'rails_helper'

RSpec.describe Application, type: :model do
  it { should belong_to(:profile) }
  it { should belong_to(:university) }

  describe 'add_school! method' do
    it 'should update application database with admitted date' do
      Application.add_school!(1,1,'Applied - Accepted','03/06/2019')
      new_date = '2019-03-06'
      allow(Date).to receive(:strptime).with('%m/%d/%Y').and_return(new_date)
      expect(Application.count).to eq(1)
    end
    it 'should update application database with rejected date' do
      Application.add_school!(1,1,'Applied - Rejected','03/06/2019')
      new_date = '2019-03-06'
      allow(Date).to receive(:strptime).with('%m/%d/%Y').and_return(new_date)
      expect(Application.count).to eq(1)
    end
    it 'should update application database with applied date' do
      Application.add_school!(1,1,'Applied - Pending Decision','03/06/2019')
      new_date = '2019-03-06'
      allow(Date).to receive(:strptime).with('%m/%d/%Y').and_return(new_date)
      expect(Application.count).to eq(1)
    end
  end
end
