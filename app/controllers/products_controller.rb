class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:favorite, :unfavorite]
  before_action :validate_search_key, only: [:search]

  def index
    # if params[:category].present?
    #    @category = params[:category]
    #    if @category == '所有商品'
    #      @products = Poduct.published.recent.paginate(:page => params[:page], :per_page => 5)
    #    else
    #      @products = Product.published.where(:category => @category).recent.paginate(:page => params[:page], :per_page => 5)
    #    end
    # else
    #     @products = case params[:order]
    #               when 'down_product.price'
    #                 Product.published.order('price DESC').paginate(:page => params[:page], :per_page => 5)
    #               when 'up_product.price'
    #                 Product.published.order('price ASC').paginate(:page => params[:page], :per_page => 5)
    #               else
    #                 Product.published.recent.paginate(:page => params[:page], :per_page => 5)
    #               end
    # end
    @products = Product.all
    @products = case params[:order]
                   when 'down_product.price'
                     Product.published.order('price DESC').paginate(:page => params[:page], :per_page => 20)
                   when 'up_product.price'
                     Product.published.order('price ASC').paginate(:page => params[:page], :per_page => 20)
                   else
                     Product.published.recent.paginate(:page => params[:page], :per_page => 20)
                   end
  end

  def show
    @product = Product.find(params[:id])
    @comments = @product.comments
    @photos = @product.photos.all


  end

  def add_to_cart
    @product = Product.find(params[:id])
    @quantity = params[:quantity].to_i
    # 判断加入购物车的商品是否超过库存

    if @quantity > @product.quantity
      @quantity = @product.quantity
      flash[:warning] = "您选择的商品数量超过库存，实际加入购物车的商品为#{@quantity}件。"
    else
      current_cart.add(@product, @quantity)
    end
    redirect_to product_path(@product)
  end

  def instant_buy
    @product = Product.find(params[:id])
    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
    else
      flash[:warning] = "你的购物车已有此物品，快去结账吧"
    end
    redirect_to carts_path
  end

  def favorite
    @product = Product.find(params[:id])
    current_user.favorite_products << @product
    redirect_to :back
  end

  def unfavorite
    @product = Product.find(params[:id])
    current_user.favorite_products.delete(@product)
    redirect_to :back 
  end

  def search
    if @query_string.present?
      search_result = Product.ransack(@search_criteria).result(:distinct => true)
      @products = search_result.paginate(:page => params[:page], :per_page => 5 )
    end
  end

  protected

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "")
    if params[:q].present?
      @search_criteria =  { title_or_description_cont: @query_string }
    end
  end


  def search_criteria(query_string)
    { :title_cont => query_string }
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :quantity, :image, :category_id, :is_hidden)
  end

end
