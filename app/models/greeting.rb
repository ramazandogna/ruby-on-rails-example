class Greeting < ApplicationRecord
  # Bu bir Active Record model'i
  # Veritabanında greetings tablosuna karşılık gelir
  
  # Validation'lar (veri doğrulama kuralları)
  validates :message, presence: true, length: { minimum: 3 }
  validates :language, presence: true
  
  # Scope'lar (önceden tanımlı sorgular)
  scope :by_language, ->(lang) { where(language: lang) }
  scope :recent, -> { order(created_at: :desc) }
  
  # Class method'lar
  def self.random_greeting
    all.sample || new(message: "Hello!", language: "en")
  end
  
  # Instance method'lar
  def formatted_message
    "#{message} (#{language.upcase})"
  end
end
