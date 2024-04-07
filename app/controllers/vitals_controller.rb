class VitalsController < ApplicationController
  before_action :set_vital, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /vitals or /vitals.json
  def index
    @vitals = current_user.vitals
  end

  # GET /vitals/1 or /vitals/1.json
  def show
  end

  # GET /vitals/new
  def new
    @vital = Vital.new
  end

  # GET /vitals/1/edit
  def edit
  end

  # POST /vitals or /vitals.json 
  def create
    @vital = current_user.vitals.new(vital_params)

    respond_to do |format|
      if @vital.save
        format.html { redirect_to vitals_path, notice: "Vital was successfully created." }
        format.json { render :show, status: :created, location: @vital }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vital.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vitals/1 or /vitals/1.json
  def update
    respond_to do |format|
      if @vital.update(vital_params)
        format.html { redirect_to vital_url(@vital), notice: "Vital was successfully updated." }
        format.json { render :show, status: :ok, location: @vital }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vital.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vitals/1 or /vitals/1.json
  def destroy
    begin
      @vital.destroy

      respond_to do |format|
        format.html { redirect_to vitals_url, notice: 'Vital was successfully destroyed.' }
        format.json { head :no_content }
      end
    rescue ActiveRecord::InvalidForeignKey
      message = 'Vital cannot be deleted because it has associated readings.'

      respond_to do |format|
        format.html { redirect_to vitals_url, alert: message }
        format.json { render json: { error: message }, status: :unprocessable_entity }
      end
    end
  end

  # For chart actions
  def chart
    @selected_vital = current_user.vitals.find_by(id: params[:vital_id])
  
    # Default date range to the last month if no specific range is provided
    start_date = params[:start_date].presence || 1.month.ago.beginning_of_day.to_date
    end_date = params[:end_date].presence || Date.current
    
    if @selected_vital&.numerical?
      @readings_for_chart = @selected_vital.readings
                              .where(measured_at: start_date..end_date)
                              .group_by_day(:measured_at)
                              .average(:numeric_reading)
    else
      @readings_for_chart = {}
      flash[:alert] = "Selected vital is not numerical or doesn't exist."
    end
  end
  
  # def chart
  #   @selected_vital = current_user.vitals.find_by(id: params[:vital_id])
    
  #   if @selected_vital&.numerical?
  #     case params[:time_frame]
  #     when '2_weeks'
  #       start_date = 2.weeks.ago.beginning_of_day
  #       @readings_for_chart = @selected_vital.readings.where('measured_at >= ?', start_date)
  #     when '6_months'
  #       start_date = 6.months.ago.beginning_of_day
  #       @readings_for_chart = @selected_vital.readings.where('measured_at >= ?', start_date)
  #     when '1_year'
  #       start_date = 1.year.ago.beginning_of_day
  #       @readings_for_chart = @selected_vital.readings.where('measured_at >= ?', start_date)
  #     else
  #       @readings_for_chart = @selected_vital.readings
  #     end
  
  #     @readings_for_chart = @readings_for_chart.group_by_day(:measured_at).average(:numeric_reading)
  #   else
  #     @readings_for_chart = {}
  #     flash[:alert] = "Selected vital is not numerical or doesn't exist."
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vital
      @vital = Vital.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vital_params
      params.require(:vital).permit(:name, :category)
    end
  end