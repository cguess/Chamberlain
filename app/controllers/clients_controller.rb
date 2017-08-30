class ClientsController < ApplicationController
	before_action :authenticate_user!

	def index
		@clients = Client.all
	end

	def new
		@client = Client.new
	end

	def create
		@client = Client.new(client_params)
		@client.save!
		redirect_to @client
	end

	def show
		@client = Client.find(params[:id])
	end

	def edit
		@client = Client.find(params[:id])
	end

	def update
		@client.update(client_params)
	end

	def destroy
		Client.find(params[:id]).delete!
	end

	private

  def client_params
    params.require(:client).permit(:name, :description, :uuid)
  end

end
