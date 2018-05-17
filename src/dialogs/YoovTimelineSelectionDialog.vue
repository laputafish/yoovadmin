<template>
  <yoov-modal id="yoovTimelineSelectionDialog">
    <div slot="header">
      <h3 class="dialog-title">
        Select Timeline
      </h3>
    </div>
    <div slot="body">
      <div class="d-flex flex-row">
        <div class="align-self-start">
          <button type="button"
                  @click="onPrevButtonClicked"
                  class="btn-prev btn btn-sm btn-primary justify-content-start">
            <i class="fa fa-fw fa-caret-left"></i>
          </button>
        </div>
        <div class="align-self-center" style="margin: 0 auto;">
          <div class="flex-grow-1 text-center current-date">
            <span>2019-05-05</span><br/>
            <span class="badge badge-default">Mon</span>
          </div>
        </div>
        <div class="align-self-end">
          <button type="button"
                  @click="onNextButtonClicked"
                  class="btn-next btn btn-sm btn-primary justify-content-end">
            <i class="fa fa-fw fa-caret-right"></i>
          </button>
        </div>
      </div>
      <div class="time-slots">
        <hr/>
        <table>
          <tr>
            <td>
              <div>8:00am</div>
              <div>8:15am</div>
              <div>8:30am</div>
              <div>8:45am</div>
              <div>9:00am</div>
              <div>9:15am</div>
              <div>9:30am</div>
              <div>9:45am</div>
            </td>
            <td>
              <div>10:00am</div>
              <div>10:15am</div>
              <div>10:30am</div>
              <div>10:45am</div>
              <div>11:00am</div>
              <div>11:15am</div>
              <div>11:30am</div>
              <div>11:45am</div>
            </td>
            <td>
              <div>12:00am</div>
              <div>12:15am</div>
              <div>12:30am</div>
              <div>12:45am</div>
              <div>1:00pm</div>
              <div>1:15pm</div>
              <div>1:30pm</div>
              <div>1:45pm</div>
            </td>            
            <td>
              <div>2:00pm</div>
              <div>2:15pm</div>
              <div>2:30pm</div>
              <div>2:45pm</div>
              <div>3:00pm</div>
              <div>3:15pm</div>
              <div>3:30pm</div>
              <div>3:45pm</div>
            </td>
            <td>
              <div>4:00pm</div>
              <div>4:15pm</div>
              <div>4:30pm</div>
              <div>4:45pm</div>
              <div>5:00pm</div>
              <div>5:15pm</div>
              <div>5:30pm</div>
              <div>5:45pm</div>
            </td>
            <td>
              <div>6:00pm</div>
              <div>6:15pm</div>
              <div>6:30pm</div>
              <div>6:45pm</div>
              <div>7:00pm</div>
              <div>7:15pm</div>
              <div>7:30pm</div>
              <div>7:45pm</div>
            </td>
            <td>
              <div>8:00pm</div>
              <div>8:15pm</div>
              <div>8:30pm</div>
              <div>8:45pm</div>
              <div>9:00pm</div>
              <div>9:15pm</div>
              <div>9:30pm</div>
              <div>9:45pm</div>
            </td>
          </tr>
        </table>
      </div>
    </div>
    <div slot="footer">
      <button :disabled="false"
              class="btn btn-primary"
              @click="$emit('close')">
        OK
      </button>
      <button class="btn btn-default"
              @click="$emit('close')">
        Cancel
      </button>
    </div>
  </yoov-modal>
</template>

<script>
  import YoovModal from '@/components/Modal'

  export default {
    components: {
      'yoov-modal': YoovModal
    },
    methods: {
      onPrevButtonClicked () {

      },
      onNextButtonClicked () {
        
      }
    }
  }
</script>

<style>
#yoovTimelineSelectionDialog .current-date {
  line-height: 1;
}

#yoovTimelineSelectionDialog .current-date span {
  padding: 0;
  margin: 0;
}
#yoovTimelineSelectionDialog .time-slots td div {
  min-width:30px;
  text-align:right;
}
</style>
