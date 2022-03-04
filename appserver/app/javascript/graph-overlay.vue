<template lang="pug">
  v-container(id="overlay")
    v-row.base.ma-1
      v-col(cols='12' xs='12' sm='8')
        v-row.ma-1(id="graph")
          v-col(cols='12' no-gutter)
            v-chip(
              v-on:click="setShowAllTooltips"
              small
              outlined
              color="accent"
            )
              | {{button.label}}
          v-col(cols='12')
            Graph(
              v-bind:chart-data='graphData'
              v-bind:options='options'
              :style='graphStyle'
            )
      v-col(cols='12' xs='12' sm='4')
        Items(
          id="graph-items"
          v-on:graph-items='setGraphItems'
          v-bind:indicatorsItems='indicatorsItems'
          v-bind:calculatedItems='calculatedItems'
        )
      v-col(cols='12')
        v-btn(color="primary", v-on:click="$emit('close')")
          .font-weight-black(style="color: var(--v-base-lighten1)")
            | 閉じる
</template>
<script>
import Graph from './indicators-graph.vue'
import Items from './graph-items.vue'
export default {
  name: "GraphOverlay",
  components: {
    Graph,
    Items
  },
  props: {
    indicatorsData: {
      type: Array,
      default: () => []
    },
    graphItems: {
      type: Array,
      default: () => ['myuhat_short', 'sigmahat_short']
    },
    indicatorsItems: {
      type: Object,
      default: () => {}
    },
    calculatedItems: {
      type: Function,
      default: () => []
    }
  },
  data: function() {
    return {
      button : {
        symbolDisplay: false,
        label: '銘柄コード表示'
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        legend: {
          display: true,
          labels: {
            fontColor: this.$vuetify.theme.themes.light.base
          }
        },
        scales: {
          xAxes: [
            {
              type: 'linear',
              position: 'bottom',
              ticks: {
                fontColor: this.$vuetify.theme.themes.light.base,
              },
              gridLines: {
                display: true,
                color: this.$vuetify.theme.themes.light.base,
                zeroLineColor: this.$vuetify.theme.themes.light.base
              },
              scaleLabel: {
                display: true,
                labelString: this.indicatorsItems[this.graphItems[0]],
                fontColor: this.$vuetify.theme.themes.light.base,
              }
            }
          ],
          yAxes: [
            {
              type: 'linear',
              ticks: {
                fontColor: this.$vuetify.theme.themes.light.base,
              },
              gridLines: {
                display: true,
                color: this.$vuetify.theme.themes.light.base,
                zeroLineColor: this.$vuetify.theme.themes.light.base
              },
              scaleLabel: {
                display: true,
                labelString: this.indicatorsItems[this.graphItems[1]],
                fontColor: this.$vuetify.theme.themes.light.base,
              }
            }
          ]
        },
        tooltips: {
          callbacks: {
            label: function(tooltipItem, data) {
               const label = '銘柄' + data.labels[tooltipItem.index]
               return label
            }
          }
        },
        showAllTooltips: false,
        animation: false
      },
      height: window.innerHeight / 1.2
    }
  },
  computed: {
    filterBy: function() {
      const data = []
      const labels = []
      this.indicatorsData.forEach(function(indicators){
        const graphIndicators = {}
        for(const [index, item] of this.entries()) {
          const graphIndicator = item.match(/^probability/) ? (indicators[item] * 100).toFixed(2)
                               : indicators[item]
          if(index === 0) { 
            graphIndicators.x = graphIndicator
          } else if(index === 1) {
            graphIndicators.y = graphIndicator
          }
          data.push(graphIndicators)
          labels.push(indicators.symbol)
        }
      }, this.graphItems)
      return {labels: labels, plotdata: data}
    },
    graphData: function() {
      const data = this.filterBy
      return {
        labels: data.labels,
        datasets:[{
          label: this.indicatorsItems[this.graphItems[0]]
            + 'と'
            + this.indicatorsItems[this.graphItems[1]]
            + 'の関係',
          data: data.plotdata,
          backgroundColor: this.$vuetify.theme.themes.light.accent,
          pointStyle: 'circle',
          showLine: false
        }],
      }
    },
    graphStyle: function() {
      return {
        height: `${this.height}px`,
        position: 'relative'
      }
    }
  },
  methods: {
    setGraphItems: function(items) {
      for (const index of [0, 1]) {
        this.$set(this.graphItems, index, items[index])
      }
      this.options.scales.xAxes[0].scaleLabel.labelString = this.indicatorsItems[items[0]]
      this.options.scales.yAxes[0].scaleLabel.labelString = this.indicatorsItems[items[1]]
    },
    setShowAllTooltips: function() {
      if (this.button.symbolDisplay) {
        this.button.symbolDisplay = false
        this.button.label = "銘柄コード表示"
        this.options.showAllTooltips = this.button.symbolDisplay
      } else {
        this.button.symbolDisplay = true
        this.button.label = "銘柄コード非表示"
        this.options.showAllTooltips = this.button.symbolDisplay
      }
    }
  }
}
</script>
<style lang='scss' scoped>
@import './stylesheets/_btn-hover.scss';
  #overlay{
    z-index: 1;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    max-width: 100%;
    background-color: rgba(0, 0, 0, 0.2);
    overflow-y: auto;
    overflow-y: scroll;
  }
  #graph{
    z-index: 2;
    padding: 1em;
    background-color: var(--v-primary-lighten1);
    ::v-deep .v-chip:hover {
      background-color: var(--v-accent-base) !important;
      color: var(--v-primary-base) !important;
    }
  }
</style>
