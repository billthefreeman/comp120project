class IncidentsController < ApplicationController
  before_action :set_incident, only: [:show, :edit, :update, :destroy]

  # GET /incidents
  # GET /incidents.json
  def index
    #@incidents = @paginate = Incident.includes(:cate).order('id DESC').paginate(:page => params[:page], :per_page => 5)
    #incidents = Incident.where("created_at > ?", Time.at(params[:after].to_i + 1)).order('id DESC').paginate(:page => params[:page], :per_page => 5)
    
    after = params[:after].to_i
    if (after == 0)
      @incidents = Incident.all.order('id DESC').paginate(:page => params[:page], :per_page => 5)
    end  
    @arr = []
    $redis.zrangebyscore("incidents" , after + 1 , (Time.now.to_f * 1).to_i , {withscores: true}).each do |source|
      inc = source[0]
      new_i = JSON.load inc
      @arr << Incident.new(new_i)
    end  
    @added  = @arr.length
  end

  def update_group 
    @group = $redis.hget('people_group', params[:reporter_id])
    @department = $redis.hget('group_department', @group)
    @phone = $redis.hget('phone', params[:reporter_id])
    @email = $redis.hget('email', params[:reporter_id])
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
  end

  # POST /incidents
  # POST /incidents.json
  def create
    @incident = Incident.new(incident_params)
    respond_to do |format|
      if @incident.save
        inc = @incident.to_json
        $redis.zadd('incidents', @incident.created_at.to_i, inc)
        format.html { redirect_to :action => :index}
        format.json { render :show, status: :created, location: @incident }
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
        format.json { render :show, status: :created, location: @incident }
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
