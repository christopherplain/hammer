class RackConfigsController < ApplicationController
  before_action :set_rack_config, only: [:import, :show, :edit, :update, :destroy]
  before_action :set_elevation, only: :show

  # GET /rack_configs
  # GET /rack_configs.json
  def index
    @rack_configs = RackConfig.all
  end

  # POST /import_rack_config
  def import
    RackConfig.import(params[:file], @rack_config)
    redirect_to rack_config_path(@rack_config), notice: "Rack configuration imported."
  end

  # GET /rack_configs/1
  # GET /rack_configs/1.json
  def show
  end

  # GET /rack_configs/new
  def new
    @rack_config = RackConfig.new
  end

  # GET /rack_configs/1/edit
  def edit
  end

  # POST /rack_configs
  # POST /rack_configs.json
  def create
    @rack_config = RackConfig.new(rack_config_params)

    respond_to do |format|
      if @rack_config.save
        format.html { redirect_to @rack_config, notice: 'Rack config was successfully created.' }
        format.json { render :show, status: :created, location: @rack_config }
      else
        format.html { render :new }
        format.json { render json: @rack_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rack_configs/1
  # PATCH/PUT /rack_configs/1.json
  def update
    respond_to do |format|
      if @rack_config.update(rack_config_params)
        format.html { redirect_to @rack_config, notice: 'Rack config was successfully updated.' }
        format.json { render :show, status: :ok, location: @rack_config }
      else
        format.html { render :edit }
        format.json { render json: @rack_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rack_configs/1
  # DELETE /rack_configs/1.json
  def destroy
    @rack_config.destroy
    respond_to do |format|
      format.html { redirect_to rack_configs_url, notice: 'Rack config was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rack_config
      @rack_config ||= RackConfig.find(params[:id])
    end

    def set_elevation
      set_rack_config
      @elevation ||= @rack_config.elevation
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rack_config_params
      params.require(:rack_config).permit(:customer, :sku)
    end
end
