<template>
  <div class="app flex-row align-items-center animated fadeIn">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-md-8">
          <div class="card-group mb-0">
            <div class="card p-4">
              <div class="card-body">
                <h1>Login</h1>
                <p class="text-muted">Sign In to your account</p>
                <div class="input-group mb-3">
                  <span class="input-group-addon"><i class="icon-user"></i></span>
                  <input type="text" class="form-control" placeholder="Email"
                         v-model="credentials.email">
                </div>
                <div class="input-group mb-4">
                  <span class="input-group-addon"><i class="icon-lock"></i></span>
                  <input type="password" class="form-control" placeholder="Password"
                         v-model="credentials.password">
                </div>
                <div class="row">
                  <div class="col-6">
                    <button type="button"
                            @click="login"
                            class="btn btn-primary px-4">Login
                    </button>
                  </div>
                  <div class="col-6 text-right">
                    <button type="button" class="btn btn-link px-0">Forgot password?</button>
                  </div>
                </div>
              </div>
            </div>
            <div class="card text-white bg-primary py-5 d-md-down-none" style="width:44%">
              <div class="card-body text-center">
                <div>
                  <h2>Sign up</h2>
                  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut
                    labore et dolore magna aliqua.</p>
                  <button type="button" class="btn btn-primary active mt-3">Register Now!</button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div>
      Token: <input type="text" :value="token" @input="setToken($event.target.value)"/>
    </div>
  </div>
</template>

<script>
  // import * as constants from '@/store/constants.json'
  // import axios from 'axios'

  export default {
    name: 'Login',
    data () {
      return {
        credentials: {
          email: 'yoovtest1@gmail.com',
          password: 'yoovyoov'
        }
      }
    },
    computed: {
      token () {
        if (this.$store.getters) {
          return this.$store.getters.token
        } else {
          return ''
        }
      },
      user () {
        return this.$store.getters.user
      }
    },
    mounted () {
      // console.log('mounted')
      // let vm = this
      // vm.$store.dispatch('checkToken', {
      //   callback: function (status) {
      //     console.log('checkToken')
      //     if (status) {
      //       console.log('if status')
      //       vm.$router.push({name: 'Meetings'})
      //     } else {
      //       console.log('if not status')
      //     }
      //   }
      // })
    },
    methods: {
      setToken (value) {
        console.log('setToken :: value:', value)
        this.$store.dispatch('SET_TOKEN', value)
      },
      login () {
        let vm = this
        console.log('Login => vm.$store.dispatch(login)')
        vm.$store.dispatch('login', {
          credentials: vm.credentials,
          callback: (valid) => {
            console.log('Login :: callback: status: ', status)
            console.log('Login :: callback: token: ' + vm.$store.getters.token)
            if (valid) {
              vm.$router.push({name: 'Dashboard'})
            } else {
              vm.$dialog.alert('Access Denied!')
            }
          }
        })
        console.log('after dispatch(login)')
        // let url = constants.apiUrl + '/auth'
        // axios.post(url, vm.credentials).then(function (response) {
        //   let data = response.data
        //   if (data.status === 'ok') {
        //     vm.$store.dispatch('SET_USER', data.user)
        //     vm.$router.push({name: 'Meetings'})
        //   } else {
        //     vm.$dialog.alert('Access Denied!')
        //   }
        // })
      }
    }

  }
</script>

