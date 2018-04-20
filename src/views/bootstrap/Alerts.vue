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
          <div class="alert alert-success" role="alert">
            <strong>Well done!</strong> You successfully read <a href="#" class="alert-link">this important alert message</a>.
          </div>
          <div class="alert alert-info" role="alert">
            <strong>Heads up!</strong> This <a href="#" class="alert-link">alert needs your attention</a>, but it's not super important.
          </div>
          <div class="alert alert-warning" role="alert">
            <strong>Warning!</strong> Better check yourself, you're <a href="#" class="alert-link">not looking too good</a>.
          </div>
          <div class="alert alert-danger" role="alert">
            <strong>Oh snap!</strong> <a href="#" class="alert-link">Change a few things up</a> and try submitting again.
          </div>
        </b-card>

        <b-card>
          <div slot="header">
            <strong>Additional content</strong>
          </div>
          <div class="alert alert-success" role="alert">
            <h4 class="alert-heading">Well done!</h4>
            <p>Aww yeah, you successfully read this important alert message. This example text is going to run a bit longer so that you can see how spacing within an alert works with this kind of content.</p>
            <p class="mb-0">Whenever you need to, be sure to use margin utilities to keep things nice and tidy.</p>
          </div>
        </b-card>

        <b-card>
          <div slot="header">
            <strong>Dismissing</strong>
          </div>
          <div class="alert alert-warning alert-dismissible fade show" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
            <strong>Holy guacamole!</strong> You should check in on some of those fields below.
          </div>
        </b-card>

      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'linkColor'
}
</script>
