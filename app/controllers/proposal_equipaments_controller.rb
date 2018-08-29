class ProposalEquipamentsController < ApplicationMainController
  before_action :set_proposal_equipament, only: [:show, :edit, :update, :destroy]
  
  # GET /proposal_equipaments
  # GET /proposal_equipaments.json
  def index
    @proposal_equipaments = ProposalEquipament.all
  end

  # GET /proposal_equipaments/1
  # GET /proposal_equipaments/1.json
  def show
  end

  # GET /proposal_equipaments/new
  def new
    @proposal_equipament = ProposalEquipament.new
  end

  # GET /proposal_equipaments/1/edit
  def edit
  end

  # POST /proposal_equipaments
  # POST /proposal_equipaments.json
  def create
    @proposal_equipament = ProposalEquipament.new(proposal_equipament_params)

    respond_to do |format|
      if @proposal_equipament.save
        format.html { redirect_to @proposal_equipament, notice: 'Proposal equipament was successfully created.' }
        format.json { render :show, status: :created, location: @proposal_equipament }
      else
        format.html { render :new }
        format.json { render json: @proposal_equipament.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proposal_equipaments/1
  # PATCH/PUT /proposal_equipaments/1.json
  def update
    respond_to do |format|
      if @proposal_equipament.update(proposal_equipament_params)
        format.html { redirect_to @proposal_equipament, notice: 'Proposal equipament was successfully updated.' }
        format.json { render :show, status: :ok, location: @proposal_equipament }
      else
        format.html { render :edit }
        format.json { render json: @proposal_equipament.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proposal_equipaments/1
  # DELETE /proposal_equipaments/1.json
  def destroy
    @proposal_equipament.destroy
    respond_to do |format|
      format.html { redirect_to proposal_equipaments_url, notice: 'Proposal equipament was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proposal_equipament
      @proposal_equipament = ProposalEquipament.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def proposal_equipament_params
      params.require(:proposal_equipament).permit(:equipament_id, :proposal_id, :quantidade,:depreciacao_aux,:name_equipament)
    end
end
