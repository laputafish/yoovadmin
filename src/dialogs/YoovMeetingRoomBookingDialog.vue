<template>
  <div id="yoovMeetingRoomBookingDialog">
    <b-card no-body
      header="Meeting Room Booking">
      <b-card-body class="d-flex flex-column">
        <div class="row flex-grow-1">
          <div class="col-sm-3 d-flex flex-column">
            <th>Meeting Rooms</th>
            <div class="flex-grow-1" style="overflow-y: scroll;">
              <table class="table-striped table-hover table-responsive" style="display:table;">
                <tbody>
                <tr v-for="room in rooms"
                    :class="{'bg-primary':selectedRoom===room}"
                  @click="selectedRoom = room">
                  <td>
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
              <table style="width:100%;">
                <tbody>
                  <tr>
                    <td colspan="7" style="width: 100%;">
                      <div class="d-flex flex-row">
                        <button type="button" class="btn-prev btn btn-sm btn-primary justify-content-start">
                          <i class="fa fa-fw fa-caret-left"></i>
                        </button>
                        <button type="button" class="ml-auto btn-next btn btn-sm btn-primary justify-content-end">
                          <i class="fa fa-fw fa-caret-right"></i>
                        </button>
                      </div>
                    </td>
                  </tr>
                  <tr class="room-schedule-weekday">
                    <td v-for="weekday in displayedWeekdays">
                      {{ weekday.label }}<br/>
                      <span class="badge badge-primary">{{ weekday.date }}</span>
                    </td>
                  </tr>
                  <tr>
                    <td>Sun</td>
                    <td>Mon</td>
                    <td>Tue</td>
                    <td>Wed</td>
                    <td>Thu</td>
                    <td>Fri</td>
                    <td>Sat</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </b-card-body>
      <b-card-footer>
        <b-button @click="$emit('close')"
                  variant="primary">Close</b-button>
      </b-card-footer>
    </b-card>
  </div>
</template>

<script>
export default {
  data () {
    return {
      selectedRoom: null,
      displayedRangeStart: '2018-05-06',
      displayedRangeEnd: '2018-05-12',
      displayedWeekdays: ['', '', '', '', '', '', ''],
      scheduleSlotStarts: [],
      weekSchedule: [
        [],
        [],
        [],
        [],
        [],
        [],
        []
      ],
      rooms: [
        { name: 'Room 201', capacity: 2, equipments: 'sdlfksdjlf jsdljf sdlkf jlsdkj fslkdf sdsd fklsd fsdkf sdfk sdfk dskfsdkfsdk fksd fksdfksd fsd kfksdkf ksdfksd kf sdf' },
        { name: 'Room 202', capacity: 3, equipments: '' },
        { name: 'Room 203', capacity: 4, equipments: '' },
        { name: 'Room 204', capacity: 5, equipments: '' },
        { name: 'Room 205', capacity: 6, equipments: '' }
      ],
      bookings: [
        {started_at: '2018-05-14 12:00:00', ended_at: '2018-05-14 13:00:00'},
        {started_at: '2018-05-14 14:00:00', ended_at: '2018-05-14 15:00:00'},
        {started_at: '2018-05-14 18:00:00', ended_at: '2018-05-14 19:00:00'},
        {started_at: '2018-05-15 11:00:00', ended_at: '2018-05-15 16:00:00'},
        {started_at: '2018-05-15 17:00:00', ended_at: '2018-05-15 19:00:00'}
      ]
    }
  },
  methods: {
    setCurrentWeek () {
      let vm = this
      let moment = vm.$moment()
      console.log('setCurrentWeek :: moment: ' + moment.format('Y-MM-DD hh:mm:ss'))
 //     let weekday = moment.weekday()
 //     console.log('s1etCurrentWeek :: weekday = ' + weekday)
      // let weekdayNames = localeData.weekdays()
      for (var i = 0; i < 7; i++) {
//        console.log('#' + i + ': moment.weekday(i) = ' + (moment.weekday(i)) + '   moment.day(i) = ' + moment.day(i))
        vm.displayedWeekdays[i] = {
          'label': moment.day(i).format('ddd'),
          'date': moment.day(i).format('Y-MM-DD')
        }
      }
      let dummy
      dummy = moment.clone()
      vm.displayedRangeStart = dummy.startOf('week')
//      console.log('setCurrentWeek after displayedRangeStart :: moment: ' + dummy.toString())

      dummy = moment.clone()
      vm.displayedRangeEnd = dummy.endOf('week')
      // console.log('setCurrentWeek after displayedRangeEnd :: moment: ' + dummy.toString())
      //
      // console.log('displayedRangeStart :: ' + vm.displayedRangeStart.format('Y-MM-DD HH:mm:ss')) // toString())
      // console.log('displayedRangeEnd :: ' + vm.displayedRangeEnd.format('Y-MM-DD HH:mm:ss')) // toString())
      //
      // console.log('bookings.length = ' + vm.bookings.length)

      // reset schedule
      for (var k = 0; k < 7; k++) {
        vm.weekSchedule[k] = []
      }

      // filter bookings
      for (var j = 0; j < vm.bookings.length; j++) {
        var booking = vm.bookings[j]
        var bookingMoment = vm.$moment(booking.started_at)
//        console.log('#' + j + ': bookingMoment = ' + bookingMoment.format('Y-MM-DD HH:mm:ss'))

        if (bookingMoment >= vm.displayedRangeStart &&
          bookingMoment <= vm.displayedRangeEnd) {
//          var weekday = Math.floor(bookingMoment.diff(vm.displayedRangeStart, 'day'))
          vm.weekSchedule[booking.weekday].push(booking)
//        console.log('#' + j + ':loop weekday = ' + booking.weekday)
        }
      }
      // adjust top position of schedule item region
//      let minHour = vm.getWeekScheduleMinHour()
    },
    getWeekScheduleMinHour () {
      let vm = this
      vm.scheduleSlotStarts = {}
      for (var i = 0; i < vm.weekSchedule.length; i++) {
        var weekdaySchedule = vm.weekSchedule[i]
        for (var j = 0; j < weekdaySchedule.length; j++) {
          var scheduleItem = vm.weekdaySchedule[j]
          if (Object.keys(vm.scheduleSlotStarts).indexOf(scheduleItem.hour) === -1) {
            vm.scheduleSlotStarts[scheduleItem.hour] = []
          }
          vm.scheduleSlotStarts[scheduleItem.hour].push(scheduleItem)
        }
      }
    },
    fillBookingInfos () {
//      console.log('fillBookingInfos')
      let vm = this
      for (var i = 0; i < vm.bookings.length; i++) {
        var startedAt = vm.bookings[i].started_at
        var bookingMoment = vm.$moment(startedAt)
//        console.log('fillBookingInfos :: bookingMoment : ' + bookingMoment.toString())

        var bookingMomentClone = bookingMoment.clone()
        var weekStart = bookingMomentClone.startOf('week')
//        console.log('fillBookingInfos :: weekStart : ' + weekStart.toString())
        vm.bookings[i].weekday = Math.floor(bookingMoment.diff(weekStart, 'day'))
        vm.bookings[i].hour = bookingMoment.get('hour')
//        console.log('#' + i + ': weekday=' + vm.bookings[i].weekday + '   hour=' + vm.bookings[i].hour)
      }
    },
    sortAssocArray (ar) {
      let vm = this
      let keys = []
      for (var hour in vm.scheduleSlotStarts) {
        keys.push(hour)
      }
      keys.sort()

      let result = []
      for (var i = 0; i < keys.length; i++) {
        result.push({
          hour: keys[i],
          items: vm.scheduleSlotStarts[keys[i]]
        })
      }
      return result
    }

  },
  mounted () {
    let vm = this
//    console.log('YoovMeetingRoomBookingDialog :: call setCurrentWeek')
    vm.fillBookingInfos()
    vm.setCurrentWeek()
    console.log('weekSchedule: ', vm.weekSchedule)
  },
  computed: {
    timestamp () {
      let vm = this
      vm.$moment.locale('hk')
      let moment = vm.$moment('2018-5-7 8:22:11')

      console.log('moment: ', moment.format('Y-MM-DD hh:mm:ss'))

      let localeData = vm.$moment.localeData()
      console.log('first day of week: ' + localeData.firstDayOfWeek())

      console.log('months: ', vm.$moment.months())
      return 'timestamp'
    }
  }
}
</script>

<style>
#yoovMeetingRoomBookingDialog .card {
  margin-bottom: 0;
  min-height: 360px;
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

#yoovMeetingRoomBookingDialog .room-schedule-weekday td {
  background-color: #666;
  border: 1px solid white;
  color: white;
  text-align: center;
  line-height: 1;
  padding: 0;
}
</style>