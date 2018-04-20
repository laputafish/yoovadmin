<template>
  <b-card>
    <div class="row">
      <div class="col-sm-5">
        <h4 class="card-title mb-0">Traffic</h4>
        <div class="small text-muted">November 2016</div>
      </div><!--/.col-->
      <div class="col-sm-7 hidden-sm-down">
        <b-button type="button" variant="primary" class="float-right"><i class="icon-cloud-download"></i></b-button>
        <b-button-toolbar class="float-right" aria-label="Toolbar with button groups">
          <b-button-group class="mr-3" aria-label="First group">
            <b-button variant="outline-secondary">Day</b-button>
            <b-button variant="outline-secondary" :active="true">Month</b-button>
            <b-button variant="outline-secondary">Year</b-button>
          </b-button-group>
        </b-button-toolbar>
      </div><!--/.col-->
    </div><!--/.row-->
    <main-chart-example class="chart-wrapper" style="height:300px;margin-top:40px;" height="300"></main-chart-example>
    <div slot="footer">
      <ul>
        <li>
          <div class="text-muted">Visits</div>
          <strong>29.703 Users (40%)</strong>
          <b-progress class="progress-xs mt-2" :precision="1" variant="success" :value="40"></b-progress>
        </li>
        <li class="hidden-sm-down">
          <div class="text-muted">Unique</div>
          <strong>24.093 Users (20%)</strong>
          <b-progress class="progress-xs mt-2" :precision="1" variant="info" :value="20"></b-progress>
        </li>
        <li>
          <div class="text-muted">Pageviews</div>
          <strong>78.706 Views (60%)</strong>
          <b-progress class="progress-xs mt-2" :precision="1" variant="warning" :value="60"></b-progress>
        </li>
        <li class="hidden-sm-down">
          <div class="text-muted">New Users</div>
          <strong>22.123 Users (80%)</strong>
          <b-progress class="progress-xs mt-2" :precision="1" variant="danger" :value="80"></b-progress>
        </li>
        <li class="hidden-sm-down">
          <div class="text-muted">Bounce Rate</div>
          <strong>40.15%</strong>
          <b-progress class="progress-xs mt-2" :precision="1" :value="40"></b-progress>
        </li>
      </ul>
    </div>
  </b-card>
</template>

<script>
import MainChartExample from './MainChartExample'

export default {
  name: 'trafficeCard',
  components: {
    MainChartExample
  }
}
</script>
