<template>
    <div class="animated fadeIn">
        <div class="row">
            <div class="col-sm-12">
                <h4>Product Menu</h4>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-12">

                Product Count: {{ products.length }}
            </div>
        </div>
    </div>
</template>

<script>
  export default {
    computed: {
      products () {
        return this.$store.state.products
      }
    },
    mounted () {

    }
  }
</script>

<style>

</style>