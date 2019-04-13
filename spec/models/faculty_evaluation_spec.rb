require 'rails_helper'
require 'spec_helper'

RSpec.describe FacultyEvaluation, type: :model do
  it { should belong_to(:faculty) }
  it { should belong_to(:application)}
end
