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
                  )
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 現在価格
              Field
            v-col(
              cols='12' xs='12' sm='4'
            )
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 短期上昇率・下降率
              Field
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 短期リターン
              Field
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 短期リスク
              Field
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 中期上昇率・下降率
              Field
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 中期リターン
              Field
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 中期リスク
              Field
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 長期上昇率・下降率
              Field
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 長期リターン
              Field
            v-col.text-sm-subtitle-2.text-xs-body-2(
              cols='12' xs='12' sm='4'
            )
              | 長期リスク
              Field
            v-col.text-center(cols='12')
              v-btn(color='primary')
                div.font-weight-black(style='color: var(--v-base-lighten1)')
                  | 絞り込み
</template>

<script>
import UpperLowerField from './upper-lower-field.vue'
export default {
  'name': 'IndicatorsFiltering',
  components: {
    'Field': UpperLowerField
  }
}
</script>

<style scoped>
.v-text-field input{
  background-color: var(--v-base-lighten5);
}
</style>
