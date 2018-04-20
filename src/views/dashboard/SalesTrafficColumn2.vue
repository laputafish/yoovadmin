<template>
  <div class="col-sm-6 col-lg-4">
    <sales-traffic-callout-row :data="calloutData"/>
    <hr class="mt-0">
    <ul class="horizontal-bars type-2">
      <sales-traffic-progress-row :data="item" v-for="(item,index) in progressData" v-bind:key="index"/>
      <li class="divider text-center">
        <button type="button" class="btn btn-sm btn-link text-muted"><i class="icon-options"></i></button>
      </li>
    </ul>
  </div>
</template>

<script>
import SalesTrafficCalloutRow from './SalesTrafficCalloutRow'
import SalesTrafficProgressRow from './SalesTrafficProgressRow'

export default {
  components: {
    salesTrafficCalloutRow: SalesTrafficCalloutRow,
    salesTrafficProgressRow: SalesTrafficProgressRow
  },
  name: 'salesTrafficColumn2',
  data () {
    return {
      calloutData: [
        {
          variant: 'warning',
          title: 'Pageviews',
          value: '78,623'
        },
        {
          variant: 'success',
          title: 'Organic',
          value: '49,123'
        }
      ],
      progressData: [
        { title: 'Male',
          icon: 'icon-user',
          valueStr: '43%',
          value: 43,
          variant: 'warning'
        },
        {
          title: 'Female',
          icon: 'icon-user-female',
          valueStr: '37%',
          value: 37,
          variant: 'warning'
        },
        {
          title: ''
        },
        {
          title: 'Organic Search',
          icon: 'icon-globe',
          valueStr: '191,235',
          note: '(56%)',
          value: 56,
          variant: 'success'
        },
        {
          title: 'Facebook',
          icon: 'icon-social-facebook',
          valueStr: '51,223',
          note: '(15%)',
          value: 15,
          variant: 'success'
        },
        {
          title: 'Twitter',
          icon: 'icon-social-twitter',
          valueStr: '37,564',
          note: '(11%)',
          value: 11,
          variant: 'success'
        },
        {
          title: 'LinkedIn',
          icon: 'icon-social-linkedin',
          valueStr: '27,319',
          note: '(8%)',
          value: 8,
          variant: 'success'
        }
      ]
    }
  }
}
</script>
