<template lang='pug'>
  v-app
    v-container
      v-row
        v-col(cols='12')
          Filtering(
            v-on:conditions='executeQuery($event)'
          )
        v-col(cols='12')
          Table(
            v-bind:apiIndicators='apiIndicators'
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
      url: '/api/indicators'
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
        for(let key in conditions) {
          if ((key === 'symbol') && conditions[key]) {
            params.push('symbol=' + conditions['symbol'])
          } else {
            if (conditions[key].upper) {
              params.push(key + 'uppervalue=' + conditions[key].upper)
            }
            if (conditions[key].lower) {
              params.push(key + 'lowervalue=' + conditions[key].lower)
            }
          }
        }
        this.url = '/api/indicators?' + params.join('&')
      }
    }
  }
}
</script>
