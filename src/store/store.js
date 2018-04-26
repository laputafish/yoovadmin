import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'
import system from './modules/system'

Vue.use(Vuex)
const debug = process.env.NODE_ENV !== 'production'

export const store = new Vuex.Store({
  modules: {
    system
  },
  plugins: [createPersistedState],
  strict: debug
})
