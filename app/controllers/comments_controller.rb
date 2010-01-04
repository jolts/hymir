class CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    @post = Post.find(params[:post_id])
    @comment.created_at = Time.now
    @post.comments << @comment # Figure out how to validate the comment before we do this

    respond_to do |format|
      if @post.save
        flash[:notice] = 'Successfully created comment.'
      end
      format.html do
        redirect_to(slug_path(
          @post.created_at.year,
          @post.created_at.month,
          @post.created_at.day,
          @post.slug
        ))
      end
    end
  end

  def destroy
    # FIXME: Untested
    @post = Post.find(params[:post_id])
    @post.comments.delete_if {|comment| comment.id.to_s == params[:comment_id]}

    respond_to do |format|
      flash[:notice] = 'Successfully destroyed comment.'
      format.html
    end
  end
end
