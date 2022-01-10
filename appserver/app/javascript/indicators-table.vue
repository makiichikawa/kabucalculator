<template lang="pug">
  table#indicators-table
    thead
      tr
        th 銘柄CD
        th 現在価格
    tbody
      tr(
        v-for="indicators in allIndicators"
        v-bind:key="indicators.symbol"
      )
        td {{indicators.symbol}}
        td {{indicators.price}}
</template>

<script>
export default {
  data: function() {
    return {
      allIndicators: []
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
          this.allIndicators = json
          this.loaded = true
        })
        .catch((error) => {
          console.warn('Failed to parsing', error)
        })
    }
  }
}
</script>
