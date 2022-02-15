<template lang="pug">
  v-container(id="overlay")
    | テスト
    v-btn(color="primary", v-on:click="$emit('close')")
      .font-weight-black(style="color: var(--v-base-lighten1)")
        | 閉じる
</template>
<script>
export default {
  name: "IndicatorsGraph"
}
</script>
<style>
  #overlay{
    z-index:1;
    position:fixed;
    top:0;
    left:0;
    width:100%;
    height:100%;
    max-width: 100%;
    background-color:rgba(0, 0, 0, 0.2);
  }
</style>
