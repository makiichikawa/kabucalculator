<template lang='pug'>
  v-app
    v-container
      v-row
        v-col(cols='12')
          Filtering
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
      apiIndicators: []
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
      fetch('/api/indicators', {
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
    }
  }
}
</script>
