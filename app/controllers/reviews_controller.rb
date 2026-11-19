class ReviewsController < ApplicationController
  before_action :set_carpet

  def create
    @review = @carpet.reviews.build(review_params)
    @review.user = Current.user

    if @review.save
      redirect_to carpet_path(@carpet), notice: "Дякуємо! Ваш відгук додано."
    else
      @reviews = @carpet.reviews.includes(:user).order(created_at: :desc)
      render "carpets/show", status: :unprocessable_entity
    end
  end

  def destroy
    @review = @carpet.reviews.find(params[:id])
    if Current.user&.admin? || @review.user == Current.user
      @review.destroy
      redirect_to carpet_path(@carpet), notice: "Відгук видалено."
    else
      redirect_to carpet_path(@carpet), alert: "У вас немає прав для видалення цього відгуку."
    end
  end

  private

  def set_carpet
    @carpet = Carpet.find(params[:carpet_id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end