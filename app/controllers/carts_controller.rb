class CartsController < ApplicationController
  allow_unauthenticated_access only: %i[ show add decrease remove ]

  def show
    @cart_items = current_cart_items
  end

  def add
    carpet = Carpet.find(params[:carpet_id])
    cart = session[:cart] ||= {}
    id_str = carpet.id.to_s
    current_qty = cart[id_str].to_i

    if carpet.stock <= 0
      redirect_to cart_path, alert: "На жаль, «#{carpet.title}» наразі немає в наявності."
    elsif current_qty >= carpet.stock
      redirect_to cart_path, alert: "Неможливо додати більше — в наявності лише #{carpet.stock} шт. товару «#{carpet.title}»."
    else
      cart[id_str] = current_qty + 1
      session[:cart] = cart
      redirect_to cart_path
    end
  end

  def decrease
    carpet_id = params[:carpet_id].to_s
    cart = session[:cart] ||= {}

    if cart[carpet_id]
      if cart[carpet_id] > 1
        cart[carpet_id] -= 1
      else
        cart.delete(carpet_id)
      end
      session[:cart] = cart
    end

    redirect_to cart_path
  end

  def remove
    cart = session[:cart] ||= {}
    cart.delete(params[:carpet_id])
    session[:cart] = cart

    redirect_to cart_path, notice: "Товар видалено з кошика."
  end

  private

  def current_cart_items
    cart = session[:cart] ||= {}
    items = []

    cart.dup.each do |carpet_id, quantity|
      carpet = Carpet.find_by(id: carpet_id)
      if carpet && carpet.stock > 0
        actual_qty = [quantity.to_i, carpet.stock].min
        cart[carpet_id] = actual_qty
        items << { carpet: carpet, quantity: actual_qty }
      else
        cart.delete(carpet_id)
      end
    end

    session[:cart] = cart
    items
  end
end