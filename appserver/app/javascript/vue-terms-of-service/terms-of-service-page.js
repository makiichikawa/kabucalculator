
import Vue from 'vue'
import Terms from './terms-of-service-page.vue'
import vuetify from '../vue-plugins/vuetify'

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    vuetify,
    render: h => h(Terms)
  }).$mount('#js-terms-of-service-vue')
})
