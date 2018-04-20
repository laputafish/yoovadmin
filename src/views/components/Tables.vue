<template>
  <div class="animated fadeIn">
    <div class="row">
      <div class="col-lg-6">
        <my-simple-table :tableData="table1Data" title="Simple Table" />
      </div><!--/.col-->

      <div class="col-lg-6">
        <my-simple-table :tableData="table1Data" title="Striped Table" :striped="true"/>
      </div><!--/.col-->
    </div><!--/.row-->

    <div class="row">

      <div class="col-lg-6">
        <my-simple-table :tableData="table1Data" title="Condensed Table" :condensed="true"/>
      </div><!--/.col-->

      <div class="col-lg-6">
        <b-card header="<i class='fa fa-align-justify'></i> Bordered Table">
          <table class="table table-bordered">
            <thead>
              <tr>
                <th>Username</th>
                <th>Date registered</th>
                <th>Role</th>
                <th>Status</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>Pompeius René</td>
                <td>2012/01/01</td>
                <td>Member</td>
                <td>
                  <span class="badge badge-success">Active</span>
                </td>
              </tr>
              <tr>
                <td>Paĉjo Jadon</td>
                <td>2012/02/01</td>
                <td>Staff</td>
                <td>
                  <span class="badge badge-danger">Banned</span>
                </td>
              </tr>
              <tr>
                <td>Micheal Mercurius</td>
                <td>2012/02/01</td>
                <td>Admin</td>
                <td>
                  <span class="badge badge-secondary">Inactive</span>
                </td>
              </tr>
              <tr>
                <td>Ganesha Dubhghall</td>
                <td>2012/03/01</td>
                <td>Member</td>
                <td>
                  <span class="badge badge-warning">Pending</span>
                </td>
              </tr>
              <tr>
                <td>Hiroto Šimun</td>
                <td>2012/01/21</td>
                <td>Staff</td>
                <td>
                  <span class="badge badge-success">Active</span>
                </td>
              </tr>
            </tbody>
          </table>
          <ul class="pagination">
            <li class="page-item"><a class="page-link" href="#">Prev</a></li>
            <li class="page-item active">
              <a class="page-link" href="#">1</a>
            </li>
            <li class="page-item"><a class="page-link" href="#">2</a></li>
            <li class="page-item"><a class="page-link" href="#">3</a></li>
            <li class="page-item"><a class="page-link" href="#">4</a></li>
            <li class="page-item"><a class="page-link" href="#">Next</a></li>
          </ul>
        </b-card>

      </div><!--/.col-->
    </div><!--/.row-->

    <div class="row">
      <div class="col-12">
        <b-card header="<i class='fa fa-align-justify'></i> Combined All Table">
          <table class="table table-bordered table-striped table-sm">
            <thead>
              <tr>
                <th>Username</th>
                <th>Date registered</th>
                <th>Role</th>
                <th>Status</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>Vishnu Serghei</td>
                <td>2012/01/01</td>
                <td>Member</td>
                <td>
                  <span class="badge badge-success">Active</span>
                </td>
              </tr>
              <tr>
                <td>Zbyněk Phoibos</td>
                <td>2012/02/01</td>
                <td>Staff</td>
                <td>
                  <span class="badge badge-danger">Banned</span>
                </td>
              </tr>
              <tr>
                <td>Einar Randall</td>
                <td>2012/02/01</td>
                <td>Admin</td>
                <td>
                  <span class="badge badge-secondary">Inactive</span>
                </td>
              </tr>
              <tr>
                <td>Félix Troels</td>
                <td>2012/03/01</td>
                <td>Member</td>
                <td>
                  <span class="badge badge-warning">Pending</span>
                </td>
              </tr>
              <tr>
                <td>Aulus Agmundr</td>
                <td>2012/01/21</td>
                <td>Staff</td>
                <td>
                  <span class="badge badge-success">Active</span>
                </td>
              </tr>
            </tbody>
          </table>
          <nav>
            <ul class="pagination">
              <li class="page-item"><a class="page-link" href="#">Prev</a></li>
              <li class="page-item active">
                <a class="page-link" href="#">1</a>
              </li>
              <li class="page-item"><a class="page-link" href="#">2</a></li>
              <li class="page-item"><a class="page-link" href="#">3</a></li>
              <li class="page-item"><a class="page-link" href="#">4</a></li>
              <li class="page-item"><a class="page-link" href="#">Next</a></li>
            </ul>
          </nav>
        </b-card>
      </div><!--/.col-->
    </div><!--/.row-->
  </div>

</template>

<script>
import MySimpleTable from '@/components/MySimpleTable'

export default {
  name: 'tables',
  components: {
    mySimpleTable: MySimpleTable
  },
  data () {
    return {
      table1Data: {
        title: 'Simple Table',
        colConfigs: [
          {title: 'Username'},
          {title: 'Date registered'},
          {title: 'Role'},
          {title: 'Status'}
        ],
        rows: [
          {
            username: 'Samppa Nori',
            registeredAt: '2012/01/01',
            role: 'Member',
            status: 'active'
          },
          {
            username: 'Estavan Lykos',
            registeredAt: '2012/02/01',
            role: 'Staff',
            status: 'banned'
          },
          {
            username: 'Chetan Mohamed',
            registeredAt: '2012/02/01',
            role: 'Admin',
            status: 'inactive'
          },
          {
            username: 'Derick Maximinus',
            registeredAt: '2012/03/01',
            role: 'Member',
            status: 'pending'
          },
          {
            username: 'Friderik David',
            registeredAt: '2012/01/21',
            role: 'Staff',
            status: 'active'
          }
        ],
        pageNo: 1,
        pageCount: 10
      },
      table2Data: {

      },
      table3Data: {

      },
      table4Data: {

      },
      table5Data: {

      }

    }
  }
}
</script>
