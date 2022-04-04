<template lang="pug">
  v-container.pa-0(
    style="background-color: var(--v-base-lighten5)"
  )
    v-row.ma-0
      v-col.pa-0(cols="12")
        v-data-table(
          :headers="headers"
          :items="apiIndicators"
          :header-props="headerProps"
          item-key="symbol"
        )
          template(v-slot:item.price="{ item }")
            .text-right
              | {{ item.price }}
          template(v-slot:item.probability_short="{ item }")
            .text-right
              | {{ item.probability_short | displayPercent }}
          template(v-slot:item.myuhat_short="{ item }")
            .text-right
              | {{ item.myuhat_short | addZero }}
          template(v-slot:item.sigmahat_short="{ item }")
            .text-right
              | {{ item.sigmahat_short | addZero }}
          template(v-slot:item.probability_medium="{ item }")
            .text-right
              | {{ item.probability_medium | displayPercent }}
          template(v-slot:item.myuhat_medium="{ item }")
            .text-right
              | {{ item.myuhat_medium | addZero }}
          template(v-slot:item.sigmahat_medium="{ item }")
            .text-right
              | {{ item.sigmahat_medium | addZero }}
          template(v-slot:item.probability_long="{ item }")
            .text-right
              | {{ item.probability_long | displayPercent }}
          template(v-slot:item.myuhat_long="{ item }")
            .text-right
              | {{ item.myuhat_long | addZero }}
          template(v-slot:item.sigmahat_long="{ item }")
            .text-right
              | {{ item.sigmahat_long | addZero }}
      v-col.text-center(cols="12")
        v-btn(color="success", v-on:click="openGraph")
          .font-weight-black(style="color: var(--v-base-lighten1)")
            | グラフでみる
        Overlay(
          v-bind:indicatorsData="apiIndicators"
          v-bind:indicatorsItems="indicatorsItems"
          v-bind:calculatedItems="calculatedItems"
          v-show="showGraph"
          v-on:close="closeGraph"
        )
</template>

<script>
import Overlay from './graph-overlay.vue'
export default {
  name: "IndicatorsTable",
  components: {
    Overlay
  },
  filters: {
    displayPercent: function (value) {
      if (!value) return "";
      return String((value * 100).toFixed(2)) + "%";
    },
    addZero: function (value) {
      if (!value) return "";
      return String(value.toFixed(4));
    },
  },
  props: {
    apiIndicators: {
      type: Array,
      default: () => [],
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
  data: function () {
    return {
      headers: this.headerItems(),
      showGraph: false,
      headerProps: {
        sortByText: 'ソート項目'
      }
    };
  },
  methods: {
    openGraph: function() {
      this.showGraph = true
    },
    closeGraph: function() {
      this.showGraph = false
    },
    headerItems: function() {
      const headerItems = []
      for (const key in this.indicatorsItems) {
        headerItems.push(
          {
            text: this.indicatorsItems[key],
            value: key
          }
        )
      }
      return headerItems
    }
  }
};
</script>

<style lang='scss' scoped>
@import '../stylesheets/_btn.scss';
::v-deep .v-data-table-header {
  background-color: var(--v-primary-base);
  tr {
    th {
      span, .v-icon {
        color: var(--v-base-lighten1) !important;
      }
      .v-icon {
        position: absolute;
      }
    }
  }
}
::v-deep .v-data-table__wrapper {
  table {
    tbody {
      tr {
        td {
          border-left:1px solid var(--v-base-base);
        }
      }
    }
  }
}
</style>
