<template>
  <div class="social-box" :class="data.name">
    <i class="fa" :class="'fa-' + data.name"></i>
    <div class="chart-wrapper">
      <social-box-chart-example :data="data.lineData" height="90"/>
    </div>
    <ul>
      <li v-for="item in data.keyValues">
        <strong>{{item.value}}</strong>
        <span>{{item.title}}</span>
      </li>
    </ul>
  </div><!--/.social-box-->
</template>

<script>
import SocialBoxChartExample from './SocialBoxChartExample'

export default {
  components: {
    SocialBoxChartExample
  },
  name: 'socialBox',
  props: [
    'data'
  ]
}
</script>
