class GroupsController < ApplicationController
  def index
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
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(group_params)
      flash[:success] =  "Group Updated Successfully"
      redirect_to group_path(@group)
    else
      render 'edit'
    end
  end

  def destroy
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
