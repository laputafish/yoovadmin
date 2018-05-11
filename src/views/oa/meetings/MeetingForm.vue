<template>
  <div class="">
    <!-- Name -->
    <div class="form-group row">
      <label class="col-sm-3 col-form-label">Name</label>
      <div class="col-sm-9">
        <input type="text" class="form-control" v-model="updatedRecord.name" placeholder="Name"/>
      </div>
    </div>

    <!-- Capacity -->
    <div class="form-group row">
      <label class="col-sm-3 col-form-label">Capacity</label>
      <div class="col-sm-3 col-md-3">
        <input type="number" class="form-control" v-model="updatedRecord.capacity" placeholder="Capacity"/>
      </div>
    </div>

    <!-- Location -->
    <div class="form-group row">
      <label class="col-sm-3 col-form-label">Location</label>
      <div class="col-sm-9">
        <input type="text" class="form-control" v-model="updatedRecord.location" placeholder="Location"/>
      </div>
    </div>

    <!-- Equipments -->
    <div class="form-group row">
      <label class="col-sm-3 col-form-label">Equipments</label>
      <div class="col-sm-9">
        <input type="text" class="form-control" v-model="updatedRecord.equipments" placeholder="Equipments"/>
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
            name: '',
            capacity: 0,
            equipments: '',
            id: 0,
            location: '',
            remark: ''
          }
        }
      }
    },
    data () {
      return {
        updatedRecord: {
          name: '',
          capacity: 0,
          equipments: '',
          id: 0,
          location: '',
          remark: ''
        }
      }
    },
    mounted () {
      this.updatedRecord.name = this.record.name
      this.updatedRecord.capacity = this.record.capacity
      this.updatedRecord.equipments = this.record.equipments
      this.updatedRecord.id = this.record.id
      this.updatedRecord.location = this.record.location
      this.updatedRecord.remark = this.record.remark
      console.log('mounted :: record: ', this.record)
    },
    watch: {
      // record: function (value) {
      //   console.log('MeetingRoomForm :: watch(record): value: ', value)
      //   this.updatedRecord = value
      // },
      updatedRecord: {
        handler: function (val, oldVal) {
          this.$emit('updated', val)
        },
        deep: true
      }
    }
  }
</script>