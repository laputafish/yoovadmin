<template>
  <div v-if="currentRoom" id="yoovRoomBookingSchedule">
    <h5 class="bg-default">{{ currentRoom.name }}&nbsp;
      <b-button variant="primary"
                @click="onTestClicked">Test</b-button>
      <span class="badge badge-success"><i class="fa fa-user"></i>&nbsp;x&nbsp;{{ currentRoom.capacity }}
      showingYoovTimelineSelectionModal: {{ showingYoovTimelineSelectionModal}}</span>
    </h5>
    <b-alert show>{{ currentRoom.equipments }}</b-alert>
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
    <div class="schedule-table-header">
      <table style="width:100%;">
        <tbody>
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
              @click="onColumnClicked(columnIndex)"
              v-for="(scheduleItems,columnIndex) in weekSchedule">
            <div v-for="item in scheduleItems"
                 :class="getScheduleItemClass(item)"
                 @click.stop="onEventClicked(columnIndex, item)"
                 class="schedule-item-wrapper"
                 :style="getItemStyle(item)">
              <div class="schedule-item">
                <span>{{ item.range }}</span><br/>
                <span class="badge badge-default"><i class="fa fa-user"></i>&nbsp;{{ item.applicant_name }}</span>
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
    <yoov-timeline-selection-modal
      :currentMoment="currentMoment"
      :booking="editBooking"
      :open="showingYoovTimelineSelectionModal"
      @onResult="onDialogResult"
      @close="showingYoovTimelineSelectionModal=false"></yoov-timeline-selection-modal>
  </div>
</template>

<script>
  import {EventBus} from '@/event-bus'
  import YoovTimelineSelectionModal from '@/dialogs/YoovTimelineSelectionModal'

  export default {
    components: {
      'yoov-timeline-selection-modal': YoovTimelineSelectionModal
    },
    data () {
      return {
        showingYoovTimelineSelectionModal: false,
        editBooking: null,
        currentMoment: null,
        currentRoom: null,
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
    model: {
      prop: 'booking',
      event: 'input'
    },
    props: {
      booking: null,
      defaultRoom: null,
      defaultMoment: null,
      editable: {
        type: Boolean,
        default: false
      }
    },
    mounted () {
      console.log('YoovRoomBookingSchedule :: mounted')
      let vm = this
      vm.currentMoment = (vm.defaultMoment === null) ? vm.defaultMoment : vm.$moment()
      vm.initBookingInfos()
      // let promises = [
      //   vm.$store.dispatch('GET_MEETING_ROOM_BOOKINGS'),
      //   vm.$store.dispatch('GET_MEETING_ROOMS')
      // ]
      // Promise.all(promises).then(function (responses) {
      //   vm.$store.dispatch('UPDATE_BOOKING', vm.localBooking).then(function (response) {
      //     console.log('promise.all :: meeting_rooms.length = ' + vm.rooms.length)
      //     vm.currentMoment = vm.$moment()
      //     let selectedRoom = null
      //     for (var i = 0; i < vm.rooms.length; i++) {
      //       if (vm.rooms[i].id === vm.booking.meeting_room_id) {
      //         selectedRoom = vm.rooms[i]
      //         vm.$store.dispatch('SELECT_ROOM', selectedRoom)
      //         break
      //       }
      //     }
      //     // vm.initBookingInfos()
      //     // console.log('mounted => refreshCalendar :: selectedRoom: ', selectedRoom)
      //     // vm.refreshCalendar(selectedRoom)
      //   })
      // })
    },
    watch: {
      defaultRoom: {
        handler: function (value) {
          console.log('defaultRoom: ', value)
          this.currentRoom = value
          this.refreshCalendar(value)
        },
        deep: true
      },
      selectedRoom: {
        handler: function (value) {
          this.currentRoom = value
          this.refreshCalendar(value)
        },
        deep: true
      }
    },
    computed: {
      selectedRoom () {
        return this.$store.getters.selectedRoom
      },
      bookings () {
        let result = this.$store.getters.meetingRoomBookings
        return result
      },
      rooms () {
        return this.$store.getters.meetingRooms
      },
      user () {
        return this.$store.getters.user
      },
      bookingTemplate () {
        return this.$store.getters.bookingTemplate
      }
    },
    methods: {
      onDialogResult (result) {
        alert('onDialogResult')
        // let dialog = result.dialog
        // let payload = result.payload
        this.showingYoovTimelineSelectionModal = false
      },
      onTestClicked () {
        this.showingYoovTimelineSelectionModal = true
      },
      onNextButtonClicked () {
        let vm = this
        console.log('onNextButtonClicked :: currentMoment = ' + vm.currentMoment.toString())
        vm.currentMoment = vm.currentMoment.add('days', 7)
        console.log('onNextButtonClicked :: currentMoment = ' + vm.currentMoment.toString())
        vm.refreshCalendar(vm.currentRoom)
      },
      onPrevButtonClicked () {
        let vm = this
        console.log('onNextButtonClicked :: currentMoment = ' + vm.currentMoment.toString())
        vm.currentMoment = vm.currentMoment.add('days', -7)
        console.log('onNextButtonClicked :: currentMoment = ' + vm.currentMoment.toString())
        vm.refreshCalendar(vm.currentRoom)
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

      setCurrentWeekBookings (room) {
        if (typeof room === 'undefined') {
          alert('selectedRoom is undefined')
        }
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
        console.log('setCurrentWeekBookings :: vm.rooms: ', vm.rooms)
        console.log('setCurrentWeekBookings :: vm.rooms.length = ' + vm.rooms.length)

        console.log('setCurrentWeekBookings :: vm.room :' + JSON.stringify(room))
        console.log('setCurrentWeekBookings :: check any booking within : ' +
          vm.displayedRangeStart.toString() + ' to ' +
          vm.displayedRangeEnd.toString())

        console.log('setCurrentWeekBookings :: before find bookings, vm.weekSchedule: ', vm.weekSchedule)

        for (var j = 0; j < vm.bookings.length; j++) {
          console.log('setCurrentWeekBookings :: vm.bookings[' + j + '].meeting_room_id = ' + vm.bookings[j].meeting_room_id)
          if (typeof room === 'undefined') {
            alert('room is undefined')
          }
          if (vm.bookings[j].meeting_room_id !== room.id) {
            continue
          }
          console.log('setCurrentWeekBookings :: found booking of room')
          var booking = vm.bookings[j]
          var bookingMoment = vm.$moment(booking.started_at)
//        console.log('#' + j + ': bookingMoment = ' + bookingMoment.format('Y-MM-DD HH:mm:ss'))

          if (bookingMoment >= vm.displayedRangeStart &&
            bookingMoment <= vm.displayedRangeEnd) {
            console.log('the booking within range')
//          var weekday = Math.floor(bookingMoment.diff(vm.displayedRangeStart, 'day'))

            loopBookings = vm.weekSchedule[booking.weekday]
            console.log('weekday = ' + booking.weekday)

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
      // logCurrentBookings () {
      //   let vm = this
      //   for (var i = 0; i < vm.currentBookings.length; i++) {
      //     let booking = vm.currentBookings[i]
      //     console.log('#' + i + ': id=' + booking.id + ' appId=' + booking.applicant_id +
      //       ' (' + booking.applicant_name + ') ' +
      //       'room id = ' + booking.meeting_room_id + ' (' + booking.meeting_room_name + ') ' +
      //       'started_at=' + booking.started_at + '   ended_at=' + booking.ended_at
      //     )
      //   }
      // },
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
      // getHumanReadableTime (moment) {
      //   let hour = moment.get('hour')
      //   let minute = moment.get('minute')
      //   let ampm = 'am'
      //   let result = hour
      //   if (hour >= 12) {
      //     ampm = 'pm'
      //   }
      //   if (minute > 0) {
      //     result += ':' + (minute < 10 ? '0' + minute : minute)
      //   }
      //   result += ampm
      //   return result
      // },

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
        let startTime = this.getHumanReadableTime(startMoment)
        let endTime = this.getHumanReadableTime(endMoment)
        return startTime + ' - ' + endTime
      },

      initBookingInfos () {
        let vm = this
        console.log('YoovRoomBookingSchedule :: initBookingInfos')
        console.log('YoovRoomBookingSchedule :: bookings:', vm.bookings)
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
        let weekdayIndex
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

        for (weekdayIndex = 0; weekdayIndex < hours.length; weekdayIndex++) {
          loopHour = hours[weekdayIndex].toString()
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
        for (weekdayIndex = 0; weekdayIndex < 7; weekdayIndex++) {
          items = vm.weekSchedule[weekdayIndex]
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
        for (weekdayIndex = 0; weekdayIndex < 7; weekdayIndex++) {
          items = vm.weekSchedule[weekdayIndex]
          console.log('checkGapBetween weekdayIndex=' + weekdayIndex + ' items.length=' + items.length)
          for (j = items.length - 1; j > 0; j--) {
            overlapped = 100 - (items[j].top - items[j - 1].top)

            let currStartMoment = items[j].startMoment
            let prevEndMoment = items[j - 1].endMoment
            console.log('checkGapBetween weekdayIndex=' + weekdayIndex + ',j=' + j + 'curr:' + currStartMoment.get('hour') + ':' + currStartMoment.get('minute') +
              '   prev:' + prevEndMoment.get('hour') + ':' + prevEndMoment.get('minute'))

            let sequential = currStartMoment.get('hour') === prevEndMoment.get('hour') &&
              currStartMoment.get('minute') === prevEndMoment.get('minute')

            console.log('checkGapBetween weekdayIndex=' + weekdayIndex + ',j=' + j + ' : sequential = ' + (sequential ? 'yes' : 'no'))
            if (!sequential && overlapped === 0) {
              hour = items[j].startMoment.get('hour')
              console.log('extend hour=' + hour + ', overlapped=' + overlapped)
              vm.extendTopPosition(hour, 20)
              vm.outputWeekSchedule()
            }
          }
        }

        console.log('setScheduleRegionTop ends :: weekdaySchedule: ', vm.weekSchedule)
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
      newSchedule (columnIndex) {
        let vm = this
        let cloneMoment = vm.currentMoment.clone()
        vm.editBooking = vm.bookingTemplate.clone()
        vm.editBooking.meeting_room_id = vm.defaultRoom.id
        vm.editBooking.meeting_room = vm.defaultRoom
        vm.selectedMoment = cloneMoment.day(columnIndex)
        vm.showingYoovTimelineSelectionModal = true
      },
      /*
        <yoov-timeline-selection-modal
          :currentMoment="selectedMoment"
          :booking="booking"
          :open="showingYoovTimelineSelectionModal"
          @onResult="onDialogResult"
          @close="showingYoovTimelineSelectionModal=false">
        </yoov-timeline-selection-modal>
      */
      editSchedule (item) {
        let vm = this
        let cloneMoment = vm.currentMoment.clone()

      },
      editSchedule2 (columnIndex, mode) {
        let vm = this
        let clone = vm.currentMoment.clone()

        if (typeof vm.booking === 'undefined') {
          alert('vm.booking is undefined')
        }
        if (typeof vm.currentRoom === 'undefined') {
          alert('vm.currentRoom is undefined')
        }
        if (vm.booking.id === 0) {
          vm.booking.meeting_room_id = vm.currentRoom.id
          vm.booking.meeting_room = vm.currentRoom
        }
        vm.booking.startMoment = vm.$moment(vm.booking.started_at)
        vm.booking.endMoment = vm.$moment(vm.booking.ended_at)
        console.log('editSchedule (mode=' + mode + ') vm.booking: ', vm.booking)

        // if edit mode, get column index of current booking
        if (mode === 'edit') {
          columnIndex = vm.booking.startMoment.day()
        }
        vm.selectedMoment = clone.day(columnIndex)

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
      onColumnClicked (columnIndex) {
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
                  vm.editSchedule(columnIndex, 'edit')
                  break
                case 'new':
                  vm.editSchedule(columnIndex, 'new')
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
          //     vm.refreshCalendar(vm.currentRoom)
          //     vm.newSchedule(index)
          //   })
          // }).catch(function () {
          //   alert('cancel')
          // })
        } else {
          this.newSchedule(columnIndex)
        }
      },
      onEventClicked (columnIndex, item) {
        let vm = this
        if (typeof item === 'undefined') {
          alert('item is undefined')
        }
        if (vm.booking === null) {
          alert('vm.booking is null')
        }
        console.log('onEventClicked (columnIndex=' + columnIndex + ') :: item.id=' + item.id + '    vs vm.booking.id=' + vm.booking.id)
        if (item.id === vm.booking.id) {
          vm.editSchedule(item)
        }
      },
      refreshCalendar (currentRoom) {
        console.log('refreshCalendar :: currentRoom: ', currentRoom)
        this.setCurrentWeekBookings(currentRoom)
      },
      getScheduleItemClass (item) {
        let vm = this
        if (item && vm.booking) {
          return {
            occupied: item.id !== vm.booking.id,
            'booking-approved': item.status === 'approved',
            'booking-rejected': item.status === 'rejected',
            'booking-pending': item.status === 'pending',
            'booking-self': (vm.user && item.applicant_id === vm.user.id),
            'booking-editable': vm.editable
          }
        } else {
          if (typeof vm.booking === 'undefined') {
            console.log('getScheduleItemClass :: vm.booking is undefined')
          }
          return {}
        }
      }
    }
  }
</script>

<style>
  #yoovRoomBookingSchedule .card .card-body table tr td {
    cursor: pointer;
  }

  #yoovRoomBookingSchedule .card .card-body [role=alert] {
    padding: 0.15rem .55rem;
  }

  #yoovRoomBookingSchedule .card .card-body {
    padding: 0.5rem;
  }

  #yoovRoomBookingSchedule .btn-prev,
  #yoovRoomBookingSchedule .btn-next {
    min-width:50px;
  }

  #yoovRoomBookingSchedule .room-schedule-weekday-label-row td {
    background-color: #666;
    border: 1px solid white;
    color: white;
    text-align: center;
    line-height: 1;
    padding: 3px 0 0 0;
  }

  #yoovRoomBookingSchedule .room-schedule-weekday-label-row .weekday-label {
    color: black;
    background-color: lightgray;
  }

  #yoovRoomBookingSchedule .room-schedule-weekday-label-row td span.badge {
    margin:3px 0;
  }

  #yoovRoomBookingSchedule .schedule-table-header {
    width: 100%;
    padding-right: 20px;
  }
  #yoovRoomBookingSchedule .schedule-item {
    background-color: #fffeba;
    border-radius: 1rem;
    text-align: center;
    height: 100%;
    width: 100%;
    position: relative;
  }

  #yoovRoomBookingSchedule .schedule-item .booking-status {
    position: absolute;
    left: 0;
    bottom: 2px;
    width: 100%;
    font-size: 10px;
  }

  #yoovRoomBookingSchedule .schedule-item-wrapper.booking-pending.occupied .schedule-item {
    background-color: #fffeea;
  }

  #yoovRoomBookingSchedule .schedule-item-wrapper.booking-approved.occupied .schedule-item {
    background-color: #93d3a2;
  }

  #yoovRoomBookingSchedule .schedule-item-wrapper.booking-rejected.occupied .schedule-item {
    background-color: #ff7f7f;
  }

  #yoovRoomBookingSchedule .schedule-item-wrapper.booking-pending:not(.occupied) .schedule-item {
    background-color: yellow; /*#fffeba;*/
  }

  #yoovRoomBookingSchedule .schedule-item-wrapper.booking-approved:not(.occupied) .schedule-item {
    background-color: #28a745;
  }

  #yoovRoomBookingSchedule .schedule-item-wrapper.booking-rejected:not(.occupied) .schedule-item {
    background-color: #ff0000;
  }

  #yoovRoomBookingSchedule .schedule-item-wrapper.occupied:not(.booking-self) .schedule-item,
  #yoovRoomBookingSchedule .schedule-item-wrapper.occupied:not(.booking-editable) .schedule-item
  {
    cursor: default;
  }

  #yoovRoomBookingSchedule .schedule-content-container {
    overflow-y: scroll;
    max-height: 400px;
  }
  #yoovRoomBookingSchedule .schedule-content-row td {
    cursor: pointer;
    position: relative;
    height: 600px;
  }

  #yoovRoomBookingSchedule .schedule-content-row td:nth-child(2n+1) {
    background-color: rgba(0, 0, 0, 0.03);
  }

  #yoovRoomBookingSchedule div[role=alert] {
    margin-bottom:1px;
  }

  #yoovRoomBookingSchedule .schedule-item-wrapper {
    height: 100px;
    width: 100%;
    position: absolute;
    left: 0;
    padding:2px;
  }
</style>
