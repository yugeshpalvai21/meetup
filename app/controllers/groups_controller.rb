class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def show  
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:success] =  "Group Created Successfully"
      redirect_to group_path(@group)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @group.update_attributes(group_params)
      flash[:success] =  "Group Updated Successfully"
      redirect_to group_path(@group)
    else
      render 'edit'
    end
  end

  def destroy
    @group.destroy
    flash[:success] = "Group Deleted Successfully Along With Associated Members"
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

  def set_group
    @group = Group.find(params[:id])
  end
end
