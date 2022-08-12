<template lang="pug">
v-container.px-5
  v-row(
    style="background-color: var(--v-base-lighten1)"
  )
    v-col.py-2.items-header(
      cols="12"
    )
      .font-weight-black
        | 計算条件
    v-col.px-3.pb-3(
      cols="12"
      style="height: calc(100% - 3.25rem)"
    )
      v-form(ref="form")
        v-row
          v-col.pb-0.text-sm-subtitle-2.text-xs-body-2(cols="12", xs="12", sm="4")
          template(
            v-for="items in this.priceItems"
          )
            .font-weight-bold
              | {{items.name}}
            v-row(justify="center", align="center")
              v-col(cols="12")
                v-text-field(
                  dense,
                  v-on:input="setItems(items.key, $event)"
                  v-bind:value="itemsData[items.key]"
                )
          v-col.text-center(cols="12")
            v-btn(color="success" v-on:click="emitItems")
              .font-weight-black(style="color: var(--v-base-lighten1)")
                | 計算
</template>
<script>
export default {
  name: 'PriceItems',
  data: function() {
    return {
      priceItems: [
        {name: '初期価格', key: 'initialPrice'},
        {name: '経過日数', key: 'term'},
        {name: '上昇率', key: 'upperRate'},
        {name: '下降率', key: 'lowerRate'}
      ],
      itemsData: {
        initialPrice: this.lastPrice,
        term: 1,
        upperRate: 10,
        lowerRate: -10
      }
    }
  },
  props: {
    lastPrice: ''
  },
  methods: {
    emitItems: function() {
      this.$emit("items", this.itemsData);
    },
    setItems: function(item, event) {
      this.itemsData[item] = event
    }
  }
}
</script>
<style lang='scss' scoped>
@import '../stylesheets/_btn.scss';
.v-text-field input {
  background-color: var(--v-base-lighten5);
}
.items-header {
  display: flex;
  justify-content: center;
  background-color: var(--v-primary-base);
  color: var(--v-base-lighten1);
  height: 3.25rem;
}
</style>
