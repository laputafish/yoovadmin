<template>
<div class="wrapper">
  <div class="animated fadeIn">
    <div class="row">
      <div class="col-12">
        <b-card id="dialogDemo" header="Bootstrap Modals">
          <b-button type="button" variant="secondary" @click="myModal = true">Launch demo modal</b-button>
          <b-button type="button" variant="secondary" @click="largeModal = true">Launch large modal</b-button>
          <b-button type="button" variant="secondary" @click="smallModal = true">Launch small modal</b-button>
          <hr>
          <b-button type="button" variant="primary" @click="primaryModal = true">Launch primary modal</b-button>
          <b-button type="button" variant="success" @click="successModal = true">Launch success modal</b-button>
          <b-button type="button" variant="warning" @click="warningModal = true">Launch warning modal</b-button>
          <b-button type="button" variant="danger" @click="dangerModal = true">Launch danger modal</b-button>
          <b-button type="button" variant="info" @click="infoModal = true">Launch info modal</b-button>
          <hr>
          <h4>Sweet Alert 2</h4>
          <b-button type="button" variant="secondary" @click="showSweetAlert('simpleDemo')">Simple Demo</b-button>
          <b-button type="button" variant="secondary" @click="showSweetAlert('basicDemo')">Basic Demo</b-button>
          <b-button type="button" variant="secondary" @click="showSweetAlert('errorMessageDemo')">An error message</b-button>
          <b-button type="button" variant="secondary" @click="showSweetAlert('htmlContentDemo')">A basic message</b-button>
          <b-button type="button" variant="secondary" @click="showSweetAlert('customHtmlDemo')">A basic message</b-button>
          <b-button type="button" variant="secondary" @click="showSweetAlert('customPositionedDemo')">A basic message</b-button>
          <b-button type="button" variant="secondary" @click="showSweetAlert('animationDemo')">Animation Demo</b-button>
          <b-button type="button" variant="secondary" @click="showSweetAlert('buttonActionDemo1')">A basic message</b-button>
          <b-button type="button" variant="secondary" @click="showSweetAlert('buttonActionDemo2')">A basic message</b-button>
          <b-button type="button" variant="secondary" @click="showSweetAlert('imageDemo')">A basic message</b-button>
          <b-button type="button" variant="secondary" @click="showSweetAlert('customStyleDemo')">A basic message</b-button>
          <b-button type="button" variant="secondary" @click="showSweetAlert('timerDemo')">A basic message</b-button>
          <b-button type="button" variant="secondary" @click="showSweetAlert('ajaxDemo')">A basic message</b-button>
          <b-button type="button" variant="secondary" @click="showSweetAlert('chainingModalsDemo')">A basic message</b-button>
          <b-button type="button" variant="secondary" @click="showSweetAlert('dynamicQueueDemo')">A basic message</b-button>
        </b-card>
      </div>
      <!--/.col-->
    </div>
    <!--/.row-->
  </div>

  <!-- Modal Component -->
  <b-modal title="Modal title" v-model="myModal" @ok="myModal = false">
    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor
    in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
  </b-modal>
  <b-modal title="Modal title" size="lg" v-model="largeModal" @ok="largeModal = false">
    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor
    in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
  </b-modal>
  <b-modal title="Modal title" size="sm" v-model="smallModal" @ok="smallModal = false">
    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor
    in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
  </b-modal>

  <b-modal title="Modal title" class="modal-primary" v-model="primaryModal" @ok="primaryModal = false">
    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor
    in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
  </b-modal>
  <b-modal title="Modal title" class="modal-success" v-model="successModal" @ok="successModal = false">
    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor
    in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
  </b-modal>
  <b-modal title="Modal title" class="modal-warning" v-model="warningModal" @ok="warningModal = false">
    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor
    in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
  </b-modal>
  <b-modal title="Modal title" class="modal-danger" v-model="dangerModal" @ok="dangerModal = false">
    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor
    in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
  </b-modal>
  <b-modal title="Modal title" class="modal-info" v-model="infoModal" @ok="infoModal = false">
    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor
    in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
  </b-modal>
</div>
</template>

<script>
import swal from 'sweetalert2'

export default {
  name: 'modals',
  data () {
    return {
      myModal: false,
      largeModal: false,
      smallModal: false,
      primaryModal: false,
      successModal: false,
      warningModal: false,
      dangerModal: false,
      infoModal: false
    }
  },
  methods: {
    showSweetAlert (demo) {
      switch (demo) {
        case 'simpleDemo':
          swal('Any fool can use a computer')
          break
        case 'basicDemo':
          swal(
            'The Internet?',
            'That thing is still around?',
            'question'
          )
          break
        case 'errorMessageDemo':
          swal(
            'Oops...',
            'Something went wrong!',
            'error'
          )
          break
        case 'htmlContentDemo':
          swal({
            html: 'Less is more.<br>'.repeat(100)
          })
          break
        case 'customHtmlDemo':
          swal({
            title: '<i>HTML</i> <u>example</u>',
            type: 'info',
            html: 'You can use <b>bold text</b>, ' +
              '<a href="//github.com">links</a> ' +
              'and other HTML tags',
            showCloseButton: true,
            showCancelButton: true,
            focusConfirm: false,
            confirmButtonText: '<i class="fa fa-thumbs-up"></i> Great!',
            confirmButtonAriaLabel: 'Thumbs up, great!',
            cancelButtonText: '<i class="fa fa-thumbs-down"></i>',
            cancelButtonAriaLabel: 'Thumbs down'
          })
          break
        case 'customPositionedDemo':
          swal({
            position: 'top-right',
            type: 'success',
            title: 'Your work has been saved',
            showConfirmButton: false,
            timer: 1500
          })
          break
        case 'animationDemo':
          swal({
            title: 'jQuery HTML example',
            html: $('<div>')
              .addClass('some-class')
              .text('jQuery is everywhere. body.length = ' + $('body').length),
            animation: true,
            customClass: 'animated tada'
          })
          break
        case 'buttonActionDemo1':
          swal({
            title: 'Are you sure?',
            text: "You won't be able to revert this!",
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, delete it!'
          }).then((result) => {
            if (result.value) {
              swal(
                'Deleted!',
                'Your file has been deleted.',
                'success'
              )
            }
          })
          break
        case 'buttonActionDemo2':
          swal({
            title: 'Are you sure?',
            text: "You won't be able to revert this!",
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, delete it!',
            cancelButtonText: 'No, cancel!',
            confirmButtonClass: 'btn btn-success',
            cancelButtonClass: 'btn btn-danger',
            buttonsStyling: false,
            reverseButtons: true
          }).then((result) => {
            if (result.value) {
              swal(
                'Deleted!',
                'Your file has been deleted.',
                'success'
              )
              // result.dismiss can be 'cancel', 'overlay',
              // 'close', and 'timer'
            } else if (result.dismiss === 'cancel') {
              swal(
                'Cancelled',
                'Your imaginary file is safe :)',
                'error'
              )
            }
          })
          break
        case 'imageDemo':
          swal({
            title: 'Sweet!',
            text: 'Modal with a custom image.',
            imageUrl: 'https://unsplash.it/400/200',
            imageWidth: 400,
            imageHeight: 200,
            imageAlt: 'Custom image',
            animation: false
          })
          break
        case 'customStyleDemo':
          swal({
            title: 'Custom width, padding, background.',
            width: 600,
            padding: 100,
            background: '#fff url(//bit.ly/1Nqn9HU)'
          })
          break
        case 'timerDemo':
          swal({
            title: 'Auto close alert!',
            text: 'I will close in 5 seconds.',
            timer: 5000,
            onOpen: () => {
              swal.showLoading()
            }
          }).then((result) => {
            if (result.dismiss === 'timer') {
              console.log('I was closed by the timer')
            }
          })
          break
        case 'ajaxDemo':
          swal({
            title: 'Submit email to run ajax request',
            input: 'email',
            showCancelButton: true,
            confirmButtonText: 'Submit',
            showLoaderOnConfirm: true,
            preConfirm: (email) => {
              return new Promise((resolve) => {
                setTimeout(() => {
                  if (email === 'taken@example.com') {
                    swal.showValidationError(
                      'This email is already taken.'
                    )
                  }
                  resolve()
                }, 2000)
              })
            },
            allowOutsideClick: false
          }).then((result) => {
            if (result.value) {
              swal({
                type: 'success',
                title: 'Ajax request finished!',
                html: 'Submitted email: ' + result.value
              })
            }
          })
          break
        case 'chainingModalsDemo':
          swal.setDefaults({
            input: 'text',
            confirmButtonText: 'Next &rarr;',
            showCancelButton: true,
            progressSteps: ['1', '2', '3']
          })

          var steps = [{
            title: 'Question 1',
            text: 'Chaining swal2 modals is easy'
          },
            'Question 2',
            'Question 3'
          ]

          swal.queue(steps).then((result) => {
            swal.resetDefaults()

            if (result.value) {
              swal({
                title: 'All done!',
                html: 'Your answers: <pre>' +
                  JSON.stringify(result.value) +
                  '</pre>',
                confirmButtonText: 'Lovely!'
              })
            }
          })
          break
        case 'dynamicQueueDemo':
          const ipAPI = 'https://api.ipify.org?format=json'

          swal.queue([{
            title: 'Your public IP',
            confirmButtonText: 'Show my public IP',
            text: 'Your public IP will be received ' +
              'via AJAX request',
            showLoaderOnConfirm: true,
            preConfirm: () => {
              return $.get(ipAPI).then((data) => {
                swal.insertQueueStep(data.ip)
              })
            }
          }])
          break
      }
    }
  }
}
</script>

<style>
#dialogDemo button {
  margin-bottom: 5px;
}
</style>
