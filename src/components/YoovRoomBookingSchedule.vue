<template>
  <div v-if="currentRoom" id="yoovRoomBookingSchedule">
    <!--<b-alert show>{{ currentRoom.equipments }}</b-alert>-->
    <div class="d-flex flex-row">
      <button type="button"
              @click="onPrevButtonClicked"
              class="btn-prev btn btn-sm btn-primary justify-content-start">
        <i class="fa fa-fw fa-caret-left"></i>
      </button>
      <h5 class="mx-auto bg-default">{{ currentRoom.name }}&nbsp;
        <span class="badge badge-success">
          <i class="fa fa-user"></i>
        &nbsp;  x&nbsp;{{ currentRoom.capacity }}
        </span>
      </h5>
      <button type="button"
              @click="onNextButtonClicked"
              class="btn-next btn btn-sm btn-primary justify-content-end">
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
                <span class="schedule-item-duration">{{ item.range }}</span><br/>
                <h6 style="margin:-5px 0 0 0;padding:0;">
                  <span class="badge badge-dark"><i class="fa fa-user"></i>&nbsp;{{ item.applicant_name }}</span>
                </h6>
                <div class="booking-description">
                  {{ item.description }}
                </div>
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
    <yoov-timeline-selection-dialog
      v-if="showingYoovTimelineSelectionModal"
      :currentMoment="selectedMoment"
      :booking="editBooking"
      @onResult="onDialogResult"
      @close="showingYoovTimelineSelectionModal=false"></yoov-timeline-selection-dialog>
    <yoov-test-modal
      v-if="showingYoovTestModal"
    @close="showingYoovTestModal=false"></yoov-test-modal>
  </div>
</template>

<script>
  import {EventBus} from '@/event-bus'
  import YoovTimelineSelectionDialog from '@/dialogs/YoovTimelineSelectionDialog'
  import YoovTestModal from '@/dialogs/YoovTestModal'

  export default {
    components: {
      'yoov-timeline-selection-dialog': YoovTimelineSelectionDialog,
      'yoov-test-modal': YoovTestModal
    },
    data () {
      return {
        showingYoovTimelineSelectionModal: false,
        showingYoovTestModal: false,

        editBooking: null,
        currentMoment: null,
        currentRoom: null,
        displayedRangeStart: '2018-05-06',
        displayedRangeEnd: '2018-05-12',
        displayedWeekdays: ['', '', '', '', '', '', ''],
        scheduleSlotByQuarter: [],
        selectedMoment: null,
        weekSchedule: [
          /* Sun */ [],
          /* Mon */ [],
          /* Tue */ [],
          /* Wed */ [],
          /* Thu */ [],
          /* Fri */ [],
          /* Sat */ []
        ],
        bookingTemplate: {
          id: 0,
          applicant_id: 0,
          applicant: null,
          // applicant_name: '',
          description: '',
          meeting_room_id: 0,
          meeting_room: null,
          meeting_room_name: '',
          started_at: null,
          ended_at: null,
          status: 'new',
          remark: ''
        }
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
      let vm = this
      vm.selectedMoment = vm.$moment()
      vm.currentMoment = (vm.defaultMoment === null) ? vm.defaultMoment : vm.$moment()
      vm.initBookingInfos()
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
      bookings: {
        handler: function (value) {
          this.refreshCalendar()
        },
        deep: true
      }
      // ,
      // selectedRoom: {
      //   handler: function (value) {
      //     this.currentRoom = value
      //     this.refreshCalendar(value)
      //   },
      //   deep: true
      // }
    },
    computed: {
      // selectedRoom () {
      //   return this.$store.getters.selectedRoom
      // },
      bookings () {
        let result = this.$store.getters.meetingRoomBookings
        return result
      },
      rooms () {
        return this.$store.getters.meetingRooms
      },
      user () {
        return this.$store.getters.user
      }
    },
    methods: {
      onDialogResult (result) {
        let vm = this
        switch (result.dialog) {
          case 'yoovTimelineSelectionDialog':
            switch (result.command) {
              case 'save':
                vm.editBooking.description = result.payload.booking.description
                vm.editBooking.started_at = result.payload.startedAt
                vm.editBooking.ended_at = result.payload.endedAt
                //            let booking = result.payload.booking
                // let promise = null
                if (vm.editBooking.id === 0) {
                  vm.$store.dispatch('SAVE_BOOKING', vm.editBooking)
                } else {
                  vm.$store.dispatch('UPDATE_BOOKING', vm.editBooking)
                }
                // promise.then(function () {
                //   console.log('AFTER SAVE/UPDATE => refreshCalendar')
                //   vm.refreshCalendar()
                // })
                this.showingYoovTimelineSelectionModal = false
                break
              case 'delete':
                this.$store.dispatch('DELETE_BOOKING', result.payload.id)
                this.showingYoovTimelineSelectionModal = false
                break
            }
            break
        }
      },
      onTestClicked () {
        console.log('onTestClicked')
        this.showingYoovTestModal = true
        this.showingYoovTimelineSelectionModal = true
        // this.showingYoovTimelineSelectionModal = true
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
            output = output + 'j=' + j + ':hr=' + weekdaySchedule[j].quarter + ',tp=' + weekdaySchedule[j].top + '; '
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
              // console.log('loop: sort weekday item: loop=' + loop + ', needle=' + needle + ' booking.quarter=' + booking.quarter + '  loopBooking.quarter=' + loopBooking.quarter)
              if (booking.quarter < loopBooking.quarter) {
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
        vm.setupScheduleSlotByQuarter()
        // console.log('before sort')
        vm.setScheduleRegionTop()
        // console.log('setCurrentWeekBookings :: scheduleSlotByQuarter: ', vm.scheduleSlotByQuarter)
      },

      setupScheduleSlotByQuarter () {
        let vm = this
        vm.scheduleSlotByQuarter = {}
        /* weekdaySchedule
        0: []
        1: [{..}, {..}]
        2: []
        3: [{..}, {..}, {..}]
        4: ...
        5: []
        6:

        =>

        scheduleSlotByQuarter
        quarter: '10:00' => [{..}, {..}, {..}]
        quarter: '10:15' => []
        quarter: '10:30' => [{..}]
        quarter: '10:45' => []
        quarter: '11:00' => [{..}, {..}]
        */
        console.log('setupScheduleSlotByQuarter :: weekSchedule: ', vm.weekSchedule)
        console.log('setupScheduleSlotByQuarter :: loop on each weekday')
        console.log('setupScheduleSlotByQuarter :: scheduleSlotByQuarter keys: ' + Object.keys(vm.scheduleSlotByQuarter))

        for (var i = 0; i < vm.weekSchedule.length; i++) {
          console.log('   Weekday#' + i + ' check any schedule within this weekday:')
          var schedulesInDay = vm.weekSchedule[i]
          if (schedulesInDay) {
            console.log('      schedulesInDay.length = ' + schedulesInDay.length)
            for (var j = 0; j < schedulesInDay.length; j++) {
              console.log('         schedule j=' + j + ': schedulesInDay[j]: ', schedulesInDay[j])
              console.log('         schedule j=' + j + ': scheduleSlotByQuarter: checking current slotByQuarter status: ', vm.scheduleSlotByQuarter)
              var scheduleItem = schedulesInDay[j]
              var quarterList = Object.keys(vm.scheduleSlotByQuarter)
              console.log('         schedule j=' + j + ': quarterList: ', quarterList)
              console.log('         schedule j=' + j + ': quarter = ' + scheduleItem.quarter)

              if (quarterList.indexOf(scheduleItem.quarter) === -1) {
                console.log('         quarterList not contains this hour, create quarter slot')
                vm.scheduleSlotByQuarter[scheduleItem.quarter] = []
              } else {
                console.log('         quarterList contains this quarter')
              }
              console.log('            push this quarter')
              vm.scheduleSlotByQuarter[scheduleItem.quarter].push(scheduleItem)
            }
          }
        }
        console.log('setupScheduleSlotByQuarter: scheduleSlotByQuarter: ', vm.scheduleSlotByQuarter)
      },

      getHumanReadableTime (moment) {
        let hour = moment.get('hour')
        let minute = moment.get('minute')
        let ampm = 'am'
        if (hour >= 12) {
          ampm = 'pm'
        }
        let result = hour > 12 ? hour - 12 : hour
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
          console.log('initBookingInfos i=' + i + ': vm.bookings[i] bookingStartMoment: ' + bookingStartMoment.toString())

          var bookingStartMomentClone = vm.$moment(bookingStartMoment.toString())
          var weekStart = bookingStartMomentClone.startOf('week')

          vm.bookings[i].weekday = Math.floor(bookingStartMoment.diff(weekStart, 'day'))
          vm.bookings[i].quarter = bookingStartMoment.format('HH:mm')
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

      sortQuarter (a, b) {
        return a > b
      },

      setScheduleRegionTop () {
        let vm = this
        console.log('setScheduleRegionTop starts')

        let quarters = []
        let weekdayIndex
        let j
        let k
        for (var quarter in vm.scheduleSlotByQuarter) {
          quarters.push(quarter)
        }
        quarters.sort(vm.sortQuarter)
        console.log('setScheduleRegionTop :: quarters: ', quarters)

        let result = []
        let top = 20
        let step = 20
        let loopQuarter = 0
        let item = null

        for (weekdayIndex = 0; weekdayIndex < quarters.length; weekdayIndex++) {
          loopQuarter = quarters[weekdayIndex]
          console.log('hour: ' + loopQuarter + ' item count = ' + vm.scheduleSlotByQuarter[loopQuarter].length)
          for (k = 0; k < vm.scheduleSlotByQuarter[loopQuarter].length; k++) {
            item = vm.scheduleSlotByQuarter[loopQuarter][k]
            item.quarter = loopQuarter
            item.top = top
          }
          //
          // result.push({
          //   hour: loopQuarter,
          //   items: vm.scheduleSlotByQuarter[loopQuarter],
          //   top: top
          // })
          top += step
        }
        vm.outputWeekSchedule()

        console.log('setScheduleRegionTop :: scheduleSlotByQuarter: ', vm.scheduleSlotByQuarter)
        let items = []
        let overlapped = 0
        for (weekdayIndex = 0; weekdayIndex < 7; weekdayIndex++) {
          items = vm.weekSchedule[weekdayIndex]
          // console.log('setScheduleRegionTop i=' + i + ' items.length=' + items.length)
          for (j = items.length - 1; j > 0; j--) {
            overlapped = 100 - (items[j].top - items[j - 1].top)
            // console.log('extendTopPosition weekday:' + i + ' j=' + j + ' overlapped: ' + overlapped)
            if (overlapped > 0) {
              quarter = items[j].startMoment.format('HH:mm')
              // console.log('extend quarter=' + quarter + ', overlapped=' + overlapped)
              vm.extendTopPosition(quarter, overlapped)
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
              quarter = items[j].startMoment.format('HH:mm')
              console.log('extend quarter=' + quarter + ', overlapped=' + overlapped)
              vm.extendTopPosition(quarter, 20)
              vm.outputWeekSchedule()
            }
          }
        }

        console.log('setScheduleRegionTop ends :: weekdaySchedule: ', vm.weekSchedule)
        return result
      },
      extendTopPosition (quarter, extendAmount) {
        let vm = this
        for (var loopQuarter in vm.scheduleSlotByQuarter) {
          if (loopQuarter >= quarter) {
            for (var i = 0; i < vm.scheduleSlotByQuarter[loopQuarter].length; i++) {
              vm.scheduleSlotByQuarter[loopQuarter][i].top += extendAmount
            }
          }
        }
      },
      newSchedule (columnIndex) {
        let vm = this
        let cloneMoment = vm.currentMoment.clone()
        let bookingTemplate = vm.bookingTemplate
        console.log('newSchedule :: bookingTemplate: ', bookingTemplate)
        vm.editBooking = JSON.parse(JSON.stringify(bookingTemplate))
        vm.editBooking.applicant_id = vm.user.id
        vm.editBooking.applicant = vm.user
        vm.editBooking.meeting_room_id = vm.currentRoom.id
        vm.editBooking.meeting_room = vm.currentRoom
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
        vm.editBooking = item
        vm.selectedMoment = item.startMoment
        vm.showingYoovTimelineSelectionModal = true
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
          // Edit
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
        } else {
          // New Schedule
          this.newSchedule(columnIndex)
        }
      },
      onEventClicked (columnIndex, item) {
        console.log('onEventClicked')
        let vm = this
        if (typeof item === 'undefined') {
          alert('item is undefined')
        }
        if (vm.booking === null) {
          alert('vm.booking is null')
        }
        vm.editSchedule(item)
      },

      refreshCalendar (currentRoom) {
        let vm = this
        if (typeof currentRoom === 'undefined') {
          currentRoom = vm.currentRoom
        }
        if (vm.currentRoom) {
          console.log('refreshCalendar :: currentRoom: ', currentRoom)
          this.setCurrentWeekBookings(currentRoom)
        } else {
          console.log('refreshCalendar :: currentRoom is undefined')
        }
      },
      getScheduleItemClass (item) {
        let vm = this
        if (vm.user && item && vm.booking) {
          return {
            occupied: item.id !== vm.booking.id,
            'booking-approved': item.status === 'approved',
            'booking-rejected': item.status === 'rejected',
            'booking-pending': item.status === 'pending',
            'booking-self': (vm.user && item.applicant_id === vm.user.id),
            'booking-editable': vm.editable,
            'is-owner': vm.user.id === item.applicant_id
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
  #yoovRoomBookingSchedule .schedule-item .schedule-item-duration {
    font-size: 12px;
  }

  #yoovRoomBookingSchedule .schedule-item .booking-status {
    position: absolute;
    left: 0;
    bottom: 2px;
    width: 100%;
    font-size: 10px;
  }

  #yoovRoomBookingSchedule .schedule-item {
    border-radius: 1rem;
    text-align: center;
    height: 100%;
    width: 100%;
    position: relative;
  }

  #yoovRoomBookingSchedule .schedule-item-wrapper.booking-pending.occupied.is-owner .schedule-item {
    background-color: rgba(40,167,69, .8);
    color: white;
  }
  #yoovRoomBookingSchedule .schedule-item-wrapper.booking-pending.occupied.is-owner:hover .schedule-item {
    background-color: rgba(40, 167, 69, 1);
  }

  #yoovRoomBookingSchedule .schedule-item-wrapper.booking-approved.occupied.is-owner .schedule-item {
    background-color: rgba(147,211,162,.8)
  }
  #yoovRoomBookingSchedule .schedule-item-wrapper.booking-approved.occupied.is-owner:hover .schedule-item {
    background-color: rgba(147,211,162,1)
  }

  #yoovRoomBookingSchedule .schedule-item-wrapper.booking-pending.occupied .schedule-item {
    background-color: rgba(255,255,204,.8);
    /*background-color: #fffeea;*/
  }
  #yoovRoomBookingSchedule .schedule-item-wrapper.booking-pending.occupied:hover .schedule-item {
    background-color: rgba(255,255,204,1);
  }

  #yoovRoomBookingSchedule .schedule-item-wrapper.booking-approved.occupied .schedule-item {
    background-color: rgba(255,255,229,.8);
    /*background-color: #28a745;*/
  }
  #yoovRoomBookingSchedule .schedule-item-wrapper.booking-approved.occupied:hover .schedule-item {
    background-color: rgba(255,255,229,1);
  }

  #yoovRoomBookingSchedule .schedule-item-wrapper.booking-rejected.occupied .schedule-item {
    background-color: #ff7f7f;
  }

  #yoovRoomBookingSchedule .schedule-item-wrapper.booking-pending:not(.occupied) .schedule-item {
    background-color: yellow; /*#fffeba;*/
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
  #yoovRoomBookingSchedule .booking-description {
    font-size: 10px;
    width: 100%;
    overflow: hidden;
    color: black;
    height: 32px;
    text-align: center;
    padding: 0 5px;
  }
  #yoovRoomBookingSchedule .schedule-item-wrapper {
    height: 100px;
    width: 100%;
    position: absolute;
    left: 0;
    padding:2px;
  }
</style>
