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
            <span>{{ currentDay }}</span><br/>
            <span class="badge badge-default">{{ showingMoment ? showingMoment.format('ddd') : '' }}</span>
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
        <hr style="margin-bottom:5px;"/>
        <table style="width:100%;margin-top:0;">
          <tr>
            <td v-for="column in timeSlots">
              <div v-for="item in column"
                   @dblclick.stop="onSlotDblClick(item)"
                   class="timeslot"
                   :class="{selected:item.selected,occupied:item.occupied}"
                @click="onSlotClicked(item)">{{ item.label }}</div>
            </td>
          </tr>
        </table>
      </div>
    </div>
    <div slot="footer" style="width:100%;">
      <small class="footnote align-self-start">* double-click to reset start point</small>
      <div class="pull-right">
        <button :disabled="false"
                class="btn btn-primary"
                @click="save()">
          OK
        </button>
        <button class="btn btn-default"
                @click="$emit('close')">
          Cancel
        </button>
      </div>
    </div>
  </yoov-modal>
</template>

<script>
  import YoovModal from '@/components/Modal'

  export default {
    data () {
      return {
        // list range
        startHour: 7,
        endHour: 23,

        startMoment: null, // list start
        endMoment: null, // list end

        startSlotMoment: null,
        endSlotMoment: null,

        showingMoment: null,
        slots: []
      }
    },
    props: {
      currentMoment: null,
      booking: {
        startMoment: null,
        endMoment: null
      }
    },
    components: {
      'yoov-modal': YoovModal
    },
    methods: {
      clearSelection () {
        let vm = this
        for (var i = 0; i < vm.slots.length; i++) {
          vm.slots[i].selected = false
        }
      },
      getSelectCount () {
        let vm = this
        let result = 0
        for (var i = 0; i < vm.slots.length; i++) {
          if (vm.slots[i].selected) {
            result++
          }
        }
        return result
      },
      onPrevButtonClicked () {
        let newMoment = this.showingMoment.clone()
        newMoment.add(-1, 'days')
        this.showingMoment = newMoment
        // this.showingMoment.add(-1, 'days')
        this.updateTimeSlots()
        // console.log('onPrevButtonClicked :: showingMoment: ', this.showingMoment.toString())
      },
      onNextButtonClicked () {
        let newMoment = this.showingMoment.clone()
        newMoment.add(1, 'days')
        this.showingMoment = newMoment
        // this.showingMoment.add(1, 'days')
        this.updateTimeSlots()
        // console.log('onNextButtonClicked :: showingMoment: ', this.showingMoment.toString())
      },
      onSlotDblClick (item) {
        let vm = this
        vm.clearSelection()
        item.selected = true
        // console.log('onSlotDblClick')
      },
      getSelectionInfo () {
        let vm = this
        let selection = []
        let first = -1
        let last = -1
        // console.log('getSelectionInfo ::vm.slots: ', vm.slots)
        for (var i = 0; i < vm.slots.length; i++) {
          // console.log('getSelectionInfo i=' + i)
          if (vm.slots[i].selected) {
            // console.log('getSelectionInfo slot selected')
            if (first === -1) {
              first = i
              // console.log('getSelectionInfo first = ' + first)
            }
            selection.push(vm.slots[i])
          } else {
            // console.log('getSelectionInfo slot not selected')
            if (first > -1) {
              if (last === -1) {
                last = i - 1
                // console.log('getSelectionInfo last = ' + last)
              }
            }
          }
        }
        return {
          firstIndex: first,
          lastIndex: last,
          selection: selection
        }
      },
      getOccupiedCount (start, end) {
        let vm = this
        let result = 0
        for (var i = start; i <= end; i++) {
          if (vm.slots[i].occupied) {
            result++
          }
        }
        return result
      },
      onSlotClicked (item) {
        if (!item.occupied) {
          let vm = this
          let index = vm.slots.indexOf(item)
          let {firstIndex, lastIndex, selection} = vm.getSelectionInfo()

          let i
          if (selection.length === 0) {
            item.selected = true
          } else {
            if (index === firstIndex || index === lastIndex) {
              vm.slots[index].selected = !vm.slots[index].selected
            } else if (index < firstIndex) {
              if (vm.getOccupiedCount(index + 1, firstIndex - 1) === 0) {
                for (i = index; i < firstIndex; i++) {
                  vm.slots[i].selected = true
                }
              }
            } else if (index > lastIndex) {
              if (vm.getOccupiedCount(lastIndex + 1, index - 1) === 0) {
                for (i = lastIndex + 1; i <= index; i++) {
                  vm.slots[i].selected = true
                }
              }
            }
          }
        }
      },
      resetSlots () {
        let vm = this
        for (var i = 0; i < vm.slots.length; i++) {
          vm.slots[i].occupied = false
          vm.slots[i].selected = false
        }
      },

      setSlotStatus (key, booking) {
        let vm = this
        // console.log('setSlotStatus : bookingStart = ' + booking.startMoment.toString())
        // console.log('setSlotStatus : bookingEnd = ' + booking.endMoment.toString())

        for (var i = 0; i < vm.slots.length; i++) {
          // let slotLabel = vm.slots[i].label
          let slotStartMoment = vm.slots[i].moment
          let slotEndMoment = slotStartMoment.clone().add(15, 'minutes')

          // console.log('setSlotStatus i=' + i + ': slotStartMoment = ' + slotStartMoment.toString())
          // console.log('setSlotStatus i=' + i + ': slotEndMoment = ' + slotEndMoment.toString())

          // let bookingStartLabel = booking.startMoment.format('hh:mm a')
          // let bookingEndLabel = booking.endMoment.format('hh:mm a')
          // console.log('setSlotStatus(' + key + ') i=' + i + ':: bookingStartLabel: ' + bookingStartLabel)
          // console.log('setSlotStatus(' + key + ') i=' + i + ':: bookingEndLabel: ' + bookingEndLabel)

          if (slotStartMoment.diff(booking.startMoment, 'minute') >= 0 &&
            booking.endMoment.diff(slotEndMoment, 'minute') >= 0) {
//          if (slotStartMoment >= booking.startMoment && slotEndMoment <= booking.endMoment) {
//             console.log('setSlotStatus i=' + i + ': ' + key + ' => true')
            vm.slots[i][key] = true
          }
          // if (slotLabel >= bookingStartLabel && slotLabel < bookingEndLabel) {
          //   console.log('setSlotStatus(' + key + ') i=' + i + ': label: ' + slotLabel + '  in range')
          //   vm.slots[i][key] = true
          // }
        }
      },

      updateTimeSlots () {
        let vm = this
        vm.resetSlots()
        vm.$store.dispatch('GET_DAY_BOOKINGS', vm.showingMoment).then(function (bookings) {
          // console.log('updateTimeSlots :: GET_DAY_BOOKINGS: bookings: ', bookings)
          for (var i = 0; i < bookings.length; i++) {
            if (bookings[i].id !== vm.booking.id) {
              vm.setSlotStatus('occupied', bookings[i])
            }
          }
          vm.setSlotStatus('selected', vm.booking)
        })

        let newSlots = []
        for (var j = 0; j < vm.slots.length; j++) {
          newSlots.push(vm.slots[j])
        }

        // vm.$nextTick(function () {
        //   vm.slots = newSlots
        //   console.log('updateTimeSlots: ', vm.slots)
        // })
//        vm.$set('slots', vm.slots)
      },

      save () {
        let vm = this
        vm.$emit('updateBooking', {
          startMoment: vm.startSlotMoment,
          endMoment: vm.endSlotMoment
        })
      }
    },
    mounted () {
      let vm = this
      vm.showingMoment = vm.currentMoment

      vm.startMoment = vm.showingMoment.clone()
      vm.startMoment.set({hour: vm.startHour, minute: 0, second: 0})

      vm.endMoment = vm.showingMoment.clone()
      vm.endMoment.set({hour: vm.endHour, minute: 0, second: 0})
      // console.log('mounted :: startMoment: ' + vm.startMoment.toString())
      // console.log('mounted :: endMoment: ' + vm.endMoment.toString())

      let loopMoment = vm.startMoment.clone()
      vm.slots = []
      while (loopMoment < vm.endMoment) {
        let moment = loopMoment.clone()
        // console.log('mounted :: assign to slots: ' + moment.toString())
        vm.slots.push({
          moment: moment,
          label: moment.format('hh:mm a'),
          selected: false,
          occupied: false
        })
        loopMoment.add('15', 'minutes')
      }
      vm.updateTimeSlots()
    },
    watched: {
      showingMoment: {
        handler: (value) => {
          console.log('showingMoment :: value:', value)
        },
        deep: true
      }
    },
    computed: {
      currentDay () {
        let vm = this
        if (vm.showingMoment) {
          return vm.showingMoment.format('Y-MM-DD')
        } else {
          return ''
        }
      },
      timeSlots () {
        let vm = this
        let result = []

        if (vm.startMoment && vm.endMoment) {
          // console.log('computed :: timeSlots')
          // console.log('computed :: startMoment = ' + vm.startMoment.toString())
          // console.log('computed :: endMoment = ' + vm.endMoment.toString())

          let hours = vm.endMoment.diff(vm.startMoment, 'hour')
          let itemsPerColumn = 12
          let slotCount = hours * 4
          let colCount = Math.ceil(slotCount / itemsPerColumn)
          // console.log('computed :: colCount = ' + colCount)
          // let items = []
          for (var i = 0; i < colCount; i++) {
            var items = []
            for (var j = 0; j < itemsPerColumn; j++) {
              items.push([])
               // {
          //       label: '',
          //       selected: false,
          //       occupied: false
          //     }])
            }
            result.push(items)
            // console.log('i = ' + i + ': computed :: result: ', result)
          }

          let loopCount = 0
          let loopMoment = vm.startMoment
          let loopColumnIndex
          let loopItemIndex
          while (loopCount < slotCount) {
            loopColumnIndex = Math.floor(loopCount / 12)
            loopItemIndex = loopCount - loopColumnIndex * itemsPerColumn

            // console.log('computed :; (col=' + loopColumnIndex + ', row=' + loopItemIndex + '):   loopMoment = ' + loopMoment.toString())
            result[loopColumnIndex][loopItemIndex] = vm.slots[loopCount]

            loopCount++
            loopMoment.add('15', 'minutes')
          }
        }
        return result
      }
    }
  }
</script>

<style>
#yoovTimelineSelectionDialog .current-date {
  line-height: 1;
}

#yoovTimelineSelectionDialog .modal-container {
  width: 560px;
}

#yoovTimelineSelectionDialog .current-date span {
  padding: 0;
  margin: 0;
}
#yoovTimelineSelectionDialog .time-slots {

}

#yoovTimelineSelectionDialog .time-slots td {
  vertical-align: top;
}

#yoovTimelineSelectionDialog .time-slots td div {
  min-width:30px;
  padding:0 5px;
  text-align:right;
  border-right: 1px solid transparent;
  border-bottom: 1px solid white;
  background-color: rgba(200,200,200,.3);
  cursor: pointer;
}

#yoovTimelineSelectionDialog .time-slots td div.occupied {
  cursor: default;
  background-color: darkgray;
  color: white;
}

#yoovTimelineSelectionDialog .time-slots td div.occupied:hover {
  background-color: darkgray;
  color: white;
}

#yoovTimelineSelectionDialog .time-slots td div:hover {
  background-color: #a2c1cc;
}

#yoovTimelineSelectionDialog .time-slots td div.selected {
  background-color: #28a745;
  color: white;
}

#yoovTimelineSelectionDialog .time-slots td div.selected:hover {
  background-color: #468499;
}

#yoovTimelineSelectionDialog .footnote {
    margin-left:10px;
}
</style>
