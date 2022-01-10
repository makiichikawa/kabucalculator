<template lang="pug">
  table#indicators-table
    thead
      tr
        th 銘柄CD
        th 現在価格
        th 短期上昇率・下降率
        th 短期リターン
        th 短期リスク
        th 中期上昇率・下降率
        th 中期リターン
        th 中期リスク
        th 長期上昇率・下降率
        th 長期リターン
        th 長期リスク

    tbody
      tr(
        v-for="indicators in allIndicators"
        v-bind:key="indicators.symbol"
      )
        td {{indicators.symbol}}
        td {{indicators.price}}
        td {{indicators.probability_short | addPercent}}
        td {{indicators.myuhat_short}}
        td {{indicators.sigmahat_short}}
        td {{indicators.probability_medium | addPercent}}
        td {{indicators.myuhat_medium}}
        td {{indicators.sigmahat_medium}}
        td {{indicators.probability_long | addPercent}}
        td {{indicators.myuhat_long}}
        td {{indicators.sigmahat_long}}
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
  filters: {
    addPercent: function(value){
      if (!value) return ''
      return String(value) + '%'
    }
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
