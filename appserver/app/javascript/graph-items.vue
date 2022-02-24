<template lang="pug">
  v-container(fill-height)
    .v-message.error--text(
      v-show='tooManyItems'
    )
      | {{rules[0]}}
    v-row(
      v-for="key in this.calculatedItems(indicatorsItems)"
    )
      v-col(cols='12')
        v-checkbox(
          v-model='selected'
          v-bind:label='indicatorsItems[key]'
          v-bind:value='key'
          :rules='rules'
          :hide-details='true'
        )
</template>
<script>
export default {
  name: 'GraphItems',
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
  data: function() {
    return {
      selected: ['myuhat_short', 'sigmahat_short'],
      tooManyItems: false
    }
  },
  computed: {
    rules: function() {
      return [this.selected.length <= 2 ||
        `指標はふたつのみ有効`]
    }
  },
  watch: {
    selected: function(newValue) {
      if (newValue.length === 2) {
        this.tooManyItems = false
        this.$emit('graph-items', newValue);
      } else if (newValue.length > 2) {
        this.tooManyItems = true 
      }
    }
  }
}
</script>
