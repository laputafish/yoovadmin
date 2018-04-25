<template>
  <div class="animated fadeIn">
    <div class="row">
      <div class="col-sm-12">
        <b-card title="Vue2 DataTable">
          <div class="card-title">
            <code>query: {{ query }}</code>
          </div>
          <hr/>
          <b-card-body>
            <div class="row">
              <div class="col-sm-12">
                <datatable v-bind="$data" />
              </div>
            </div>
          </b-card-body>
        </b-card>
      </div>
    </div>
  </div>
</template>
<script>
  import mockData from './_mockData'

  export default {
    data () {
      return {
        columns: [
          {title: 'User ID', field: 'uid', sortable: true},
          {title: 'Username', field: 'name'},
          {title: 'Age', field: 'age', sortable: true},
          {title: 'Email', field: 'email'},
          {title: 'Country', field: 'country'}
        ],
        data: [],
        total: 0,
        query: {}
      }
    },
    watch: {
      query: {
        handler (query) {
          mockData(query).then(({ rows, total }) => {
            this.data = rows
            this.total = total
          })
        },
        deep: true
      }
    }
  }
</script>
