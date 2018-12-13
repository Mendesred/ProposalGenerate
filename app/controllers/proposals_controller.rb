class ProposalsController < ApplicationMainController
  before_action :set_proposal, only: [:show, :edit, :update, :destroy]

  # GET /proposals
  # GET /proposals.json
  def index
    select_service
    @admins = policy_scope(Admin)
    if  current_admin.full_access? || current_admin.partial_access?
      @proposals = Proposal.all.page(params[:page])
    else
      @proposals = Proposal.where(admin_id: current_admin.id).page(params[:page])
    end
  end
  # GET /proposals/1
  # GET /proposals/1.json
  def show
    if current_admin.full_access? || @proposal.admin_id == current_admin.id
      select_calculation
    else
      flash[:alert] = "Você não esta autorizado para executar essa ação."
      redirect_to(request.referrer || root_path)
    end
    respond_to do |format|
      format.html
      format.pdf do
        if(params[:ids]!=nil)
          @proposals = Proposal.where(id: params[:ids].split(','))
          render pdf: "Proposta_"+params[:ids],template:"proposals/show2"
        else
         render pdf: "Proposta_#{@proposal.codigo_cliente}"
        end
      end
    end
  end

  # GET /proposals/new
  def new
    @proposal = Proposal.new
    new_type
    select_all_sub_type
    select_all_equip_type
    selected_service
    selected_role
    select_period
    select_city
    select_rotation
    select_equipament
    select_equipament_associate
    select_role
    select_role_associate
    select_calculation
    select_company

    @proposal.company_id=@selected_service.company_id.to_f
  end

  # GET /proposals/1/edit
  def edit
    if current_admin.full_access? || @proposal.admin_id == current_admin.id
      select_calculation
    else
      flash[:alert] = "Você não esta autorizado a executar essa ação."
      redirect_to(request.referrer || root_path)
    end
    select_all_sub_type
    select_all_equip_type
    selected_service
    selected_role
    select_period
    select_city
    select_rotation
    select_equipament
    select_role
    select_calculation
    select_company

  end


  # POST /proposals
  # POST /proposals.json
  def create
    @proposal = Proposal.new(proposal_params)
    @proposal.admin = current_admin
    @proposal.user_criate=current_admin.nome
    selected_service
    selected_role
    select_period
    select_city
    select_rotation
    select_equipament
    select_role
    select_calculation
    select_company
    select_all_equip_type
    select_all_sub_type

    respond_to do |format|
      if @proposal.save
        format.html { redirect_to "/services/#{@proposal.proposal_roles[0].role.service_id}/proposals/#{@proposal.id}", notice: 'Proposal was successfully created.' }
        format.json { render :show, status: :created, location: @proposal }
      else
        #format.html { redirect_to "services//proposals/new?service=#{@proposal.proposal_roles[0].role.service_id}",alert: @proposal.errors.full_messages.each { |message| message[0][0] } }#.message.id('\n')
        format.html { render :new }
        #format.html { render json: @proposal.errors, status: :unprocessable_entity }
        format.json { render json: @proposal.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /proposals/1
  # PATCH/PUT /proposals/1.json
  def update
    #@selected_service = Service.find(@proposal.proposal_roles[0].role.service_id)
    selected_service
    selected_role
    select_period
    select_city
    select_rotation
    select_equipament
    select_role
    select_calculation
    select_all_equip_type
    select_company
    @proposal.admin = current_admin #Deve fazer campo visivel para administrador direcionar proposta a outro ususario
    @proposal.user_updated=current_admin.nome

    respond_to do |format|
      if @proposal.update(proposal_params)
        format.html { redirect_to "/services/#{@proposal.proposal_roles[0].role.service_id}/proposals/#{@proposal.id}", notice: 'Proposal was successfully updated.' }
        format.json { render :show, status: :ok, location: @proposal }
      else
        #format.html { redirect_to "/proposals/#{@proposal.id}/edit/?service=#{@proposal.proposal_roles[0].role.service_id}", alert: @proposal.errors.full_messages.each { |message| message}  }
        #format.html { render :edit => "service_id =?", params[service]] }
        format.html { render :edit }
        format.json { render json: @proposal.errors, status: :unprocessable_entity }
        #format.html { render json: @proposal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proposals/1
  # DELETE /proposals/1.json
  def destroy
    @proposal.destroy
    respond_to do |format|
      format.html { redirect_to service_proposals_url, notice: 'Proposal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def select_city
      @select_all_city = City.all
    end
    def select_rotation
      @select_all_rotarion = Rotation.all
    end

    def select_all_equip_type
      @select_all_equip_type = TypeEquipament.all
    end
    def select_all_sub_type
      @select_all_sub_type = SubType.all
    end
    def select_calculation
      @select_all_calculation = Calculation.first
    end
    def select_company
      @select_all_company = Company.all
    end
    def select_period
      @select_all_period = Period.order("created_at").all
    end
    def select_equipament
      @select_all_equip = Equipament.all
    end     
    def select_equipament_associate
      @select_equip_associate = @proposal.proposal_equipaments.build
    end    
    def select_role
      @select_all_role = Role.all
    end
    def selected_role
      @select_role_from_params = Role.order("created_at").where(["service_id =?", params[:service_id]]) 
    end
    def selected_service
      @selected_service = Service.where(["id =?", params[:service_id]]).first 
    end
    def select_role_associate
      @select_role_associate = @proposal.proposal_roles.build
    end 
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @proposal_admin = current_admin
    end
    def select_service
      @select_all_service = Service.all
    end 

    def set_proposal
      @proposal = Proposal.find(params[:id])
    end

    def new_type
      @selected_type =0
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def proposal_params
      delocalize_config = { :intermunicipal => :number,:txopracional => :number, :txadministrativa=> :number  }
      params.require(:proposal).permit(:admin_id,:cliente, :codigo_cliente, :company_id,:txopracional,:txadministrativa, :city_id, :rotation_id, :role_id,:period_id, 
        :intermunicipal, :h_almoco,:h_feriado, :dias_vr, :dias_vt, :adcional_periculosidade_insalubridade,:grau_de_insalubridade, 
        :controle_hora_extra,:h_extra_jornada_all,:dias_jornada_ex_semana_all,:h_ex_jornada_all,:m_ex_jornada_all,:h_ex_feriado_jornada_all,
        :h_extra_jornada_matu,:dias_ex_semana_matu,:h_ex_jornada_matu,:m_ex_jornada_matu,:h_ex_feriado_jornada_matu,:h_extra_jornada_vesp,
        :dias_ex_semana_vesp,:m_ex_jornada_vesp,:h_ex_jornada_vesp,:h_ex_feriado_jornada_vesp,   :h_extra_jornada_notur,:dias_ex_semana_notur,
        :h_ex_jornada_notur,:m_ex_jornada_notur,:h_ex_feriado_jornada_notur,:controle_vr, :vr_all, :dias_pg_vr_semana_all, 
        :dias_pg_vr_feriado_all, :vr_matu, :dias_pg_vr_semana_matu, :dias_pg_vr_feriado_matu, :vr_vesp, :dias_pg_vr_semana_vesp, 
        :dias_pg_vr_feriado_vesp, :vr_notur, :dias_pg_vr_semana_notur, :dias_pg_vr_feriado_notur, :controle_vt, :vt_all, :dias_pg_vt_semana_all, 
        :dias_pg_vt_feriado_all, :vt_matu, :dias_pg_vt_semana_matu, :dias_pg_vt_feriado_matu, :vt_vesp, :dias_pg_vt_semana_vesp, 
        :dias_pg_vt_feriado_vesp, :vt_notur, :dias_pg_vt_semana_notur, :dias_pg_vt_feriado_notur,:total_equipamento,
        proposal_equipaments_attributes: ProposalEquipament.attribute_names.map(&:to_sym).push(:_destroy),
        proposal_roles_attributes: ProposalRole.attribute_names.map(&:to_sym).push(:_destroy)).delocalize(delocalize_config)
    end

end
