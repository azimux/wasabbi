
class ForumCategoriesController < ApplicationController
  # GET /forum_categories
  # GET /forum_categories.xml
  def index
    @forum_categories = ForumCategory.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @forum_categories }
    end
  end

  # GET /forum_categories/1
  # GET /forum_categories/1.xml
  def show
    @forum_category = ForumCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @forum_category }
    end
  end

  # GET /forum_categories/new
  # GET /forum_categories/new.xml
  def new
    @forum_category = ForumCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @forum_category }
    end
  end

  # GET /forum_categories/1/edit
  def edit
    @forum_category = ForumCategory.find(params[:id])
  end

  # POST /forum_categories
  # POST /forum_categories.xml
  def create
    @forum_category = ForumCategory.new(params[:forum_category])

    respond_to do |format|
      if @forum_category.save
        flash[:notice] = 'ForumCategory was successfully created.'
        format.html { redirect_to(@forum_category) }
        format.xml  { render :xml => @forum_category, :status => :created, :location => @forum_category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @forum_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /forum_categories/1
  # PUT /forum_categories/1.xml
  def update
    @forum_category = ForumCategory.find(params[:id])

    respond_to do |format|
      if @forum_category.update_attributes(params[:forum_category])
        flash[:notice] = 'ForumCategory was successfully updated.'
        format.html { redirect_to(@forum_category) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @forum_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /forum_categories/1
  # DELETE /forum_categories/1.xml
  def destroy
    @forum_category = ForumCategory.find(params[:id])
    @forum_category.destroy

    respond_to do |format|
      format.html { redirect_to(forum_categories_url) }
      format.xml  { head :ok }
    end
  end
end
