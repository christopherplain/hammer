class NetworkConnectionsController < ApplicationController
  before_action :set_network_connection, only: [:show, :edit, :update, :destroy]

  # GET /network_connections
  # GET /network_connections.json
  def index
    @network_connections = NetworkConnection.all
  end

  # GET /network_connections/1
  # GET /network_connections/1.json
  def show
  end

  # GET /network_connections/new
  def new
    @network_connection = NetworkConnection.new
  end

  # GET /network_connections/1/edit
  def edit
  end

  # POST /network_connections
  # POST /network_connections.json
  def create
    @network_connection = NetworkConnection.new(network_connection_params)

    respond_to do |format|
      if @network_connection.save
        format.html { redirect_to @network_connection, notice: 'Network connection was successfully created.' }
        format.json { render :show, status: :created, location: @network_connection }
      else
        format.html { render :new }
        format.json { render json: @network_connection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /network_connections/1
  # PATCH/PUT /network_connections/1.json
  def update
    respond_to do |format|
      if @network_connection.update(network_connection_params)
        format.html { redirect_to @network_connection, notice: 'Network connection was successfully updated.' }
        format.json { render :show, status: :ok, location: @network_connection }
      else
        format.html { render :edit }
        format.json { render json: @network_connection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /network_connections/1
  # DELETE /network_connections/1.json
  def destroy
    @network_connection.destroy
    respond_to do |format|
      format.html { redirect_to network_connections_url, notice: 'Network connection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_network_connection
      @network_connection = NetworkConnection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def network_connection_params
      params.require(:network_connection).permit(:device1_port, :device2_port, :cable_type, :cable_color, :cable_length)
    end
end
