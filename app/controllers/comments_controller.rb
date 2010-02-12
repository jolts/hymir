class CommentsController < ApplicationController
  before_filter :find_post_by_slug
  before_filter :login_required, :only => [:destroy]

  def create
    @comment = Comment.new(params[:comment])
    @comment.created_at = Time.now
    if signed_in?
      @comment.name     = current_user.username
      @comment.email    = current_user.email
      @comment.url      = Hymir::Config[:domain]
      @comment.has_user = true
    end
    @post.comments << @comment

    if @post.save && @post.published_or_created_at > 2.weeks.ago
      flash[:notice] = t('flash.notice.comment.new')
    else
      flash[:error] = t('flash.error.comment.new')
    end
    redirect_to post_url(@post)
  end

  def destroy
    @post.comments.delete_if {|comment| comment.id.to_s == params[:id]}
    if request.xhr?
      flash.now[:notice] = t('flash.notice.comment.destroy') if @post.save
      render :nothing => true
    else
      flash[:notice] = t('flash.notice.comment.destroy') if @post.save
      redirect_to post_url(@post)
    end
  end

  protected
    def find_post_by_slug
      @post = Post.find_by_slug(params[:post_id])
    end
  # protected
end
