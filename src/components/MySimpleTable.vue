<template>
  <b-card :header="getHeader">
    <table class="table" :class="{'table-striped': striped, 'table-sm': condensed}">
      <thead>
        <tr>
          <th v-for="colConfig in tableData.colConfigs">
            {{ colConfig.title }}
          </th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="row in tableData.rows">
          <td>{{ row.username }}</td>
          <td>{{ row.registeredAt }}</td>
          <td>{{ row.role }}</td>
          <td>
            <span v-if="row.status==='active'" class="badge badge-success">Active</span>
            <span v-if="row.status==='banned'" class="badge badge-danger">Banned</span>
            <span v-if="row.status==='inactive'" class="badge badge-secondary">Inactive</span>
            <span v-if="row.status==='pending'" class="badge badge-warning">Pending</span>
            <span v-else></span>
          </td>
        </tr>
      </tbody>
    </table>
    <ul class="pagination">
      <li class="page-item">
        <a class="page-link" href="#">Prev</a>
      </li>
      <li :class="{active: tableData.pageNo==i}" v-for="i in tableData.pageCount" class="page-item">
        <a class="page-link" href="#">{{ i }}</a>
      </li>
      <li class="page-item">
        <a class="page-link" href="#">Next</a>
      </li>
    </ul>
  </b-card>
</template>

<script>
export default {
  name: 'mySimpleTable',
  props: {
    title: {
      type: String,
      default: 'Simple Table'
    },
    striped: {
      type: Boolean,
      default: false
    },
    condensed: {
      type: Boolean,
      default: false
    },
    tableData: {
      type: Object,
      default: {
        colConfigs: {
          type: Array,
          default: []
        },
        rows: {
          type: Array,
          default: []
        },
        pageNo: {
          type: Number,
          default: 1
        },
        pageCount: {
          type: Number,
          default: 1
        }
      }
    }
  },
  computed: {
    getHeader () {
      return "<i class='fa fa-align-justify'></i> " + this.title
    }
  }
}
</script>
