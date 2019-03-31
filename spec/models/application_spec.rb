require 'rails_helper'

RSpec.describe Application, type: :model do
  it { should belong_to(:profile) }
  it { should belong_to(:university) }

  describe 'add_school! method' do
    it 'should update application database with admitted date' do
      Application.add_school!(1,1,'Applied - Accepted','2019-03-06','Fall','2019')
      expect(Application.count).to eq(1)
    end
    it 'should update application database with rejected date' do
      Application.add_school!(1,1,'Applied - Rejected','2019-03-06','Fall','2020')
      expect(Application.count).to eq(1)
    end
    it 'should update application database with applied date' do
      Application.add_school!(1,1,'Applied - Pending Decision','2019-03-06', 'Fall','2021')
      expect(Application.count).to eq(1)
    end
  end
end
