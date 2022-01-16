<template lang="pug">
  v-app
    v-container
      v-data-table(
        :headers='headers'
        :items='allIndicators'
      )
        template(v-slot:item.probability_short="{ item }")
          | {{ item.probability_short | addPercent }}
        template(v-slot:item.probability_medium="{ item }")
          | {{ item.probability_medium | addPercent }}
        template(v-slot:item.probability_long="{ item }")
          | {{ item.probability_long | addPercent }}
</template>

<script>
export default {
  data: function() {
    return {
      headers: [
        {
          text: '銘柄',
          value: 'symbol'
        },
        {
          text: '現在価格',
          value: 'price'
        },
        {
          text: '短期上昇率・下降率',
          value: 'probability_short'
        },
        {
          text: '短期リターン',
          value: 'myuhat_short'
        },
        {
          text: '短期リスク',
          value: 'sigmahat_short'
        },
        {
          text: '中期上昇率・下降率',
          value: 'probability_medium'
        },
        {
          text: '中期リターン',
          value: 'myuhat_medium'
        },
        {
          text: '中期リスク',
          value: 'sigmahat_medium'
        },
        {
          text: '長期上昇率・下降率',
          value: 'probability_long'
        },
        {
          text: '長期リターン',
          value: 'myuhat_long'
        },
        {
          text: '長期リスク',
          value: 'sigmahat_long'
        }
      ],
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
