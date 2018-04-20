<template>
  <li v-if="data.title!==''">
    <i :class="data.icon"></i>
    <span class="title">{{ data.title }}</span>
    <span class="value">{{ data.valueStr }}
      <span v-show="data.note" class="text-muted small">{{ data.note }}</span>
    </span>
    <div class="bars">
      <b-progress class="progress-xs" :value="data.value" :variant="data.variant"></b-progress>
    </div>
  </li>
  <li v-else class="divider"></li>
</template>

<script>
export default {
  name: 'salesTrafficProgressRow',
  props: [
    'data'
  ]
}
</script>
