import * as types from '../mutation-types'
import data from './data.json'

const state = {
  ...data,
  activeMenu: ''
}

const getters = {
  products: (state) => {
    return state.products
  },
  categoryTree: (state) => {
    return {
      id: 0,
      name: 'root',
      children: state.categories
    }
  }
}

const actions = {
}

function containsChild (parent, category) {
  let result = false
  for (var i = 0; i < parent.children.length; i++) {
    if (parent.children[i].id === category.id) {
      result = true
      break
    }
  }
  return result
}

function getCategoryParent (category, categories) {
  if (typeof categories === 'undefined') {
    categories = state.categories
  }
  let result = null
  for (var i = 0; i < categories.length; i++) {
    if (containsChild(categories[i], category)) {
      result = categories[i]
      break
    }
  }
  return result
}

function getCategory (categoryId, categories) {
  if (typeof categories === 'undefined') {
    categories = state.categories
  }
  let result = null
  for (var i = 0; i < categories.length; i++) {
    console.log('#' + i + ': ' + categories[i].name)
    if (categories[i].id === categoryId) {
      result = categories[i]
    } else {
      if (categories[i].children && categories[i].children.length > 0) {
        result = getCategory(categoryId, categories[i].children)
      }
    }
    if (result) {
      break
    }
  }
  return result
}

function moveCategory (category, afterParent, beforeParent) {
  // remove child from before parent
  for (var i = 0; i < beforeParent.children.length; i++) {
    if (beforeParent.children[i].id === category.id) {
      beforeParent.children.splice(i, 1)
      break
    }
  }
  // add child to after parent
  afterParent.children.push(category)
}

const mutations = {
  [types.SET_ACTIVE_MENU] (state, data) {
    state.activeMenu = data
  },
  [types.REPOSITION_CATEGORY] (state, payload) {
    let afterParent = getCategory(payload.afterParent.id)
    let beforeParent = getCategory(payload.beforeParent.id)
    let item = getCategory(payload.data.id)

    let currentParent = getCategoryParent(item)

    if (currentParent.id !== afterParent.id) {
      moveCategory(item, afterParent, beforeParent)
    }
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
