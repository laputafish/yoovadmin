import Vue from 'vue'
import Vuex from 'vuex'
import system from './modules/system/system'
import meetingRooms from './modules/meetingRooms/meetingRooms'
import meetings from './modules/meetings/meetings'

Vue.use(Vuex)
const debug = process.env.NODE_ENV !== 'production'

export const store = new Vuex.Store({
  modules: {
    system,
    meetingRooms,
    meetings
  },
  strict: debug
})
