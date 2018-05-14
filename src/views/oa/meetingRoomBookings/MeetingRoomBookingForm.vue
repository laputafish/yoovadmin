<template>
  <div class="">
    <!-- Applicant -->
    <div class="form-group row">
      <label class="col-sm-3 col-form-label">Applicant</label>
      <div class="col-sm-9">
        <input type="text" disabled
               :placeholder="record.applicant_name"
               class="form-control"
        />
      </div>
    </div>

    <!-- Meeting Room -->
    <div class="form-group row">
      <label class="col-sm-3 col-form-label">Meeting Room</label>
      <div class="col-sm-9">
        <input type="text" disabled
               :placeholder="record.meeting_room_name"
               class="form-control"
        />
      </div>
    </div>

    <!-- Started At Picker -->
    <div class="form-group row">
      <label class="col-sm-3 col-form-label">Started At</label>
      <div class="col-sm-3 input-group">
        <date-picker class="vue-start-picker form-control"
                     input-format="YYYY-MM-DD HH:mm"
                     v-ref:started-at-picker
                     v-model="record.started_at"
                     :config="datePickerConfig"
                     :on-change="onStartedAtChanged"
                     placeholder="2018-12-31 13:50:10"/>
      </div>
    </div>

    <!-- Ended At Picker -->
    <div class="form-group row">
      <label class="col-sm-3 col-form-label">Ended At</label>
      <div class="col-sm-3 input-group">
        <date-picker class="vue-end-picker form-control"
                     input-format="YYYY-MM-DD HH:mm"
                     v-ref:ended-at-picker
                     v-model="record.ended_at"
                     :config="datePickerConfig"
                     :on-change="onEndedAtChanged"
                     placeholder="2018-12-31 13:50:10"/>
      </div>
    </div>

    <!-- Remark -->
    <div class="form-group row">
      <label class="col-sm-3 col-form-label">Remark</label>
      <div class="col-sm-9">
        <input type="text" class="form-control" v-model="updatedRecord.remark" placeholder="Remark"/>
      </div>
    </div>

  </div>
</template>

<script>
  export default {
    props: {
      'record': {
        type: Object,
        default () {
          return {
            id: 0,
            applicant_id: 0,
            applicant_name: '',
            meeting_room_id: 0,
            meeting_room_name: '',
            remark: ''
          }
        }
      }
    },
    data () {
      return {
        datePickerConfig: {
          format: 'YYYY-MM-DD hh:mm:ss',
          useCurrent: false,
          showClear: true,
          showClose: true
        },
        updatedRecord: {
          id: 0,
          applicant_id: 0,
          applicant_name: '',
          meeting_room_id: 0,
          meeting_room_name: '',
          remark: ''
        }
      }
    },
    mounted () {
      this.updatedRecord.id = this.record.id
      this.updatedRecord.applicant_id = this.record.applicant_id
      this.updatedRecord.applicant_name = this.record.applicant_name
      this.updatedRecord.meeting_room_id = this.record.meeting_room_id
      this.updatedRecord.meeting_room_name = this.record.meeting_room_name
      this.updatedRecord.remark = this.record.remark
      console.log('mounted :: record: ', this.record)
    },
    watch: {
      updatedRecord: {
        handler: function (val, oldVal) {
          this.$emit('updated', val)
        },
        deep: true
      }
    }
  }
</script>