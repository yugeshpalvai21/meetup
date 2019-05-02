class HomeController < ApplicationController
  require 'csv'

  def index
  end

  def import_data
  end

  def process_data
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
      user = find_or_create_user(record)
      group = Group.find_by_name(record[2].to_s.downcase)
      group_user = GroupUser.create(group: group, user: user, role: record[3].to_s.downcase)
    end
  end

  def find_or_create_user(record)
    user = User.where('first_name = ? AND last_name = ?', record[0].to_s.downcase, record[1].to_s.downcase).first
    if user.nil?
      user = User.create(first_name: record[0].to_s, last_name: record[1])
    end
    return user
  end
end
