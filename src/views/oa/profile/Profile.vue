<template>
  <div class="animated fadeIn">
    <div class="container-fluid">
      <div class="row">
        <div class="col">
          <h3>{{ displayName }}</h3>
          <button type="button"
                  class="pull-right btn btn-primary">Submit</button>
        </div>
      </div>
      <div class="d-flex flex-row">
        <form>
          <div class="row">
            <div class="form-group col-sm">
              <label for="name">User Name</label>
              <input class="form-control" id="name" v-model="user.name"/>
            </div>
            <div class="form-group col-sm">
              <label for="first_name">First Name</label>
              <input class="form-control" id="first_name" v-model="user.first_name"/>
            </div>
            <div class="form-group col-sm">
              <label for="last_name">Last Name</label>
              <input class="form-control" id="last_name" v-model="user.last_name"/>
            </div>
            <div class="form-group col-sm">
              <label for="email">Email</label>
              <input class="form-control" id="email" v-model="user.email"/>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    data () {
      return {
        user: {
          name: '',
          first_name: '',
          last_name: '',
          alias: '',
          email: '',
          mobile: ''
        }
      }
    },
    computed: {
      displayName () {
        let vm = this
        let names = []
        let result = ''
        let firstLastName = ''
        if (vm.user.last_name !== '') names.push(vm.user.last_name)
        if (vm.user.first_name !== '') names.push(vm.user.first_name)
        firstLastName = names.length > 0 ? names.join(', ') : ''
        if (vm.user.alias !== '') {
          result = vm.user.alias
          result += firstLastName !== '' ? '(' + firstLastName + ')' : ''
        } else {
          result += firstLastName !== '' ? firstLastName : ''
        }
        return result
      }
    }
  }
</script>
