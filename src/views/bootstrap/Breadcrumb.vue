<template>
    <div class="animated fadeIn">
        <div class="row">
            <div class="col-sm-12">
                <h2>Breadcrumb</h2>
            </div>
            <div class="col-sm-12">
                <b-breadcrumb :items="items"/>
            </div>
        </div>
    </div>
</template>

<script>
  export default {
    data() {
      return {
        items: [
          {
            text: 'Admin',
            href: '#'
          }, {
            text: 'Manage',
            href: '#'
          }, {
            text: 'Library',
            active: false
          },
          {
            text: 'Google',
            href: 'http://google.com',
          }, {
            text: 'to(name)',
            to: {name: 'home'},
          }, {
            text: 'Another Story',
            active: true
          }
        ]
      }
    }
  }

</script>

<style>


</style>