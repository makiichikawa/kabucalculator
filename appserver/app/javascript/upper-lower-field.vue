<template lang="pug">
  v-container.ma-0.pa-0
    v-row(
      justify='center' align='center'
    )
      v-col(cols='12' xs='12' sm='5')
        v-text-field(
          hint='下限'
          dense
          v-on:input="emitLowerValue"
          v-bind:id="idName + '-lower-value'"
          :rules="rules"
        )
      v-col.text-center(cols='12' xs='12' sm='2')
        | ~
      v-col(cols='12' xs='12' sm='5')
        v-text-field(
          hint='上限'
          dense
          v-on:input="emitUpperValue"
          v-bind:id="idName + '-upper-value'"
          :rules="rules"
        )
</template>

<script>
export default {
  name: 'UpperLowerField',
  props: {
    idName: {
      type: String,
      default: ''
    }
  },
  computed: {
    rules: function() {
      const rules = []
      const rule =
        v => !v || !isNaN(v) ||
          `数値のみ有効`
      rules.push(rule)

      if (this.idName.match(/price|sigmahat/)) {
        const rule =
        v => !v || !(Math.sign(v) === -1) ||
          `正の数のみ有効`
        rules.push(rule)
      }

      if (this.idName.match(/probability/)) {
        const rule =
        v => !v || !(Math.abs(v) > 50) ||
          `-50～50のみ有効`
        rules.push(rule)
      }
      return rules
    }
  },
  methods:{
    emitLowerValue: function(value) {
      this.$emit('input-lower-value', {input: value, id: this.idName})
    },
    emitUpperValue: function(value) {
      this.$emit('input-upper-value', {input: value, id: this.idName})
    }
  }
}
</script>
