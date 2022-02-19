<template lang="pug">
  v-container.base
    v-row.ma-1(style="background-color: var(--v-base-lighten5)")
      v-col(cols="12")
        v-data-table(
          :headers="headers",
          :items="apiIndicators",
          item-key="symbol",
          multi-sort
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
        v-btn(color="primary", v-on:click="openGraph")
          .font-weight-black(style="color: var(--v-base-lighten1)")
            | グラフでみる
        Overlay(
          v-bind:indicatorsHeader="headers"
          v-bind:indicatorsData="apiIndicators"
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
      type: Object,
      default: () => {},
    },
  },
  data: function () {
    return {
      headers: [
        {
          text: "銘柄",
          value: "symbol",
        },
        {
          text: "現在価格",
          value: "price",
        },
        {
          text: "短期上昇率・下降率",
          value: "probability_short",
        },
        {
          text: "短期リターン",
          value: "myuhat_short",
        },
        {
          text: "短期リスク",
          value: "sigmahat_short",
        },
        {
          text: "中期上昇率・下降率",
          value: "probability_medium",
        },
        {
          text: "中期リターン",
          value: "myuhat_medium",
        },
        {
          text: "中期リスク",
          value: "sigmahat_medium",
        },
        {
          text: "長期上昇率・下降率",
          value: "probability_long",
        },
        {
          text: "長期リターン",
          value: "myuhat_long",
        },
        {
          text: "長期リスク",
          value: "sigmahat_long",
        },
      ],
      showGraph: false
    };
  },
  methods: {
    openGraph: function() {
      this.showGraph = true
    },
    closeGraph: function() {
      this.showGraph = false
    }
  }
};
</script>

<style scoped>
.v-data-table >>> .v-data-table-header {
  background-color: var(--v-primary-base);
}
.v-data-table >>> .v-data-table-header tr th span {
  color: var(--v-base-lighten1);
}
.v-data-table >>> .v-data-table-header i.v-icon.v-icon {
  color: var(--v-base-lighten1) !important;
}
</style>
