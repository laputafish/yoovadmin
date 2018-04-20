<template>
  <li v-if="data.title!==''">
    <i :class="iconClass"></i>
    <div class="desc">
      <div class="title">{{ data.title }}</div>
      <small>{{ data.desc }}</small>
    </div>
    <div class="value">
      <div class="small text-muted">{{ data.note }}</div>
      <strong>{{ data.value }}</strong>
    </div>
    <div class="actions">
      <button type="button" class="btn btn-link text-muted"><i class="icon-settings"></i></button>
    </div>
  </li>
  <li v-else class="divider"></li>
</template>

<script>
export default {
  name: 'salesTrafficProductItem',
  props: [
    'data'
  ],
  computed: {
    iconClass () {
      return [
        this.data.icon,
        this.data.bgClass
      ]
    }
  }
}
</script>
