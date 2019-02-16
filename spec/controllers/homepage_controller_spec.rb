require 'rails_helper'

RSpec.describe HomepageController, type: :controller do
  it "should successfully get the index call" do
    get :index
    assert_response :success
  end
  it "should generate the index form" do
    get :index
    expect(get(:index)).to render_template('homepage/index')
  end
end
