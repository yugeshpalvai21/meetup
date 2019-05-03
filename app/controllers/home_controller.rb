class HomeController < ApplicationController
  require 'csv'

  def index
  end

  def users
    @users = User.all
  end

  def import_data
  end

  def process_data
    # Check Whether The File is Uploaded or Not
    if params[:csv_file].nil?
      flash[:info] = "Please Attach File To Process"
      redirect_to import_data_path
    else
    	records = CSV.read(params[:csv_file].path)
      extract_csv_data(records)   	
    	flash[:notice] = "Processed Data Successfully"
    	redirect_to root_path
    end
  end

  private

  def extract_csv_data(records)
    records.each do |record|
      # Check Whether User is already existed or Creates New User
      user = find_or_create_user(record)

      #Find Group details based on given group name
      group = Group.find_by_name(record[2].to_s.downcase)

      #Extract Role Value From Record
      role = record[3].to_s.downcase

      #Creates Association Between Group and User
      add_user_to_group(user, group,role)
    end
  end

  def find_or_create_user(record)
    # User is Created, If User Not Existed 
    user = User.where('first_name = ? AND last_name = ?', record[0].to_s.downcase, record[1].to_s.downcase).first
    if user.nil?
      user = User.create(first_name: record[0].to_s, last_name: record[1])
    end
    return user
  end

  def add_user_to_group(user,group,role)
    # First Checks Whether User is Associated With Group, If Not Then Creates New Association
    if GroupUser.where('user_id = ? AND group_id = ?', user.id, group.id).empty?
      GroupUser.create(group: group, user: user, role: role)
    end
  end
end
