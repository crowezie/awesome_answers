class FavoritesController < QuestionNestingsController

  def create
    favorite = Favorite.new(question: @question, user: current_user)
    if favorite.save
      redirect_to @question, notice: "favorited!"
    else
      redirect_to @question, alert: "Can't favorite!"
    end
  end

  def destroy
    favorite = Favorite.find params[:id]
    if can? :destroy, favorite
      favorite.destroy
      redirect_to @question, notice: "Removed favorite Status"
    else
      redirect_to root_path, alert: "access denied"
    end
  end


end
