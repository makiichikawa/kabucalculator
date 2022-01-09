import Vue from 'vue'
import IndicatorsTable from './indicators-table.vue'

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    render: h => h(IndicatorsTable)
  }).$mount('#js-indicators-table-vue')
})
