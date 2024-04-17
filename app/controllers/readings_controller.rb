class ReadingsController < ApplicationController
  before_action :set_reading, only: %i[ show edit update destroy ]
  before_action { authorize(@reading || Reading) }

  # GET /readings or /readings.json
  def index
    @readings = policy_scope(Reading).order(measured_at: :asc)
  
    if @readings.exists?
      @calendar, @pagy, @readings = pagy_calendar(@readings, 
                                                  year: { size: [1, 1, 1, 1] }, 
                                                  month: { size: [0, 12, 12, 0] },
                                                  day: { size: [0, 31, 31, 0] }, 
                                                  pagy: { items: 10 })
    end
  end

  # GET /readings/new
  def new
    @reading = Reading.new
    @user_vitals = current_user.vitals
  end

  # GET /readings/1/edit
  def edit
    @user_vitals = current_user.vitals
  end

  # POST /readings or /readings.json
  def create
    vital = current_user.vitals.find(params[:reading][:vital_id])
    @reading = Reading.new(reading_params.merge(user_id: current_user.id, vital_id: vital.id))

    if @reading.save
      redirect_to @reading, notice: "Reading was successfully created."
    else
      @user_vitals = current_user.vitals
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /readings/1 or /readings/1.json
  def update
    respond_to do |format|
      if @reading.update(reading_params)
        format.html { redirect_to reading_url(@reading), notice: "Reading was successfully updated." }
        format.json { render :show, status: :ok, location: @reading }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reading.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /readings/1 or /readings/1.json
  def destroy
    @reading.destroy

    respond_to do |format|
      format.html { redirect_to readings_url, notice: "Reading was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_reading
      @reading = Reading.find(params[:id])
    end

    def reading_params
      params.require(:reading).permit(:measured_at, :numeric_reading, :text_reading, :vital_id, :image)
    end

    # Pagy Calendar Pagination Methods

    def pagy_calendar_period(collection)
      # Return the starting and ending times for your readings
      starting = collection.minimum(:measured_at)
      ending = collection.maximum(:measured_at)
      [starting, ending]
    end
  
    def pagy_calendar_filter(collection, from, to)
      # Filter your collection based on selected period
      collection.where(measured_at: from...to)
    end
end
