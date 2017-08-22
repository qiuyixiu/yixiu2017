class Admin::ProductsController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :admin_required

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    @categories = Category.all.map { |c| [c.name, c.id]}
    @photo = @product.photos.build #for multi-pics
  end

  def show
    @product = Product.find_by_friendly_id!(params[:id])

    # colors = ['rgba(255, 99, 132, 0.2)',
    #           'rgba(54, 162, 235, 0.2)',
    #           'rgba(255, 206, 86, 0.2)',
    #           'rgba(75, 192, 192, 0.2)',
    #           'rgba(153, 102, 255, 0.2)',
    #           'rgba(255, 159, 64, 0.2)'
    #           ]
    #
    # ticket_names = @event.tickets.map { |t| t.name }
    #
    #
    # @data1 = {
    #   labels: ticket_names,
    #   datasets: Registration::STATUS.map do |s|
    #   {
    #     label: I18n.t(s, :scope => "registration.status"),
    #     data: @event.tickets.map{ |t| t.registrations.by_status(s).count },
    #     backgroundColor: colors,
    #     borderWidth: 1
    #     }
    #   end
    # }
    #
    # @data2 = {
    #   labels: ticket_names,
    #   datasets: [{
    #     label: '# of Amount',
    #     data: @event.tickets.map{ |t| t.registrations.by_status("confirmed").count * t.price },
    #     backgroundColor: colors,
    #     borderwidth: 1
    #     }]
    # }
    #
    # if @event.registrations.any?
    #   dates = (@event.registrations.order("id ASC").first.created_at.to_date..Date.today).to_a
    #
    #   @data3 = {
    #     lables: dates,
    #     datasets: Registration.map do |s|
    #       {
    #         :label => I18n.t,
    #         :data => dates.map{ |d|
    #           @event.registrations.where( "created_at >= ? AND created_at <= ?", d.beginning_of_day, d.end_of_day).count
    #         },
    #         borderColor: colors
    #       }
    #     end
    #   }
    # end
  end

  def edit
    @product = Product.find_by_friendly_id!(params[:id])
    @categories = Category.all.map { |c| [c.name, c.id] }
  end

  def create
    @product = Product.new(product_params)
    @product.category_id = params[:category_id]
    if @product.save
      if params[:photos] != nil
       params[:photos]['avatar'].each do |a|
         @photo = @product.photos.create(:avatar => a)
       end
      end
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def update
    @product = Product.find_by_friendly_id!(params[:id])
    @product.category_id = params[:category_id]
    if params[:photos] != nil
      @product.photos.destroy_all #need to destroy old pics first

      params[:photos]['avatar'].each do |a|
        @picture = @product.photos.create(:avatar => a)
      end

      @product.update(product_params)
      redirect_to admin_products_path

    elsif @product.update(product_params)
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find_by_friendly_id!(params[:id])
    @product.destroy
    redirect_to admin_products_path
  end

  def publish
    @product = Product.find(params[:id])
    @product.publish!
    redirect_to :back
  end

  def hide
    @product = Product.find(params[:id])
    @product.hide!
    redirect_to :back
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :quantity, :image, :category_id, :is_hidden, :recommend, :stock_tag, :friendly_id)
  end

end
