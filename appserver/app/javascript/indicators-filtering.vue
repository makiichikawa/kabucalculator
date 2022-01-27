<template lang="pug">
  v-container.base
    v-row.ma-1
      v-col.text-center.primary(cols='12')
        div.font-weight-black(style='color: var(--v-base-lighten1)')
          | 検索条件
      v-col(cols='12')
        v-form
          v-row(
            style='background: var(--v-base-lighten1)'
          )
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 銘柄
              v-row(
                justify='center' align='center'
              )
                v-col(cols='12')
                  v-text-field(
                    hint='銘柄コード'
                    dense
                    v-on:input='setSymbolCondition'
                  )
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 現在価格
              Field(
                v-on:input-upper-value="setCondition('upper', $event, conditions.price)"
                v-on:input-lower-value="setCondition('lower', $event, conditions.price)"
              )
            v-col(
              cols='12' xs='12' sm='4'
            )
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 短期上昇率・下降率
              Field(
                v-on:input-upper-value="setCondition('upper', $event, conditions.probabilityShort)"
                v-on:input-lower-value="setCondition('lower', $event, conditions.probabilityShort)"
              )
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 短期リターン
              Field(
                v-on:input-upper-value="setCondition('upper', $event, conditions.myuShort)"
                v-on:input-lower-value="setCondition('lower', $event, conditions.myuShort)"
              )
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 短期リスク
              Field(
                v-on:input-upper-value="setCondition('upper', $event, conditions.sigmaShort)"
                v-on:input-lower-value="setCondition('lower', $event, conditions.sigmaShort)"
              )
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 中期上昇率・下降率
              Field(
                v-on:input-upper-value="setCondition('upper', $event, conditions.probabilityMedium)"
                v-on:input-lower-value="setCondition('lower', $event, conditions.probabilityMedium)"
              )
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 中期リターン
              Field(
                v-on:input-upper-value="setCondition('upper', $event, conditions.myuMedium)"
                v-on:input-lower-value="setCondition('lower', $event, conditions.myuMedium)"
              )
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 中期リスク
              Field(
                v-on:input-upper-value="setCondition('upper', $event, conditions.sigmaMedium)"
                v-on:input-lower-value="setCondition('lower', $event, conditions.sigmaMedium)"
              )
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 長期上昇率・下降率
              Field(
                v-on:input-upper-value="setCondition('upper', $event, conditions.probabilityLong)"
                v-on:input-lower-value="setCondition('lower', $event, conditions.probabilityLong)"
              )
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 長期リターン
              Field(
                v-on:input-upper-value="setCondition('upper', $event, conditions.myuLong)"
                v-on:input-lower-value="setCondition('lower', $event, conditions.myuLong)"
              )
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 長期リスク
              Field(
                v-on:input-upper-value="setCondition('upper', $event, conditions.sigmaLong)"
                v-on:input-lower-value="setCondition('lower', $event, conditions.sigmaLong)"
              )
            v-col.text-center(cols='12')
              v-btn(
                color='primary'
                v-on:click='emitExtractionConditions'
              )
                div.font-weight-black(style='color: var(--v-base-lighten1)')
                  | 絞り込み
</template>

<script>
import UpperLowerField from './upper-lower-field.vue'
export default {
  'name': 'IndicatorsFiltering',
  components: {
    'Field': UpperLowerField
  },
  data: function() {
    return {
      conditions: {
        symbol: [],
        price: {},
        probabilityShort: {},
        myuShort: {},
        sigmaShort: {},
        probabilityMedium: {},
        myuMedium: {},
        sigmaMedium: {},
        probabilityLong: {},
        myuLong: {},
        sigmaLong: {}
      }
    }
  },
  methods: {
    emitExtractionConditions: function() {
      for(let key in this.conditions) {
        if(!(Object.keys(this.conditions[key]).length)) {
          delete this.conditions[key]
        }
      }
      this.$emit('conditions', this.conditions)
    },
    setSymbolCondition: function(symbols) {
      this.conditions.symbol = symbols.split(' ')
    },
    setCondition: function(upper_or_lower, value, condition) {
      condition[upper_or_lower] = value
    }
  }
}
</script>

<style scoped>
.v-text-field input{
  background-color: var(--v-base-lighten5);
}
</style>
