class CarpetsController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]
  before_action :require_admin, only: %i[ manage new create edit update destroy ]
  before_action :set_carpet, only: %i[ show edit update destroy ]

  def index
    carpets = Carpet.all

    # Фільтр за категоріями
    if params[:categories].present?
      carpets = carpets.where(category: params[:categories])
    end

    # Фільтр за мінімальною ціною
    if params[:min_price].present?
      carpets = carpets.where("price >= ?", params[:min_price])
    end

    # Фільтр за максимальною ціною
    if params[:max_price].present?
      carpets = carpets.where("price <= ?", params[:max_price])
    end

    # Сортування
    carpets = case params[:sort]
              when "price_asc"
                carpets.order(price: :asc)
              when "price_desc"
                carpets.order(price: :desc)
              else
                carpets.order(id: :asc)
              end

    @carpets = carpets.page(params[:page]).per(6)
  end

  def show
  end

  def manage
    @carpets = Carpet.order(id: :asc)
  end

  def new
    @carpet = Carpet.new
  end

  def create
    @carpet = Carpet.new(carpet_params)
    if @carpet.save
      redirect_to manage_carpets_path, notice: "Новий килим успішно додано!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @carpet.update(carpet_params)
      redirect_to manage_carpets_path, notice: "Дані килима оновлено!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @carpet.destroy
    redirect_to manage_carpets_path, notice: "Килим видалено з каталогу."
  end

  private

  def set_carpet
    @carpet = Carpet.find(params[:id])
  end

  def carpet_params
    params.require(:carpet).permit(:title, :description, :price, :stock, :category, :image_url)
  end
end