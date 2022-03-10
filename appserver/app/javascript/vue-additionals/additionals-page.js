import Vue from 'vue'
import Additionals from './additionals-page.vue'
import vuetify from '../vue-plugins/vuetify'

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    vuetify,
    render: h => h(Additionals)
  }).$mount('#js-additionals-vue')
})