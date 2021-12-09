class LikesController < ApplicationController
  before_action :set_like, only: %i[ show edit update destroy ]
  before_action :logged_in, only: %i[ cLike pLike dLike ]

  # GET /likes or /likes.json
  def index
    @likes = Like.all
  end

  # GET /likes/1 or /likes/1.json
  def show
  end

  # GET /likes/new
  def new
    @like = Like.new
  end

  # GET /likes/1/edit
  def edit
  end

  # POST /likes or /likes.json
  def create
    @like = Like.new(like_params)

    respond_to do |format|
      if @like.save
        format.html { redirect_to @like, notice: "Like was successfully created." }
        format.json { render :show, status: :created, location: @like }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /likes/1 or /likes/1.json
  def update
    respond_to do |format|
      if @like.update(like_params)
        format.html { redirect_to @like, notice: "Like was successfully updated." }
        format.json { render :show, status: :ok, location: @like }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /likes/1 or /likes/1.json
  def destroy
    @like.destroy
    respond_to do |format|
      format.html { redirect_to likes_url, notice: "Like was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # Post
  def cLike
    @like = Like.new({like_tag: params[:like_tag], user_id: session[:user_id], comment_id: params[:commentID]})

    respond_to do |format|
      if @like.save
        format.html { redirect_to "/restaurant/#{params[:name]}", notice: "You just like or dislike a comment." }
        format.json { render :show, status: :created, location: @like }
      else
        format.html { redirect_to "/restaurant/#{params[:name]}", notice: "You fail to like or dislike a comment." }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # Patch
  def pLike
    @like = Like.find_by(user_id: session[:user_id], comment_id: params[:commentID])

    respond_to do |format|
      if @like.update(like_tag: params[:like_tag], user_id: session[:user_id], comment_id: params[:commentID])
        format.html { redirect_to "/restaurant/#{params[:name]}", notice: "You just like or dislike a comment." }
        format.json { render :show, status: :ok, location: @like }
      else
        format.html { redirect_to "/restaurant/#{params[:name]}", notice: "You fail to like or dislike a comment." }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # Delete
  def dLike
    @like = Like.find_by(user_id: session[:user_id], comment_id: params[:commentID])

    @like.destroy
    respond_to do |format|
      format.html { redirect_to "/restaurant/#{params[:name]}", notice: "You just unlike or undislike a comment." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    # Check user login
    def logged_in
      if(session[:user_id])
        @user = User.find_by(id: session[:user_id])
        return true
      else
        redirect_to main_path, notice: "you did not login"
      end
    end

    # Only allow a list of trusted parameters through.
    def like_params
      params.require(:like).permit(:like_tag, :user_id, :comment_id)
    end
end
