<template lang="pug">
  v-container
    .text-sm-h5
      | {{symbol}}の将来価格予想
    svg(viewbox="40 40 540 540")
      <!--  縦軸、横軸  -->
      g(stroke="black" stroke-width="1")
        line(x1="80%" y1="5%" x2="80%" y2="95%")
        line(x1="0%" y1="50%" x2="90%" y2="50%")
      <!--  縦の目盛り  -->
      g
        text(x="83%" v-bind:y="upperRatePoint" class='font-weight-black')
          | {{upperMessage}}
        text(x="83%" y="49%" class='font-weight-black')
          | {{middleMessage}}
        text(x="83%" v-bind:y="lowerRatePoint" class='font-weight-black')
          | {{lowerMessage}}
        text(x="77%" y="4%")
          | 株価
      <!--  横の目盛り  -->
      g
        text(x="6%"  y="55%")
            | 現在
        text(x="83%" y="55%")
            | 将来
        text(x="92%" y="51%")
            | 時間

      <!--  グラフ  -->
      g(fill="var(--v-primary-base)")
        circle(cx="10%" cy="50%" r="5" fill="var(--v-primary-base)")
        circle(cx="80%" v-bind:cy="upperRatePoint" r="5" fill='blue')
        circle(cx="80%" v-bind:cy="lowerRatePoint" r="5" fill='red')
        circle(cx="80%" cy="50%" r="5" fill="var(--v-primary-base)")
      g(stroke-width="2")
        line(x1="10%" y1="50%" x2="80%" v-bind:y2="upperRatePoint" stroke='blue')
        line(x1="10%" y1="50%" x2="80%" v-bind:y2="lowerRatePoint" stroke='red')  
        line(x1="10%" y1="50%" x2="80%" y2="50%" stroke="var(--v-primary-base)")
</template>
<script>
export default {
  name: 'PriceGraph',
  props: {
    symbol: {
      type: String,
      require: true,
      default: ''
    },
    upperPrice: {
      type: String,
      require: false,
      default: ''
    },
    middlePrice: {
      type: String,
      require: true,
      default: ''
    },
    lowerPrice: {
      type: String,
      require: false,
      default: ''
    },
    upperRate: {
      type: Number,
      require: false,
      default: 0
    },
    lowerRate: {
      type: Number,
      require: false,
      default: 0
    }
  },
  computed: {
    upperMessage: function() {
      if (this.upperRate > 0) {
        return this.createMessage(this.upperPrice, this.upperRate)
      } else {
        return ''
      }
    },
    middleMessage: function() {
      return this.createMessage(this.middlePrice, 0)
    },
    lowerMessage: function() {
      if (this.lowerRate < 0) {
        return this.createMessage(this.lowerPrice, this.lowerRate)
      } else {
        return ''
      }
    },
    upperRatePoint: function() {
      return this.calculatePoint(this.upperRate) + '%'
    },
    lowerRatePoint: function() {
      return this.calculatePoint(this.lowerRate) + '%'
    },
  },
  mounted: function () {
    window.addEventListener('resize', this.handleResize)
  },
  beforeDestroy: function () {
    window.removeEventListener('resize', this.handleResize)
  },
  methods: {
    handleResize: function() {
      // resizeのたびにこいつが発火するので、ここでやりたいことをやる
      this.svgWidth = window.innerWidth;
      this.svgHeight = window.innerHeight;
    },
    createMessage: function(price, rate) {
      if (price) {
        return Math.round(price * 10) / 10 + '(' + rate + '%)'
      } else {
        return ''
      }
    },
    calculatePoint: function(rate) {
      return String(10 + 0.8 * (50 - rate))
    }
  }
}
</script>
<style lang='scss' scoped>
  svg {
    position: fixed;
	  top: 3.25rem;
	  left: 35%;
    width: 50%;
    height: 90%;
  }
</style>
