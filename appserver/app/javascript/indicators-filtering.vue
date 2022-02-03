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
                    id='symbol'
                  )
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 現在価格
              Field(
                v-on:input-upper-value="setPriceMyuSigmaCondition('upper', $event, conditions.price)"
                v-on:input-lower-value="setPriceMyuSigmaCondition('lower', $event, conditions.price)"
                v-bind:idName="'price'"
              )
            v-col(
              cols='12' xs='12' sm='4'
            )
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 短期上昇率・下降率
              Field(
                v-on:input-upper-value="setProbabilityCondition('upper', $event, conditions.probability_short)"
                v-on:input-lower-value="setProbabilityCondition('lower', $event, conditions.probability_short)"
                v-bind:idName="'probability-short'"
              )
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 短期リターン
              Field(
                v-on:input-upper-value="setPriceMyuSigmaCondition('upper', $event, conditions.myuhat_short)"
                v-on:input-lower-value="setPriceMyuSigmaCondition('lower', $event, conditions.myuhat_short)"
                v-bind:idName="'myuhat-short'"
              )
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 短期リスク
              Field(
                v-on:input-upper-value="setPriceMyuSigmaCondition('upper', $event, conditions.sigmahat_short)"
                v-on:input-lower-value="setPriceMyuSigmaCondition('lower', $event, conditions.sigmahat_short)"
                v-bind:idName="'sigmahat-short'"
              )
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 中期上昇率・下降率
              Field(
                v-on:input-upper-value="setProbabilityCondition('upper', $event, conditions.probability_medium)"
                v-on:input-lower-value="setProbabilityCondition('lower', $event, conditions.probability_medium)"
                v-bind:idName="'probability-medium'"
              )
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 中期リターン
              Field(
                v-on:input-upper-value="setPriceMyuSigmaCondition('upper', $event, conditions.myuhat_medium)"
                v-on:input-lower-value="setPriceMyuSigmaCondition('lower', $event, conditions.myuhat_medium)"
                v-bind:idName="'myuhat-medium'"
              )
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 中期リスク
              Field(
                v-on:input-upper-value="setPriceMyuSigmaCondition('upper', $event, conditions.sigmahat_medium)"
                v-on:input-lower-value="setPriceMyuSigmaCondition('lower', $event, conditions.sigmahat_medium)"
                v-bind:idName="'sigmahat-medium'"
              )
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 長期上昇率・下降率
              Field(
                v-on:input-upper-value="setProbabilityCondition('upper', $event, conditions.probability_long)"
                v-on:input-lower-value="setProbabilityCondition('lower', $event, conditions.probability_long)"
                v-bind:idName="'probability-long'"
              )
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 長期リターン
              Field(
                v-on:input-upper-value="setPriceMyuSigmaCondition('upper', $event, conditions.myuhat_long)"
                v-on:input-lower-value="setPriceMyuSigmaCondition('lower', $event, conditions.myuhat_long)"
                v-bind:idName="'myuhat-long'"
              )
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 長期リスク
              Field(
                v-on:input-upper-value="setPriceMyuSigmaCondition('upper', $event, conditions.sigmahat_long)"
                v-on:input-lower-value="setPriceMyuSigmaCondition('lower', $event, conditions.sigmahat_long)"
                v-bind:idName="'sigmahat-long'"
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
        symbol: '',
        price: {
          upper: '',
          lower: ''
        },
        probability_short: {
          upper: '',
          lower: ''
        },
        myuhat_short: {
          upper: '',
          lower: ''
        },
        sigmahat_short: {
          upper: '',
          lower: ''
        },
        probability_medium: {
          upper: '',
          lower: ''
        },
        myuhat_medium: {
          upper: '',
          lower: ''
        },
        sigmahat_medium: {
          upper: '',
          lower: ''
        },
        probability_long: {
          upper: '',
          lower: ''
        },
        myuhat_long: {
          upper: '',
          lower: ''
        },
        sigmahat_long: {
          upper: '',
          lower: ''
        }
      }
    }
  },
  methods: {
    emitExtractionConditions: function() {
      this.$emit('conditions', this.conditions)
    },
    setSymbolCondition: function(symbols) {
      this.conditions.symbol = symbols.replace(/\s+/, ',')
    },
    setPriceMyuSigmaCondition: function(upper_or_lower, value, condition) {
      condition[upper_or_lower] = value
    },
    setProbabilityCondition: function(upper_or_lower, value, condition) {
      if (value) {
        const originalValue = parseInt(value) / 100
        condition[upper_or_lower] = String(originalValue)
      } else {
        condition[upper_or_lower] = ''
      }
    }
  }
}
</script>

<style scoped>
.v-text-field input{
  background-color: var(--v-base-lighten5);
}
</style>
