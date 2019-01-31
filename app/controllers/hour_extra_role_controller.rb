class HourExtraRolesController < ApplicationController
  before_action :set_hour_extra_role, only: [:show, :edit, :update, :destroy]

  # GET /hour_extra_role_fields
  # GET /hour_extra_role_fields.json
  def index
    @hour_extra_role_fields = HourExtraRole.all
  end

  # GET /hour_extra_role_fields/1
  # GET /hour_extra_role_fields/1.json
  def show
  end

  # GET /hour_extra_role_fields/new
  def new
    @hour_extra_role_field = HourExtraRole.new
  end

  # GET /hour_extra_role_fields/1/edit
  def edit
  end

  # POST /hour_extra_role_fields
  # POST /hour_extra_role_fields.json
  def create
    @hour_extra_role_field = HourExtraRole.new(hour_extra_role_field_params)

    respond_to do |format|
      if @hour_extra_role_field.save
        format.html { redirect_to @hour_extra_role_field, notice: 'Hour extra role field was successfully created.' }
        format.json { render :show, status: :created, location: @hour_extra_role_field }
      else
        format.html { render :new }
        format.json { render json: @hour_extra_role_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hour_extra_role_fields/1
  # PATCH/PUT /hour_extra_role_fields/1.json
  def update
    respond_to do |format|
      if @hour_extra_role_field.update(hour_extra_role_field_params)
        format.html { redirect_to @hour_extra_role_field, notice: 'Hour extra role field was successfully updated.' }
        format.json { render :show, status: :ok, location: @hour_extra_role_field }
      else
        format.html { render :edit }
        format.json { render json: @hour_extra_role_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hour_extra_role_fields/1
  # DELETE /hour_extra_role_fields/1.json
  def destroy
    @hour_extra_role_field.destroy
    respond_to do |format|
      format.html { redirect_to hour_extra_role_fields_url, notice: 'Hour extra role field was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hour_extra_role_field
      @hour_extra_role_field = HourExtraRole.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hour_extra_role_field_params
      params.require(:hour_extra_role).permit(:proposal_hour_id, :role_hour_id)
    end
end
