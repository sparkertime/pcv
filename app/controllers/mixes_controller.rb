class MixesController < ApplicationController
  # GET /mixes
  # GET /mixes.xml
  def index
    #@mixes = Mix.all(:order => 'NAME ASC')
    @mixes = Mix.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mixes }
    end
  end

  # GET /mixes/1
  # GET /mixes/1.xml
  def show
    @mix = Mix.find(params[:id])
    @other_feeds = Feed.not_in_mix(@mix).all(:order => 'NAME ASC')

    respond_to do |format|
      format.html # show.html.erb
      format.xml  # show.xml.builder
    end
  end

  # GET /mixes/new
  # GET /mixes/new.xml
  def new
    @mix = Mix.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mix }
    end
  end

  # GET /mixes/1/edit
  def edit
    @mix = Mix.find(params[:id])
  end

  # POST /mixes
  # POST /mixes.xml
  def create
    @mix = Mix.new(params[:mix])

    respond_to do |format|
      if @mix.save
        flash[:notice] = 'Mix was successfully created.'
        format.html { redirect_to(@mix) }
        format.xml  { render :xml => @mix, :status => :created, :location => @mix }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mix.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mixes/1
  # PUT /mixes/1.xml
  def update
    @mix = Mix.find(params[:id])

    respond_to do |format|
      if @mix.update_attributes(params[:mix])
        flash[:notice] = 'Mix was successfully updated.'
        format.html { redirect_to(@mix) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mix.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mixes/1
  # DELETE /mixes/1.xml
  def destroy
    @mix = Mix.find(params[:id])
    @mix.destroy

    respond_to do |format|
      format.html { redirect_to(mixes_url) }
      format.xml  { head :ok }
    end
  end

  def add_feed
    mix = Mix.find(params[:id])
    feed = Feed.find(params[:feed_id])

    mix.feeds << feed
    redirect_to mix
  end

  def remove_feed
    mix = Mix.find(params[:id])
    feed = Feed.find(params[:feed_id])

    mix.feeds.delete feed
    redirect_to mix
  end
end
