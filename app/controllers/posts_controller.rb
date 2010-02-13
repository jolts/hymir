class PostsController < ApplicationController
  before_filter :find_post_by_slug, :only => [:show, :edit, :update, :destroy]
  before_filter :login_required, :only => [:new, :create, :edit, :update, :destroy]

  def index
    @posts = Post.paginate(:page => params[:page], :per_page => 5,
                           :order => 'created_at DESC', :conditions => published?,
                           :$where => search? ? "this.title.match(/#{params[:q]}/i) || this.body.match(/#{params[:q]}/i)" : nil)
  end

  def tag
    @posts = Post.all(:order => 'created_at DESC', :tags => params[:tag], :conditions => published?)
  end

  def archive
    @posts = Post.all(:order => 'created_at DESC', :conditions => published?,
                      :$where => "this.created_at.getFullYear() == #{params[:year]} && this.created_at.getMonth()+1 == #{params[:month]}")
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post].merge(:creator_id => current_user.id, :user_id => current_user.id))

    if @post.save
      flash[:notice] = t('flash.notice.post.new')
      redirect_to post_path(@post)
    else
      render :action => 'new'
    end
  end

  def edit
  end
  
  def update
    if @post.update_attributes(params[:post].merge(:updater_id => current_user.id))
      flash[:notice] = t('flash.notice.post.edit')
      redirect_to post_path(@post)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @post.destroy
    flash[:notice] = t('flash.notice.post.destroy')
    redirect_to root_path
  end

  protected
    def published?
      signed_in? ? {} : {:published => true}
    end

    def search?
      !params[:q].blank?
    end

    def find_post_by_slug
      @post = Post.find_by_slug(params[:id], :conditions => published?)
    end
  #
end
