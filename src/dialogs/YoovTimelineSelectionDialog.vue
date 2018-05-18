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
            <span>{{ showingMoment ? showingMoment.format('Y-MM-DD') : '' }}</span><br/>
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
            <!--<td>-->
              <!--<div>10:00am</div>-->
              <!--<div>10:15am</div>-->
              <!--<div>10:30am</div>-->
              <!--<div>10:45am</div>-->
              <!--<div>11:00am</div>-->
              <!--<div>11:15am</div>-->
              <!--<div>11:30am</div>-->
              <!--<div>11:45am</div>-->
            <!--</td>-->
            <!--<td>-->
              <!--<div>12:00am</div>-->
              <!--<div>12:15am</div>-->
              <!--<div>12:30am</div>-->
              <!--<div>12:45am</div>-->
              <!--<div>1:00pm</div>-->
              <!--<div>1:15pm</div>-->
              <!--<div>1:30pm</div>-->
              <!--<div>1:45pm</div>-->
            <!--</td>            -->
            <!--<td>-->
              <!--<div>2:00pm</div>-->
              <!--<div>2:15pm</div>-->
              <!--<div>2:30pm</div>-->
              <!--<div>2:45pm</div>-->
              <!--<div>3:00pm</div>-->
              <!--<div>3:15pm</div>-->
              <!--<div>3:30pm</div>-->
              <!--<div>3:45pm</div>-->
            <!--</td>-->
            <!--<td>-->
              <!--<div>4:00pm</div>-->
              <!--<div>4:15pm</div>-->
              <!--<div>4:30pm</div>-->
              <!--<div>4:45pm</div>-->
              <!--<div>5:00pm</div>-->
              <!--<div>5:15pm</div>-->
              <!--<div>5:30pm</div>-->
              <!--<div>5:45pm</div>-->
            <!--</td>-->
            <!--<td>-->
              <!--<div>6:00pm</div>-->
              <!--<div>6:15pm</div>-->
              <!--<div>6:30pm</div>-->
              <!--<div>6:45pm</div>-->
              <!--<div>7:00pm</div>-->
              <!--<div>7:15pm</div>-->
              <!--<div>7:30pm</div>-->
              <!--<div>7:45pm</div>-->
            <!--</td>-->
            <!--<td>-->
              <!--<div>8:00pm</div>-->
              <!--<div>8:15pm</div>-->
              <!--<div>8:30pm</div>-->
              <!--<div>8:45pm</div>-->
              <!--<div>9:00pm</div>-->
              <!--<div>9:15pm</div>-->
              <!--<div>9:30pm</div>-->
              <!--<div>9:45pm</div>-->
            <!--</td>-->
          </tr>
        </table>
      </div>
    </div>
    <div slot="footer">
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
        this.showingMoment.add('days', -1)
        console.log('onPrevButtonClicked :: showingMoment: ', this.showingMoment.toString())
      },
      onNextButtonClicked () {
        this.showingMoment.add('days', 1)
        console.log('onNextButtonClicked :: showingMoment: ', this.showingMoment.toString())
      },
      onSlotDblClick (item) {
        let vm = this
        vm.clearSelection()
        item.selected = true
        console.log('onSlotDblClick')
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
      onSlotClicked (item) {
        let vm = this
        let index = vm.slots.indexOf(item)
        let {firstIndex, lastIndex, selection} = vm.getSelectionInfo()
        console.log('onSlotClicked :: index = ' + index)
        console.log('onSlotClicked :: firstIndex = ' + firstIndex)
        console.log('onSlotClicked :: lastIndex = ' + lastIndex)

        let i
        if (selection.length === 0) {
          item.selected = true
        } else {
          if (index < firstIndex) {
            for (i = index; i < firstIndex; i++) {
              vm.slots[i].selected = true
            }
          } else if (index > lastIndex) {
            for (i = lastIndex + 1; i <= index; i++) {
              vm.slots[i].selected = true
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
        for (var i = 0; i < vm.slots.length; i++) {
          let label = vm.slots[i].label
          let bookingStartLabel = booking.startMoment.format('hh:mm a')
          let bookingEndLabel = booking.endMoment.format('hh:mm a')
          if (label >= bookingStartLabel && label <= bookingEndLabel) {
            vm.slots[i][key] = true
          }
        }
      },

      updateTimeSlots () {
        let vm = this
        vm.resetSlots()
        vm.$store.dispatch('GET_DAY_BOOKINGS', vm.showingMoment).then(function (bookings) {
          console.log('updateTimeSlots :: GET_DAY_BOOKINGS: bookings: ', bookings)
          for (var i = 0; i < bookings.length; i++) {
            if (bookings[i].id !== vm.booking.id) {
              vm.setSlotStatus('occupied', bookings[i])
            }
          }
          vm.setSlotStatus('selected', vm.booking)
        })
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
      console.log('mounted :: startMoment: ' + vm.startMoment.toString())
      console.log('mounted :: endMoment: ' + vm.endMoment.toString())

      let loopMoment = vm.startMoment.clone()
      vm.slots = []
      while (loopMoment < vm.endMoment) {
        vm.slots.push({
          moment: loopMoment,
          label: loopMoment.format('hh:mm a'),
          selected: false,
          occupied: false
        })
        loopMoment.add('15', 'minutes')
      }
      vm.updateTimeSlots()
    },
    computed: {
      timeSlots () {
        let vm = this
        let result = []

        if (vm.startMoment && vm.endMoment) {
          console.log('computed :: timeSlots')
          console.log('computed :: startMoment = ' + vm.startMoment.toString())
          console.log('computed :: endMoment = ' + vm.endMoment.toString())

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
            console.log('i = ' + i + ': computed :: result: ', result)
          }

          let loopCount = 0
          let loopMoment = vm.startMoment
          let loopColumnIndex
          let loopItemIndex
          while (loopCount < slotCount) {
            loopColumnIndex = Math.floor(loopCount / 12)
            loopItemIndex = loopCount - loopColumnIndex * itemsPerColumn

            console.log('computed :; (col=' + loopColumnIndex + ', row=' + loopItemIndex + '):   loopMoment = ' + loopMoment.toString())
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
  background-color: lightgray;
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

</style>
