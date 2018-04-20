<template>
  <b-table class="table-outline mb-0" hover responsive outline
    :items="items"
    :fields="fields"
    head-variant="default"
    >
    <template slot="avatar" slot-scope="item">
      <div class="avatar">
        <img :src="item.value.url" class="img-avatar" alt="">
        <span class="avatar-status" v-bind:class="{ 'bg-success': item.value.status == 'success',  'bg-warning': item.value.status == 'warning', 'bg-danger': item.value.status == 'danger', 'bg-secondary': item.value.status == '' }"></span>
      </div>
    </template>
    <template slot="user" slot-scope="item">
      <div>{{item.value.name}}</div>
      <div class="small text-muted">
        <span>
          <template v-if="item.value.new">New</template>
          <template v-else>Recurring</template>
        </span> | Registered: {{item.value.registered}}
      </div>
    </template>
    <template slot="country" slot-scope="item">
      <img :src="item.value.flag" :alt="item.value.name" style="height:24px;">
    </template>
    <template slot="usage" slot-scope="item">
      <div class="clearfix">
        <div class="float-left">
          <strong>{{item.value.value}}%</strong>
        </div>
        <div class="float-right">
          <small class="text-muted">{{item.value.period}}</small>
        </div>
      </div>
      <b-progress class="progress-xs" v-model="item.value.value" :variant="variant(item.value.value)"></b-progress>
    </template>
    <template slot="payment" slot-scope="item">
      <i :class="item.value.icon" style="font-size:24px"></i>
    </template>
    <template slot="activity" slot-scope="item">
      <div class="small text-muted">Last login</div>
      <strong>{{item.value}}</strong>
    </template>
  </b-table>
</template>

<script>
export default {
  name: 'paymentActivityTable',
  props: [
    'items',
    'fields'
  ],
  methods: {
    variant (value) {
      let $variant
      if (value <= 25) {
        $variant = 'info'
      } else if (value > 25 && value <= 50) {
        $variant = 'success'
      } else if (value > 50 && value <= 75) {
        $variant = 'warning'
      } else if (value > 75 && value <= 100) {
        $variant = 'danger'
      }
      return $variant
    }
  }
}
</script>
