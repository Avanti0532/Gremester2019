class ApplicationsController < ApplicationController
  protect_from_forgery except: "show"
  def profile_params
    params.require(:application).permit(:id, :profile_id, :university_id, :applied, :applied_date, :admitted, :admitted_date, :rejected, :rejected_date)
  end
  def show
    id = params[:id]
    @application = Application.find(id)
    @application1 = @application.as_json
    @application1.merge! "uni_name" => @application.university.university_name
    respond_to do |format|
      if request.xhr? then
        format.json { render :json => @application1 }
      end
    end
  end

  def update
    @app_id = profile_params[:id]
    @applied_date = profile_params[:applied_date]
    @admitted_date = profile_params[:admitted_date]
    @rejected_date = profile_params[:rejected_date]
    @application = Application.find(@app_id)
    @application.applied_date = @applied_date
    @application.applied = true unless @applied_date.blank?
    @application.admitted_date = @admitted_date
    @application.admitted = true unless @admitted_date.blank?
    @application.rejected_date = @rejected_date
    @application.rejected = true unless @rejected_date.blank?
    @application.save(:validate => true)
    if !@application.errors.full_messages.empty?
      error = ''
      @application.errors.full_messages.each do |message|
        error = error + message + ' '
      end
      flash.now[:notice] = error
      if request.xhr? then
        render :json => {'result' => error}
      else
        redirect_to show_profiles_path(@application.profile_id)
      end
    else
      flash[:notice] = 'Edit is successful'
      render :json => {'result' => 1}
    end
  end
end
