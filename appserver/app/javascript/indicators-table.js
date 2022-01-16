import Vue from 'vue'
import Vuetify from 'vuetify'
Vue.use(Vuetify)
import 'vuetify/dist/vuetify.min.css'
import IndicatorsTable from './indicators-table.vue'

const vuetify = new Vuetify()
document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    vuetify,
    render: h => h(IndicatorsTable)
  }).$mount('#js-indicators-table-vue')
})
