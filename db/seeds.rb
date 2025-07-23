# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Örnek greeting verilerini oluştur
greetings_data = [
  { message: "Hello World!", language: "en" },
  { message: "Merhaba Dünya!", language: "tr" },
  { message: "Hola Mundo!", language: "es" },
  { message: "Bonjour le Monde!", language: "fr" },
  { message: "Hallo Welt!", language: "de" },
  { message: "Ciao Mondo!", language: "it" }
]

greetings_data.each do |greeting_attrs|
  Greeting.find_or_create_by(greeting_attrs)
end

puts "#{Greeting.count} adet greeting oluşturuldu."
