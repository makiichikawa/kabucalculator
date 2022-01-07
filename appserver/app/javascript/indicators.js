import Vue from 'vue'
import Indicators from './indicators.vue'

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    render: h => h(Indicators)
  }).$mount('#js-indicators-vue')
})
