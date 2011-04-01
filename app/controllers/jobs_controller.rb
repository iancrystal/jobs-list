class JobsController < ApplicationController
  # GET /jobs
  # GET /jobs.xml
  def index

    JobPostMailer.deliver_confirm_post
    session[:admin_id] = false
    @category_array = Category.category_array

    # mysql (development) like is case insensitive, postgresql (production/heroku) uses ilike which is not supported
    # in mysql. this is set in config/environments/development.rb, production.rb and test.rb
    like = LIKE
    session[:category_id] = params[:category].to_i

    # life span of AD
    $DAYS = 30

    days_ago = Time.now - ($DAYS * (24 * 60 * 60))

    if (params[:search].blank? && params[:category].blank?)
      @jobs = Job.find(:all, :conditions => ["created_at > ?", days_ago ] )
    else
      chosen_category = params[:category]
      category = Category.find(chosen_category)
      category_array = category.descendants.map {|child| "category_id = #{child.id}" }
      category_array << "category_id = #{category.id}"
      category_clause = category_array.join(" or " )
      @jobs = Job.find(:all, :conditions => [ "(created_at > ?) and (#{category_clause}) and (title #{like} ? or company #{like} ? or city #{like} ? or state #{like} ? or website #{like} ? or description #{like} ? or contact_info #{like} ?)" , days_ago, "%"+params[:search]+"%", "%"+params[:search]+"%", "%"+params[:search]+"%", "%"+params[:search]+"%", "%"+params[:search]+"%", "%"+params[:search]+"%", "%"+params[:search]+"%" ] )
    end

    @jobs_sorted_by_location = @jobs.sort {|a,b| "#{a.state} #{a.city}".downcase <=> "#{b.state} #{b.city}".downcase }

    @jobs.sort! {|a,b| b.created_at <=> a.created_at}

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @jobs }
    end
  end

  # GET /jobs/1
  # GET /jobs/1.xml
  def show
    @job = Job.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @job }
    end
  end

  # GET /jobs/new
  # GET /jobs/new.xml
  def new
    @category_array = Category.category_array
    @job = Job.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @job }
    end
  end

  # GET /jobs/1/edit
  def edit
    @job = Job.find(params[:id])
  end

  # POST /jobs
  # POST /jobs.xml
  def create
    @job = Job.new(params[:job])

    respond_to do |format|
      if @job.save
        format.html { redirect_to(@job, :notice => 'Job was successfully created.') }
        format.xml  { render :xml => @job, :status => :created, :location => @job }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /jobs/1
  # PUT /jobs/1.xml
  def update
    @job = Job.find(params[:id])

    respond_to do |format|
      if @job.update_attributes(params[:job])
        format.html { redirect_to(@job, :notice => 'Job was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.xml
  def destroy
    @job = Job.find(params[:id])
    @job.destroy

    respond_to do |format|
      format.html { redirect_to(jobs_url) }
      format.xml  { head :ok }
    end
  end

  def display_children(parent)
    puts parent.children(true).map {|child| child.name }.join(", " )
  end
end

