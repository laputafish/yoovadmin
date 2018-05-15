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
              <hr/>
              <table style="width:100%;">
                <tbody>
                  <tr>
                    <td colspan="7" class="d-flex flex-row" style="width: 100%;">
                      <button type="button" class="btn btn-primary justify-content-start">
                        <i class="fa fa-fw fa-caret-left"></i>
                      </button>
                      <button type="button" class="btn btn-primary justify-content-end">
                        <i class="fa fa-fw fa-caret-right"></i>
                      </button>
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
      rooms: [
        { name: 'Room 201', capacity: 2, equipments: 'sdlfksdjlf jsdljf sdlkf jlsdkj fslkdf sdsd fklsd fsdkf sdfk sdfk dskfsdkfsdk fksd fksdfksd fsd kfksdkf ksdfksd kf sdf' },
        { name: 'Room 202', capacity: 3, equipments: '' },
        { name: 'Room 203', capacity: 4, equipments: '' },
        { name: 'Room 204', capacity: 5, equipments: '' },
        { name: 'Room 205', capacity: 6, equipments: '' }
      ]
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

</style>