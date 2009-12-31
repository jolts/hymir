class CommentsController < ApplicationController
  load_and_authorize_resource

  def new
  end

  def create
    @comment.user_id = current_user.id
    @comment.body = params[:comment][:body]
    @comment.created_at = Time.now
    @comment.updated_at = Time.now

    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Successfully created comment.'
        format.html { redirect_to(post_url(@comment.post_id)) }
      else
        format.html { render :action => 'new' }
      end
    end
  end

  def edit
  end

  def update
    @comment.body = params[:comment][:body]
    @comment.updated_at = Time.now

    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Successfully updated comment.'
        format.html { redirect_to(post_url(@comment.post_id)) }
      else
        format.html { render :action => 'edit' }
      end
    end
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      flash[:notice] = 'Successfully destroyed comment.'
      format.html { redirect_to(post_url(@comment.post_id)) }
    end
  end
end
