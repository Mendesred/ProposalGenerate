class ProposalHourExtrasController < ApplicationMainController
	before_action :authenticate_admin!
	before_action :set_proposal_hour_extra, only: [:show, :edit, :update, :destroy]

	# GET /proposal_hour_extras
	# GET /proposal_hour_extras.json
	def index
		select_service
		@proposal_hour_extras = ProposalHourExtra.all
	end

	# GET /proposal_hour_extras/1
	# GET /proposal_hour_extras/1.json
	def show
		unless  current_admin.full_access? || current_admin.partial_access?
			redirect_to "/404.html"# configurar pagina 403
		end
		select_calculation
		respond_to do |format|
      format.html
      format.pdf do
         render pdf: "Proposta_hour_extra#{@proposal_hour_extra.codigo_cliente}"
      end
    end
	end

	# GET /proposal_hour_extras/new
	def new
		if  current_admin.full_access? || current_admin.partial_access?
			@proposal_hour_extra = ProposalHourExtra.new
		else
			redirect_to "/404.html"# configurar pagina 403
		end
		select_city
		selected_service
		select_rotation
		select_role
		selected_role
		select_service
		select_company
		select_role_associate

		@proposal_hour_extra.company_id=@selected_service.company_id.to_f
	end

	# GET /proposal_hour_extras/1/edit
	def edit
		unless  current_admin.full_access? || current_admin.partial_access?
			redirect_to "/404.html"# configurar pagina 403
		end
		select_city
		select_rotation
		select_role
		selected_role
		selected_service
		select_service
		select_company
	end

	# POST /proposal_hour_extras
	# POST /proposal_hour_extras.json
	def create
		@proposal_hour_extra = ProposalHourExtra.new(proposal_hour_extra_params)
		@proposal_hour_extra.admin = current_admin
		@proposal_hour_extra.user_criate=current_admin.nome
		select_calculation
		select_city
		select_rotation
		select_role
		select_company
		select_calculation
		selected_role
		selected_service
		select_service
		respond_to do |format|
			if @proposal_hour_extra.save
				#format.html { redirect_to @proposal_hour_extra_params, notice: 'Proposal hour extra was successfully created.' }
				format.html { redirect_to "/services/#{@proposal_hour_extra.hour_extra_roles[0].role.service_id}/proposal_hour_extras/#{@proposal_hour_extra.id}", notice: 'Proposal was successfully created.' }
				format.json { render :show, status: :created, location: @proposal_hour_extra }
			else
				format.html { render :new }
				format.json { render json: @proposal_hour_extra.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /proposal_hour_extras/1
	# PATCH/PUT /proposal_hour_extras/1.json
	def update
		select_calculation
		select_city
		select_rotation
		select_role
		select_company
		select_calculation
		selected_role
		selected_service
		select_service
    @proposal_hour_extra.user_update=current_admin.nome

		respond_to do |format|
			if @proposal_hour_extra.update(proposal_hour_extra_params)
				format.html { redirect_to "/services/#{@proposal_hour_extra.hour_extra_roles[0].role.service_id}/proposal_hour_extras/#{@proposal_hour_extra.id}", notice: 'Proposal was successfully created.' }
				format.json { render :show, status: :ok, location: @proposal_hour_extra }
			else
				format.html { render :edit }
				format.json { render json: @proposal_hour_extra.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /proposal_hour_extras/1
	# DELETE /proposal_hour_extras/1.json
	def destroy
		@proposal_hour_extra.destroy
		respond_to do |format|
			format.html { redirect_to proposal_hour_extras_url, notice: 'Proposal hour extra was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
		def select_city
			@select_all_city = City.order("created_at").all
		end
		def select_rotation
			@select_all_rotarion = Rotation.order("created_at").all
		end
		def select_role
			@select_all_role = Role.order("created_at").all
		end
		def select_company
			@select_all_company = Company.all
		end
		def select_calculation
			@select_all_calculation = Calculation.first
		end
		def select_role_associate
			@select_role_associate = @proposal_hour_extra.hour_extra_roles.build
		end
		def selected_role
			@select_role_from_params = Role.order("created_at").where(["service_id =?", params[:service_id]]) 
		end
		def selected_service
			@selected_service = Service.where(["id =?", params[:service_id]]).first 
		end
		def select_service
			@select_all_service = Service.order("created_at").all
		end 
		# Use callbacks to share common setup or constraints between actions.
		def set_proposal_hour_extra
			@proposal_hour_extra = ProposalHourExtra.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def proposal_hour_extra_params
      delocalize_config = { :tx_administrativa => :number,:tx_opracional => :number, :intermunicipal=> :number}
			params.require(:proposal_hour_extra).permit(:client, :codigo_cliente,:detail, :horas_extras, :ad_noturno, :city_id, :rotation_id, :company_id, :admin_id, :v_hora_base, :intermunicipal,
																	:tx_opracional, :tx_administrativa,	hour_extra_roles_attributes: HourExtraRole.attribute_names.map(&:to_sym).push(:_destroy)).delocalize(delocalize_config)
		end
end