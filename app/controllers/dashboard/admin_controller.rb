class Dashboard::AdminController < ApplicationMainController
  before_action :set_admins, only:[:edit, :update, :destroy]

  # GET /calculations
  # GET /calculations.json
  def index
  	@admins = policy_scope(Admin)
    @admins = @admins.limit(10).order(:created_at)
  end

  # GET /calculations/1
  # GET /calculations/1.json
  def show
  end

  # GET /calculations/new
  def new
    @admins = Admin.new
    authorize @admins
  end

  # GET /calculations/1/edit
  def edit
    authorize @admins
  end

  # POST /calculations
  # POST /calculations.json
  def create
    @admins = Admin.new(params_admins)
    if @admins.save(params_admins)
      redirect_to dashboard_admin_index_path, notice: "O Administrador (#{@admins.email}) foi cadastrado com sucesso!"
    else
      render :edit
    end
  end

  # PATCH/PUT /calculations/1
  # PATCH/PUT /calculations/1.json
  def update
    senha = params[:admin][:password]
    senha_confirmacao = params[:admin][:password_confirmation]

    if senha.blank?&&senha_confirmacao.blank?
      params[:admin].delete(:password)
      params[:admin].delete(:password_confirmation)
    end

    if @admins.update(params_admins)
      redirect_to dashboard_admin_index_path, notice: "O Administrador (#{@admins.email}) foi atualizado com sucesso!"
    else
      render :edit
    end
  end

  # DELETE /calculations/1
  # DELETE /calculations/1.json
  def destroy
    authorize @admins
    user = @admins.email
    @admins.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_admin_index_path, notice: "O Administrador (#{user}) foi deletado com sucesso!" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admins
      @admins = Admin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def params_admins
      if @admins.blank?
        params.require(:admin).permit(:nome ,:privilegio ,:email, :password, :password_confirmation)
      else
        params.require(:admin).permit(policy(@admins).permitted_attributes)        
      end
    end
end

