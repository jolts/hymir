class PostsController < ApplicationController
  before_filter :find_post_by_slug, :only => [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @posts = Post.paginate(:per_page => 3, :page => params[:page], :order => 'created_at DESC')

    respond_to do |format|
      format.html
      format.js
      format.json { render :json => @posts }
      format.atom
    end
  end

  def search
    if params[:q] && !params[:q].empty?
      @posts = Post.all(:order => 'created_at DESC',
                        '$where' => "this.title.match(/#{params[:q]}/i) || this.body.match(/#{params[:q]}/i)")
    end
    @posts ||= []

    respond_to do |format|
      format.html
      format.json { render :json => @posts }
    end
  end

  def tag
    @posts = Post.all(:order => 'created_at DESC', :tags => params[:tag])

    respond_to do |format|
      format.html
      format.json { render :json => @posts }
    end
  end

  def archive
    # FIXME: Refactor this into a '$where' condition
    @posts = Post.all(:order => 'created_at DESC').select do |p|
      p.created_at.month == params[:month].to_i &&
      p.created_at.year  == params[:year].to_i
    end

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
    end
  end

  def new
    @post = Post.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @post = Post.new(params[:post].merge(:user_id => current_user.id))

    respond_to do |format|
      if @post.save
        flash[:notice] = 'Successfully created post.'
        format.html { redirect_to post_url(@post) }
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
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Successfully updated post.'
        format.html { redirect_to post_url(@post) }
      else
        format.html { render :action => 'edit' }
      end
    end
  end
  
  def destroy
    @post.destroy

    respond_to do |format|
      flash[:notice] = 'Successfully destroyed post.'
      format.html { redirect_to root_path }
    end
  end

  private
    def find_post_by_slug
      @post ||= Post.find_by_slug(params[:id])
    end
  # private
end
