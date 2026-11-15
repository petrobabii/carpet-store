class CarpetsController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]

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
    @carpet = Carpet.find(params[:id])
  end
end