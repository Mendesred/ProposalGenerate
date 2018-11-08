class EquipamentsController < ApplicationMainController
	before_action :set_equipament, only: [:show, :edit, :update, :destroy]

	# GET /equipaments
	# GET /equipaments.json
	def index
		@equipaments = Equipament.all
	end

	# GET /equipaments/1
	# GET /equipaments/1.json
	def show
		select_type
		select_sub_type
	end

	# GET /equipaments/new
	def new
		@equipament = Equipament.new
		select_type
		select_sub_type
	end

	# GET /equipaments/1/edit
	def edit
		select_type
		select_sub_type
	end

	# POST /equipaments
	# POST /equipaments.json
	def create
		@equipament = Equipament.new(equipament_params)

		respond_to do |format|
			if @equipament.save
				format.html { redirect_to @equipament, notice: 'Equipament was successfully created.' }
				format.json { render :show, status: :created, location: @equipament }
			else
				format.html { render :new }
				format.json { render json: @equipament.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /equipaments/1
	# PATCH/PUT /equipaments/1.json
	def update
		respond_to do |format|
			if @equipament.update(equipament_params)
				format.html { redirect_to @equipament, notice: 'Equipament was successfully updated.' }
				format.json { render :show, status: :ok, location: @equipament }
			else
				format.html { render :edit }
				format.json { render json: @equipament.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /equipaments/1
	# DELETE /equipaments/1.json
	def destroy
		@equipament.destroy
		respond_to do |format|
			format.html { redirect_to equipaments_url, notice: 'Equipament was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def select_type
			@select_all_type = TypeEquipament.all
		end
		def select_sub_type
			@select_all_sub_type = SubType.all
		end

		def set_equipament
			@equipament = Equipament.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def equipament_params
			delocalize_config = { :valor => :number }
			params.require(:equipament).permit( :name_equipament,:fornecedor ,:marca_mod ,:rec_manutencao ,:obs_equipament ,
																					:valor, :depreciacao, :proposal_id, :type_equipament_id, :sub_type_id, :control_print).delocalize(delocalize_config)
		end
end
