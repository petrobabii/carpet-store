class CarpetsController < ApplicationController
  def index
    @carpets = Carpet.page(params[:page]).per(6)
  end

  def show
    @carpet = Carpet.find(params[:id])
  end
end