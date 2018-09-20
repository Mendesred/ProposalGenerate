class RotationsController < ApplicationMainController
  before_action :set_rotation, only: [:show, :edit, :update, :destroy]

  # GET /rotations
  # GET /rotations.json
  def index
    @rotations = Rotation.all
  end

  # GET /rotations/1
  # GET /rotations/1.json
  def show
  end

  # GET /rotations/new
  def new
    @rotation = Rotation.new
    select_period
  end

  # GET /rotations/1/edit
  def edit
    select_period
  end

  # POST /rotations
  # POST /rotations.json
  def create
    @rotation = Rotation.new(rotation_params)

    respond_to do |format|
      if @rotation.save
        format.html { redirect_to @rotation, notice: 'Rotation was successfully created.' }
        format.json { render :show, status: :created, location: @rotation }
      else
        format.html { render :new }
        format.json { render json: @rotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rotations/1
  # PATCH/PUT /rotations/1.json
  def update
    respond_to do |format|
      if @rotation.update(rotation_params)
        format.html { redirect_to @rotation, notice: 'Rotation was successfully updated.' }
        format.json { render :show, status: :ok, location: @rotation }
      else
        format.html { render :edit }
        format.json { render json: @rotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rotations/1
  # DELETE /rotations/1.json
  def destroy
    @rotation.destroy
    respond_to do |format|
      format.html { redirect_to rotations_url, notice: 'Rotation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def select_period
      @select_all_period = Period.all      
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_rotation
      @rotation = Rotation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rotation_params
      delocalize_config = { :intermunicipal => :number }
      params.require(:rotation).permit(:tipo_escala, :dias_trabalhados, :qtd_funcionarios, :v_reciclagem, :efetivo, :fator_escala, :period_id, :ad_vespertido_noturno, :ad_noturno, :Dias_trabalhados_mes).delocalize(delocalize_config)
    end
end
