class FavoritesController < ApplicationController
  before_action :set_favorite, only: %i[ show edit update destroy ]
  before_action :logged_in, only: %i[ fav deleteFavFromRestPage createFavFromRestPage deleteFavFromFavPage ]

  # GET /favorites or /favorites.json
  def index
    @favorites = Favorite.all
  end

  # GET /favorites/1 or /favorites/1.json
  def show
  end

  # GET /favorites/new
  def new
    @favorite = Favorite.new
  end

  # GET /favorites/1/edit
  def edit
  end

  # POST /favorites or /favorites.json
  def create
    @favorite = Favorite.new(favorite_params)

    respond_to do |format|
      if @favorite.save
        format.html { redirect_to @favorite, notice: "Favorite was successfully created." }
        format.json { render :show, status: :created, location: @favorite }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /favorites/1 or /favorites/1.json
  def update
    respond_to do |format|
      if @favorite.update(favorite_params)
        format.html { redirect_to @favorite, notice: "Favorite was successfully updated." }
        format.json { render :show, status: :ok, location: @favorite }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favorites/1 or /favorites/1.json
  def destroy
    @favorite.destroy
    respond_to do |format|
      format.html { redirect_to favorites_url, notice: "Favorite was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def fav

  end

  # Delete
  def deleteFavFromFavPage
    @favor = Favorite.find_by(id: params[:favID])
    @favor.destroy
    respond_to do |format|
      format.html { redirect_to favorite_path }
      format.json { head :no_content }
    end
  end

  # Post
  def createFavFromRestPage 
    rest = Restaurant.find_by(id: params[:restID]).name
    @favor = Favorite.new({user_id: session[:user_id], restaurant_id: params[:restID]})

    respond_to do |format|
      if @favor.save
        format.html { redirect_to "/restaurant/#{rest}", notice: "You just favorite #{rest}." }
        format.json { render :show, status: :created, location: @follow }
      else
        format.html { redirect_to "/restaurant/#{rest}", notice: "Fail to follow #{rest}." }
        format.json { render json: @follow.errors, status: :unprocessable_entity }
      end
    end
  end

  # Delete
  def deleteFavFromRestPage 
    @favor = Favorite.find_by(user_id: session[:user_id], restaurant_id: Restaurant.find_by(name: params[:name]).id)
    @favor.destroy
    respond_to do |format|
      format.html { redirect_to "/restaurant/#{params[:name]}", notice: "You just unfavorite #{params[:name]}." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favorite
      @favorite = Favorite.find(params[:id])
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
    def favorite_params
      params.require(:favorite).permit(:user_id, :restaurant_id)
    end
end
