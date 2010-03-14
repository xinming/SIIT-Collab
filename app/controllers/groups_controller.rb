class GroupsController < ApplicationController
  before_filter :require_user
  before_filter :set_variables

  def index
    @title = "Groups"
    @right = render_to_string :partial => "right"
  end

  def show
    @group = Group.find(params[:id])
    @title = @group.name
    @shares = Share.all(:conditions => { :group_id => @group.id}, :order => "created_at DESC" )
  end

  def new
    @title = "Create New Group"
    @group = Group.new
  end

  def create
    @group = Group.new(params[:group])
    @group.creator = current_user
    @group.members << current_user

    respond_to do |wants|
      if @group.save
        flash[:success] = 'Group was successfully created.'
        wants.html { redirect_to(@group) }
        # wants.xml { render :xml => @group, :status => :created, :location => @group }
      else
        wants.html { render :action => "new" }
        # wants.xml { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    @title = "Group Settings"
    @group = Group.find(params[:id])
  end
  
  def update
    @title = "Group Settings"
    @group = Group.find(params[:id])
    if @group.update_attributes(params[:group])
      flash[:success] = "Settings to \"#{@group.name}\" is updated."
      redirect_to @group
    else
      flash[:error] = "Settings to \"#{@group.name}\" is not saved because of some errors."
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    Group.destroy(params[:id])
    flash[:success] = "Group  &#8220;#{@group.name}&#8221; was successfully deleted."
    redirect_to join_groups_path
  end

  def join

    if request.method == :post
      @group = Group.find(params[:id])
      if not current_user.is_member_of?(@group)
        @group.members << current_user
        @group.save
        flash[:success] = "You have joined the group &#8220;#{@group.name}&#8221;."
      else
        flash[:error] = "You are already a member of the group &#8220;#{@group.name}&#8221;."
      end
      redirect_to @group
    else
      @title = "Join a Group"
      @all_groups = Group.all
      @right = render_to_string :partial => "join_right"
    end
  end

  def unjoin
    @group = Group.find(params[:id])
    if current_user.is_member_of?(@group)
      @group.remove_member(current_user)
      flash[:success] = "You are no longer a member of the group &#8220;#{@group.name}&#8221;."
    end

    redirect_to @group
  end

  protected
    def set_variables
      @groups = current_user.groups
      @my_groups = current_user.my_groups
    end
end
