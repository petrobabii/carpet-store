class CartsController < ApplicationController
  allow_unauthenticated_access only: %i[ show add decrease remove ]

  def show
    @cart_items = current_cart_items
  end

  def add
    carpet = Carpet.find(params[:carpet_id])
    cart = session[:cart] ||= {}
    
    cart[carpet.id.to_s] = (cart[carpet.id.to_s] || 0) + 1
    session[:cart] = cart

    redirect_to cart_path
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
    cart.map do |carpet_id, quantity|
      carpet = Carpet.find_by(id: carpet_id)
      carpet ? { carpet: carpet, quantity: quantity } : nil
    end.compact
  end
end