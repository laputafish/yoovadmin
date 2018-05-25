<template>
  <b-card no-body class="p-0">
    <b-card-body class="p-2">
      <table>
        <tr>
          <td>
            <img src="/static/img/scanner.png" class="office-scanner">
          </td>
          <td>
            <b-button variant="default"
                      class="mb-1"
                      @click="onHoldClicked">Hold</b-button><br/>
            <b-button variant="primary"
                      @click="onHoldClicked">Hold</b-button>
          </td>
        </tr>
        <tr>

        </tr>
      </table>
    </b-card-body>
  </b-card>
</template>

<script>
  export default {
    methods: {
      onHoldClicked () {
      }
    }
  }
</script>

<style>

</style>
