class TypeEquipamentsController < ApplicationMainController
  before_action :set_type_equipament, only: [:show, :edit, :update, :destroy]

  # GET /type_equipaments
  # GET /type_equipaments.json
  def index
    @type_equipaments = TypeEquipament.all
  end

  # GET /type_equipaments/1
  # GET /type_equipaments/1.json
  def show
  end

  # GET /type_equipaments/new
  def new
    @type_equipament = TypeEquipament.new
  end

  # GET /type_equipaments/1/edit
  def edit
  end

  # POST /type_equipaments
  # POST /type_equipaments.json
  def create
    @type_equipament = TypeEquipament.new(type_equipament_params)

    respond_to do |format|
      if @type_equipament.save
        format.html { redirect_to @type_equipament, notice: 'Type equipament was successfully created.' }
        format.json { render :show, status: :created, location: @type_equipament }
      else
        format.html { render :new }
        format.json { render json: @type_equipament.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /type_equipaments/1
  # PATCH/PUT /type_equipaments/1.json
  def update
    respond_to do |format|
      if @type_equipament.update(type_equipament_params)
        format.html { redirect_to @type_equipament, notice: 'Type equipament was successfully updated.' }
        format.json { render :show, status: :ok, location: @type_equipament }
      else
        format.html { render :edit }
        format.json { render json: @type_equipament.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /type_equipaments/1
  # DELETE /type_equipaments/1.json
  def destroy
    @type_equipament.destroy
    respond_to do |format|
      format.html { redirect_to type_equipaments_url, notice: 'Type equipament was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_type_equipament
      @type_equipament = TypeEquipament.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def type_equipament_params
      params.require(:type_equipament).permit(:name_type)
    end
end
