<template lang="pug">
v-container.pa-2(
  style="background: var(--v-primary-lighten5)"
)
  v-row.ma-1
    v-col.text-center.primary(cols="12")
      .font-weight-black(style="color: var(--v-base-lighten1)")
        | 検索条件
    v-col(cols="12")
      v-form(ref="form")
        v-row(style="background: var(--v-base-lighten1)")
          v-col.text-sm-subtitle-2.text-xs-body-2(cols="12", xs="12", sm="4")
            | {{indicatorsItems.symbol}}
            v-row(justify="center", align="center")
              v-col(cols="12")
                v-text-field#symbol(
                  hint="銘柄コード",
                  dense,
                  v-on:input="setSymbolCondition"
                  :rules="rules"
                )
          v-col.text-sm-subtitle-2.text-xs-body-2(cols="12", xs="12", sm="4")
            | {{indicatorsItems.price}}
            Field(
              v-on:input-upper-value="setUpperLowerCondition('upper', $event, conditions.price)",
              v-on:input-lower-value="setUpperLowerCondition('lower', $event, conditions.price)",
              v-bind:idName="'price'"
            )
          v-col(cols="12", xs="12", sm="4")
          template(
            v-for="key in this.calculatedItems(indicatorsItems)"
          )
            v-col.text-sm-subtitle-2.text-xs-body-2(cols="12", xs="12", sm="4")
              v-tooltip(top)
                template(v-slot:activator="{ on, attrs }")
                  span(v-bind="attrs" v-on="on")
                    a(href="/additionals") {{indicatorsItems[key]}}
                span
                  | {{additionals[key]}}
              Field(
                v-on:input-upper-value="setUpperLowerCondition('upper', $event, conditions[key])",
                v-on:input-lower-value="setUpperLowerCondition('lower', $event, conditions[key])",
                v-bind:idName='key'
              )
          v-col.text-center(cols="12")
            v-btn(color="primary", v-on:click="emitExtractionConditions")
              .font-weight-black(style="color: var(--v-base-lighten1)")
                | 絞り込み
</template>

<script>
import UpperLowerField from "./upper-lower-field.vue";
export default {
  name: "IndicatorsFiltering",
  components: {
    Field: UpperLowerField,
  },
  props: {
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
      conditions: {
        symbol: "",
        price: {
          upper: "",
          lower: "",
        },
        probability_short: {
          upper: "",
          lower: "",
        },
        myuhat_short: {
          upper: "",
          lower: "",
        },
        sigmahat_short: {
          upper: "",
          lower: "",
        },
        probability_medium: {
          upper: "",
          lower: "",
        },
        myuhat_medium: {
          upper: "",
          lower: "",
        },
        sigmahat_medium: {
          upper: "",
          lower: "",
        },
        probability_long: {
          upper: "",
          lower: "",
        },
        myuhat_long: {
          upper: "",
          lower: "",
        },
        sigmahat_long: {
          upper: "",
          lower: "",
        },
      },
      additionals: {
        probability_short: '直近5日間の価格水準。50%(-50%)に近づくほどより上昇(下降)している。',
        myuhat_short: '直近5日間の収益率。より高い値をとるほど収益率が高い。',
        sigmahat_short: '直近5日間の値動きの激しさを示す。値が大きいほど値動きが激しい。',
        probability_medium: '直近25日間の価格水準。50%(-50%)に近づくほどより上昇(下降)している。',
        myuhat_medium: '直近25日間の収益率。より高い値をとるほど収益率が高い。',
        sigmahat_medium: '直近25日間の値動きの激しさを示す。値が大きいほど値動きが激しい。',
        probability_long: '直近75日間の価格水準。50%(-50%)に近づくほどより上昇(下降)している。',
        myuhat_long: '直近75日間の収益率。より高い値をとるほど収益率が高い。',
        sigmahat_long: '直近75日間の値動きの激しさを示す。値が大きいほど値動きが激しい。'
      }
    };
  },
  computed: {
    rules: function() {
      const rules = []
      const rule =
        v => !v || v.match(/^(\d{4}\s*){1,}$/) ||
          `4桁の整数のみ有効。スペースでつなげると複数検索可(1234 1235)`
      rules.push(rule)
      return rules
    }
  },
  mounted() {
    document.addEventListener('keypress', this.submitOnEnter)
  },
  beforeDestroy() {
    document.removeEventListener('keypress', this.submitOnEnter)
  },
  methods: {
    emitExtractionConditions: function () {
      if (this.$refs.form.validate()) {
        this.$emit("conditions", this.conditions);
      }
    },
    setSymbolCondition: function (symbols) {
      this.conditions.symbol = symbols.replace(/\s+/g, ",");
    },
    setUpperLowerCondition: function (upperOrLower, value, condition) {
      if (value.id.match(/probability/))
        condition[upperOrLower] =
          value.input ? String(parseInt(value.input) / 100) : "";
      else {
        condition[upperOrLower] = value.input;
      }
    },
    submitOnEnter: function(event) {
      if (event.keyCode === 13) {
        this.emitExtractionConditions()
      }
    }
  },
};
</script>

<style lang='scss' scoped>
@import '../stylesheets/_btn-hover.scss';
.v-text-field input {
  background-color: var(--v-base-lighten5);
}
</style>
