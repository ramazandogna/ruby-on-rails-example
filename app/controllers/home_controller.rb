class HomeController < ApplicationController
  # GET /hello action
  def hello
    # Model'den veri çekiyoruz (MVC'nin M kısmı)
    @greeting = Greeting.random_greeting
    @message = @greeting.formatted_message
    @current_time = Time.current
    
    # Bu action otomatik olarak app/views/home/hello.html.erb dosyasını render eder
    # Eğer JSON dönmek istersek:
    # render json: { message: @message, time: @current_time }
  end
  
  # GET / (ana sayfa)
  def index
    @welcome_message = "Ruby on Rails Uygulamanıza Hoş Geldiniz!"
    @total_greetings = Greeting.count
  end
  
  # GET /vue (Vue.js demo sayfası)
  def vue
    # Bu sayfa Vue.js ile interactive olacak
    # Server-side veri isteğe bağlı
  end
end
