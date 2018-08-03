class RackComponentsController < ApplicationController
  before_action :set_rack_component, only: [:show, :edit, :update, :destroy]

  # GET /rack_components
  # GET /rack_components.json
  def index
    @rack_components = RackComponent.all
  end

  # GET /rack_components/1
  # GET /rack_components/1.json
  def show
  end

  # GET /rack_components/new
  def new
    @rack_component = RackComponent.new
  end

  # GET /rack_components/1/edit
  def edit
  end

  # POST /rack_components
  # POST /rack_components.json
  def create
    @rack_component = RackComponent.new(rack_component_params)

    respond_to do |format|
      if @rack_component.save
        format.html { redirect_to @rack_component, notice: 'Rack component was successfully created.' }
        format.json { render :show, status: :created, location: @rack_component }
      else
        format.html { render :new }
        format.json { render json: @rack_component.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rack_components/1
  # PATCH/PUT /rack_components/1.json
  def update
    respond_to do |format|
      if @rack_component.update(rack_component_params)
        format.html { redirect_to @rack_component, notice: 'Rack component was successfully updated.' }
        format.json { render :show, status: :ok, location: @rack_component }
      else
        format.html { render :edit }
        format.json { render json: @rack_component.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rack_components/1
  # DELETE /rack_components/1.json
  def destroy
    @rack_component.destroy
    respond_to do |format|
      format.html { redirect_to rack_components_url, notice: 'Rack component was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rack_component
      @rack_component = RackComponent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rack_component_params
      params.require(:rack_component).permit(:u_location, :orientation, :part_number, :sku)
    end
end
