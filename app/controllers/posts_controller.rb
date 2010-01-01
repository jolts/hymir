class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @posts = Post.all(:order => 'created_at DESC')

    respond_to do |format|
      format.html
      format.json { render :json => @posts }
      format.atom
    end
  end

  def show
    @post ||= Post.first(:slug => params[:slug])
    @comment = Comment.new(:post_id => @post.id)

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
    @post = Post.new(params[:post])
    @post.user_id = current_user.id
    @post.created_at = Time.now
    @post.updated_at = Time.now

    respond_to do |format|
      if @post.save
        flash[:notice] = 'Successfully created post.'
        format.html { redirect_to(@post.url) }
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
    @post.title = params[:post][:title]
    @post.body  = params[:post][:body]
    @post.named_tags = params[:post][:named_tags]
    @post.updated_at = Time.now

    respond_to do |format|
      if @post.save
        flash[:notice] = 'Successfully updated post.'
        format.html { redirect_to(@post.url) }
      else
        format.html { render :action => 'edit' }
      end
    end
  end
  
  def destroy
    @post.destroy

    respond_to do |format|
      flash[:notice] = 'Successfully destroyed post.'
      format.html { redirect_to(posts_url) }
    end
  end
end
