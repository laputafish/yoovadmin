<template>
  <div class="animated fadeIn">
    <div class="container-fluid">
      <div class="row">
        <div class="col">
          <div class="pull-right toolbar">
          <router-link to="/"
                  class="btn btn-primary ml-1">Back</router-link>
          <button type="button"
                  class="btn btn-primary">Submit</button>
          </div>
          <h3>{{ displayName }}</h3>
        </div>
      </div>
      <hr/>

      <div class="row">
        <div class="form-group col-sm-3">
          <label for="name">User Name</label>
          <input class="form-control" id="name" v-model="user.name"/>
        </div>
        <div class="form-group col-sm-3">
          <label for="name">Alias</label>
          <input class="form-control" id="alias" v-model="user.alias"/>
        </div>
        <div class="form-group col-sm-6">
          <label for="email">Email</label>
          <input class="form-control" id="email" v-model="user.email"/>
        </div>
      </div>

      <div class="row">
        <div class="form-group col-sm-4">
          <label for="first_name">First Name</label>
          <input class="form-control" id="first_name" v-model="user.first_name"/>
        </div>
        <div class="form-group col-sm-4">
          <label for="last_name">Last Name</label>
          <input class="form-control" id="last_name" v-model="user.last_name"/>
        </div>
        <div class="form-group col-sm-4">
          <label for="mobile">Mobile</label>
          <input class="form-control" id="mobile" v-model="user.mobile"/>
        </div>
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
    watch: {
      dbUser: function (value) {
        let vm = this
        vm.user.name = value.name
        vm.user.first_name = value.first_name
        vm.user.last_name = value.last_name
        vm.user.alias = value.alias
        vm.user.email = value.email
        vm.user.mobile = value.mobile
      }
    },
    computed: {
      dbUser () {
        return this.$store.getters.user
      },
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

<style>
  .toolbar .btn {
    min-width: 80px;
  }
</style>