class InfoController < ApplicationController
  caches_page :about
  caches_page :portfolio
  caches_page :services

  def about
    respond_to do |format|
      format.html
    end
  end

  def portfolio
    respond_to do |format|
      format.html
    end
  end

  def services
    respond_to do |format|
      format.html
    end
  end
end
