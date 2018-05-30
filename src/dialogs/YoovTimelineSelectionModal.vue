<template>
  <b-modal ref="modalDialog"
           id="yoovTimelineSelectionModal"
           @ok="onOk"
           @cancel="onCancel"
           title="Select Time Slots">
    <div id="yoovTimelineSelectionDialog">
      <div class="input-group row">
        <label class="col-sm-3 col-form-label" for="applicantName">In Charge</label>
        <input class="col-sm-9 form-control" v-model="applicantName"/>
      </div>
      <div class="input-group row">
        <label class="col-sm-3 col-form-label" for="purpose">Purpose</label>
        <input class="col-sm-9 form-control" v-model="purpose"/>
      </div>
      <hr style="margin-top:1rem;margin-bottom:8px;"/>

      <div class="d-flex flex-row">
        <div class="align-self-start">
          <button type="button"
                  @click="onPrevButtonClicked"
                  class="btn-prev btn btn-sm btn-primary justify-content-start">
            <i class="fa fa-fw fa-caret-left"></i>
          </button>
        </div>
        <div class="align-self-center" style="margin: 0 auto;">
          <span class="flex-grow-1 text-center current-date">
            <span>{{ currentDay }}</span>
            <span class="weekday-label">{{ showingMoment ? showingMoment.format('ddd') : '' }}</span>
          </span>
        </div>
        <div class="align-self-end">
          <button type="button"
                  @click="onNextButtonClicked"
                  class="btn-next btn btn-sm btn-primary justify-content-end">
            <i class="fa fa-fw fa-caret-right"></i>
          </button>
        </div>
      </div>
      <transition name="timeSlots" mode="out-in">
        <div ref="timeSlots" class="time-slots" :key="triggerTransition">
          <hr style="margin-top:0.5rem;margin-bottom:5px;"/>
          <table style="width:100%;margin-top:0;">
            <tr>
              <td v-for="column in timeSlots">
                <div v-for="item in column"
                     @dblclick.stop="onSlotDblClick(item)"
                     class="timeslot"
                     :class="{selected:item.selected,occupied:item.occupied}"
                     @mousedown="onSlotMouseDown(item)"
                     @mouseup="selecting=false"
                     @mousemove="onSlotMouseMove(item)">
                  <div class="timeslot-label">{{ item.label }}</div>
                </div>
              </td>
            </tr>
          </table>
        </div>
      </transition>
      <small class="footnote align-self-start">* double-click to reset start point</small>
    </div>
    <!--<div style="width:100%;" class="mt-0 pt-0">-->
      <!--<div class="text-center">-->
        <!--<div v-if="false">booking: {{ booking }}</div>-->
        <!--<button :disabled="false"-->
                <!--class="btn btn-primary"-->
                <!--@click="save()">-->
          <!--OK-->
        <!--</button>-->
        <!--&lt;!&ndash;<button class="btn btn-default"&ndash;&gt;-->
                <!--&lt;!&ndash;@click="$emit('close')">&ndash;&gt;-->
          <!--&lt;!&ndash;Cancel&ndash;&gt;-->
        <!--&lt;!&ndash;</button>&ndash;&gt;-->
        <!--<b-btn class="mt-3" variant="outline-danger" block @click="close">Close Me</b-btn>-->
      <!--</div>-->
    <!--</div>-->

  </b-modal>
</template>

<script>
  import YoovModal from '@/components/Modal'
  //  import {EventBus} from '@/event-bus'

  export default {
    data () {
      return {
        triggerTransition: false,
        selecting: false,
        // list range
        startHour: 7,
        endHour: 23,
        intervals: 15, // minutes

        startMoment: null, // list start
        endMoment: null, // list end

        startSlotMoment: null,
        endSlotMoment: null,

        showingMoment: null,
        slots: [],

        applicantName: '',
        purpose: ''
      }
    },
    props: {
      currentMoment: null,
      booking: null,
      open: null,
      mode: null
    },
    components: {
      'yoov-modal': YoovModal
    },
    methods: {
      triggerAnimation () {
        this.triggerTransition = !this.triggerTransition
      },
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
        console.log('onPrevButtonClicked :: this.showingMoment = ' + this.showingMoment.toString())
        this.updateTimeSlots()
        this.triggerAnimation()
        // console.log('onPrevButtonClicked :: showingMoment: ', this.showingMoment.toString())
      },
      onNextButtonClicked () {
        let newMoment = this.showingMoment.clone()
        newMoment.add(1, 'days')
        this.showingMoment = newMoment
        // this.showingMoment.add(1, 'days')
        console.log('onPrevButtonClicked :: this.showingMoment = ' + this.showingMoment.toString())
        this.updateTimeSlots()
        this.triggerAnimation()
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
      onSlotMouseMove (item) {
        let vm = this
        if (vm.selecting) {
          let index = vm.slots.indexOf(item)
          console.log('onSlotMouseMove: index = ' + index)
          if (index > 0) {
            if (vm.slots[index - 1].selected) {
              item.selected = !item.occupied
            }
          }
        }
      },
      onSlotMouseDown (item) {
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
              } else {
                vm.clearSelection()
                item.selected = true
              }
            } else if (index > lastIndex) {
              if (vm.getOccupiedCount(lastIndex + 1, index - 1) === 0) {
                for (i = lastIndex + 1; i <= index; i++) {
                  vm.slots[i].selected = true
                }
              } else {
                vm.clearSelection()
                item.selected = true
              }
            }
          }
          if (item.selected) {
            vm.selecting = true
          }
        }
      },

      resetSlots () {
        let vm = this
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
        //
        // for (var i = 0; i < vm.slots.length; i++) {
        //   vm.slots[i].occupied = false
        //   vm.slots[i].selected = false
        // }
      },

      setSlotStatus (key, booking) {
        let vm = this
        console.log('setSlotStatus key=' + key + ', booking:', booking)
        for (var i = 0; i < vm.slots.length; i++) {
          let slotStartMoment = vm.slots[i].moment
          let slotEndMoment = slotStartMoment.clone().add(15, 'minutes')
          console.log('#' + i + ': slot start/end: ' + slotStartMoment.toString() + ' - ' + slotEndMoment.toString())
          console.log('     booking start/end: ' + booking.startMoment.toString() + ' - ' + booking.endMoment.toString())
          if (slotStartMoment.diff(booking.startMoment, 'minute') >= 0 &&
            booking.endMoment.diff(slotEndMoment, 'minute') >= 0) {
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
            console.log('bookings[i].id = ' + bookings[i].id)
            console.log('vm.booking.id = ' + vm.booking.id)
            if (bookings[i].id !== vm.booking.id) {
              vm.setSlotStatus('occupied', bookings[i])
            }
          }
          if (vm.booking.startMoment && vm.booking.endMoment) {
            vm.setSlotStatus('selected', vm.booking)
          }
        })

        let newSlots = []
        for (var j = 0; j < vm.slots.length; j++) {
          newSlots.push(vm.slots[j])
        }
      },

      onCancel () {
        this.$refs.modalDialog.hide()
        this.$emit('close')
      },

      onDialogClose () {
        let vm = this
        let selectionInfo = vm.getSelectionInfo()

        console.log('save() selectionInfo: ', selectionInfo)
        console.log('save() slot count = ' + vm.slots.length)
        let startSlot = vm.slots[selectionInfo.firstIndex]
        let endSlot = vm.slots[selectionInfo.lastIndex]
        console.log('save() startSlot: ', startSlot)
        console.log('save() endSlot: ', endSlot)

        let startMoment = startSlot.moment.clone()
        console.log('save() startMoment: ', startMoment.toString())

        let endMoment = endSlot.moment.clone()
        console.log('save() endMoment: ', endMoment.toString())

        let nextStartMoment = endMoment.clone().add(vm.intervals, 'minutes')
        console.log('save() nextStartMoment: ' + nextStartMoment.toString())
        vm.$emit('onResult', {
          dialog: 'yoovTimelineSelectionModal',
          payload: {
            mode: vm.mode,
            startMoment: startMoment,
            startedAt: startMoment.format('Y-MM-DD HH:mm:ss'),
            endMoment: endMoment,
            endedAt: nextStartMoment.format('Y-MM-DD HH:mm:ss')
          }
        })
      },

      onOk () {
        let vm = this
        let selectionInfo = vm.getSelectionInfo()

        if ((selectionInfo.selection.length === 0) && (vm.booking.id !== 0)) {
          vm.$dialog.confirm('No time slots selected! Schedule will be removed. Are you sure?', {
            okText: 'Yes',
            cancelText: 'No'
          })
          .then(function () {
            vm.onDialogClose()
          })
          .catch(function () {
            vm.$refs.modalDialog.show()
          })
        } else {
          vm.onDialogClose()
        }
      }
    },
    mounted () {
      console.log('YoovTimelineSelectionDialog :: mounted')
      let vm = this
      vm.$refs.timeSlots.onselectstart = function () { return false }
      // if (vm.currentMoment) {
      //   vm.showingMoment = vm.currentMoment
      //
      //   vm.startMoment = vm.showingMoment.clone()
      //   vm.startMoment.set({hour: vm.startHour, minute: 0, second: 0})
      //
      //   vm.endMoment = vm.showingMoment.clone()
      //   vm.endMoment.set({hour: vm.endHour, minute: 0, second: 0})
      //   // console.log('mounted :: startMoment: ' + vm.startMoment.toString())
      //   // console.log('mounted :: endMoment: ' + vm.endMoment.toString())
      //
      //   let loopMoment = vm.startMoment.clone()
      //   vm.slots = []
      //   while (loopMoment < vm.endMoment) {
      //     let moment = loopMoment.clone()
      //     // console.log('mounted :: assign to slots: ' + moment.toString())
      //     vm.slots.push({
      //       moment: moment,
      //       label: moment.format('hh:mm a'),
      //       selected: false,
      //       occupied: false
      //     })
      //     loopMoment.add('15', 'minutes')
      //   }
      //   vm.updateTimeSlots()
      // }
    },
    watch: {
      currentMoment: {
        handler: function (value) {
          let vm = this
          console.log('watch(currentMoment) : value:', value)
          console.log('watch(currentMoment) : currentMoment:', vm.currentMoment)
          console.log('watch(showingMoment) : showingMoment:', vm.showingMoment)
          vm.showingMoment = value
          vm.updateTimeSlots()
        },
        deep: true
      },
      showingMoment: {
        handler: (value) => {
          console.log('showingMoment :: value:', value)
        },
        deep: true
      },
      open: function (value) {
        if (value) {
          this.$refs.modalDialog.show()
        }
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
  #yoovTimelineSelectionModal .current-date {
    line-height: 1;
  }

  #yoovTimelineSelectionModal .current-date .weekday-label {
    font-weight: bold;
    font-size: 14px;
    padding-top: 4px;
    text-transform: uppercase;
  }

  #yoovTimelineSelectionModal .modal-dialog {
    max-width: 600px;
  }
  #yoovTimelineSelectionModal .modal-container {
    width: 560px;
  }

  #yoovTimelineSelectionModal .current-date span {
    padding: 0;
    margin: 0;
  }
  #yoovTimelineSelectionModal .time-slots {

  }

  #yoovTimelineSelectionModal .time-slots .timeslot {
    height: 25px;
    font-size: 9px;
  }

  #yoovTimelineSelectionModal .time-slots td div.timeslot {
    min-width:30px;
    padding:0 5px;
    text-align:center;
    border-right: 1px solid transparent;
    border-bottom: 1px solid white;
    background-color: rgba(200,200,200,.3);
    cursor: pointer;
    position: relative;
  }

  #yoovTimelineSelectionModal .time-slots div.timeslot div.timeslot-label {
    margin-top: -3px;
    position:absolute;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: transparent;
  }

  #yoovTimelineSelectionModal .time-slots td {
    vertical-align: top;
  }

  #yoovTimelineSelectionModal .time-slots td div.occupied {
    cursor: default;
    background-color: darkgray;
    color: white;
  }

  #yoovTimelineSelectionModal .time-slots td div.occupied:hover {
    background-color: darkgray;
    color: white;
  }

  #yoovTimelineSelectionModal .time-slots td div:hover {
    background-color: #a2c1cc;
  }

  #yoovTimelineSelectionModal .time-slots td div.selected {
    background-color: #28a745;
    color: white;
  }

  #yoovTimelineSelectionModal .time-slots td div.selected:hover {
    background-color: #468499;
  }

  #yoovTimelineSelectionModal .footnote {
    margin-left:10px;
  }

  #yoovTimelineSelectionModal .modal-footer button {
    min-width: 80px;
  }

</style>
