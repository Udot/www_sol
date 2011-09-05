class MyApp < Sinatra::Application
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