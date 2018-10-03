class CableLabelsController < ApplicationController
  before_action :set_cable_label, only: [:show, :edit, :update, :destroy]
  before_action :set_build, only: [:index, :new, :create]

  # GET /builds/1/cable_labels
  # GET /builds/1/cable_labels.json
  def index
    @cable_labels = CableLabel.all
  end

  # GET /cable_labels/1
  # GET /cable_labels/1.json
  def show
  end

  # GET /builds/1/cable_labels/new
  def new
    @cable_label = CableLabel.new
  end

  # GET /cable_labels/1/edit
  def edit
  end

  # POST /builds/1/cable_labels
  # POST /builds/1/cable_labels.json
  def create
    @cable_label = CableLabel.new(cable_label_params)

    respond_to do |format|
      if @cable_label.save
        format.html { redirect_to @cable_label, flash: { success: 'Cable label was successfully created.' } }
        format.json { render :show, status: :created, location: @cable_label }
      else
        format.html { render :new }
        format.json { render json: @cable_label.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cable_labels/1
  # PATCH/PUT /cable_labels/1.json
  def update
    respond_to do |format|
      if @cable_label.update(cable_label_params)
        format.html { redirect_to @cable_label, flash: { success: { 'Cable label was successfully updated.' } }
        format.json { render :show, status: :ok, location: @cable_label }
      else
        format.html { render :edit }
        format.json { render json: @cable_label.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cable_labels/1
  # DELETE /cable_labels/1.json
  def destroy
    @cable_label.destroy
    respond_to do |format|
      format.html { redirect_to cable_labels_url, flash: { success: { 'Cable label was successfully deleted.' } }
      format.json { head :no_content }
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
