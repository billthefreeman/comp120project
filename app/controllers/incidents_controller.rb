class IncidentsController < ApplicationController
  before_action :set_incident, only: [:show, :edit, :update, :destroy]

  # GET /incidents
  # GET /incidents.json
  def index
    @incidents = @paginate = Incident.includes(:cate).order('id DESC').paginate(:page => params[:page], :per_page => 5)
    expires_in 3.minutes, :public => true
  end

  def update_group 
    reporter = Person.find(params[:reporter_id])
    @reporter_id = reporter.id
    @group = reporter.group.group_name
    @department = reporter.group.department.department_name
    @phone = reporter.phone
    @email = reporter.email
  end

  # GET /incidents/1
  # GET /incidents/1.json
  def show
  end

  # GET /incidents/new
  def new
    @incident = Incident.new
  end

  # GET /incidents/1/edit
  def edit
    @incident = Incident.find(params[:id])
    expires_in 3.minutes, :public => true
  end

  # POST /incidents
  # POST /incidents.json
  def create
    @incident = Incident.new(incident_params)
    respond_to do |format|
      if @incident.save
        format.html { redirect_to :action => :index}
        format.json { render :show, status: :created, location: @artile }
      else
        format.html { render :new }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incidents/1
  # PATCH/PUT /incidents/1.json
  def update
    @incident = Incident.find(params[:id])
    respond_to do |format|
      if @incident.update(incident_params)
        format.html { redirect_to :action => :index}
        format.json { render :show, status: :created, location: @artile }
      else
        format.html { render :new }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incidents/1
  # DELETE /incidents/1.json
  def destroy
    @incident.destroy
    redirect_to :action => :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_incident
      @incident = Incident.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def incident_params
      params.require(:incident).permit!
    end
end
