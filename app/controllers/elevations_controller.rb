class ElevationsController < ApplicationController
  before_action :set_elevation, only: [:show, :edit, :update, :destroy]

  # GET /elevations
  # GET /elevations.json
  def index
    @elevations = Elevation.all
  end

  # GET /elevations/1
  # GET /elevations/1.json
  def show
  end

  # GET /elevations/new
  def new
    @elevation = Elevation.new
  end

  # GET /elevations/1/edit
  def edit
  end

  # POST /elevations
  # POST /elevations.json
  def create
    @elevation = Elevation.new(elevation_params)

    respond_to do |format|
      if @elevation.save
        format.html { redirect_to @elevation, notice: 'Elevation was successfully created.' }
        format.json { render :show, status: :created, location: @elevation }
      else
        format.html { render :new }
        format.json { render json: @elevation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /elevations/1
  # PATCH/PUT /elevations/1.json
  def update
    respond_to do |format|
      if @elevation.update(elevation_params)
        format.html { redirect_to @elevation, notice: 'Elevation was successfully updated.' }
        format.json { render :show, status: :ok, location: @elevation }
      else
        format.html { render :edit }
        format.json { render json: @elevation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /elevations/1
  # DELETE /elevations/1.json
  def destroy
    # @elevation.destroy
    @elevation.destroy
    respond_to do |format|
      format.html { redirect_to @rack_config, notice: 'Elevation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_elevation
      # @elevation = Elevation.find(params[:id])
      set_rack_config
      @elevation = @rack_config.elevation
    end

    def set_rack_config
      @rack_config = RackConfig.find(params[:rack_config_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def elevation_params
      params.require(:elevation).permit(:sku, :part_number)
    end
end
