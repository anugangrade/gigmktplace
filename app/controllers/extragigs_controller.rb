class ExtragigsController < ApplicationController
  before_action :set_extragig, only: [:show, :edit, :update, :destroy]
  before_action :set_gig
  before_filter :authenticate_user! 

  # GET /extragigs
  # GET /extragigs.json
  def index
    @extragigs = @gig.extragigs
  end

  # GET /extragigs/1
  # GET /extragigs/1.json
  def show
  end

  # GET /extragigs/new
  def new
    @extragig = Extragig.new
  end

  # GET /extragigs/1/edit
  def edit
  end

  # POST /extragigs
  # POST /extragigs.json
  def create
    @extragig = @gig.extragigs.new(extragig_params)

    respond_to do |format|
      if @extragig.save
        format.html { redirect_to gig_extragigs_path(@gig), notice: 'Extragig was successfully created.' }
        format.json { render :show, status: :created, location: @extragig }
      else
        format.html { render :new }
        format.json { render json: @extragig.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /extragigs/1
  # PATCH/PUT /extragigs/1.json
  def update
    respond_to do |format|
      if @extragig.update(extragig_params)
        format.html { redirect_to gig_extragigs_path(@gig), notice: 'Extragig was successfully updated.' }
        format.json { render :show, status: :ok, location: @extragig }
      else
        format.html { render :edit }
        format.json { render json: @extragig.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /extragigs/1
  # DELETE /extragigs/1.json
  def destroy
    @extragig.destroy
    respond_to do |format|
      format.html { redirect_to gig_extragigs_path(@gig), notice: 'Extragig was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_gig
      @gig = Gig.find(params[:gig_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_extragig
      @extragig = Extragig.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def extragig_params
      params.require(:extragig).permit(:title, :amount, :express_boolean)
    end
end
