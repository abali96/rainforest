class ProductsController < ApplicationController

  before_action :ensure_logged_in, :except => [:show, :index]

  def index
    @products = if params[:search]
      Product.where("LOWER(name) LIKE LOWER(?)", "%#{params[:search]}%")
    else
      Product.all
    end

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @products } #this automatically calls to_json on the response
    end
  end

  def show
    @product = Product.find(params[:id])

    if current_user
      @review = @product.reviews.build
    end

  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = current_user.products.new(product_params)

    if @product.save
      redirect_to products_url
    else
      render :new
    end
  end

  def update
    @product = Product.find(params[:id])

    if @product.update_attributes(product_params)
      redirect_to product_path(@product)
    else
      render :edit
    end

  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_url
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :price_in_cents)
  end
end
