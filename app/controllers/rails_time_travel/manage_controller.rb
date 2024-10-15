require_dependency "rails_time_travel/application_controller"

module RailsTimeTravel
  class ManageController < RailsTimeTravel::ApplicationController
    def index
    end

    def set_datetime
      if params[:seconds].present?
        if params[:seconds] == "reset"
          Timecop.return
          session.delete(:timecop_date)
        else
          seconds = params[:seconds].to_i
          session[:timecop_date] = params[:direction] == "future" ? Time.now + seconds.seconds : Time.now - seconds.seconds
        end
      end

      if params[:date].present?
        session[:timecop_date] = Time.parse(params[:date])
      end

      redirect_to action: :index
    end
  end
end
