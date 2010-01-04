class CommentsController < ApplicationController
  before_filter :find_post_by_id
  load_and_authorize_resource :except => [:destroy]

  def create
    @comment.created_at = Time.now
    @post.comments << @comment

    respond_to do |format|
      if @post.save
        flash[:notice] = 'Successfully created comment.'
      else
        flash[:error] = 'Error while creating comment. Possibly the information you supplied was invalid.'
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
    @post.comments.delete_if {|comment| comment.id.to_s == params[:id]}

    respond_to do |format|
      if @post.save
        flash[:notice] = 'Successfully destroyed comment.'
      else
        flash[:error] = 'Error while destroying comment.'
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

  private
    def find_post_by_id
      @post = Post.find(params[:post_id])
    end
  # private
end
