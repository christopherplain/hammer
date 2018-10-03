class LabelTemplatesController < ApplicationController
  before_action :set_label_template, only: [:show, :edit, :update, :destroy]
  before_action :set_build, only: [:index, :new, :create]

  # GET /builds/1/label_templates
  # GET /builds/1/label_templates.json
  def index
    @label_templates = LabelTemplate.all
  end

  # GET /label_templates/1
  # GET /label_templates/1.json
  def show
  end

  # GET /builds/1/label_templates/new
  def new
    @label_template = LabelTemplate.new
  end

  # GET /label_templates/1/edit
  def edit
  end

  # POST /builds/1/label_templates
  # POST /builds/1/label_templates.json
  def create
    @label_template = LabelTemplate.new(label_template_params)

    respond_to do |format|
      if @label_template.save
        format.html { redirect_to @label_template, flash: { success: 'Label format was successfully created.' } }
        format.json { render :show, status: :created, location: @label_template }
      else
        format.html { render :new }
        format.json { render json: @label_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /label_templates/1
  # PATCH/PUT /label_templates/1.json
  def update
    respond_to do |format|
      if @label_template.update(label_template_params)
        format.html { redirect_to @label_template, flash: { success: 'Label format was successfully updated.' } }
        format.json { render :show, status: :ok, location: @label_template }
      else
        format.html { render :edit }
        format.json { render json: @label_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /label_templates/1
  # DELETE /label_templates/1.json
  def destroy
    @label_template.destroy
    respond_to do |format|
      format.html { redirect_to label_templates_url, flash: { success: 'Label format was successfully deleted.' } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_label_template
      @label_template ||= LabelTemplate.find(params[:id])
    end

    def set_build
      @build ||= Build.find(params[:build_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def label_template_params
      params.require(:label_template).permit(*LabelTemplate.field_keys)
    end
end
