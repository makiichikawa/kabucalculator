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
        )
      v-col.text-center(cols='12' xs='12' sm='2')
        | ~
      v-col(cols='12' xs='12' sm='5')
        v-text-field(
          hint='上限'
          dense
          v-on:input="emitUpperValue"
          v-bind:id="idName + '-upper-value'"
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
  methods:{
    emitLowerValue: function(value) {
      this.$emit('input-lower-value', value)
    },
    emitUpperValue: function(value) {
      this.$emit('input-upper-value', value)
    }
  }
}
</script>
