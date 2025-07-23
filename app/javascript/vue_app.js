import { createApp } from 'vue'

// Vue component tanımlaması
const GreetingApp = {
  data() {
    return {
      greetings: [],
      newGreeting: {
        message: '',
        language: 'tr'
      },
      loading: false
    }
  },
  
  mounted() {
    this.fetchGreetings()
  },
  
  methods: {
    async fetchGreetings() {
      try {
        const response = await fetch('/api/greetings')
        this.greetings = await response.json()
      } catch (error) {
        console.log('Greeting verileri yüklenirken hata:', error)
        // Fallback data
        this.greetings = [
          { id: 1, message: 'Merhaba Vue!', language: 'tr' },
          { id: 2, message: 'Hello Vue!', language: 'en' }
        ]
      }
    },
    
    async addGreeting() {
      if (!this.newGreeting.message.trim()) return
      
      this.loading = true
      try {
        const response = await fetch('/api/greetings', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
          },
          body: JSON.stringify({ greeting: this.newGreeting })
        })
        
        if (response.ok) {
          const newGreeting = await response.json()
          this.greetings.push(newGreeting)
          this.newGreeting = { message: '', language: 'tr' }
        }
      } catch (error) {
        console.log('Greeting eklenirken hata:', error)
      } finally {
        this.loading = false
      }
    },
    
    randomGreeting() {
      return this.greetings[Math.floor(Math.random() * this.greetings.length)]
    }
  },
  
  template: `
    <div class="vue-greeting-app">
      <h2>🚀 Vue.js Component (Client-Side)</h2>
      
      <div class="greeting-display">
        <h3>Rastgele Selamlama:</h3>
        <div v-if="greetings.length > 0" class="current-greeting">
          <p><strong>{{ randomGreeting()?.message }}</strong></p>
          <small>{{ randomGreeting()?.language?.toUpperCase() }}</small>
        </div>
      </div>
      
      <div class="add-greeting">
        <h4>Yeni Selamlama Ekle:</h4>
        <div class="form-group">
          <input 
            v-model="newGreeting.message" 
            type="text" 
            placeholder="Selamlama mesajı..."
            @keyup.enter="addGreeting"
          />
          <select v-model="newGreeting.language">
            <option value="tr">Türkçe</option>
            <option value="en">English</option>
            <option value="es">Español</option>
            <option value="fr">Français</option>
          </select>
          <button @click="addGreeting" :disabled="loading">
            {{ loading ? 'Ekleniyor...' : 'Ekle' }}
          </button>
        </div>
      </div>
      
      <div class="greetings-list">
        <h4>Tüm Selamlamalar ({{ greetings.length }} adet):</h4>
        <ul>
          <li v-for="greeting in greetings" :key="greeting.id">
            <strong>{{ greeting.message }}</strong> 
            <span class="lang">({{ greeting.language }})</span>
          </li>
        </ul>
      </div>
    </div>
  `
}

// Vue uygulamasını başlat
document.addEventListener('DOMContentLoaded', () => {
  const vueElement = document.getElementById('vue-app')
  if (vueElement) {
    createApp(GreetingApp).mount('#vue-app')
  }
})
