class RackConfigsController < ApplicationController
  before_action :set_rack_config, only: [:import, :show, :edit, :update, :destroy]
  before_action :set_customer, only: [:index, :show, :new, :create, :destroy]

  # GET /customers/1/rack_configs
  # GET /customers/1/rack_configs.json
  def index
    @rack_configs = @customer.rack_configs.order(sku: :asc)
  end

  # POST /rack_configs/1/import
  def import
    RackConfig.import(params[:file], @rack_config)
    redirect_to rack_config_path(@rack_config), flash: { success: "Rack configuration successfully imported." }
  end

  # GET /rack_configs/1
  # GET /rack_configs/1.json
  def show
    respond_to do |format|
      format.html
      format.csv { send_data @rack_config.export,
        filename: "#{@rack_config.customer.name}_RackConfig_#{@rack_config.sku}.csv" }
    end
  end

  # GET /customers/1/rack_configs/new
  def new
    @rack_config = RackConfig.new
  end

  # GET /rack_configs/1/edit
  def edit
    @import = params[:import]
    @components = @rack_config.components.all
    @components.order(row_order: :desc)
  end

  # POST /customers/1/rack_configs
  # POST /customers/1/rack_configs.json
  def create
    @rack_config = RackConfig.new(rack_config_params)
    @rack_config.customer = @customer

    respond_to do |format|
      if @rack_config.save
        format.html { redirect_to @rack_config, flash: { success: 'Rack config was successfully created.' } }
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
        format.html { redirect_to @rack_config, flash: { success: 'Rack config was successfully updated.' } }
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
      format.html { redirect_to customer_rack_configs_path(@customer), flash: { success: 'Rack config was successfully deleted.' } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rack_config
      @rack_config ||= RackConfig.find(params[:id])
    end

    def set_customer
      @customer ||= Customer.find(params[:customer_id]) if params[:customer_id]
      @customer ||= @rack_config.customer
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rack_config_params
      params.require(:rack_config).permit(*RackConfig.field_keys)
    end
end
