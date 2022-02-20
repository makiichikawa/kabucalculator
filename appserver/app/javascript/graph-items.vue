<template lang="pug">
  v-container(fill-height)
    .v-message.error--text(
      v-show='tooManyItems'
    )
      | {{rules[0]}}
    v-row(
      v-for="item in indicatorItems" :key="item.label"
    )
      v-col(cols='12')
        v-checkbox(
          v-model='selected'
          v-bind:label='item.label'
          v-bind:value='item.value'
          :rules='rules'
          :hide-details='true'
        )
</template>
<script>
export default {
  name: 'GraphItems',
  data: function() {
    return {
      selected: ['myuhat_short', 'sigmahat_short'],
      indicatorItems: [
        {
          label: '短期上昇率・下降率',
          value: 'probability_short'
        },
        {
          label: '短期リターン',
          value: 'myuhat_short'
        },
        {
          label: '短期リスク',
          value: 'sigmahat_short'
        },
        {
          label: '中期上昇率・下降率',
          value: 'probability_medium'
        },
        {
          label: '中期リターン',
          value: 'myuhat_medium'
        },
        {
          label: '中期リスク',
          value: 'sigmahat_medium'
        },
        {
          label: '長期上昇率・下降率',
          value: 'probability_long'
        },
        {
          label: '長期リターン',
          value: 'myuhat_long'
        },
        {
          label: '長期リスク',
          value: 'sigmahat_long'
        }
      ],
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
