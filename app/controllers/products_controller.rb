class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  
  def index
    @products = Product.all.with_attached_photo
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_url, notice: t('.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      redirect_to product_url(@product), notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    
    redirect_to products_path, notice: t('.destroyed') , status: :see_other
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :price, :description, :photo)
    end
end
