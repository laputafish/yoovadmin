<template>
  <yoov-modal id="yoov-time-slot-entry-confirmation-dialog">
    <div slot="header" class="header">
      <h3 class="dialog-title">
        Schedule Changed
      </h3>
    </div>
    <div slot="body" class="d-flex flex-column">
      <div class="row flex-grow-1">
        <div class="col-sm-12 pb-3">
          <div class="pb-2">
            There is already an entry.
          </div>
          <table>
            <tr>
              <td class="d-flex flex-row" style="padding-top:3px;padding-right:10px;">
                <span class="flex-grow-1 badge badge-primary">started at</span></td>
              <td style="padding-right:10px;">{{ booking.started_at }}</td>
            </tr>
            <tr>
              <td class="d-flex flex-row" style="padding-top:3px;padding-right:10px;">
                <span class="flex-grow-1 badge badge-primary">ended at</span></td>
              <td style="padding-right:10px;">{{ booking.ended_at }}</td>
            </tr>
          </table>
        </div>
        <div class="col-sm-12">
          Click [Edit] to edit it.<br/>
          Click [New] to abandon previous input and create a new one.
        </div>
      </div>
    </div>
    <div slot="footer" class="text-center d-flex flex-row justify-content-between" style="width:100%;">
      <b-button @click="onButtonClicked('edit')"
                variant="success"
                class="flex-grow-1">
        Edit
      </b-button>
      <b-button @click="onButtonClicked('new')"
                variant="primary"
                class="flex-grow-1">
        New
      </b-button>
      <b-button @click="onButtonClicked('cancel')"
                variant="default"
                class="flex-grow-1">
        Cancel
      </b-button>
    </div>
  </yoov-modal>
</template>

<script>
  import YoovModal from '@/components/Modal'

  export default {
    components: {
      'yoov-modal': YoovModal
    },
    props: {
      booking: {
        type: Object,
        default: null
      }
    },
    methods: {
      onButtonClicked (action) {
        this.$emit('onResult', {
          dialog: 'yoovTimeSlotEntryConfirmationDialog',
          payload: {
            action: action
          }
        })
      }
    }
  }
</script>

<style scoped="">
  button {
    width: 100%;
    margin-bottom: 10px;
    float: none;
  }
  .modal-footer button {
    margin: 0 3px;
  }
</style>