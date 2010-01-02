class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @pager = Paginator.new(Post.count, 10) do |offset, per_page|
      Post.all(:offset => offset, :limit => per_page, :order => 'created_at DESC')
    end
    @posts = @pager.page(params[:page])

    respond_to do |format|
      format.html
      format.json { render :json => @posts }
      format.atom
    end
  end

  def tag
    @pager = Paginator.new(Post.count, 10) do |offset, per_page|
      Post.all(:offset => offset, :limit => per_page, :order => 'created_at DESC').select do |p|
        p.tags.include?(params[:tag])
      end
    end
    @posts = @pager.page(params[:page])

    respond_to do |format|
      format.html
      format.json { render :json => @posts }
    end
  end

  def archive
    @pager = Paginator.new(Post.count, 10) do |offset, per_page|
      Post.all(:offset => offset, :limit => per_page, :order => 'created_at DESC').select do |p|
        if params[:day]
          p.created_at.day   == params[:day].to_i   &&
          p.created_at.month == params[:month].to_i &&
          p.created_at.year  == params[:year].to_i
        elsif params[:month]
          p.created_at.month == params[:month].to_i &&
          p.created_at.year  == params[:year].to_i
        else
          p.created_at.year  == params[:year].to_i
        end
      end
    end
    @posts = @pager.page(params[:page])

    respond_to do |format|
      format.html
      format.json { render :json => @posts }
    end
  end

  def show
    @post ||= Post.find_by_slug(params[:slug])

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
        format.html do
          redirect_to(slug_url(
            @post.created_at.year,
            @post.created_at.month,
            @post.created_at.day,
            @post.slug
          ))
        end
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
        format.html do
          redirect_to(slug_url(
            @post.created_at.year,
            @post.created_at.month,
            @post.created_at.day,
            @post.slug
          ))
        end
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
