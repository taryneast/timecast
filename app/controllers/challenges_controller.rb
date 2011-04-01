class ChallengesController < ApplicationController
  before_filter :login_required
  before_filter :find_challenge, :except => [:index, :new, :create]

  # GET /challenges
  # GET /challenges.xml
  def index
    @challenges = current_user.challenges.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @challenges }
    end
  end

  # GET /challenges/new
  # GET /challenges/new.xml
  def new
    @challenge = current_user.challenges.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @challenge }
    end
  end

  # POST /challenges
  # POST /challenges.xml
  def create
    @challenge = current_user.challenges.new(params[:challenge])

    respond_to do |format|
      if @challenge.save
        format.html { redirect_to(@challenge, :notice => 'Challenge was successfully created.') }
        format.xml  { render :xml => @challenge, :status => :created, :location => @challenge }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @challenge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /challenges/1/edit
  def edit
  end

  # GET /challenges/1
  # GET /challenges/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @challenge }
    end
  end

  # PUT /challenges/1
  # PUT /challenges/1.xml
  def update
    respond_to do |format|
      if @challenge.update_attributes(params[:challenge])
        format.html { redirect_to(@challenge, :notice => 'Challenge was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @challenge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /challenges/1
  # DELETE /challenges/1.xml
  def destroy
    @challenge.destroy

    respond_to do |format|
      format.html { redirect_to(challenges_url) }
      format.xml  { head :ok }
    end
  end
  

  private

  def find_challenge
    @challenge = current_user.challenges.find_by_id(params[:id])
  end
end
