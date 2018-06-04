<template>
  <yoov-modal id="yoovTimelineSelectionDialog"
    :class="{'is-owner':booking.applicant_id===user.id,'mobile':isMobile}">
    <div slot="header" class="flex-grow-1 d-flex flex-row">
      <h3 class="dialog-title mr-auto" style="margin-top:7px;">
        Select Timeline
      </h3>
      <div class="text-center float-right"
        v-if="isMobile">
        <button :disabled="booking.id===0 || booking.applicant_id!==user.id"
                class="btn btn-danger"
                @click="deleteBooking(booking)">
          Delete
        </button>
        <button :disabled="selectionInfo.selection.length===0 || booking.description==='' || booking.applicant_name==='' || booking.applicant_id!==user.id"
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
    <div slot="body" class="container yoov-modal-body"
      :class="{'mobile':$mq==='mobile'}">
      <div class="input-group row">
        <label class="col-3 col-form-label" for="applicantName">Applicant</label>
        <input v-validate="'required'"
               :disabled="true"
               name="applicantName"
               class="col-9 form-control-readonly"
               v-model="booking.applicant.name"/>
      </div>
      <div class="input-group row">
        <label class="col-3 col-form-label" for="description">Description</label>
        <input v-validate="'required'"
               name="description"
               :disabled="!haveAccess"
               :class="{'error-input':errors.has('description'), 'form-control':haveAccess, 'form-control-readonly':!haveAccess}"
               class="col-9"
               v-model="booking.description"/>
      </div>
      <hr style="margin-top:0.5rem;margin-bottom:8px;"/>

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
            <span class="date-label">{{ currentDay }}</span>
            <span class="weekday-label">{{ showingMoment ? showingMoment.format('ddd') : '' }}</span>
            <br/>
            <span v-if="selectionInfo.selection.length>0"
              class="selection-status">
              {{ selectionInfo.fromLabel }}
              <span v-show="!isMobile">&nbsp;</span>
              <i class="fa fa-minus"></i>
              <span v-show="!isMobile">&nbsp;</span>
              <span class="badge badge-info selection-duration">
                {{ selectionInfo.durationStr }}
              </span>
              <span v-show="!isMobile">&nbsp;</span>
              <i class="fa fa-minus"></i>
              <span v-show="!isMobile">&nbsp;</span>
              {{ selectionInfo.toLabel }}
            </span>
            <span v-else class="selection-status">
              ???
              &nbsp;<i class="fa fa-minus"></i>&nbsp;
              <span class="badge badge-info selection-duration">
                ???
              </span>
              &nbsp;<i class="fa fa-minus"></i>&nbsp;
              ???
            </span>
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
      <div ref="timeSlots" class="time-slots">
        <hr style="margin-top:0.3rem;margin-bottom:5px;"/>
        <table style="width:100%;margin-top:0;">
          <tr>
            <td v-for="column in timeSlots">
              <div v-for="item in column"
                   @dblclick.stop="onSlotDblClick(item)"
                   class="timeslot"
                   :class="{selected:item.selected,occupied:item.occupied,'blank-slot':!item.label}"
                   @mousedown="onSlotMouseDown(item)"
                   @mouseup="selecting=false"
                   @mousemove="onSlotMouseMove(item)">
                <div class="timeslot-label"
                     v-if="item.label">{{ item.label }}
                  <span v-show="!isMobile"> ...</span>
                </div>
              </div>
            </td>
          </tr>
        </table>
      </div>
      <small class="footnote align-self-start">* double-click to reset start point</small>
    </div>
    <div slot="footer" style="width:100%;" class="mt-0 pt-0">
      <div class="text-center">
        <button :disabled="booking.id===0 || booking.applicant_id!==user.id"
                class="btn btn-danger"
                @click="deleteBooking(booking)">
          Delete
        </button>
        <button :disabled="selectionInfo.selection.length===0 || booking.description==='' || booking.applicant_name==='' || booking.applicant_id!==user.id"
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
//  import {EventBus} from '@/event-bus'

  export default {
    data () {
      return {
        pendingForFirstClick: true,
        firstClick: false,
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
        slots: []
      }
    },
    props: {
      currentMoment: null,
      booking: null,
      mode: null
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
        this.pendingForFirstClick = true
        // console.log('onPrevButtonClicked :: showingMoment: ', this.showingMoment.toString())
      },
      onNextButtonClicked () {
        let newMoment = this.showingMoment.clone()
        newMoment.add(1, 'days')
        this.showingMoment = newMoment
        // this.showingMoment.add(1, 'days')
        this.updateTimeSlots()
        this.pendingForFirstClick = true
        // console.log('onNextButtonClicked :: showingMoment: ', this.showingMoment.toString())
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
      onSlotDblClick (item) {
        let vm = this
        if (item.label) {
          vm.pendingForFirstClick = false
          vm.clearSelection()
          item.selected = true
          // console.log('onSlotDblClick')
        }
      },
      onSlotMouseMove (item) {
        let vm = this
        if (item.label) {
          if (vm.haveAccess) {
            if (vm.selecting) {
              let index = vm.slots.indexOf(item)
              console.log('onSlotMouseMove: index = ' + index)
              if (index > 0) {
                if (vm.slots[index - 1].selected) {
                  item.selected = !item.occupied
                }
              }
            }
          }
        }
      },
      onSlotMouseDown (item) {
        let vm = this
        if (item.label) {
          if (!item.occupied && vm.haveAccess) {
            let index = vm.slots.indexOf(item)
            let {firstIndex, lastIndex, selection} = vm.selectionInfo

            let i
            if (selection.length === 0) {
              item.selected = true
            } else {
              if (index === firstIndex || index === firstIndex - 1 || index === lastIndex || index === lastIndex + 1) {
                vm.slots[index].selected = !vm.slots[index].selected
              } else if (index > firstIndex && index < lastIndex) {
                vm.clearSelection()
                item.selected = true
              } else if (index < firstIndex) {
                if (vm.pendingForFirstClick) {
                  vm.clearSelection()
                  item.selected = true
                } else {
                  if (vm.getOccupiedCount(index + 1, firstIndex - 1) === 0) {
                    for (i = index; i < firstIndex; i++) {
                      vm.slots[i].selected = true
                    }
                  } else {
                    vm.clearSelection()
                    item.selected = true
                  }
                }
              } else if (index > lastIndex) {
                console.log('index > lastIndex : pendingForFirstClick: ' + vm.pendingForFirstClick)
                if (vm.pendingForFirstClick) {
                  vm.clearSelection()
                  item.selected = true
                } else {
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
            }
            vm.$validator.validate()
            vm.pendingForFirstClick = false
            if (item.selected) {
              vm.selecting = true
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
          let slotStartMoment = vm.slots[i].moment
          let slotEndMoment = slotStartMoment.clone().add(15, 'minutes')
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
          // console.log('updateTimeSlots :: GET_DAY_BOOKINGS: bookings: ', bookings)
          for (var i = 0; i < bookings.length; i++) {
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

      deleteBooking (booking) {
        let vm = this
        vm.$dialog.confirm({
          title: 'Booking Cancellation',
          body: 'Are you sure?'
        }, {
          okText: 'Yes',
          cancelText: 'No'
        }).then(function () {
          vm.$emit('onResult', {
            dialog: 'yoovTimelineSelectionDialog',
            command: 'delete',
            payload: {
              id: vm.booking.id
            }
          })
        })
      },

      save () {
        let vm = this
//        let selectionInfo = vm.getSelectionInfo()
        console.log('save() selectionInfo: ', vm.selectionInfo)
        console.log('save() slot count = ' + vm.slots.length)
        let startSlot = vm.slots[vm.selectionInfo.firstIndex]
        let endSlot = vm.slots[vm.selectionInfo.lastIndex]
        console.log('save() startSlot: ', startSlot)
        console.log('save() endSlot: ', endSlot)

        let startMoment = startSlot.moment.clone()
        console.log('save() startMoment: ', startMoment.toString())

        let endMoment = endSlot.moment.clone()
        console.log('save() endMoment: ', endMoment.toString())

        let nextStartMoment = endMoment.clone().add(vm.intervals, 'minutes')
        console.log('save() nextStartMoment: ' + nextStartMoment.toString())

        // vm.booking.started_at = startMoment.format('Y-MM-DD HH:mm:ss')
        // vm.booking.ended_at = endMoment.format('Y-MM-DD HH:mm:ss')
        vm.$emit('onResult', {
          dialog: 'yoovTimelineSelectionDialog',
          command: 'save',
          payload: {
            mode: vm.mode,
            startedAt: startMoment.format('Y-MM-DD HH:mm:ss'),
            endedAt: nextStartMoment.format('Y-MM-DD HH:mm:ss'),
            booking: vm.booking
            // startMoment: startMoment,
            // startedAt: startMoment.format('Y-MM-DD HH:mm:ss'),
            // endMoment: endMoment,
            // endedAt: nextStartMoment.format('Y-MM-DD HH:mm:ss')
          }
        })
      }
    },
    mounted () {
      console.log('YoovTimelineSelectionDialog :: mounted')
      let vm = this
      vm.$refs.timeSlots.onselectstart = function () { return false }
      if (vm.currentMoment) {
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
      }
    },
    // watched: {
    //   showingMoment: {
    //     handler: (value) => {
    //       console.log('showingMoment :: value:', value)
    //     },
    //     deep: true
    //   }
    // },
    computed: {
      isMobile () {
        return this.$mq === 'mobile'
      },
      haveAccess () {
        return this.booking.applicant_id === this.user.id
      },
      user () {
        return this.$store.getters.user
      },
      selectionInfo () {
        let vm = this
        let selection = []
        let first = -1
        let last = -1
        let durationItems = []
        let durationStr = ''
        let totalMin = 0
        let fromLabel = ''
        let toLabel = ''

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

        if (first !== -1 && last !== -1) {
          totalMin = (last - first + 1) * 15
          let hours = Math.floor(totalMin / 60)
          let mins = totalMin - hours * 60
          if (hours > 0) {
            durationItems.push(hours + ' hours')
          }
          if (mins > 0) {
            durationItems.push(mins + ' mins')
          }
          fromLabel = vm.slots[first].label

          let toMoment = vm.slots[last].moment.clone().add(vm.intervals, 'minutes')
          toLabel = toMoment.format('hh:mm a')
          durationStr = durationItems.join(' ')
        }

        return {
          firstIndex: first,
          lastIndex: last,
          selection: selection,
          fromLabel: fromLabel,
          toLabel: toLabel,
          duration: totalMin,
          durationStr: durationStr
        }
      },
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

#yoovTimelineSelectionDialog .current-date .date-label {
  font-size: 14px;
}
#yoovTimelineSelectionDialog .current-date .weekday-label {
  font-weight: bold;
  font-size: 14px;
  padding-top: 4px;
  text-transform: uppercase;
}

#yoovTimelineSelectionDialog .modal-body {
  padding: 0.5rem;
}

#yoovTimelineSelectionDialog .modal-container {
  width: 98%;
  max-width: 600px;
}

#yoovTimelineSelectionDialog .current-date span {
  padding: 0;
  margin: 0;
}

#yoovTimelineSelectionDialog.is-owner .time-slots td div.timeslot {
  cursor: pointer
}

#yoovTimelineSelectionDialog .time-slots td div.timeslot {
  height: 25px;
  font-size: 9px;
  min-width:30px;
  padding:0 5px;
  text-align:center;
  border-right: 1px solid transparent;
  border-bottom: 1px solid white;
  background-color: rgba(200,200,200,.3);
  cursor: default;
  position: relative;
}

#yoovTimelineSelectionDialog .time-slots td div.timeslot.blank-slot {
  cursor: default;
}

#yoovTimelineSelectionDialog .time-slots td div.timeslot div.timeslot-label {
  margin-top: -2px;
  font-size: 9px;
  position:absolute;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  background-color: transparent;
}

#yoovTimelineSelectionDialog .time-slots td {
  vertical-align: top;
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
  background-color: #186429;
  color: white;
}
#yoovTimelineSelectionDialog.is-owner .time-slots td div.selected {
  background-color: #28a745;
  color: white;
}

#yoovTimelineSelectionDialog .time-slots td div.selected:hover {
  background-color: #468499;
}

#yoovTimelineSelectionDialog .footnote {
    margin-left:10px;
}

#yoovTimelineSelectionDialog .modal-footer button {
  min-width: 80px;
}
#yoovTimelineSelectionDialog .modal-footer button:disabled {
  cursor: default
}
#yoovTimelineSelectionDialog .error-input {
  border-color: red;
}
#yoovTimelineSelectionDialog .selection-status {
  font-size:8px;
}
#yoovTimelineSelectionDialog .selection-status .selection-duration {
  padding: 3px;
}
.yoov-modal-body .input-group {
  margin-bottom: 3px;
}
.yoov-modal-body .input-group input.form-control-readonly {
  background-color: rgba(0,0,0,.05);
  border: lightgray 1px solid;
}

#yoovTimelineSelectionDialog .modal-header {
  padding: 0;
}
/*#yoovTimelineSelectionDialog .modal-header h3 {*/
  /*font-size: 18px;*/
/*}*/
@media(min-width:560px) {
  #yoovTimelineSelectionDialog .modal-header {
    padding: 0.5rem;
  }

  /*#yoovTimelineSelectionDialog .modal-header h3 {*/
    /*font-size: 28px;*/
  /*}*/
}

#yoovTimelineSelectionDialog.mobile .modal-header h3 {
  font-size: 20px;
}
#yoovTimelineSelectionDialog.mobile .modal-header {
  padding: 2px;
}
#yoovTimelineSelectionDialog.mobile .modal-footer {
  display: none;
}
#yoovTimelineSelectionDialog.mobile .modal-header button {
  padding: 7px;
  min-width:50px;
}
#yoovTimelineSelectionDialog.mobile .yoov-modal-body {
  padding: 0;
}
#yoovTimelineSelectionDialog.mobile .yoov-modal-body .row {
  margin: 0;
}
#yoovTimelineSelectionDialog.mobile .yoov-modal-body .col-form-label {
  padding: 0;
}
#yoovTimelineSelectionDialog.mobile .yoov-modal-body .input-group input.form-control-readonly {
  padding: 0.375rem 0.75rem;
}
#yoovTimelineSelectionDialog.mobile .yoov-modal-body .btn-prev,
#yoovTimelineSelectionDialog.mobile .yoov-modal-body .btn-next {
  min-width: 40px;
}
</style>

