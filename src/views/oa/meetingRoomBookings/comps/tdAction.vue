<template>
  <div>
    <button type="button"
            @click="editItem"
            class="btn btn-default btn-sm ml-1">
      <i class="fa fa-fw fa-edit"></i>
    </button>
    <button type="button"
            v-tooltip="'With ' + row.booking_count + ' booking(s)'"
            :disabled="row.booking_count>0"
            @click="deleteItem"
            class="btn btn-danger btn-sm">
      <i class="fa fa-fw fa-close"></i>
    </button>
  </div>
</template>

<script>
  import { EventBus } from '@/event-bus.js'

  export default {
    props: ['row', 'nested'],
    methods: {
      editItem () {
        console.log('tdAction :: editItem')
        EventBus.$emit('edit_meeting_room_booking', {room: this.row})
      },
      deleteItem () {
        console.log('tdAction :: deleteItem')
        EventBus.$emit('delete_meeting_room_booking', {room: this.row})
      }
    }
  }
</script>