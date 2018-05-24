<template>
  <div class="" v-if="record">
    <!-- Applicant -->
    <div class="form-group row">
      <label class="col-sm-2 col-form-label">Applicant</label>
      <div class="col-sm-10">
        <input type="text" disabled
               :placeholder="record.applicant_name"
               class="form-control"
        />
      </div>
    </div>

    <!-- Subject -->
    <div class="form-group row">
      <label class="col-sm-2 col-form-label">Subject</label>
      <div class="col-sm-10">
        <input type="text" class="form-control" v-model="record.subject" placeholder="Subject"/>
      </div>
    </div>

    <!-- Venue -->
    <div class="form-group row">
      <label class="col-sm-2 col-form-label">Venue</label>
      <div class="col-sm-10">
        <yoov-radio-toggle
          class="mb-1"
          v-model="record.venue_type"
          :options="[{caption:'Conference Room', value:'conference_room'},{caption:'Others',value:'else'}]"
        >
        </yoov-radio-toggle>
        <yoov-meeting-room-booking-field
          v-if="record.venue_type === 'conference_room'"
          v-model="record.room_booking">
        </yoov-meeting-room-booking-field>
        <div v-else>
          <input class="form-control" v-model="record.venue"/>
        </div>
      </div>
    </div>

    <!-- Started At Picker -->
    <div class="form-group row">
      <label class="col-sm-2 col-form-label">Started At</label>
      <div class="col-sm-3 input-group">
        <datetime format="YYYY-MM-DD H:i:s"
                  @input="updateStartedAt"
                  :value="record.started_at"></datetime>
      </div>
    </div>

    <!-- Ended At Picker -->
    <div class="form-group row">
      <label class="col-sm-2 col-form-label">Ended At</label>
      <div class="col-sm-3 input-group">
        <datetime format="YYYY-MM-DD H:i:s"
                  @input="updateEndedAt"
                  :value="record.ended_at"></datetime>
      </div>
    </div>

    <!--&lt;!&ndash; Started At &ndash;&gt;-->
    <!--<div class="form-group row">-->
    <!--<label class="col-sm-3 col-form-label">Started At</label>-->
    <!--<div class="col-sm-3 input-group">-->
    <!--<input type="text" class="form-control" v-model="record.started_at"-->
    <!--placeholder="2018-12-31 13:50:10"/>-->
    <!--<div class="input-group-append">-->
    <!--<button-->
    <!--@click="selectDateTime('started_at')"-->
    <!--type="button" class="btn btn-primary">...</button>-->
    <!--</div>-->
    <!--</div>-->
    <!--</div>-->

    <!--&lt;!&ndash; Ended At &ndash;&gt;-->
    <!--<div class="form-group row">-->
    <!--<label class="col-sm-3 col-form-label">Ended At</label>-->
    <!--<div class="col-sm-3 input-group">-->
    <!--<input type="text" class="form-control" v-model="record.ended_at"-->
    <!--placeholder="2018-12-31 13:50:10"/>-->
    <!--<div class="input-group-append">-->
    <!--<button-->
    <!--@click="selectDateTime('ended_at')"-->
    <!--type="button" class="btn btn-primary">...</button>-->
    <!--</div>-->
    <!--</div>-->
    <!--</div>-->

    <!-- Remark -->
    <div class="form-group row">
      <label class="col-sm-2 col-form-label">Remark</label>
      <div class="col-sm-9">
        <textarea type="text" rows="10" class="form-control" v-model="record.remark" placeholder="Remark"></textarea>
      </div>
    </div>

    <div v-if="false" class="row">
      <div class="col-sm-12">
        {{ record }}
      </div>
    </div>
  </div>
</template>

<script>
  import YoovRadioToggle from '@/components/YoovRadioToggle'
  import YoovMeetingRoomBookingField from '@/components/YoovMeetingRoomBookingField'
  import datetime from 'vuejs-datetimepicker'
  //  import datePicker from 'vue-bootstrap-datetimepicker'

  export default {
    components: {
      'yoov-radio-toggle': YoovRadioToggle,
      'yoov-meeting-room-booking-field': YoovMeetingRoomBookingField,
      'datetime': datetime
      // ,
      // 'date-picker': datePicker
    },
    props: {
      'propRecord': {
        type: Object,
        default () {
          return {
            id: 0,
            subject: '',
            venue_type: 'conference_room',
            venue: '',
            meeting_room_booking_id: 0,
            used_id: 0,
            user_name: '',
            started_at: '',
            ended_at: '',
            remark: ''
          }
        }
      }
    },
    data () {
      return {
        record: null,
        config: {
          format: 'YYYY-MM-DD hh:mm:ss',
          useCurrent: true
        }
        // datePickerConfig: {
        //   format: 'YYYY-MM-DD hh:mm:ss',
        //   useCurrent: false,
        //   showClear: true,
        //   showClose: true
        // },
        // record: {
        //   id: 0,
        //   subject: '',
        //   venue_type: 'conference_room',
        //   venue: '',
        //   meeting_room_booking_id: 0,
        //   used_id: 0,
        //   user_name: '',
        //   started_at: '',
        //   ended_at: '',
        //   remark: ''
        // }
      }
    },
    mounted () {
      // this.record = this.tempMeeting
      // if (this.propRecord) {
      //   this.record.id = this.propRecord.id
      //   this.record.subject = this.propRecord.subject
      //   this.record.venue_type = this.propRecord.venue_type
      //   this.record.venue = this.propRecord.venue
      //   this.record.meeting_room_booking_id = this.propRecord.meeting_room_booking_id
      //   this.record.user_id = this.propRecord.user_id
      //   this.record.user_name = this.propRecord.user_name
      //   this.record.started_at = this.propRecord.started_at
      //   this.record.ended_at = this.propRecord.ended_at
      //   this.record.remark = this.propRecord.remark
      // }
      // console.log('mounted :: record: ', this.propRecord)
    },
    watch: {
      tempMeeting: {
        handler: function (value) {
          console.log('watch(tempMeeting): value:', value)
          this.record = value
          this.$store.dispatch('UPDATE_WORKING_BOOKING', this.record.room_booking)
        },
        deep: true
      }
    //   // // record: function (value) {
    //   // //   console.log('MeetingRoomForm :: watch(record): value: ', value)
    //   // //   this.record = value
    //   // // },
    //   // record: {
    //   //   handler: function (val, oldVal) {
    //   //     this.$emit('updated', val)
    //   //   },
    //   //   deep: true
    //   // }
    },
    methods: {
      updateStartedAt (newValue) {
        this.$store.dispatch('SET_TEMP_MEETING_STARTED_AT', newValue)
      },
      updateEndedAt (newValue) {
        this.$store.dispatch('SET_TEMP_MEETING_ENDED_AT', newValue)
      },
      onStartedAtChanged (newStart) {
        var endedAtPicker = this.$.endedAtPicker.control
        endedAtPicker.minDate(newStart)
      },
      onEndedAtChanged (newEnd) {
        var startedAtPicker = this.$.startedAtPicker.control
        startedAtPicker.maxDate(newEnd)
      }
    },

    computed: {
      tempMeeting () {
        let vm = this
        let tempMeeting = vm.$store.getters.tempMeeting
        console.log('computed(tempMeeting): tempMeeting: ', tempMeeting)
        this.record = vm.$store.getters.tempMeeting
        return vm.$store.getters.tempMeeting
      }
    }
  }
</script>