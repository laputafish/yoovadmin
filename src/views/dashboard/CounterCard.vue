<template>
  <b-card :class="card.class" :no-block="true">
    <div class="card-body pb-0">
      <b-dropdown class="float-right" variant="transparent p-0" right>
        <template slot="button-content">
          <i class="icon-settings"></i>
        </template>
        <b-dropdown-item>Action</b-dropdown-item>
        <b-dropdown-item>Another action</b-dropdown-item>
        <b-dropdown-item>Something else here...</b-dropdown-item>
        <b-dropdown-item disabled>Disabled action</b-dropdown-item>
      </b-dropdown>
      <h4 class="mb-0">9.823</h4>
      <p>Members online</p>
    </div>
    <card-line3-chart-example class="chart-wrapper" style="height:70px;" height="70"/>
  </b-card>
</template>

<script>
import CardLine3ChartExample from './CardLine3ChartExample'

export default {
  components: {
    cardLine3ChartExample: CardLine3ChartExample
  },
  name: 'counterCard',
  props: [
    'card'
  ]
}
</script>
