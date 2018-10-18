class AssetNumbersController < ApplicationController
  before_action :set_build, only: :index

  # GET /build/1/asset_numbers
  # GET /build/1/asset_numbers.json
  def index
    respond_to do |format|
      format.csv {
        send_data AssetNumber.export(@build),
        filename: "#{@build.customer.name}_AssetNumbers_#{@build.sales_order}.csv"
      }
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
      params.require(:asset_number).permit(*AssetNumber.field_keys)
    end
end
