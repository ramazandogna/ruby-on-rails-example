# Bu class Ruby'nin tüm temel özelliklerini demonstre eder
class RubySyntaxDemo < ApplicationRecord
  # === CLASS VARIABLES & CONSTANTS ===
  # Constant (büyük harfle başlar) - JavaScript'te const DEMO_VERSION = "1.0"
  DEMO_VERSION = "1.0"
  
  # Class variable (@@) - JavaScript'te static property
  @@demo_counter = 0
  
  # === VALIDATIONS (Rails özelliği) ===
  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :content, presence: true
  validates :category, inclusion: { in: ['variables', 'methods', 'arrays', 'hashes', 'loops'] }
  
  # === CALLBACKS (Rails özelliği) ===
  # JavaScript'te: beforeCreate, afterCreate hooks benzeri
  before_save :normalize_title
  after_create :increment_counter
  
  # === SCOPE'LAR (SQL query builder) ===
  # JavaScript Sequelize'de: where(), order() benzeri
  scope :by_category, ->(cat) { where(category: cat) }
  scope :recent, -> { order(created_at: :desc) }
  scope :published, -> { where(published: true) }
  
  # === CLASS METHODS (static methods) ===
  def self.demo_statistics
    {
      total_demos: count,                    # SQL: SELECT COUNT(*) FROM ruby_syntax_demos
      categories: distinct.pluck(:category), # SQL: SELECT DISTINCT category FROM...
      latest: recent.first&.title || "Henüz demo yok"
    }
  end
  
  def self.create_sample_data
    # Array of hashes (JavaScript'te array of objects)
    sample_demos = [
      {
        title: "Ruby Variables & Data Types",
        content: "String, Integer, Float, Boolean, Symbol örnekleri",
        category: "variables",
        published: true
      },
      {
        title: "Ruby Methods & Blocks",
        content: "def, yield, proc, lambda örnekleri",
        category: "methods",
        published: true
      },
      {
        title: "Arrays & Iteration",
        content: "each, map, select, reject örnekleri",
        category: "arrays",
        published: true
      },
      {
        title: "Hashes & Symbols",
        content: "Hash tanımlama, key-value pairs, symbol kullanımı",
        category: "hashes",
        published: false
      },
      {
        title: "Loops & Conditionals",
        content: "if/else, case/when, times, while döngüleri",
        category: "loops",
        published: true
      }
    ]
    
    # each döngüsü (JavaScript forEach benzeri)
    sample_demos.each do |demo_data|
      # find_or_create_by: Varsa bul, yoksa oluştur
      find_or_create_by(title: demo_data[:title]) do |demo|
        demo.content = demo_data[:content]
        demo.category = demo_data[:category]
        demo.published = demo_data[:published]
      end
    end
  end
  
  def self.reset_counter
    @@demo_counter = 0
  end
  
  def self.current_counter
    @@demo_counter
  end
  
  # === INSTANCE METHODS ===
  def formatted_title
    # String interpolation (JavaScript template literals benzeri)
    "📚 #{title.titleize}"  # titleize: her kelimenin ilk harfi büyük
  end
  
  def word_count
    # Method chaining (JavaScript'te array.split().length benzeri)
    content.split.length
  end
  
  def summary(max_words = 10)
    # Default parameter (JavaScript'te function summary(maxWords = 10))
    words = content.split
    if words.length > max_words
      "#{words.first(max_words).join(' ')}..."
    else
      content
    end
  end
  
  def tags
    # Array literal syntax
    case category
    when 'variables'
      ['basic', 'syntax', 'types']
    when 'methods'
      ['functions', 'blocks', 'advanced']
    when 'arrays'
      ['collections', 'iteration', 'enumerable']
    when 'hashes'
      ['key-value', 'dictionaries', 'objects']
    when 'loops'
      ['control-flow', 'iteration', 'conditions']
    else
      ['general', 'ruby']
    end
  end
  
  def is_long_content?
    # Predicate method (? ile biter, boolean döner)
    # JavaScript'te: function isLongContent() { return ... }
    word_count > 20
  end
  
  def publish!
    # Bang method (! ile biter, destructive/mutating operation)
    # JavaScript'te genelde mutating method'ları böyle ayırt etmeyiz
    update!(published: true)
  end
  
  def toggle_published!
    # Boolean toggle
    update!(published: !published)
  end
  
  # === PRIVATE METHODS ===
  private
  
  def normalize_title
    # Callback method - save'den önce çalışır
    # JavaScript'te: this.title = this.title.trim().toLowerCase()
    self.title = title.strip.titleize if title.present?
  end
  
  def increment_counter
    # Callback method - create'den sonra çalışır
    @@demo_counter += 1
  end
end
