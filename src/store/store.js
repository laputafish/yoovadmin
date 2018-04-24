import Vue from 'vue'
import Vuex from 'vuex'
import system from './modules/system'
import actions from './actions'

Vue.use(Vuex)
const debug = process.env.NODE_ENV !== 'production'

export const store = new Vuex.Store({
  actions,
  modules: {
    system
  },
  strict: debug
})
