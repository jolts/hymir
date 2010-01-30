class PagesController < ApplicationController
  before_filter :find_page_by_url, :except => [:new, :create]

  def show
    respond_to do |format|
      format.html
      format.json { render :json => @page }
    end
  end

  def new
    @page = Page.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @page = Page.new(params[:page].merge(:creator_id => current_user.id, :user_id => current_user.id))

    respond_to do |format|
      if @page.save
        flash[:notice] = t('flash.notice.page.new')
        format.html { redirect_to page_path(@page) }
      else
        format.html { render :action => 'new' }
      end
    end
  end

  def edit
    respond_to do |format|
      format.html
    end
  end
  
  def update
    respond_to do |format|
      if @page.update_attributes(params[:page].except(:url).merge(:updater_id => current_user.id))
        flash[:notice] = t('flash.notice.page.edit')
        format.html { redirect_to page_path(@page) }
      else
        format.html { render :action => 'edit' }
      end
    end
  end
  
  def destroy
    @page.destroy

    respond_to do |format|
      flash[:notice] = t('flash.notice.page.destroy')
      format.html { redirect_to root_path }
    end
  end

  protected
    def find_page_by_url
      @page = Page.find_by_url(params[:id])
    end
  #
end
