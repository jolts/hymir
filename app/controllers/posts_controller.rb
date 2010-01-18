class PostsController < ApplicationController
  before_filter :find_post_by_slug, :only => [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    if params[:q].blank?
      @posts = Post.paginate(:page => params[:page], :per_page => 1,
                             :order => 'created_at DESC', :conditions => published?)
    else
      @posts = Post.paginate(:page => params[:page], :per_page => 5,
                             :order => 'created_at DESC', :conditions => published?,
                             :$where => "this.title.match(/#{params[:q]}/i) || this.body.match(/#{params[:q]}/i)")
    end

    respond_to do |format|
      format.html
      format.json { render :json => @posts }
      format.atom
    end
  end

  def tag
    @posts = Post.all(:order => 'created_at DESC', :tags => params[:tag], :conditions => published?)

    respond_to do |format|
      format.html
      format.json { render :json => @posts }
    end
  end

  def archive
    @posts = Post.all(:order => 'created_at DESC', :conditions => published?,
                      :$where => "this.created_at.getFullYear() == #{params[:year]} && this.created_at.getMonth()+1 == #{params[:month]}")

    respond_to do |format|
      format.html
      format.json { render :json => @posts }
    end
  end

  def show
    @comment = Comment.new

    respond_to do |format|
      format.html
      format.json { render :json => @post }
      format.atom
    end
  end

  def new
    @post = Post.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @post = Post.new(params[:post].merge(:creator_id => current_user.id, :user_id => current_user.id))

    respond_to do |format|
      if @post.save
        flash[:notice] = t('flash.notice.post.new')
        format.html { redirect_to post_path(@post) }
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
      if @post.update_attributes(params[:post].merge(:updater_id => current_user.id))
        flash[:notice] = t('flash.notice.post.edit')
        format.html { redirect_to post_path(@post) }
      else
        format.html { render :action => 'edit' }
      end
    end
  end
  
  def destroy
    @post.destroy

    respond_to do |format|
      flash[:notice] = t('flash.notice.post.destroy')
      format.html { redirect_to root_path }
    end
  end

  private
    def published?
      signed_in? ? {} : {:published => true}
    end

    def find_post_by_slug
      @post = Post.find_by_slug(params[:id], :conditions => published?)
    end
  # private
end
