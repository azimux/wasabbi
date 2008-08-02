class ForumOptionsController < ApplicationController
  # GET /forum_options
  # GET /forum_options.xml
  def index
    @forum_options = ForumOption.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @forum_options }
    end
  end

  # GET /forum_options/1
  # GET /forum_options/1.xml
  def show
    @forum_option = ForumOption.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @forum_option }
    end
  end

  # GET /forum_options/new
  # GET /forum_options/new.xml
  def new
    @forum_option = ForumOption.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @forum_option }
    end
  end

  # GET /forum_options/1/edit
  def edit
    @forum_option = ForumOption.find(params[:id])
  end

  # POST /forum_options
  # POST /forum_options.xml
  def create
    @forum_option = ForumOption.new(params[:forum_option])

    respond_to do |format|
      if @forum_option.save
        flash[:notice] = 'ForumOption was successfully created.'
        format.html { redirect_to(@forum_option) }
        format.xml  { render :xml => @forum_option, :status => :created, :location => @forum_option }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @forum_option.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /forum_options/1
  # PUT /forum_options/1.xml
  def update
    @forum_option = ForumOption.find(params[:id])

    respond_to do |format|
      if @forum_option.update_attributes(params[:forum_option])
        flash[:notice] = 'ForumOption was successfully updated.'
        format.html { redirect_to(@forum_option) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @forum_option.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /forum_options/1
  # DELETE /forum_options/1.xml
  def destroy
    @forum_option = ForumOption.find(params[:id])
    @forum_option.destroy

    respond_to do |format|
      format.html { redirect_to(forum_options_url) }
      format.xml  { head :ok }
    end
  end
end
