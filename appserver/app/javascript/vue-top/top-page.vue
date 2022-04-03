<template lang='pug'>
  v-app(style="background: var(--v-base-base)")
    v-container.py-4
      v-row
        v-col.text-center(cols='12').py-9
          img(
            v-bind:src='logo'
            class='logo')
        v-col.text-center(cols='12')
          .text-sm-h4
            | 統計指標を使って銘柄を選択
        v-col.text-center(cols='12')
          v-btn(
            color="accent"
            :href="`/indicators`"
          )
            .font-weight-black(style="color: var(--v-base-lighten1)")
              | 試してみる
        v-col(cols='12')
          .text-sm-h6
            | 統計指標を使う理由
        v-col(cols='12' xs='12' sm='6')
          v-card(height='100%')
            v-card-title
              | 客観的 
            v-card-text
              p
                | 価格の安い株はどれか?
                br
                | リターンが高い株はどれか?
                br
                | リスクの低い株はどれか?
                br
                | これらに答えをくれるのが統計指標です。
              p
                | KabuCalculatorでは価格水準、リターン、リスクを表す指標を用意しています。
              p
                | チャートを見て感覚的な捉えることも重要ですが、数値としても客観的に把握することも重要です。
        v-col(cols='12' xs='12' sm='6')
          v-card(height='100%')
            v-card-title
              | 比較 
            v-card-text
              p
                | 偏差値という指標がいい点は性質の異なる数学や英語などのテストを比べることが出来ることです。 
              p
                | KabuCalculatorでは偏差値のように価格水準を把握することができ、
                br
                | 異なる性質の株を比較できるようになっています。
              p
                | KabuCalculatorを使って買いタイミングの株を見つけてみてください。
</template>
<script>
export default {
  data() {
    return {
      logo: require('../images/kabucalculator-logo-header.svg')
    }
  }
}
</script>
<style lang='scss' scoped>
@import '../stylesheets/_btn.scss';
.logo {
  height: 4.00rem;
}
</style>
