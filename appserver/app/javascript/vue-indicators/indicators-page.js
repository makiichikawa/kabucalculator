import Vue from 'vue'
import Indicators from './indicators-page.vue'
import vuetify from '../vue-plugins/vuetify'

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    vuetify,
    render: h => h(Indicators)
  }).$mount('#js-indicators-vue')
})
