<template>
<!-- <div id="app">
  <app-menu></app-menu> -->

  <router-view/>
<!-- </div> -->
</template>

<script>
import AppMenu from './components/app_menu'

export default {
  name: 'app',
  components: {
    appMenu: AppMenu
  }
}
</script>

<style>

#app .navbar-brand img {
  height: 24px;
  width: auto;
  margin-right: 5px;
  vertical-align: middle;
}
</style>
<style lang="scss">
// @import "./assets/css/style.css";
// @import "./assets/custom-bootstrap.scss";
@import "../node_modules/bootstrap/scss/bootstrap.scss";
@import "../node_modules/bootstrap-vue/dist/bootstrap-vue.css";
@import "./assets/scss/style";
</style>
