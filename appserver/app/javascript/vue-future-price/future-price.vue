<template lang='pug'>
  v-app
    v-container.base
      v-row
        v-col(cols='12')
          Items(
            id="items"
            v-on:items='calculatePrices($event); setRate($event)'
            v-bind:lastPrice='lastPrice'
          )
        v-col(cols='12')
          Graph(
            id="graph"
            v-bind:symbol='symbol'
            v-bind:upperPrice="price['upper']"
            v-bind:middlePrice="price['middle']"
            v-bind:lowerPrice="price['lower']"
            v-bind:upperRate="upperRate"
            v-bind:lowerRate="lowerRate"
          )
</template>
<script>
import Graph from './price-graph.vue'
import Items from './price-items.vue'
export default {
  name: 'FuturePrice',
  components: {
    Graph,
    Items
  },
  props: {
    symbol: { type: String, required: true },
    lastPrice: {type: String, required: true}
  },
  data() {
    return {
      price: {
        'upper': '',
        'middle': '',
        'lower': ''
      },
      upperRate: 0,
      lowerRate: 0
    }
  },
  methods: {
    calculatePrices: function(items) {
      const url = 'http://localhost:4951/futureprice?symbol='
                + this.symbol
                + '&initial_price='
                + items.initialPrice
                + '&term='
                + items.term;
      const upperUrl = url + '&lower_probability=' + this.probability(items.upperRate);
      const middleUrl = url + '&lower_probability=0.50';
      const lowerUrl = url + '&lower_probability=' + this.probability(items.lowerRate);
      this.getPrice(upperUrl, 'upper');
      this.getPrice(middleUrl, 'middle');
      this.getPrice(lowerUrl, 'lower');
    },
    token() {
      const meta = document.querySelector('meta[name="csrf-token"]')
      return meta ? meta.getAttribute('content') : ''
    },
    probability: function(rate) {
      return ( 50 + Number(rate) ) / 100
    },
    getPrice: function(url, lowerOrMiddleOrUpper) {
      fetch(url, {
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
        this.price[lowerOrMiddleOrUpper] = json.upper_price
      })
      .catch((error) => {
        console.warn('Failed to parsing', error)
      }) 
    },
    setRate: function(items) {
      this.upperRate = Number(items.upperRate)
      this.lowerRate = Number(items.lowerRate)
    }
  }
}
</script>
<style lang='scss' scoped>
#items{
    position: fixed;
    top: -12px;
    bottom: -12px;
    left: -12px;
    min-height: 100vh;
    width: 30%;
    display: flex;
  }
#graph{
  position: fixed;
  left: 35%;
  top: 3.25rem;
}
</style>
