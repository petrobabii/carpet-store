class OrdersController < ApplicationController
  before_action :require_admin, only: %i[ manage update ]

  def index
    @orders = Current.user.orders.includes(order_items: :carpet).order(created_at: :desc)
  end

  def manage
    @orders = Order.includes(:user, order_items: :carpet).order(created_at: :desc)
  end

  def new
    @cart_items = load_cart_items
    if @cart_items.empty?
      redirect_to cart_path, alert: "Ваш кошик порожній."
      return
    end

    @total_price = @cart_items.sum { |item| item[:carpet].price * item[:quantity] }
    @order = Order.new
  end

  def create
    @cart_items = load_cart_items
    if @cart_items.empty?
      redirect_to cart_path, alert: "Ваш кошик порожній."
      return
    end

    @total_price = @cart_items.sum { |item| item[:carpet].price * item[:quantity] }
    @order = Current.user.orders.build(order_params)
    @order.total_price = @total_price
    @order.status = "В обробці"
    @order.payment_status = "Не оплачено"

    stock_error = nil

    ActiveRecord::Base.transaction do
      @order.save!

      @cart_items.each do |item|
        carpet = item[:carpet]
        qty = item[:quantity]

        if carpet.stock < qty
          stock_error = "Недостатньо товару «#{carpet.title}» на складі (доступно: #{carpet.stock} шт.)."
          raise ActiveRecord::Rollback
        end

        @order.order_items.create!(
          carpet: carpet,
          quantity: qty,
          price: carpet.price
        )

        carpet.update!(stock: carpet.stock - qty)
      end
    end

    if @order.persisted? && stock_error.nil?
      session[:cart] = {}
      redirect_to orders_path, notice: "Замовлення ##{@order.id} успішно оформлено!"
    else
      flash.now[:alert] = stock_error || "Не вдалося оформити замовлення. Перевірте введені дані та залишки товарів."
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(admin_order_params)
      redirect_to manage_orders_path, notice: "Дані замовлення ##{@order.id} оновлено."
    else
      redirect_to manage_orders_path, alert: "Помилка оновлення замовлення."
    end
  end

  private

  def order_params
    params.require(:order).permit(:customer_name, :phone, :delivery_method, :address, :payment_method)
  end

  def admin_order_params
    params.require(:order).permit(:status, :payment_status)
  end

  def load_cart_items
    cart = session[:cart] || {}
    carpets = Carpet.where(id: cart.keys).index_by { |c| c.id.to_s }
    cart.filter_map do |carpet_id, qty|
      carpet = carpets[carpet_id.to_s]
      next unless carpet && qty.to_i > 0
      { carpet: carpet, quantity: qty.to_i }
    end
  end
end