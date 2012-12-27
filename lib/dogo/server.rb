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
      halt 401, erb(:"401") unless Dogo.api_key == params[:api_key]

      if Dogo::Url.shortened?(params[:url])
        params[:url]
      elsif Dogo::Url.valid?(params[:url])
        shortened = Dogo::Url.new(params[:url])
        shortened.url
      else
        status 422
        erb(:"422")
      end
    end

    get "/:id" do
      shortened = find_or_pass(params[:id])
      shortened.click!

      redirect shortened.full
    end

    not_found do
      erb(:"404")
    end
  end
end
