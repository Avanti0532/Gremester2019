require 'spec_helper'
require 'rails_helper'

describe ApplicationsController do
  describe 'show schools on edit' do
    before :each do
      @application = Application.new(id: 1, profile_id: 1, university_id: 1, applied: 't', applied_date: '2019-01-02', admitted: 't', admitted_date: '2019-03-05', rejected: '', rejected_date:'')
      @application.save
      @university = University.new(id: 1, rank: 1, university_name: 'Stanford University')
      @university.save
      @application1 = double("applications")
    end
    it 'should call method show method' do
      expect(Application).to receive(:find).and_return(@application)
      format = double("format")
      format.should_receive(:json).and_return(@application1)
      controller.should_receive(:respond_to).and_yield(format)
      xhr :get, :show, {"id"=>"1", "application"=>{}}
    end
  end
  describe 'update application dates' do
    before :each do
      @application = Application.new(id: 1, profile_id: 1, university_id: 1, applied: 't', applied_date: '2019-01-02', admitted: '', admitted_date: '', rejected: '', rejected_date:'')
      @application.save
    end
    it 'should redirect to schools of interest page on successful update' do
      expect(Application).to receive(:find).and_return(@application)
      post :update, {"id"=>"1", "applied_date"=>"2019-01-02", "admitted_date"=>"2019-03-31", "rejected_date"=>"", "application"=>{"id"=>"1", "applied_date"=>"2019-01-02", "admitted_date"=>"2019-03-31", "rejected_date"=>""}}
      parse_json = JSON(response.body)
      expect(response).to have_http_status(200)
      parse_json["result"].should == 1
    end
    it 'should redirect to schools of interest with error message on unsuccessful update' do
      expect(Application).to receive(:find).and_return(@application)
      allow_any_instance_of(Application).to receive(:save).and_return(false)
      Application.any_instance.stub_chain("errors.full_messages").and_return(["error1","error2"])
      post :update, {"id"=>"1", "applied_date"=>"2019-01-02", "admitted_date"=>"2019", "rejected_date"=>"", "application"=>{"id"=>"1", "applied_date"=>"2019-01-02", "admitted_date"=>"2019-03-31", "rejected_date"=>""}}
      expect(response).to redirect_to(show_profiles_path(@application.profile_id))
    end
    it 'should return error for unsuccessful update on ajax call' do
      expect(Application).to receive(:find).and_return(@application)
      allow_any_instance_of(Application).to receive(:save).and_return(false)
      Application.any_instance.stub_chain("errors.full_messages").and_return(["error1","error2"])
      xhr :post, :update, {"id"=>"1", "applied_date"=>"2019-01-02", "admitted_date"=>"2019", "rejected_date"=>"", "application"=>{"id"=>"1", "applied_date"=>"2019-01-02", "admitted_date"=>"2019-03-31", "rejected_date"=>""}}
      parse_json = JSON(response.body)
      parse_json["result"].should == "error1 error2 "
    end
  end
end
