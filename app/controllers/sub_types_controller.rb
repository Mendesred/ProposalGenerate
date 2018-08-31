class SubTypesController < ApplicationMainController
  before_action :set_sub_type, only: [:show, :edit, :update, :destroy]

  # GET /sub_types
  # GET /sub_types.json
  def index
    @sub_types = SubType.all
  end

  # GET /sub_types/1
  # GET /sub_types/1.json
  def show
  end

  # GET /sub_types/new
  def new
    @sub_type = SubType.new
  end

  # GET /sub_types/1/edit
  def edit
  end

  # POST /sub_types
  # POST /sub_types.json
  def create
    @sub_type = SubType.new(sub_type_params)

    respond_to do |format|
      if @sub_type.save
        format.html { redirect_to @sub_type, notice: 'Sub type was successfully created.' }
        format.json { render :show, status: :created, location: @sub_type }
      else
        format.html { render :new }
        format.json { render json: @sub_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sub_types/1
  # PATCH/PUT /sub_types/1.json
  def update
    respond_to do |format|
      if @sub_type.update(sub_type_params)
        format.html { redirect_to @sub_type, notice: 'Sub type was successfully updated.' }
        format.json { render :show, status: :ok, location: @sub_type }
      else
        format.html { render :edit }
        format.json { render json: @sub_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_types/1
  # DELETE /sub_types/1.json
  def destroy
    @sub_type.destroy
    respond_to do |format|
      format.html { redirect_to sub_types_url, notice: 'Sub type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub_type
      @sub_type = SubType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sub_type_params
      params.require(:sub_type).permit(:name_sub_type)
    end
end
