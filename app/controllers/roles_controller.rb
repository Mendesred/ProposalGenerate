class RolesController < ApplicationMainController
	before_action :authenticate_admin!
	before_action :set_role, only: [:show, :edit, :update, :destroy]

	# GET /roles
	# GET /roles.json
	def index
		@roles = Role.all
	end

	# GET /roles/1
	# GET /roles/1.json
	def show
		unless  current_admin.full_access? || current_admin.partial_access?
			redirect_to "/404.html"# configurar pagina 403
		end
	end

	# GET /roles/new
	def new
		if  current_admin.full_access? || current_admin.partial_access?
			@Roles = Role.new.page(params[:page])
		else
			redirect_to "/404.html"# configurar pagina 403
		end
		select_service
	end

	# GET /roles/1/edit
	def edit
		select_service
		unless  current_admin.full_access? || current_admin.partial_access?
			redirect_to "/404.html"# configurar pagina 403
		end
	end

	# POST /roles
	# POST /roles.json
	def create
		@role = Role.new(role_params)

		respond_to do |format|
			if @role.save
				format.html { redirect_to @role, notice: 'Role was successfully created.' }
				format.json { render :show, status: :created, location: @role }
			else
				format.html { render :new }
				format.json { render json: @role.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /roles/1
	# PATCH/PUT /roles/1.json
	def update
		respond_to do |format|
			if @role.update(role_params)
				format.html { redirect_to @role, notice: 'Role was successfully updated.' }
				format.json { render :show, status: :ok, location: @role }
			else
				format.html { render :edit }
				format.json { render json: @role.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /roles/1
	# DELETE /roles/1.json
	def destroy
		@role.destroy
		respond_to do |format|
			format.html { redirect_to roles_url, notice: 'Role was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
		def select_service
			@select_all_service = Service.all
		end
		# Use callbacks to share common setup or constraints between actions.
		def set_role
			@role = Role.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def role_params
			delocalize_config = { :salario => :number,:assist_medica => :number, :seg_vida => :number, :uniformes => :number, 
														:assist_Soc_Familiar => :number, :vale_refeicao => :number, :ppr => :number,:beneficio_Natalidade => :number, :uniformes => :number }
			params.require(:role).permit(:cargo, :salario, :gratificacao, :assist_medica,:seg_vida, :uniformes, 
				:assist_Soc_Familiar, :beneficio_Natalidade, :ppr, :vale_refeicao, :service_id).delocalize(delocalize_config)
		end
end
