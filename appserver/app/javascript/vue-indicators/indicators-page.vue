<template lang='pug'>
  v-app
    v-container
      v-row
        v-col(cols='12')
          Filtering(
            v-on:conditions='executeQuery($event)'
            v-bind:indicatorsItems='indicatorsItems'
            v-bind:calculatedItems='calculatedItems'
          )
        v-col(cols='12')
          Table(
            v-bind:apiIndicators='apiIndicators'
            v-bind:indicatorsItems='indicatorsItems'
            v-bind:calculatedItems='calculatedItems'
          )
</template>

<script>
import IndicatorsTable from './indicators-table.vue'
import IndicatorsFiltering from './indicators-filtering.vue'

export default {
  components: {
    'Table': IndicatorsTable,
    'Filtering': IndicatorsFiltering
  },
  data: function() {
    return {
      apiIndicators: [],
      url: '/api/indicators',
      indicatorsItems: {
        symbol: '銘柄',
        price: '現在価格',
        probability_short: '短期上昇率・下降率',
        myuhat_short: '短期リターン',
        sigmahat_short: '短期リスク',
        probability_medium: '中期上昇率・下降率',
        myuhat_medium: '中期リターン',
        sigmahat_medium: '中期リスク',
        probability_long: '長期上昇率・下降率',
        myuhat_long: '長期リターン',
        sigmahat_long: '長期リスク'
      }
    }
  },
  created() {
    this.getIndicators()
  },
  methods: {
    token() {
      const meta = document.querySelector('meta[name="csrf-token"]')
      return meta ? meta.getAttribute('content') : ''
    },
    getIndicators() {
      fetch(this.url, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-Token': this.token()
        },
        credentials: 'same-origin',
        redirect: 'manual'
      })
        .then((response) => response.json())
        .then((json) => {
          this.apiIndicators = json
        })
        .catch((error) => {
          console.warn('Failed to parsing', error)
        })
    },
    executeQuery: function(conditions) {
      this.setQueryParams(conditions)
      this.getIndicators()
    },
    setQueryParams: function(conditions) {
      if (Object.keys(conditions).length) {
        const params = []
        for(const key in conditions) {
          if ((key === 'symbol') && conditions[key]) {
            params.push('symbol=' + conditions.symbol)
          } else {
            if (conditions[key].upper) {
              params.push(key + '_uppervalue=' + conditions[key].upper)
            }
            if (conditions[key].lower) {
              params.push(key + '_lowervalue=' + conditions[key].lower)
            }
          }
        }
        this.url = '/api/indicators?' + params.join('&')
      }
    },
    calculatedItems: function(indicatorsItems) {
      const items = Object.keys(indicatorsItems).filter(key =>
        !((key === 'symbol') || (key === 'price'))
      )
      return items
    }
  }
}
</script>
