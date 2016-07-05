
class OscarDataController < ApplicationController
  def create
    # hard coding for testing purposes
    # @data = OscarData.new("http://oscars.yipitdata.com")
    DataGrabber.new("http://oscars.yipitdata.com")
    render :show
  end
end
