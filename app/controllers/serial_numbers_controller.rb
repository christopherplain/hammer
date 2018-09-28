class SerialNumbersController < ApplicationController
  before_action :set_serial_number, only: [:show, :edit, :update, :destroy]
  before_action :set_build, only: [:index, :create, :new]

  # GET /builds/1/serial_numbers
  # GET /builds/1/serial_numbers.json
  def index
    @serial_numbers = SerialNumber.all
  end

  # GET /serial_numbers/1
  # GET /serial_numbers/1.json
  def show
  end

  # GET /builds/1/serial_numbers/new
  def new
    @serial_number = SerialNumber.new
    @serial_numbers = SerialNumber.prep_scan(@build)
  end

  # GET /serial_numbers/1/edit
  def edit
  end

  # POST /builds/1/serial_numbers
  # POST /builds/1/serial_numbers.json
  def create
    old_serials = @build.serial_numbers.all

    respond_to do |format|
      params[:serial_numbers].each do |hash|
      sn_params = hash.permit(SerialNumber.field_keys)
      serial_number = @build.serial_numbers.build(sn_params)

        if serial_number.save!
          old_serials.where(component_id: serial_number.component.id).destroy
        else
          format.html { render :new }
          format.json { render json: serial_number.errors, status: :unprocessable_entity }
        end

        format.html { redirect_to @build, flash: { success: 'Serial numbers were successfully saved.' } }
        format.json { render :show, status: :created }
      end
    end
  end

  # PATCH/PUT /serial_numbers/1
  # PATCH/PUT /serial_numbers/1.json
  def update
    respond_to do |format|
      if @serial_number.update(serial_number_params)
        format.html { redirect_to @serial_number, flash: { success: 'Serial number was successfully updated.' } }
        format.json { render :show, status: :ok, location: @serial_number }
      else
        format.html { render :edit }
        format.json { render json: @serial_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /serial_numbers/1
  # DELETE /serial_numbers/1.json
  def destroy
    @serial_number.destroy
    respond_to do |format|
      format.html { redirect_to serial_numbers_url, flash: { success: 'Serial number was successfully deleted.' } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_serial_number
      @serial_number ||= SerialNumber.find(params[:id])
    end

    def set_build
      @build ||= Build.find(params[:build_id]) if params[:build_id]
      @build ||= @serial_number.build
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def serial_number_params
      params.require(:serial_number).permit(SerialNumber.field_keys)
    end
end
