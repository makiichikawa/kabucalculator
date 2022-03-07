import Vue from 'vue'
import Top from './top-page.vue'
import vuetify from '../vue-plugins/vuetify'

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    vuetify,
    render: h => h(Top)
  }).$mount('#js-top-vue')
})
