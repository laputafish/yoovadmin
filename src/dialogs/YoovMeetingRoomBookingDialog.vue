<template>
  <yoov-modal id="yoovMeetingRoomBookingDialog"
    :class="{'read-only':booking.status=='approved'||booking.status=='rejected'}">
    <div slot="header" class="header">
      <div class="pull-right">
        <span class="badge badge-primary booking-status" v-if="booking.status==='pending'">Pending</span>
        <span class="badge badge-success booking-status" v-else-if="booking.status==='approved'">Approved</span>
        <span class="badge badge-danger booking-status" v-else-if="booking.status==='rejected'">Rejected</span>
        <span class="badge badge-secondary booking-status" v-else>(New)</span>
      </div>
      <h3 class="dialog-title">
        Meeting Room Booking
      </h3>
    </div>
    <div slot="body" class="d-flex flex-column">
      <div class="row flex-grow-1">
        <div class="col-sm-3 d-flex flex-column">
          <h4>Meeting Rooms</h4>
          <div class="flex-grow-1" style="overflow-y: scroll;">
            <table class="rooms-table table-hover table-responsive" style="display:table;">
              <tbody>
              <tr v-for="room in rooms"
                @click="onRoomSelected(room)">
                <td class="room-item"
                    :class="{'bg-primary':selectedRoom===room}">
                  {{ room.name }}&nbsp;
                  <span class="badge badge-success"><i class="fa fa-user"></i>&nbsp;x&nbsp;{{ room.capacity }}</span>
                </td>
              </tr>
              </tbody>
            </table>
          </div>
        </div>
        <div class="col-sm-9 d-flex flex-column">
          <div v-if="selectedRoom">
            <h5 class="bg-default">{{ selectedRoom.name }}&nbsp;
              <span class="badge badge-success"><i class="fa fa-user"></i>&nbsp;x&nbsp;{{ selectedRoom.capacity }}</span>
            </h5>
            <b-alert show>{{ selectedRoom.equipments }}</b-alert>
            <div class="schedule-table-header">
              <table style="width:100%;">
                <tbody>
                <tr>
                  <td colspan="7" style="width: 100%;">
                    <div class="d-flex flex-row">
                      <button type="button"
                              @click="onPrevButtonClicked"
                              class="btn-prev btn btn-sm btn-primary justify-content-start">
                        <i class="fa fa-fw fa-caret-left"></i>
                      </button>
                      <button type="button"
                              @click="onNextButtonClicked"
                              class="ml-auto btn-next btn btn-sm btn-primary justify-content-end">
                        <i class="fa fa-fw fa-caret-right"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr class="room-schedule-weekday-label-row">
                  <td v-for="weekday in displayedWeekdays">
                    {{ weekday.label }}<br/>
                    <span class="badge weekday-label">{{ weekday.date }}</span>
                  </td>
                </tr>
                </tbody>
              </table>
            </div>
            <div class="schedule-content-container">
              <table style="width:100%;">
                <tbody>
                  <tr class="schedule-content-row">
                    <td class="schedule-column"
                        @click="onColumnClicked(index)"
                      v-for="(scheduleItems,index) in weekSchedule">
                      <div v-for="item in scheduleItems"
                           :class="getScheduleItemClass(item)"
                           @click.stop="onEventClicked(item)"
                        class="schedule-item-wrapper"
                        :style="getItemStyle(item)">
                        <div class="schedule-item">
                          <span>{{ item.range }}</span><br/>
                          <span class="badge badge-default"><i class="fa fa-user"></i>&nbsp;{{ item.applicant_name }}</span>
                          <span>id={{ item.id }}</span>
                          <div class="booking-status">
                            <i v-if="item.status==='pending'" class="fa fa-fw fa-hourglass-half"></i>
                            <i v-else class="fa fa-fw fa-check"></i>
                          </div>
                        </div>
                      </div>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div slot="footer" style="height:40px;width: 100%;position:relative;" class="text-center">
      <div style="position:absolute;left:0;top:0;text-align:center;width:100%;">selectedRoom: {{ selectedRoom }}
      </div>
      <div style="position:absolute;left:0;top:0;text-align:center;width:100%;">
        <b-button @click="$emit('close')"
                  variant="primary"
            class="btn btn-primary">
          OK
        </b-button>
        <b-button @click="$emit('close')"
                  variant="primary"
            class="btn btn-default">
          Cancel
        </b-button>
      </div>
    </div>
  </yoov-modal>
</template>

<script>
import YoovModal from '@/components/Modal'
import {EventBus} from '@/event-bus'

export default {
  components: {
    'yoov-modal': YoovModal
  },
  data () {
    return {
      currentMoment: null,
      displayedRangeStart: '2018-05-06',
      displayedRangeEnd: '2018-05-12',
      displayedWeekdays: ['', '', '', '', '', '', ''],
      scheduleSlotByHour: [],
      weekSchedule: [
        /* Sun */ [],
        /* Mon */ [],
        /* Tue */ [],
        /* Wed */ [],
        /* Thu */ [],
        /* Fri */ [],
        /* Sat */ []
      ]
    }
  },
  props: {
    booking: null
  },
  methods: {
    getScheduleItemClass (item) {
      let vm = this
      return {
        occupied: item.id !== vm.booking.id,
        'booking-approved': item.status === 'approved',
        'booking-rejected': item.status === 'rejected',
        'booking-pending': item.status === 'pending'
      }
    },
    onRoomSelected (room) {
      console.log('onRoomSelected starts')
      let vm = this
      vm.$store.dispatch('SELECT_ROOM', room).then(function () {
        console.log('after dispatch(SELECT_ROOM)')
        vm.refreshCalendar(room)
      })
      console.log('onRoomSelected ends')
    },
    updateBookingHandler (payload) {
      // payload.startMoment
      // payload.endMoment
      let vm = this
      vm.$emit('updateBooking', {
        meeting_room_id: 0,
        meeting_room: null,
        started_at: '',
        ended_at: ''
      })
    },

    outputWeekSchedule () {
      let vm = this
      let weekdaySchedule
      let output = ''
//      console.log('outputWeekSchedule :: weekSchedule.length = ' + vm.weekSchedule.length)
      for (var i = 0; i < vm.weekSchedule.length; i++) {
        weekdaySchedule = vm.weekSchedule[i]
        output = 'Weekday #' + i + ': '
        for (var j = 0; j < weekdaySchedule.length; j++) {
          output = output + 'j=' + j + ':hr=' + weekdaySchedule[j].hour + ',tp=' + weekdaySchedule[j].top + '; '
        }
//        console.log('outputWeekSchedule: ' + output)
      }
    },

    setCurrentWeekBookings (selectedRoom) {
      let vm = this
      let dummy = null
      let dummyDay = null

      let displayedWeekdays = []
      for (var i = 0; i < 7; i++) {
        dummy = vm.currentMoment.clone()
        dummyDay = dummy.day(i)
        displayedWeekdays.push({
          'label': dummyDay.format('ddd'),
          'date': dummyDay.format('Y-MM-DD')
        })
      }
      vm.displayedWeekdays = displayedWeekdays
      console.log('setCurrentWeekBookings :: displayedWeekdays: ', vm.displayedWeekdays)

      dummy = vm.currentMoment.clone()
      vm.displayedRangeStart = dummy.startOf('week')
      dummy = vm.currentMoment.clone()
      vm.displayedRangeEnd = dummy.endOf('week')

      // reset schedule
      for (var k = 0; k < 7; k++) {
        vm.weekSchedule[k] = []
      }
      // console.log('setCurrentWeekBookings :: weekSchedule: ', vm.weekSchedule)

      let loopBookings = []
      let loopBooking = null
      let loop = 0
      let needle = 0
      // filter bookings

      // console.log('=====> setCurrentWeekBookings:before :: weekSchedule:', vm.weekSchedule)
      console.log('setCurrentWeekBookings :: vm.rooms.length = ' + vm.rooms.length)
      // if (vm.rooms.length > 0) {
      //   if (vm.selectedRoom === null) {
      //     vm.selectedRoom = vm.rooms[0]
      //   }
      // } else {
      //   vm.selectedRoom = null
      // }

      console.log('setCurrentWeekBookings :: vm.selectedRoom :' + JSON.stringify(selectedRoom))

      for (var j = 0; j < vm.bookings.length; j++) {
        console.log('setCurrentWeekBookings :: vm.bookings[' + j + '].meeting_room_id = ' + vm.bookings[j].meeting_room_id)
        if (vm.bookings[j].meeting_room_id !== selectedRoom.id) {
          continue
        }
        var booking = vm.bookings[j]
        var bookingMoment = vm.$moment(booking.started_at)
//        console.log('#' + j + ': bookingMoment = ' + bookingMoment.format('Y-MM-DD HH:mm:ss'))

        if (bookingMoment >= vm.displayedRangeStart &&
          bookingMoment <= vm.displayedRangeEnd) {
//          var weekday = Math.floor(bookingMoment.diff(vm.displayedRangeStart, 'day'))

          loopBookings = vm.weekSchedule[booking.weekday]
          loop = loopBookings.length - 1
          needle = -1
          loopBooking = loopBookings[loop]
          // console.log('sort weekday item: loop=' + loop + ', needle=' + needle)
          while (loop >= 0) {
            loopBooking = loopBookings[loop]
            // console.log('loop: sort weekday item: loop=' + loop + ', needle=' + needle + ' booking.hour=' + booking.hour + '  loopBooking.hour=' + loopBooking.hour)
            if (parseInt(booking.hour) < parseInt(loopBooking.hour)) {
              needle = loop
            } else {
              break
            }
            loop--
          }
          if (needle === -1) {
            vm.weekSchedule[booking.weekday].push(booking)
          } else {
            vm.weekSchedule[booking.weekday].splice(needle, 0, booking)
          }
          vm.outputWeekSchedule()
        }
      }
      // console.log('=====> setCurrentWeekBookings:after :: weekSchedule:', vm.weekSchedule)

      // adjust top position of schedule item region
      // console.log('setCurrentWeekBookings :: adjust top position')
      vm.setupScheduleSlotByHour()
      // console.log('before sort')
      vm.setScheduleRegionTop()
      // console.log('setCurrentWeekBookings :: scheduleSlotByHour: ', vm.scheduleSlotByHour)
    },
    setupScheduleSlotByHour () {
      let vm = this
      vm.scheduleSlotByHour = {}
      /* weekdaySchedule
      0: []
      1: [{..}, {..}]
      2: []
      3: [{..}, {..}, {..}]
      4: ...
      5: []
      6:

      =>

      scheduleSlotByHour
      hour: 10 => [{..}, {..}, {..}]
      hour: 11 => []
      hour: 12 => [{..}]
      hour: 14 => []
      hour: 16 => [{..}, {..}]
      */
      console.log('setupScheduleSlotByHour :: weekSchedule: ', vm.weekSchedule)
      for (var i = 0; i < vm.weekSchedule.length; i++) {
        var schedulesInDay = vm.weekSchedule[i]
        if (schedulesInDay) {
          for (var j = 0; j < schedulesInDay.length; j++) {
            console.log('Weekday#' + i + ' :: j#' + j + ': schedulesInDay[j]: ', schedulesInDay[j])
            console.log('Weekday#' + i + ' :: j#' + j + ': scheduleSlotByHour: ', vm.scheduleSlotByHour)
            var scheduleItem = schedulesInDay[j]
            var hourList = Object.keys(vm.scheduleSlotByHour)
            console.log('Weekday#' + i + ' :: j#' + j + ': hourList: ', hourList)
            console.log('Weekday#' + i + ' :: j#' + j + ': hour = ' + scheduleItem.hour)

            if (hourList.indexOf(scheduleItem.hour.toString()) === -1) {
              vm.scheduleSlotByHour[scheduleItem.hour] = []
            }
            vm.scheduleSlotByHour[scheduleItem.hour].push(scheduleItem)
          }
        }
      }
      console.log('setupScheduleSlotByHour: scheduleSlotByHour: ', vm.scheduleSlotByHour)
    },
    getHumanReadableTime (moment) {
      let hour = moment.get('hour')
      let minute = moment.get('minute')
      let ampm = 'am'
      let result = hour
      if (hour >= 12) {
        ampm = 'pm'
      }
      if (minute > 0) {
        result += ':' + (minute < 10 ? '0' + minute : minute)
      }
      result += ampm
      return result
    },
    getTimeSlotRange (startMoment, endMoment) {
      let vm = this
      let startTime = vm.getHumanReadableTime(startMoment)
      let endTime = vm.getHumanReadableTime(endMoment)
      return startTime + ' - ' + endTime
    },
    fillBookingInfos () {
      let vm = this
      for (var i = 0; i < vm.bookings.length; i++) {
        var bookingStartMoment = vm.$moment(vm.bookings[i].started_at)
        var bookingEndMoment = vm.$moment(vm.bookings[i].ended_at)
        var bookingStartMomentClone = bookingStartMoment.clone()
        var weekStart = bookingStartMomentClone.startOf('week')

        vm.bookings[i].weekday = Math.floor(bookingStartMoment.diff(weekStart, 'day'))
        vm.bookings[i].hour = bookingStartMoment.get('hour')
        vm.bookings[i].range = vm.getTimeSlotRange(bookingStartMoment, bookingEndMoment)
        vm.bookings[i].startMoment = bookingStartMoment
        vm.bookings[i].endMoment = bookingEndMoment
      }
    },
    getItemStyle (item) {
    //  console.log('getItemStyle: top = ' + item.top)
      return {
        top: item.top + 'px'
      }
    },

    sortNumber (a, b) {
      return a - b
    },

    setScheduleRegionTop () {
      let vm = this
      console.log('setScheduleRegionTop starts')

      let hours = []
      let i
      let j
      let k
      for (var hour in vm.scheduleSlotByHour) {
        hours.push(parseInt(hour))
      }
      hours.sort(vm.sortNumber)
      console.log('setScheduleRegionTop :: hours: ', hours)

      let result = []
      let top = 20
      let step = 20
      let loopHour = 0
      let item = null

      for (i = 0; i < hours.length; i++) {
        loopHour = hours[i].toString()
        console.log('hour: ' + loopHour + ' item count = ' + vm.scheduleSlotByHour[loopHour].length)
        for (k = 0; k < vm.scheduleSlotByHour[loopHour].length; k++) {
          item = vm.scheduleSlotByHour[loopHour][k]
          item.hour = loopHour
          item.top = top
        }
        //
        // result.push({
        //   hour: loopHour,
        //   items: vm.scheduleSlotByHour[loopHour],
        //   top: top
        // })
        top += step
      }
      vm.outputWeekSchedule()

      console.log('setScheduleRegionTop :: scheduleSlotByHour: ', vm.scheduleSlotByHour)
      let items = []
      let overlapped = 0
      for (i = 0; i < 7; i++) {
        items = vm.weekSchedule[i]
        // console.log('setScheduleRegionTop i=' + i + ' items.length=' + items.length)
        for (j = items.length - 1; j > 0; j--) {
          overlapped = 100 - (items[j].top - items[j - 1].top)
          // console.log('extendTopPosition weekday:' + i + ' j=' + j + ' overlapped: ' + overlapped)
          if (overlapped > 0) {
            hour = items[j].startMoment.get('hour')
            // console.log('extend hour=' + hour + ', overlapped=' + overlapped)
            vm.extendTopPosition(hour, overlapped)
            vm.outputWeekSchedule()
          }
        }
      }

      // check if gap in between two sequential events
      for (i = 0; i < 7; i++) {
        items = vm.weekSchedule[i]
        console.log('checkGapBetween i=' + i + ' items.length=' + items.length)
        for (j = items.length - 1; j > 0; j--) {
          overlapped = 100 - (items[j].top - items[j - 1].top)

          let currStartMoment = items[j].startMoment
          let prevEndMoment = items[j - 1].endMoment
          console.log('checkGapBetween i=' + i + ',j=' + j + 'curr:' + currStartMoment.get('hour') + ':' + currStartMoment.get('minute') +
            '   prev:' + prevEndMoment.get('hour') + ':' + prevEndMoment.get('minute'))

          let sequential = currStartMoment.get('hour') === prevEndMoment.get('hour') &&
            currStartMoment.get('minute') === prevEndMoment.get('minute')

          console.log('checkGapBetween i=' + i + ',j=' + j + ' : sequential = ' + (sequential ? 'yes' : 'no'))
          if (!sequential && overlapped === 0) {
            hour = items[j].startMoment.get('hour')
            console.log('extend hour=' + hour + ', overlapped=' + overlapped)
            vm.extendTopPosition(hour, 20)
            vm.outputWeekSchedule()
          }
        }
      }

      return result
    },
    extendTopPosition (hour, extendAmount) {
      let vm = this
      for (var loopHour in vm.scheduleSlotByHour) {
        if (loopHour >= hour) {
          for (var i = 0; i < vm.scheduleSlotByHour[loopHour].length; i++) {
            vm.scheduleSlotByHour[loopHour][i].top += extendAmount
          }
        }
      }
    },
    editSchedule (index, mode) {
      let vm = this
      let clone = vm.currentMoment.clone()
      vm.selectedMoment = clone.day(index)

      if (vm.booking.id === 0) {
        vm.booking.meeting_room_id = vm.selectedRoom.id
        vm.booking.meeting_room = vm.selectedRoom
      }
      EventBus.$emit('showDialog', {
        dialog: 'timelineSelectionDialog',
        booking: vm.booking,
        mode: mode,
        currentMoment: vm.selectedMoment
      })
    },
    onTimeSlotActionConfirmed (action) {
      let vm = this
      switch (action) {
        case 'new':
          break
        case 'edit':
          break
        default:
          vm.showingConfirmationDialog = false
      }
    },
    onColumnClicked (index) {
      let vm = this
      console.log('YoovMeetingRoomBookingDialog :: onColumnClicked :: vm.booking: ', vm.booking)
      if (vm.booking.started_at !== null) {
        console.log('YoovMeetingRoomBookingDialog :: onColumnClicked :: emit(showDialog)')
        EventBus.$emit('showDialog', {
          dialog: 'timeSlotEntryConfirmationDialog',
          booking: vm.booking,
          callback: function (action) {
            console.log('timeSlotEntryConfirmationDialog :: callback :: action = ' + action)
            switch (action) {
              case 'edit':
                vm.editSchedule(index, 'edit')
                break
              case 'new':
                vm.editSchedule(index, 'new')
                break
              default:
                break
            }
          }
        })

//        vm.showingConfirmationDialog = true
        // vm.$dialog.confirm({
        //   title: 'Schedule Changed',
        //   body: 'Previous selected time slot will be removed. Are you sure?'
        // }, {
        //   okText: 'Yes',
        //   cancelText: 'No'
        // }).then(function () {
        //   console.log('onColumnClicked :: confirm')
        //   vm.$store.dispatch('REMOVE_BOOKING', vm.booking.id).then(function (response) {
        //     vm.booking.started_at = null
        //     vm.booking.ended_at = null
        //     vm.refreshCalendar(vm.selectedRoom)
        //     vm.newSchedule(index)
        //   })
        // }).catch(function () {
        //   alert('cancel')
        // })
      } else {
        this.editSchedule('index', 'new')
      }
    },
    onEventClicked (item) {
//      alert('applicant = ' + item.applicant)
    },
    onNextButtonClicked () {
      let vm = this
      console.log('onNextButtonClicked :: currentMoment = ' + vm.currentMoment.toString())
      vm.currentMoment = vm.currentMoment.add('days', 7)
      console.log('onNextButtonClicked :: currentMoment = ' + vm.currentMoment.toString())
      vm.refreshCalendar(vm.selectedRoom)
    },
    onPrevButtonClicked () {
      let vm = this
      console.log('onNextButtonClicked :: currentMoment = ' + vm.currentMoment.toString())
      vm.currentMoment = vm.currentMoment.add('days', -7)
      console.log('onNextButtonClicked :: currentMoment = ' + vm.currentMoment.toString())
      vm.refreshCalendar(vm.selectedRoom)
    },
    refreshCalendar (selectedRoom) {
      console.log('refreshCalendar :: selectedRoom: ', selectedRoom)
      this.setCurrentWeekBookings(selectedRoom)
    }
  },
  watch: {
    'displayedWeekdays': {
      handler () {
//        alert('watch(displayedWeekdays)')
      },
      deep: true
    }
  },
  mounted () {
    let vm = this
    let promises = [
      vm.$store.dispatch('GET_MEETING_ROOM_BOOKINGS'),
      vm.$store.dispatch('GET_MEETING_ROOMS')
    ]
    Promise.all(promises).then(function (responses) {
      console.log('promise.all :: meeting_rooms.length = ' + vm.rooms.length)
      vm.currentMoment = vm.$moment()
      let selectedRoom = null
      for (var i = 0; i < vm.rooms.length; i++) {
        if (vm.rooms[i].id === vm.booking.meeting_room_id) {
          selectedRoom = vm.rooms[i]
          vm.$store.dispatch('SELECT_ROOM', selectedRoom)
          break
        }
      }
      vm.fillBookingInfos()
      console.log('mounted => refreshCalendar :: selectedRoom: ', selectedRoom)
      vm.refreshCalendar(selectedRoom)
    })

    // vm.$store.dispatch('GET_MEETING_ROOM_BOOKINGS', {
    //   callback: (bookings) => {
    //     console.log('mounted :: callback :: bookings: ', bookings)
    //   }
    // })
    // let response = vm.$store.dispatch('GET_MEETING_ROOMS', {
    //   callback: () => {
    //
    //   }
    // })
    // console.log('mounted :: response: ', response)
    // vm.$nextTick(function () {
    //   console.log('mounted: bookings: ', vm.bookings)
    //   console.log('mounted: rooms: ', vm.rooms)
    //   vm.currentMoment = vm.$moment()
    //   vm.fillBookingInfos()
    //   vm.refreshCalendar()
    // })
  },
  computed: {
    selectedRoom () {
      return this.$store.getters.selectedRoom
    },
    currentBooking () {
      let vm = this
      var result = {
        startMoment: null,
        endMoment: null
      }
      if (vm.booking) {
        result.startMoment = vm.$moment(vm.booking.started_at)
        result.endMoment = vm.$moment(vm.booking.ended_at)
      }
      return result
    },

    rooms () {
      return this.$store.getters.meetingRooms
    },
    bookings () {
      let result = this.$store.getters.meetingRoomBookings
      console.log('YoovMeetingRoomBookingDialog :: bookins: ', result)
      return result
    },
    timestamp () {
      let vm = this
      vm.$moment.locale('hk')
      // let moment = vm.$moment('2018-5-7 8:22:11')
      // let localeData = vm.$moment.localeData()
      return 'timestamp'
    }
  }
}
</script>

<style>
#yoovMeetingRoomBookingDialog .dialog-header {

}

#yoovMeetingRoomBookingDialog .modal-container {
  width: 90%;
  min-width: 1200px;
  height: 710px;
}

#yoovMeetingRoomBookingDialog.read-only .modal-body {
  background-color: rgba(128,128,128,.05);
}

#yoovMeetingRoomBookingDialog .booking-status {
  font-size: 18px;

}

#yoovMeetingRoomBookingDialog .header {
  width: 100%;
  padding: 0 5px;
}

#yoovMeetingRoomBookingDialog .card {
  margin-bottom: 0;
  min-height: 360px;
}

#yoovMeetingRoomBookingDialog .rooms-table td.room-item {
  cursor: pointer;
  background-color: white;
}

#yoovMeetingRoomBookingDialog .rooms-table td.room-item:hover {
  background-color: rgba(0, 0, 0, 0.05);
}

#yoovMeetingRoomBookingDialog .rooms-table tr:nth-child(2n+1) td.room-item {
  background-color: rgba(0, 0, 0, 0.03);
}

#yoovMeetingRoomBookingDialog .rooms-table td.room-item {
  padding: 10px;
  border-radius: 5px;
}
#yoovMeetingRoomBookingDialog .card .card-body table tr td {
  cursor: pointer;
}

#yoovMeetingRoomBookingDialog .card .card-body [role=alert] {
  padding: 0.15rem .55rem;
}

#yoovMeetingRoomBookingDialog .card .card-body {
  padding: 0.5rem;
}

#yoovMeetingRoomBookingDialog .btn-prev,
#yoovMeetingRoomBookingDialog .btn-next {
  min-width:50px;
}

#yoovMeetingRoomBookingDialog .room-schedule-weekday-label-row td {
  background-color: #666;
  border: 1px solid white;
  color: white;
  text-align: center;
  line-height: 1;
  padding: 3px 0 0 0;
}

#yoovMeetingRoomBookingDialog .room-schedule-weekday-label-row .weekday-label {
  color: black;
  background-color: lightgray;
}

#yoovMeetingRoomBookingDialog .room-schedule-weekday-label-row td span.badge {
  margin:3px 0;
}

#yoovMeetingRoomBookingDialog .schedule-table-header {
  width: 100%;
  padding-right: 20px;
}
#yoovMeetingRoomBookingDialog .schedule-item {
  background-color: #fffeba;
  border-radius: 1rem;
  text-align: center;
  height: 100%;
  width: 100%;
  position: relative;
}

#yoovMeetingRoomBookingDialog .schedule-item .booking-status {
  position: absolute;
  left: 0;
  bottom: 2px;
  width: 100%;
  font-size: 10px;
}

#yoovMeetingRoomBookingDialog .schedule-item-wrapper.booking-pending.occupied .schedule-item {
  background-color: #fffeea;
}

#yoovMeetingRoomBookingDialog .schedule-item-wrapper.booking-approved.occupied .schedule-item {
  background-color: #93d3a2;
}

#yoovMeetingRoomBookingDialog .schedule-item-wrapper.booking-rejected.occupied .schedule-item {
  background-color: #ff7f7f;
}

#yoovMeetingRoomBookingDialog .schedule-item-wrapper.booking-pending:not(.occupied) .schedule-item {
  background-color: #fffeba;
}

#yoovMeetingRoomBookingDialog .schedule-item-wrapper.booking-approved:not(.occupied) .schedule-item {
  background-color: #28a745;
}

#yoovMeetingRoomBookingDialog .schedule-item-wrapper.booking-rejected:not(.occupied) .schedule-item {
  background-color: #ff0000;
}

#yoovMeetingRoomBookingDialog .schedule-item-wrapper.occupied .schedule-item {
  cursor: default;
}

#yoovMeetingRoomBookingDialog .schedule-content-container {
  overflow-y: scroll;
  max-height: 400px;
}
#yoovMeetingRoomBookingDialog .schedule-content-row td {
  cursor: pointer;
  position: relative;
  height: 600px;
}

#yoovMeetingRoomBookingDialog .schedule-content-row td:nth-child(2n+1) {
  background-color: rgba(0, 0, 0, 0.03);
}

#yoovMeetingRoomBookingDialog .schedule-item-wrapper {
  height: 100px;
  width: 100%;
  position: absolute;
  left: 0;
  padding:2px;
}


</style>