class HomeController < ApplicationController
  def index
  end

  def import_data
  end

  def process_data
  	flash[:success] = "Data Processing Successfully"
  	redirect_to root_path
  end
end
