import 'vuetify/dist/vuetify.min.css'
import '@mdi/font/css/materialdesignicons.css'
import ja from 'vuetify/es5/locale/ja.js'
import Vue from 'vue'
import Vuetify from 'vuetify'
import App from './App.vue'
Vue.use(Vuetify)

const vuetify = new Vuetify({
  theme: {
    themes: {
      light: {
        base: '#eceff1',
        primary: '#263238',
        accent: '#ff9800'
      },
    },
    options: {
      customProperties: true
    }
  },
  lang: {
        locales: { ja },
        current: 'ja',
  }
})
document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    vuetify,
    render: h => h(App)
  }).$mount('#js-indicators-vue')
})
