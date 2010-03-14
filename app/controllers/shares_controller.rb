class SharesController < ApplicationController
  before_filter :require_user
  
  def index
    @title = "Share"
    if params[:group].nil?
      @groups = current_user.groups
      @right = render_to_string :partial => "choose_right"
      render 'choose_group'
    else
      @group = Group.find(params[:group])
      @right = render_to_string :partial => "shares_right"
    end
  end
  
  def new
    @group = Group.find(params[:group])
    case params[:type]
      when 'video'
        @share = Video.new(:share => Share.new)
      when 'picture'
        @share = Picture.new(:share => Share.new)
      when 'news'
        @share = News.new(:share => Share.new)
    end
    @title = "Share a #{@share.name}"
  end
  
  def create
    @group = Group.find(params[:group])
    case params[:type]
    when 'video'
      @share = Video.new(params[:video])
    when 'picture'
        @share = Picture.new(params[:picture])
    when 'news'
      @share = News.new(params[:news])
    end
    @share.share = Share.new(:user => current_user, :group => @group)
    respond_to do |wants|
      if @share.save
        flash[:success] = "#{@share.name} was successfully shared."
        wants.html { redirect_to(root_url) }
        # wants.xml { render :xml => @share, :status => :created, :location => @share }
      else
        wants.html { render :action => "new" }
        # wants.xml { render :xml => @share.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @item = Share.find(params[:id])
    @item.destroy
    flash[:success] = "Share was successfully deleted."
    redirect_to(root_url)
  end
end
