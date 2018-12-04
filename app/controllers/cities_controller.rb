class CitiesController < ApplicationMainController
  before_action :set_city, only: [:show, :edit, :update, :destroy]
  
  # GET /cities
  # GET /cities.json
  def index
    if  current_admin.full_access? || current_admin.partial_access?
      @cities = City.all.page(params[:page])
    else
      redirect_to "/404.html"# configurar pagina 403
    end
  end

  # GET /cities/1
  # GET /cities/1.json
  def show
    if  current_admin.full_access? || current_admin.partial_access?
      @cities = City.all.page(params[:page])
    else
      redirect_to "/404.html"# configurar pagina 403
    end
  end

  # GET /cities/new
  def new
    @city = City.new
    if  current_admin.full_access? || current_admin.partial_access?
      @city = City.new
    else
      redirect_to "/404.html"# configurar pagina 403
    end
  end

  # GET /cities/1/edit
  def edit
    unless current_admin.full_access? || current_admin.partial_access?
      redirect_to "/404.html"# configurar pagina 403
    end
  end

  # POST /cities
  # POST /cities.json
  def create
    @city = City.new(city_params)

    respond_to do |format|
      if @city.save
        format.html { redirect_to @city, notice: 'City was successfully created.' }
        format.json { render :show, status: :created, location: @city }
      else
        format.html { render :new }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cities/1
  # PATCH/PUT /cities/1.json
  def update
    respond_to do |format|
      if @city.update(city_params)
        format.html { redirect_to @city, notice: 'City was successfully updated.' }
        format.json { render :show, status: :ok, location: @city }
      else
        format.html { render :edit }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cities/1
  # DELETE /cities/1.json
  def destroy
    @city.destroy
    respond_to do |format|
      format.html { redirect_to cities_url, notice: 'City was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city
      @city = City.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def city_params
      delocalize_config = { :valeTransporte => :number }
      params.require(:city).permit(:nome, :feriado, :valeTransporte, :issqn).delocalize(delocalize_config)
    end
end
