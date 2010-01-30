class CommentsController < ApplicationController
  before_filter :find_post_by_slug

  def create
    @comment = Comment.new(params[:comment])

    if signed_in?
      @comment.name     = current_user.username
      @comment.email    = current_user.email
      @comment.url      = Hymir::Config[:domain]
      @comment.has_user = true
    end

    @comment.created_at = Time.now
    @post.comments << @comment

    respond_to do |format|
      if @post.save && @post.published_or_created_at > 2.weeks.ago
        flash[:notice] = t('flash.notice.comment.new')
      else
        flash[:error] = t('flash.error.comment.new')
      end
      format.html { redirect_to post_url(@post) }
    end
  end

  def destroy
    respond_to do |format|
      if can? :destroy, Comment
        @post.comments.delete_if {|comment| comment.id.to_s == params[:id]}
        flash[:notice] = t('flash.notice.comment.destroy') if @post.save
      else
        flash[:error] = 'Access denied.'
      end
      format.html { redirect_to post_url(@post) }
    end
  end

  protected
    def find_post_by_slug
      @post = Post.find_by_slug(params[:post_id])
    end
  # private
end
