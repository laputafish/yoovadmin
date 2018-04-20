<template>
  <div class="animated fadeIn">
    <div class="row">
      <div class="col-sm-12">
        <h2>Alerts</h2>
      </div>
    </div>
    <div class="row">
      <div class="col-sm-12">

        <b-card>
          <div slot="header">
            <strong>Link Color</strong>
          </div>
          <div>
            <b-alert show variant="primary">Primary Alert</b-alert>
            <b-alert show variant="secondary">Secondary Alert</b-alert>
            <b-alert show variant="success">
              <strong>Well done!</strong> You successfully read <a href="#" class="alert-link">this important alert message</a>.
            </b-alert>
            <b-alert show variant="info">
              <strong>Heads up!</strong> This <a href="#" class="alert-link">alert needs your attention</a>, but it's not super important.
            </b-alert>
            <b-alert show variant="warning">
              <strong>Warning!</strong> Better check yourself, you're <a href="#" class="alert-link">not looking too good</a>.
            </b-alert>
            <b-alert show variant="danger">
              <strong>Oh snap!</strong> <a href="#" class="alert-link">Change a few things up</a> and try submitting again.
            </b-alert>
            <b-alert show variant="light">Light Alert</b-alert>
            <b-alert show variant="dark">Dark Alert</b-alert>
          </div>
        </b-card>

        <b-card>
          <div slot="header">
            <strong>Color of links within alerts</strong>
          </div>
          <div>
            <b-alert show variant="primary">
              Primary Alert with <a href="#" class="alert-link">an example link</a>.
            </b-alert>
            <b-alert show variant="secondary">
              Secondary Alert with <a href="#" class="alert-link">an example link</a>.
            </b-alert>
            <b-alert show variant="success">
              Success Alert with <a href="#" class="alert-link">an example link</a>.
            </b-alert>
            <b-alert show variant="danger">
              Danger Alert with <a href="#" class="alert-link">an example link</a>.
            </b-alert>
            <b-alert show variant="warning">
              Warning Alert with <a href="#" class="alert-link">an example link</a>.
            </b-alert>
            <b-alert show variant="info">
              Info Alert with <a href="#" class="alert-link">an example link</a>.
            </b-alert>
            <b-alert show variant="light">
              Light Alert with <a href="#" class="alert-link">an example link</a>.
            </b-alert>
            <b-alert show variant="dark">
              Dark Alert with <b-link href="#" class="alert-link">an example link</b-link>.
            </b-alert>
          </div>
        </b-card>

        <b-card>
          <div slot="header">
            <strong>Dismissible alerts</strong>
          </div>
          <div>
            <b-alert show dismissible>
              Dismissible Alert!  Click the close button over there <b>&rArr;</b>
            </b-alert>
          </div>
        </b-card>

        <b-card>
          <div slot="header">
            <strong>Auto dismissing alerts</strong>
          </div>
          <div>
            <b-alert :show="dismissCountDown"
                     dismissible
                     variant="warning"
                     @dismissed="dismissCountdown=0"
                     @dismiss-count-down="countDownChanged">
              This alert will dismiss after {{dismissCountDown}} seconds...
            </b-alert>
            <b-btn @click="showAlert" variant="info" class="m-1">
              Show alert with count-down timer
            </b-btn>
          </div>
        </b-card>

      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'linkColor',
  data () {
    return {
      dismissSecs: 5,
      dismissCountDown: 0
    }
  },
  methods: {
    countDownChanged (dismissCountDown) {
      this.dismissCountDown = dismissCountDown
    },
    showAlert () {
      this.dismissCountDown = this.dismissSecs
    }
  }
}
</script>
