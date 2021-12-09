class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[ show edit update destroy ]
  before_action :logged_in, only: %i[ appoint cAppoint dApp ]

  # GET /appointments or /appointments.json
  def index
    @appointments = Appointment.all
  end

  # GET /appointments/1 or /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments or /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @appointment, notice: "Appointment was successfully created." }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1 or /appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to @appointment, notice: "Appointment was successfully updated." }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1 or /appointments/1.json
  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: "Appointment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def appoint
    @appointment = Appointment.new
    @restau = Restaurant.find_by(name: params[:name])
  end

  def cAppoint
    @restau = Restaurant.find_by(name: params[:name])
    time = " ".concat(params[:appointment][:start_time])
    startTime = Date.today.to_s.concat(time).to_datetime
    ppl = params[:appointment][:people_amount].blank? ? 0 : params[:appointment][:people_amount]
    tab = params[:appointment][:table_number].blank? ? 0 : Table.find_by(table_number: params[:appointment][:table_number], restaurant_id: @restau.id).id
    #puts "===ppl : #{ppl}======== table : #{tab}========#{startTime}"

    @appointment = Appointment.new({user_id: @user.id, table_id: tab, start_time: startTime, people_amount: ppl})
    respond_to do |format|
      if @appointment.save
        format.html { redirect_to home_path, notice: "Appointment was successfully created." }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :appoint, status: :unprocessable_entity }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end

  end

  def dApp
    @appointment = Appointment.find(params[:id])

    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to home_path, notice: "Appointment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Check user login
    def logged_in
      if(session[:user_id])
        @user = User.find_by(id: session[:user_id])
        return true
      else
        redirect_to main_path, notice: "you did not login"
      end
    end

    # Only allow a list of trusted parameters through.
    def appointment_params
      params.require(:appointment).permit(:user_id, :table_id, :start_time, :people_amount, :table_number)
    end
end
