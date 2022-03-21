<template lang='pug'>
  v-app(
    style="background: var(--v-base-base)"
  )
    v-container
      .text-sm-body-1.py-12
        | KabuCalculatorで計算されている指標はすべて、株価は対数正規分布に従うという前提で計算したものになります。
        br
        | シンプルな株式モデルとなりますが、株式同士で比較する一つの目安として指標を使用いただけたらと思います。
      v-row
        v-col(cols='12' sm='12' md='10')
          v-card(height='100%')
            v-card-title
              | 上昇率、下降率
            v-card-text
              p
                | 株価の対数収益率が正規分布に従うことを前提にして計算した値となります。 
                br
                | 現在の株価がとりうる確率(0～1)を-50%～50%で再スケーリングしました。
              p
                | -50%に近いほど価格水準が低いことを示し、50%に近いほど価格水準が高いことを示しています。
                br
                | 0%は株価の成長率を加味した上で過去の価格水準と今の価格水準が同じであることを示します。
        v-col(cols='12' sm='12' md='10')
          v-card(height='100%')
            v-card-title
              | リターン
            v-card-text
              p
                | 株価の対数収益率の平均になります。
              p
                | 値が大きいほど、収益率つまりリターン大きい株式ということになります。
        v-col(cols='12' sm='12' md='10')
          v-card(height='100%')
            v-card-title
              | リスク
            v-card-text
              p
                | 株価の対数収益率の標準偏差になります。
              p
                | 値が大きいほど、価格変動が大きい、つまりリスクの大きい株式ということになります。
        v-col.text-center(cols='12' sm='12' md='10')
          v-btn(
            color="primary"
            :href="`/indicators`"
          )
            .font-weight-black(style="color: var(--v-base-lighten1)")
              | 戻る
</template>
<style lang='scss' scoped>
@import '../stylesheets/_btn-hover.scss';
</style>
