class OrdersController < ApplicationController

  before_action { @client = OandaAPI::Client::TokenClient.new(:practice, Rails.application.secrets.oanda_token) }  
  before_action { @account_number = Rails.application.secrets.oanda_account }
  
  def index
  end

  def new
    @options_for_type = [['market', 'market']]
    @options_for_side = [['buy', 'buy'], ['sell', 'sell']]
  end

  def create
    @instrument = params[:instrument]
    @type = params[:type]
    @side = params[:side] 
    @units = params[:units]
    @order = Order.new(@client, @account_number, instrument: @instrument, type: @type, side: @side, units: @units).place
    redirect_to orders_path
  end
end
