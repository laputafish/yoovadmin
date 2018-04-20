<template>
  <div class="col-sm-6 col-lg-4">
    <sales-traffic-callout-row :data="calloutData"/>
    <hr class="mt-0">
    <ul class="icons-list">
      <sales-traffic-product-item :data="item" v-for="(item,index) in products" v-bind:key="index"/>
      <li class="divider text-center">
        <button type="button" class="btn btn-sm btn-link text-muted"><i class="icon-options"></i></button>
      </li>
    </ul>
  </div>
</template>

<script>
import SalesTrafficCalloutRow from './SalesTrafficCalloutRow'
import SalesTrafficProductItem from './SalesTrafficProductItem'

export default {
  components: {
    salesTrafficCalloutRow: SalesTrafficCalloutRow,
    salesTrafficProductItem: SalesTrafficProductItem
  },
  name: 'salesTrafficColumn3',
  data () {
    return {
      calloutData: [
        {
          variant: '',
          title: 'CTR',
          value: '23%'
        },
        {
          variant: 'primary',
          title: 'Bounce Rate',
          value: '5%'
        }
      ],
      products: [
        {
          title: 'iMac 4k',
          desc: 'Lorem ipsum dolor sit amet',
          note: 'Sold this week',
          value: '1.924',
          action: '',
          icon: 'icon-screen-desktop',
          bgClass: 'bg-primary'
        },
        {
          title: 'Samsung Galaxy Edge',
          desc: 'Lorem ipsum dolor sit amet',
          note: 'Sold this week',
          value: '1.224',
          action: '',
          icon: 'icon-screen-smartphone',
          bgClass: 'bg-info'
        },
        {
          title: 'iPhone 6S',
          desc: 'Lorem ipsum dolor sit amet',
          note: 'Sold this week',
          value: '1.163',
          action: '',
          icon: 'icon-user',
          bgClass: 'bg-warning'
        },
        {
          title: 'Premium accounts',
          desc: 'Lorem ipsum dolor sit amet',
          note: 'Sold this week',
          value: '928',
          action: '',
          icon: 'icon-user',
          bgClass: 'bg-danger'
        },
        {
          title: 'Spotify Subscriptions',
          desc: 'Lorem ipsum dolor sit amet',
          note: 'Sold this week',
          value: '893',
          action: '',
          icon: 'icon-social-spotify',
          bgClass: 'bg-success'
        },
        {
          title: 'Ebook',
          desc: 'Lorem ipsum dolor sit amet',
          note: 'Downloads',
          value: '121.924',
          action: '',
          icon: 'icon-cloud-download',
          bgClass: 'bg-danger'
        },
        {
          title: 'Photos',
          desc: 'Lorem ipsum dolor sit amet',
          note: 'Uploaded',
          value: '12.125',
          action: '',
          icon: 'icon-camera',
          bgClass: 'bg-warning'
        }
      ]
    }
  }
}
</script>
