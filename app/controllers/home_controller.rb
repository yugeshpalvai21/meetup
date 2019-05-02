class HomeController < ApplicationController
  require 'csv'

  def index
  end

  def import_data
  end

  def process_data
  	records = CSV.read(params[:csv_file].path)
  	records.each do |record|
  		user = User.where('first_name = ? AND last_name = ?', record[0].to_s.downcase, record[1].to_s.downcase).first
  		if user.nil?
  			user = User.create(first_name: record[0].to_s, last_name: record[1])
  		end
  		group = Group.find_by_name(record[2].to_s.downcase)
  		group_user = GroupUser.create(group: group, user: user, role: record[3].to_s.downcase)
  		if group_user.errors.any?
  			puts group_user.errors.full_messages
  		end
  	end

  	flash[:notice] = "Processed Data Successfully"
  	redirect_to root_path
  end
end
