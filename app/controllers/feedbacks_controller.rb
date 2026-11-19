class FeedbacksController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  before_action :require_admin, only: %i[ manage update destroy ]

  def new
    @feedback = Feedback.new
    @my_feedbacks = authenticated? ? Current.user.feedbacks.order(created_at: :desc) : []
  end

  def create
    @feedback = Feedback.new(feedback_params)
    @feedback.user = Current.user if authenticated?

    if @feedback.save
      redirect_to new_feedback_path, notice: "Дякуємо! Ваше звернення надіслано адміністратору."
    else
      @my_feedbacks = authenticated? ? Current.user.feedbacks.order(created_at: :desc) : []
      render :new, status: :unprocessable_entity
    end
  end

  def manage
    @feedbacks = Feedback.includes(:user).order(Arel.sql("admin_reply IS NOT NULL ASC, created_at DESC"))
  end

  def update
    @feedback = Feedback.find(params[:id])
    if @feedback.update(admin_reply: params[:feedback][:admin_reply], replied_at: Time.current)
      redirect_to manage_feedbacks_path, notice: "Відповідь на звернення ##{@feedback.id} збережено."
    else
      redirect_to manage_feedbacks_path, alert: "Не вдалося зберегти відповідь."
    end
  end

  def destroy
    @feedback = Feedback.find(params[:id])
    @feedback.destroy
    redirect_to manage_feedbacks_path, notice: "Звернення видалено."
  end

  private

  def feedback_params
    params.require(:feedback).permit(:last_name, :first_name, :phone, :message)
  end
end