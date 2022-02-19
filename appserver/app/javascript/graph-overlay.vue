/* eslint-disable vue/require-prop-types */
<template lang="pug">
  v-container(id="overlay")
    v-row
      v-col(cols='12')
        Graph(
          id="graph"
          v-bind:chart-data='graphData'
          v-bind:options='options'
          :style='graphStyle'
        )
      v-col(cols='12')
        v-btn(color="primary", v-on:click="$emit('close')")
          .font-weight-black(style="color: var(--v-base-lighten1)")
            | 閉じる
</template>
<script>
import Graph from './indicators-graph.vue'
export default {
  name: "GraphOverlay",
  components: {
    Graph
  },
  props: {
    indicatorsHeader: {
      type: Array,
      default: () => []
    },
    indicatorsData: {
      type: Array,
      default: () => []
    }
  },
  data: function() {
    return {
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
                labelString: '短期リターン',
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
                labelString: '短期リスク',
                fontColor: this.$vuetify.theme.themes.light.base,
              }
            }
          ]
        },
        tooltips: {
          callbacks: {
            label: function(tooltipItem, data) {
               const label = data.labels[tooltipItem.index];
               return label + ': (' + tooltipItem.xLabel + ', ' + tooltipItem.yLabel + ')';
            }
          }
        }
      },
      height: window.innerHeight / 1.2,
      graphItems: ['myuhat_short', 'sigmahat_short']
    }
  },
  computed: {
    filterBy: function() {
      const data = []
      const labels = []
      this.indicatorsData.forEach(function(indicators){
        const graphIndicators = {}
        for(const [index, item] of this.entries()) {
          if(index === 0) { 
            graphIndicators.x = indicators[item]
          } else if(index === 1) {
            graphIndicators.y = indicators[item]
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
          label: '短期リターンと短期リスクの散布図',
          data: data.plotdata,
          backgroundColor: this.$vuetify.theme.themes.light.accent,
          pointStyle: 'circle',
          showLine: false
        }],
      }
    },
    graphStyle () {
      return {
        height: `${this.height}px`,
        position: 'relative'
      }
    }
  },
}
</script>
<style>
  #overlay{
    z-index: 1;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    max-width: 100%;
    background-color: rgba(0, 0, 0, 0.2);
  }
  #graph{
    z-index: 2;
    padding: 1em;
    background-color: var(--v-primary-lighten1);
  }
</style>
