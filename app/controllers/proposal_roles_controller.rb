class ProposalRolesController < ApplicationMainController
  before_action :set_proposal_role, only: [:show, :edit, :update, :destroy]
  
  # GET /proposal_roles
  # GET /proposal_roles.json
  def index
    @proposal_roles = ProposalRole.all
  end

  # GET /proposal_roles/1
  # GET /proposal_roles/1.json
  def show
  end

  # GET /proposal_roles/new
  def new
    @proposal_role = ProposalRole.new
  end

  # GET /proposal_roles/1/edit
  def edit
  end

  # POST /proposal_roles
  # POST /proposal_roles.json
  def create
    @proposal_role = ProposalRole.new(proposal_role_params)

    respond_to do |format|
      if @proposal_role.save
        format.html { redirect_to @proposal_role, notice: 'Proposal role was successfully created.' }
        format.json { render :show, status: :created, location: @proposal_role }
      else
        format.html { render :new }
        format.json { render json: @proposal_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proposal_roles/1
  # PATCH/PUT /proposal_roles/1.json
  def update
    respond_to do |format|
      if @proposal_role.update(proposal_role_params)
        format.html { redirect_to @proposal_role, notice: 'Proposal role was successfully updated.' }
        format.json { render :show, status: :ok, location: @proposal_role }
      else
        format.html { render :edit }
        format.json { render json: @proposal_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proposal_roles/1
  # DELETE /proposal_roles/1.json
  def destroy
    @proposal_role.destroy
    respond_to do |format|
      format.html { redirect_to proposal_roles_url, notice: 'Proposal role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proposal_role
      @proposal_role = ProposalRole.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def proposal_role_params
      delocalize_config = { :intermunicipal => :number }
      params.require(:proposal_role).permit(:proposal_id, :role_id, :qtd_postos).delocalize(delocalize_config)
    end
end
