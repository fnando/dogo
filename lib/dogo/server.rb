module Dogo
  class Server < Sinatra::Application
    set :views, File.expand_path("../server/views", __FILE__)
    set :public_dir, File.expand_path("../server/assets", __FILE__)
    set :static, true

    helpers do
      def find_or_pass(id)
        url = Dogo::Url.find(id)
        pass unless url
        url
      end
    end

    get "/" do
      redirect Dogo.default_url
    end

    get "/shorten" do
      require "pry"; binding.pry
      halt 401, erb(:"401") unless Dogo.api_key == params[:api_key]

      if Dogo::Url.valid?(params[:url])
        shortened = Dogo::Url.new(params[:url])
        "#{request.scheme}://#{request.host_with_port}/#{shortened.id}"
      else
        status 422
        erb(:"422")
      end
    end

    get "/:id" do
      url = find_or_pass(params[:id])

      url.click!
      redirect url.url
    end

    not_found do
      erb(:"404")
    end
  end
end
