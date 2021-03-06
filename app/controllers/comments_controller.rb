class CommentsController < ApplicationController
  def new
    @parent_id = params.delete(:parent_id)
    @commentable = find_commentable
    @comment = Comment.new(parent_id: @parent_id,
                           commentable_id: @commentable.id,
                           commentable_type: @commentable.class.to_s)
  end

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(permited_params)
    @comment.author = current_user
    if @comment.save
      flash[:notice] = 'Successfully created comment.'
      redirect_to @commentable
    else
      flash[:error] = 'Error adding comment.'
    end
  end

  private

  def permited_params
    params.require(:comment).permit(:body)
  end

  def find_commentable
    params.each do |name, value|
      return Regexp.last_match(1).classify.constantize.find(value) if name =~ /(.+)_id$/
    end
    nil
  end
end
