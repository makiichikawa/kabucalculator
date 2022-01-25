<template lang='pug'>
  v-app
    v-container
      v-row
        v-col(cols='12')
          Filtering
        v-col(cols='12')
          Table
</template>

<script>
import IndicatorsTable from './indicators-table.vue'
import IndicatorsFiltering from './indicators-filtering.vue'

export default {
  components: {
    'Table': IndicatorsTable,
    'Filtering': IndicatorsFiltering
  }
}
</script>
