import * as types from '../mutation-types'
import data from './data.json'

const state = {
  ...data,
  activeMenu: ''
}

const getters = {
  products: (state) => {
    return state.products
  }
}

const actions = {
}

const mutations = {
  [types.SET_ACTIVE_MENU] (state, data) {
    state.activeMenu = data
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
