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
  
  # GET /ruby (Ruby Syntax Demo sayfası)
  def ruby
    # === RUBY SYNTAX DEMONSTRATION ===
    
    # 1. VARIABLES & DATA TYPES
    # String variables (JavaScript'te const name = "Ramazan")
    @student_name = "Ramazan"
    @course_name = 'Ruby on Rails'  # Single quotes da kullanılabilir
    
    # Number variables
    @student_age = 25              # Integer
    @course_rating = 4.8           # Float
    @is_enrolled = true            # Boolean
    
    # Symbol (Ruby'ye özel, immutable string benzeri)
    @status = :active              # JavaScript'te Symbol('active') benzeri
    
    # Nil (JavaScript'te null/undefined)
    @graduation_date = nil
    
    # 2. STRING OPERATIONS
    # String interpolation (JavaScript template literals benzeri)
    @welcome_message = "Merhaba #{@student_name}! #{@course_name} kursuna hoş geldin."
    
    # String methods (JavaScript'teki string methods benzeri)
    @uppercase_name = @student_name.upcase     # toUpperCase()
    @lowercase_name = @student_name.downcase   # toLowerCase()
    @name_length = @student_name.length        # length
    
    # 3. ARRAYS (JavaScript arrays benzeri)
    @programming_languages = ['Ruby', 'JavaScript', 'Python', 'Go', 'Rust']
    @numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    @mixed_array = ['Ruby', 42, true, :symbol, nil]  # Mixed types allowed
    
    # 4. ARRAY METHODS (JavaScript array methods benzeri)
    # each - forEach benzeri
    @each_example = []
    @programming_languages.each do |language|  # |language| = function parameter
      @each_example << "#{language} is awesome!"  # << = push() benzeri
    end
    
    # map - JavaScript map() benzeri
    @map_example = @programming_languages.map do |lang|
      lang.upcase
    end
    
    # select - JavaScript filter() benzeri
    @select_example = @numbers.select do |num|
      num.even?  # even? predicate method (çift sayı mı?)
    end
    
    # reject - filter'ın tersi
    @reject_example = @numbers.reject do |num|
      num.odd?   # odd? predicate method (tek sayı mı?)
    end
    
    # find - JavaScript find() benzeri
    @find_example = @programming_languages.find do |lang|
      lang.start_with?('P')  # P ile başlayan ilk dil
    end
    
    # 5. HASHES (JavaScript objects benzeri)
    @student_info = {
      name: @student_name,           # Symbol key (modern syntax)
      age: @student_age,
      languages: @programming_languages,
      enrolled: @is_enrolled
    }
    
    # Old syntax (hala kullanılır)
    @course_info = {
      :name => @course_name,         # => hash rocket syntax
      :rating => @course_rating,
      :duration => "3 months"
    }
    
    # String keys (JavaScript object benzeri)
    @project_info = {
      "title" => "Ruby Learning Project",
      "status" => "in_progress",
      "completion" => 65
    }
    
    # 6. HASH OPERATIONS
    @hash_keys = @student_info.keys      # Object.keys() benzeri
    @hash_values = @student_info.values  # Object.values() benzeri
    @has_name_key = @student_info.key?(:name)  # hasOwnProperty benzeri
    
    # Hash iteration
    @hash_iteration_example = []
    @student_info.each do |key, value|   # for...in benzeri
      @hash_iteration_example << "#{key}: #{value}"
    end
    
    # 7. CONDITIONAL STATEMENTS
    # if/elsif/else (JavaScript if/else if/else)
    if @student_age >= 18
      @age_status = "Adult"
    elsif @student_age >= 13
      @age_status = "Teenager"
    else
      @age_status = "Child"
    end
    
    # Ternary operator (JavaScript ? : benzeri)
    @enrollment_status = @is_enrolled ? "Enrolled" : "Not Enrolled"
    
    # case/when (JavaScript switch/case benzeri)
    @difficulty_level = case @course_rating
                       when 0..2 then "Beginner"      # Range kullanımı
                       when 3..4 then "Intermediate"
                       when 5 then "Advanced"
                       else "Unknown"
                       end
    
    # 8. LOOPS & ITERATIONS
    # times loop (Ruby'ye özel)
    @times_example = []
    5.times do |i|  # 0'dan 4'e kadar
      @times_example << "Iteration #{i + 1}"
    end
    
    # Range iteration (JavaScript for loop benzeri)
    @range_example = []
    (1..5).each do |num|  # 1'den 5'e kadar (inclusive)
      @range_example << "Number: #{num}"
    end
    
    # upto method
    @upto_example = []
    1.upto(3) do |num|
      @upto_example << "Count: #{num}"
    end
    
    # 9. BLOCKS, PROCS & LAMBDAS (JavaScript functions/callbacks benzeri)
    # Block examples yukarıda gördük (do...end veya {})
    
    # Proc (JavaScript function reference benzeri)
    multiply_by_two = Proc.new { |x| x * 2 }
    @proc_example = @numbers.first(3).map(&multiply_by_two)
    
    # Lambda (Proc'a benzer ama daha strict)
    square = lambda { |x| x * x }
    @lambda_example = @numbers.first(3).map(&square)
    
    # 10. METHOD DEFINITIONS (View'da kullanacağımız helper methods)
    # Bu method'lar private section'da tanımlanacak
    
    # 11. OBJECT ORIENTED CONCEPTS
    # Class instantiation
    @current_time = Time.now  # new Date() benzeri
    @formatted_time = @current_time.strftime("%Y-%m-%d %H:%M:%S")
    
    # 12. DATABASE OPERATIONS (Rails ActiveRecord)
    # Sample data oluştur
    RubySyntaxDemo.create_sample_data
    
    # Model queries (Sequelize benzeri)
    @all_demos = RubySyntaxDemo.all                    # SELECT * FROM ruby_syntax_demos
    @published_demos = RubySyntaxDemo.published        # WHERE published = true
    @variable_demos = RubySyntaxDemo.by_category('variables')  # WHERE category = 'variables'
    @demo_stats = RubySyntaxDemo.demo_statistics       # Custom statistics
    
    # 13. EXCEPTION HANDLING (try/catch benzeri)
    begin
      @division_result = 10 / 2
    rescue ZeroDivisionError => e
      @division_result = "Cannot divide by zero: #{e.message}"
    rescue => e  # Catch all other exceptions
      @division_result = "Error: #{e.message}"
    ensure
      # finally block benzeri (her zaman çalışır)
      @division_attempted = true
    end
    
    # 14. REGULAR EXPRESSIONS (JavaScript RegExp benzeri)
    email_pattern = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    @email_examples = [
      "ramazan@example.com",
      "invalid-email",
      "test@domain.co.uk"
    ]
    
    @email_validation_results = @email_examples.map do |email|
      {
        email: email,
        valid: email.match?(email_pattern)  # test() benzeri
      }
    end
  end
  
  private
  
  # Helper methods (private methods)
  def format_array_as_string(array)
    # JavaScript: array.join(', ')
    array.join(', ')
  end
  
  def calculate_percentage(part, total)
    # Guard clause (early return pattern)
    return 0 if total.zero?
    
    ((part.to_f / total) * 100).round(2)
  end
end
