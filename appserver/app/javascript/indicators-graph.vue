<script>
import {Scatter, mixins} from 'vue-chartjs'
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
  mounted() {
    this.renderChart(this.chartData, this.options)
  }
}
</script>