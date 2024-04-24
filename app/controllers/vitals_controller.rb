class VitalsController < ApplicationController
  before_action :set_vital, only: %i[ show edit update destroy chart ]
  before_action { authorize(@vital || Vital) }

  # GET /vitals or /vitals.json
  def index
    @breadcrumbs = [
      { content: "Vitals", href: vitals_path },
    ]
    @vitals = policy_scope(Vital)
  end

  # GET /vitals/new
  def new
    @vital = Vital.new
  end

  def edit
    @breadcrumbs = [
      { content: "Vitals", href: vitals_path },
      { content: "Edit #{@vital.to_s}", href: edit_vital_path },
    ]
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
    if @vital.readings.exists?
      respond_to do |format|
        format.html { redirect_to vitals_url, alert: "Vital cannot be deleted because it has associated readings." }
        format.json { render json: { error: "Vital cannot be deleted because it has associated readings." }, status: :unprocessable_entity }
      end
    else
      @vital.destroy
      respond_to do |format|
        format.html { redirect_to vitals_url, notice: "Vital was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  def chart
    @breadcrumbs = [
      { content: "Vitals", href: vitals_path },
      { content: "#{@vital.to_s} Chart", href: vital_chart_path },
    ]
    start_date = params[:start_date].presence || 1.month.ago.beginning_of_day.to_date
    end_date = params[:end_date].presence || Date.current

    @readings_for_chart = @vital.chart_data(start_date, end_date)
    flash[:alert] = "Selected vital is not numerical or doesn't exist." if @readings_for_chart.empty?
  end

  private

  def set_vital
    @vital = Vital.find(params[:id])
  end

  def vital_params
    params.require(:vital).permit(:name, :category)
  end
end
