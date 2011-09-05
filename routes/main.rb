class MyApp < Sinatra::Application
  get '/mu-c9478619-b3ea1fef-e218a7ee-09081759' do
    '42'
  end
  get "/" do
    @active = "root"
    haml :landing
  end

  get "/about" do
    @active = "about"
    haml :about
  end

  get "/contact" do
    @active = "contact"
    haml :contact
  end
end