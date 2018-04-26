<template>
  <b-card :header="'Vue2DataTable'" class="animated fadeIn">
    <div class="card-title">
      <code>query: {{ query }}</code>
    </div>
    <hr/>
    <h4>active menu: {{ activeMenu }}</h4>
    <datatable v-bind="$data" />
  </b-card>
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
    computed: {
      activeMenu: function (value) {
        return this.$store.getters.activeMenu
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
