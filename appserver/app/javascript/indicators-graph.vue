<script>
import {Scatter, mixins} from 'vue-chartjs'
import Chart from 'chart.js'
export default {
  name: 'IndicatorsGraph',
  extends: Scatter,
  mixins: [mixins.reactiveProp],
  props: {
    options: {
      type: Object,
      default: null
    }
  },
  watch: {
    options: {
      handler: function() {
        this.drawChart()
      },
      deep: true
    }
  },
  mounted: function() {
    this.drawChart()
  },
  methods: {
    drawChart: function() {
      this.addPlugin(
        {
          beforeRender: this.beforeRender,
          afterDraw: this.afterDraw
        }
      )
      this.renderChart(this.chartData, this.options)
    },
    beforeRender: function (chart) {
      if (chart.config.options.showAllTooltips) {
        chart.pluginTooltips = []
        for (let index=0; index < chart.config.data.datasets.length; index++) {
          chart.getDatasetMeta(index).data.forEach(function (sector) {
            chart.pluginTooltips.push(new Chart.Tooltip({
              _chart: chart.chart,
              _chartInstance: chart,
              _data: chart.data,
              _options: chart.options.tooltips,
              _active: [sector]
            }, chart))
          })
        }
        chart.options.tooltips.enabled = false
      }
    },
    afterDraw: function(chart, easing) {
      if (chart.config.options.showAllTooltips) {
        if (!chart.allTooltipsOnce) {
          if (easing !== 1)
            return
          chart.allTooltipsOnce = true
        }

        chart.options.tooltips.enabled = true
        Chart.helpers.each(chart.pluginTooltips, function (tooltip) {
          tooltip.initialize()
          tooltip.update()
          tooltip.pivot()
          tooltip.transition(easing).draw()
        })
        chart.options.tooltips.enabled = false
      }
    }
  }
}
</script>
