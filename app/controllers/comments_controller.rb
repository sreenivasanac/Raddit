class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # def index
  #   @comments = Comment.all
  #   respond_with(@comments)
  # end

  # def show
  #   respond_with(@comment)
  # end

  # def new
  #   @comment = Comment.new(comment_params)
  #   respond_with(@comment)
  # end

  def edit
    
  end

  def create
    @link = Link.find(params[:link_id])
    debugger
    @comment = @link.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @link, notice: 'Comment was added successfully' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # def update
  #   @comment.update(comment_params)
  #   respond_with(@comment)
  # end

  def destroy
    @link = @comment.link
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @link, notice: 'Comment was deleted successfully' }
      format.json { head :no_content }
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:link_id, :body, :user_id)
    end
end
