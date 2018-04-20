<template>
<div class="col-sm-12 col-lg-4">
  <sales-traffic-callout-row :data="calloutData"/>
  <hr class="mt-0">

  <ul class="horizontal-bars">
    <li v-for="item in valueList">
      <div class="title">
        {{ item.title }}
      </div>
      <div class="bars">
        <b-progress class="progress-xs" :value="item.value1" variant="info"></b-progress>
        <b-progress class="progress-xs" :value="item.value2" variant="danger"></b-progress>
      </div>
    </li>
    <li class="legend">
      <span class="badge badge-pill badge-info"></span> <small>New clients</small> &nbsp; <span class="badge badge-pill badge-danger"></span> <small>Recurring clients</small>
    </li>
  </ul>
</div>
</template>

<script>
import SalesTrafficCalloutRow from './SalesTrafficCalloutRow'

export default {
  components: {
    salesTrafficCalloutRow: SalesTrafficCalloutRow
  },
  name: 'salesTrafficColumn1',
  data () {
    return {
      calloutData: [
        {
          variant: 'info',
          title: 'New Clients',
          value: '9,123'
        },
        {
          variant: 'danger',
          title: 'Recuring Clients',
          value: '22,6434'
        }
      ],
      valueList: [
        {
          title: 'Monday',
          value1: 34,
          value2: 78
        },
        {
          title: 'Tuesday',
          value1: 56,
          value2: 94
        },
        {
          title: 'Wednesday',
          value1: 12,
          value2: 67
        },
        {
          title: 'Thursday',
          value1: 43,
          value2: 91
        },
        {
          title: 'Friday',
          value1: 22,
          value2: 73
        },
        {
          title: 'Saturday',
          value1: 53,
          value2: 82
        },
        {
          title: 'Sunday',
          value1: 9,
          value2: 69
        }
      ]
    }
  }
}
</script>
