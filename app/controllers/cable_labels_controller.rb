class CableLabelsController < ApplicationController
  before_action :set_build, only: :index

  # GET /builds/1/cable_labels
  # GET /builds/1/cable_labels.json
  def index
    respond_to do |format|
      format.csv {
        send_data CableLabel.export(@build),
        filename: "#{@build.customer.name}_CableLabels_#{@build.project_name}.csv"
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cable_label
      @cable_label ||= CableLabel.find(params[:id])
    end

    def set_build
      @build ||= Build.find(params[:build_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cable_label_params
      params.require(:cable_label).permit(*CableLabel.field_keys)
    end
end
