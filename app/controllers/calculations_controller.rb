class CalculationsController < ApplicationMainController
	before_action :set_calculation, only: [:show, :edit, :update, :destroy]
	
	# GET /calculations
	# GET /calculations.json
	def index
		if  current_admin.full_access? || current_admin.partial_access?
			@calculations = Calculation.all.page(params[:page])
		else
			redirect_to "/404.html"# configurar pagina 403
		end
	end
	# GET /calculations/1
	# GET /calculations/1.json
	def show
		
	end

	# GET /calculations/new
	def new
		if  current_admin.full_access? || current_admin.partial_access?
			@calculation = Calculation.new
		else
			redirect_to "/404.html"# configurar pagina 403
		end
	end

	# GET /calculations/1/edit
	def edit
		unless current_admin.full_access? || current_admin.partial_access?
			redirect_to "/404.html"# configurar pagina 403
		end
	end

	# POST /calculations
	# POST /calculations.json
	def create
		@calculation = Calculation.new(calculation_params)

		respond_to do |format|
			if @calculation.save
				format.html { redirect_to @calculation, notice: 'Calculation was successfully created.' }
				format.json { render :index, status: :created, location: @calculation }
			else
				format.html { render :new }
				format.json { render json: @calculation.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /calculations/1
	# PATCH/PUT /calculations/1.json
	def update
		respond_to do |format|
			if @calculation.update(calculation_params)
				format.html { redirect_to @calculation, notice: 'Calculation was successfully updated.' }
				format.json { render :index, status: :ok, location: @calculation }
			else
				format.html { render :edit }
				format.json { render json: @calculation.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /calculations/1
	# DELETE /calculations/1.json
	def destroy
		@calculation.destroy
		respond_to do |format|
			format.html { redirect_to calculations_url, notice: 'Calculation was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_calculation
			@calculation = Calculation.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def calculation_params
			delocalize_config = { :salario_minimo => :number}
			params.require(:calculation).permit(:salario_minimo, :fgts, :inss, :sebrae, :incra, :salario_educacao, :sesc, :senac,:decimo_terceito,:um_terco_constitucional,
																					:ferias,:pct_inss_sob_soma_decimo_um_terco_ferias,:pct_fgts_sob_soma_decimo_um_terco_ferias,:aviso_previo,
																					:indenizacao_fgts,:pct_reserva_tecnica,:indindexceOperacional,:indiceAdministrativo,:horasDeCalculoAdNoturno).delocalize(delocalize_config)
		end
end
