
class OscarDataController < ApplicationController
  def create
    @data = OscarData.new("http://oscars.yipitdata.com")
    render :show
  end
end
