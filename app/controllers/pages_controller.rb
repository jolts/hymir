class PagesController < ApplicationController
  before_filter :find_page_by_url, :except => [:new, :create]
  before_filter :login_required, :except => [:show]

  def show
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(params[:page].merge(:creator_id => current_user.id, :user_id => current_user.id))

    if @page.save
      flash[:notice] = t('flash.notice.page.new')
      redirect_to page_path(@page)
    else
      render :action => 'new'
    end
  end

  def edit
  end
  
  def update
    if @page.update_attributes(params[:page].except(:url).merge(:updater_id => current_user.id))
      flash[:notice] = t('flash.notice.page.edit')
      redirect_to page_path(@page)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @page.destroy
    flash[:notice] = t('flash.notice.page.destroy')
    redirect_to root_path
  end

  protected
    def find_page_by_url
      @page = Page.find_by_url(params[:id])
    end
  # protected
end
