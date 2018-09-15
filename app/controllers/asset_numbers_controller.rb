class AssetNumbersController < ApplicationController
  before_action :set_asset_number, only: [:show, :edit, :update, :destroy]
  before_action :set_build, only: [:index, :import, :new, :edit, :create, :update]

  # GET /build/1/asset_numbers
  # GET /build/1/asset_numbers.json
  def index
    @asset_numbers = AssetNumber.all
  end

  # POST /build/1/asset_numbers/import
  def import
    AssetNumber.import(params[:file], @build)
    redirect_to build_path(@build), flash: { success: "Asset numbers successfully imported." }
  end

  # GET /asset_numbers/1
  # GET /asset_numbers/1.json
  def show
  end

  # GET /build/1/asset_numbers/new
  def new
    @asset_number = AssetNumber.new
  end

  # GET /asset_numbers/1/edit
  def edit
  end

  # POST /build/1/asset_numbers
  # POST /build/1/asset_numbers.json
  def create
    @asset_number = AssetNumber.new(asset_number_params)

    respond_to do |format|
      if @asset_number.save
        format.html { render :new, flash: { success: 'Asset number was successfully saved.' } }
        format.json { render :show, status: :created, location: @asset_number }
      else
        format.html { render :new }
        format.json { render json: @asset_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asset_numbers/1
  # PATCH/PUT /asset_numbers/1.json
  def update
    respond_to do |format|
      if @asset_number.update(asset_number_params)
        format.html { redirect_to @asset_number, flash: { success: 'Asset number was successfully updated.' } }
        format.json { render :show, status: :ok, location: @asset_number }
      else
        format.html { render :edit }
        format.json { render json: @asset_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_numbers/1
  # DELETE /asset_numbers/1.json
  def destroy
    @asset_number.destroy
    respond_to do |format|
      format.html { redirect_to asset_numbers_url, flash: { success: 'Asset number was successfully deleted.' } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset_number
      @asset_number ||= AssetNumber.find(params[:id])
    end

    def set_build
      @build ||= Build.find(params[:build_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def asset_number_params
      params.require(:asset_number).permit(:id, :expected_asset, :scanned_asset, :rack_component_id)
    end
end
