class BuildsController < ApplicationController
  before_action :set_build, only: [:import, :show, :edit, :update, :destroy]
  before_action :set_customer, only: [:index , :new, :create]

  # GET /customers/1/builds
  # GET /customers/1/builds.json
  def index
    @builds = @customer.builds.order(project_name: :asc)
  end

  # POST /builds/1/import
  def import
    Build.import(params[:file], @build)
    redirect_to build_path(@build), flash: { success: "Build successfully imported." }
  end

  # GET /builds/1
  # GET /builds/1.json
  def show
    respond_to do |format|
      format.html { @rack_config = @build.rack_config }
      format.csv {
        send_data @build.export,
        filename: "#{@build.customer.name}_Build_#{@build.project_name}.csv"
      }
    end
  end

  # GET /customers/1/builds/new
  def new
    @build = @customer.builds.new
  end

  # GET /builds/1/edit
  def edit
  end

  # POST /customers/1/builds
  # POST /customers/1/builds.json
  def create
    @build = @customer.builds.new(build_params)

    respond_to do |format|
      if @build.save
        LabelTemplate.generate(@build)
        CableLabel.generate(@build)

        format.html { redirect_to @build, flash: { success: 'Build was successfully created.' } }
        format.json { render :show, status: :created, location: @build }
      else
        format.html { render :new }
        format.json { render json: @build.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /builds/1
  # PATCH/PUT /builds/1.json
  def update
    respond_to do |format|
      if @build.update_attributes(build_params)
        format.html { redirect_to @build, flash: { success: 'Build was successfully updated.' } }
        format.json { render :show, status: :ok, location: @build }
      else
        format.html { render :edit }
        format.json { render json: @build.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /builds/1
  # DELETE /builds/1.json
  def destroy
    customer = @build.customer
    @build.destroy
    respond_to do |format|
      format.html { redirect_to customer_builds_path(customer), flash: { success: 'Build was successfully deleted.' } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_build
      @build ||= Build.find(params[:id])
    end

    def set_customer
      @customer ||= Customer.find(params[:customer_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def build_params
      params.require(:build).permit(
        *Build.field_keys,
        asset_numbers_attributes: [:id, *AssetNumber.field_keys],
        cable_labels_attributes: [:id, *CableLabel.field_keys],
        label_templates_attributes: [:id, *LabelTemplate.field_keys],
        serial_numbers_attributes: [:id, *SerialNumber.field_keys]
      )
    end
end
