
import Vue from 'vue'
import Price from './future-price.vue'
import vuetify from '../vue-plugins/vuetify'
Vue.config.devtools = true;
document.addEventListener('DOMContentLoaded', () => {
  const selector = '#js-future-price-vue'
  const indicator = document.querySelector(selector)
  const symbol = indicator.getAttribute("data-vue-symbol")
  const lastPrice = indicator.getAttribute("data-vue-last-price")
  new Vue({
    vuetify,
    render: h =>
      h(Price,{
        props: {
          symbol: symbol,
          lastPrice: lastPrice
        }
      })
  }).$mount(selector)
})
