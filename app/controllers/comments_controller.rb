class CommentsController < ApplicationController
  before_filter :find_post_by_id
  load_and_authorize_resource :except => [:destroy]

  def create
    if signed_in?
      @comment.name = current_user.username
      @comment.email = current_user.email
      @comment.url = 'http://github.com/gigamo/hymir'
      @comment.has_user = true
    end
    @comment.created_at = Time.now
    @post.comments << @comment

    respond_to do |format|
      if @post.save
        flash[:notice] = 'Successfully created comment.'
      else
        flash[:error] = 'Error while creating comment.'
        #@comment.errors.full_messages.uniq.map {|e| e.downcase}.join(', ')
      end
      format.html do
        redirect_to(slug_path(
          @post.created_at.year,
          @post.created_at.month,
          @post.created_at.day,
          @post.slug,
          'html'
        ))
      end
    end
  end

  def destroy
    respond_to do |format|
      if can? :destroy, Comment
        @post.comments.delete_if {|comment| comment.id.to_s == params[:id]}
        if @post.save
          flash[:notice] = 'Successfully destroyed comment.'
        end
      else
        flash[:error] = 'Access denied.'
      end
      format.html do
        redirect_to(slug_path(
          @post.created_at.year,
          @post.created_at.month,
          @post.created_at.day,
          @post.slug,
          'html'
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
