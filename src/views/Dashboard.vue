<template>
  <div class="animated fadeIn">
    <div class="row">
      <div class="col-sm-6 col-lg-3" v-for="card in cards">
        <counter-card :card="card"/>
      </div><!--/.col-->
    </div><!--/.row-->

    <!-- Traffic Data -->
    <traffic-card/>

    <!-- Social Statistics -->
    <div class="row">
      <div class="col-sm-6 col-lg-3" v-for="item in socialData">
        <social-box :data="item"/>
      </div>
    </div><!--/.row-->

    <div class="row">
      <div class="col-md-12">
        <sales-traffic :trafficData="trafficData"/>

      </div><!--/.col-->
    </div><!--/.row-->
  </div>
</template>

<script>
import CardLine1ChartExample from './dashboard/CardLine1ChartExample'
import CardLine2ChartExample from './dashboard/CardLine2ChartExample'
import CardLine3ChartExample from './dashboard/CardLine3ChartExample'
import CardBarChartExample from './dashboard/CardBarChartExample'

import CounterCard from './dashboard/CounterCard'
import TrafficCard from './dashboard/TrafficCard'
import SocialBox from './dashboard/SocialBox'
import SalesTraffic from './dashboard/SalesTraffic'

export default {
  name: 'dashboard',
  components: {
    CardLine1ChartExample,
    CardLine2ChartExample,
    CardLine3ChartExample,
    CardBarChartExample,

    counterCard: CounterCard,
    trafficCard: TrafficCard,
    socialBox: SocialBox,
    salesTraffic: SalesTraffic
  },
  data: function () {
    return {
      socialData: [
        {name: 'facebook',
          lineData: [65, 59, 84, 84, 51, 55, 40],
          keyValues: [
            {title: 'friends', value: '89k'},
            {title: 'feeds', value: '459'}
          ]
        },
        {name: 'twitter',
          lineData: [1, 13, 9, 17, 34, 41, 38],
          keyValues: [
            {title: 'followers', value: '973k'},
            {title: 'tweets', value: '1'}
          ]
        },
        {name: 'linkedin',
          lineData: [78, 81, 80, 45, 34, 12, 40],
          keyValues: [
            {title: 'contacts', value: '500+'},
            {title: 'feeds', value: '292'}
          ]
        },
        {name: 'google-plus',
          lineData: [35, 23, 56, 22, 97, 23, 64],
          keyValues: [
            {title: 'followers', value: '894'},
            {title: 'circles', value: '92'}
          ]
        }
      ],
      cards: [
        {class: 'bg-primary'},
        {class: 'bg-info'},
        {class: 'bg-warning'},
        {class: 'bg-danger'}
      ],
      trafficData: {
        tableItems: [
          {
            avatar: { url: '/static/img/avatars/1.jpg', status: 'success' },
            user: { name: 'Yiorgos Avraamu', new: true, registered: 'Jan 1, 2015' },
            country: { name: 'USA', flag: 'static/img/flags/USA.png' },
            usage: { value: 50, period: 'Jun 11, 2015 - Jul 10, 2015' },
            payment: { name: 'Mastercard', icon: 'fa fa-cc-mastercard' },
            activity: '10 sec ago'
          },
          {
            avatar: { url: '/static/img/avatars/2.jpg', status: 'danger' },
            user: { name: 'Avram Tarasios', new: false, registered: 'Jan 1, 2015' },
            country: { name: 'Brazil', flag: 'static/img/flags/Brazil.png' },
            usage: { value: 22, period: 'Jun 11, 2015 - Jul 10, 2015' },
            payment: { name: 'Visa', icon: 'fa fa-cc-visa' },
            activity: '5 minutes ago'
          },
          {
            avatar: { url: '/static/img/avatars/3.jpg', status: 'warning' },
            user: { name: 'Quintin Ed', new: true, registered: 'Jan 1, 2015' },
            country: { name: 'India', flag: 'static/img/flags/India.png' },
            usage: { value: 74, period: 'Jun 11, 2015 - Jul 10, 2015' },
            payment: { name: 'Stripe', icon: 'fa fa-cc-stripe' },
            activity: '1 hour ago'
          },
          {
            avatar: { url: '/static/img/avatars/4.jpg', status: '' },
            user: { name: 'Enéas Kwadwo', new: true, registered: 'Jan 1, 2015' },
            country: { name: 'France', flag: 'static/img/flags/France.png' },
            usage: { value: 98, period: 'Jun 11, 2015 - Jul 10, 2015' },
            payment: { name: 'PayPal', icon: 'fa fa-paypal' },
            activity: 'Last month'
          },
          {
            avatar: { url: '/static/img/avatars/5.jpg', status: 'success' },
            user: { name: 'Agapetus Tadeáš', new: true, registered: 'Jan 1, 2015' },
            country: { name: 'Spain', flag: 'static/img/flags/Spain.png' },
            usage: { value: 22, period: 'Jun 11, 2015 - Jul 10, 2015' },
            payment: { name: 'Google Wallet', icon: 'fa fa-google-wallet' },
            activity: 'Last week'
          },
          {
            avatar: { url: '/static/img/avatars/6.jpg', status: 'danger' },
            user: { name: 'Friderik Dávid', new: true, registered: 'Jan 1, 2015' },
            country: { name: 'Poland', flag: 'static/img/flags/Poland.png' },
            usage: { value: 43, period: 'Jun 11, 2015 - Jul 10, 2015' },
            payment: { name: 'Amex', icon: 'fa fa-cc-amex' },
            activity: 'Last week'
          }
        ],
        tableFields: {
          avatar: {
            label: '<i class="icon-people"></i>',
            class: 'text-center'
          },
          user: {
            label: 'User'
          },
          country: {
            label: 'Country',
            class: 'text-center'
          },
          usage: {
            label: 'Usage'
          },
          payment: {
            label: 'Payment method',
            class: 'text-center'
          },
          activity: {
            label: 'Activity'
          }
        }
      }
    }
  },
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
