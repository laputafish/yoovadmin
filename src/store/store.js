import Vue from 'vue'
import Vuex from 'vuex'
import data from './data.json'

Vue.use(Vuex)

export const store = new Vuex.Store({
  state: data,
  getter: {
    products: (state) => {
      return state.products
    }
  },
  mutations: {},
  actions: {}
})
