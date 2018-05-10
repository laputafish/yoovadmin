import Vue from 'vue'
import Vuex from 'vuex'
import system from './modules/system'
import meetingRooms from './modules/meetingRooms'

Vue.use(Vuex)
const debug = process.env.NODE_ENV !== 'production'

export const store = new Vuex.Store({
  modules: {
    system,
    meetingRooms
  },
  strict: debug
})
