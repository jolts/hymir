class PostsController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :edit, :update, :destroy]

  def index
    @posts = Post.all(:order => 'created_at DESC')
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    @post.user_id = current_user.id
    @post.created_at = Time.now
    @post.updated_at = Time.now

    if @post.save
      flash[:notice] = 'Successfully created post.'
      redirect_to @post
    else
      render :action => 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    @post.title = params[:post][:title]
    @post.body  = params[:post][:body]
    @post.updated_at = Time.now

    if @post.save
      flash[:notice] = 'Successfully updated post.'
      redirect_to @post
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = 'Successfully destroyed post.'
    redirect_to posts_url
  end
end
