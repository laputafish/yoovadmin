<template>
  <b-card header="Traffic &amp; Sales">
    <div class="row">
      <sales-traffic-column1 />
      <sales-traffic-column2 />
      <sales-traffic-column3 />
    </div>
    <br/>
    <payment-activity-table
      :items="trafficData.tableItems"
      :fields="trafficData.tableFields">
    </payment-activity-table>
  </b-card>
</template>

<script>
import SalesTrafficColumn1 from './SalesTrafficColumn1'
import SalesTrafficColumn2 from './SalesTrafficColumn2'
import SalesTrafficColumn3 from './SalesTrafficColumn3'
import PaymentActivityTable from './PaymentActivityTable'

export default {
  components: {
    salesTrafficColumn1: SalesTrafficColumn1,
    salesTrafficColumn2: SalesTrafficColumn2,
    salesTrafficColumn3: SalesTrafficColumn3,
    paymentActivityTable: PaymentActivityTable
  },
  name: 'salesTraffic',
  props: [
    'trafficData'
  ]
}
</script>
