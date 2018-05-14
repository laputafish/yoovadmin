import Cookie from 'cookie'
import Cookies from 'js-cookie'
import * as types from './system_types'
import data from '../data.json'
import * as constants from '../../constants'
// import axios from 'axios'
import Vue from 'vue'

const state = {
  ...data,
  token: null,
  user: null,
  activeMenu: ''
}

const getters = {
  token (state) {
    return state.token
    // console.log('getters.token')
    // return localStorage.getItem('token')
  },
  loggedIn (state) {
    console.log('getters.loggedIn')
    return Boolean(state.user && state.token)
  },
  user (state) {
    console.log('getters.user')
    return state.user
  },
  productsByCategory (state) {
    return (categoryId) => {
      return state.products.filter((product) => {
        return product.category_id === categoryId
      })
    }
  },
  categoryTree: (state) => {
    return state.categoryRoot
  }
}

function getCategory (categoryId, categoryNode) {
  if (typeof categoryNode === 'undefined') {
    categoryNode = state.categoryRoot
  }
  let result = null
  if (categoryId === categoryNode.id) {
    result = categoryNode
  } else {
    if (categoryNode.children) {
      for (var i = 0; i < categoryNode.children.length; i++) {
        var child = categoryNode.children[i]
        console.log('getCategory i=' + i + ': child.name = ' + child.name)
        result = getCategory(categoryId, child)
        if (result) {
          break
        }
        //
        // if (child.id === categoryId) {
        //   result = child
        //   break
        // } else {
        //   console.log('getCategory :: child: ', child)
        //   if (child.children) {
        //     result = getCategory(categoryId, child)
        //     if (result) {
        //       break
        //     }
        //   }
        // }
      }
    }
  }
  return result
}

function getCategoryParent (categoryId, categoryNode) {
  console.log('getCategoryParent :: categoryId: ', categoryId)
  if (typeof categoryNode === 'undefined') {
    categoryNode = state.categoryRoot
  }
  let result = null
  console.log('getCategoryParent :: categoryNode.children.length = ' + categoryNode.children.length)
  for (var i = 0; i < categoryNode.children.length; i++) {
    var children = categoryNode.children[i]
    console.log('check i=' + i + ' child#' + children.id + ' "' + children.name)
    if (children.id === categoryId) {
      result = categoryNode
      break
    } else {
      if (children.children) {
        result = getCategoryParent(categoryId, children)
        if (result) {
          break
        }
      }
    }
  }
  return result
}

function moveCategory (category, afterParent, beforeParent) {
  // remove child from before parent
  console.log('moveCategory: beforeParent: ', beforeParent)
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

  setUser (state, payload) {
    state.user = payload.user
    if (typeof payload.callback === 'function') {
      payload.callback(true)
    }
  },
  setToken (state, token) {
    localStorage.setItem('token', token)
    state.token = token
    Vue.axios.defaults.headers.common['Authorization'] = 'Bearer ' + token
    Vue.axios.defaults.headers.common['Content-Type'] = 'application/json'
    Vue.axios.defaults.headers.common['Accept'] = 'application/json'
    console.log('setToken :: localStorage.setItem :: token = ' + token)
  },
  [types.SET_ACTIVE_MENU] (state, data) {
    state.activeMenu = data
  },
  [types.REPOSITION_CATEGORY] (state, payload) {
    let afterParent = getCategory(payload.afterParent.id)
    let beforeParent = getCategory(payload.beforeParent.id)
    let item = getCategory(payload.data.id)

    console.log('REPOSITION_CATEGORY : afterParent.id = ' + payload.afterParent.id)
    console.log('REPOSITION_CATEGORY : beforeParent.id = ' + payload.beforeParent.id)

    console.log('system.js :: REPOSITION_CATEGORY :: item: ', item)
    let currentParent = getCategoryParent(item)
    console.log('system.js :: REPOSITION_CATEGORY :: currentParent is ' + currentParent.name)

    if (currentParent.id !== afterParent.id) {
      moveCategory(item, afterParent, beforeParent)
    }
  },
  removeCategoryChild (state, payload) {
    let parentId = payload.parentId
    let itemId = payload.itemId
    console.log('removeCategoryChild :: parentId = ' + parentId)
    console.log('removeCategoryChild :: itemId = ' + itemId)
    let parent = getCategory(parentId)
    let item = getCategory(itemId)

    let index = parent.children.indexOf(item)
    console.log('removeCategoryChild :: index = ' + index)

    parent.children.splice(index, 1)
  },
  appendCategoryChild (state, payload) {
    let parentId = payload.parentId
    let item = payload.item
    let parent = getCategory(parentId)
    if (!parent.children) {
      parent.children = []
    }
    parent.children.push(item)
  },
  insertCategoryChild (state, payload) {
    let parentId = payload.parentId
    let item = payload.item
    let index = payload.index

    let parent = getCategory(parentId)
    if (!parent.children) {
      parent.children = []
    }
    parent.children.splice(index, 0, item)
  }
}

const actions = {
  async checkToken ({ commit, getters, dispatch }, payload) {
    let token = localStorage.getItem('token')
    this.token = token
    dispatch(types.SET_TOKEN, token)
    console.log('checkToken :: token=' + getters.token)
    let result = false
    if (token) {
      Vue.axios.defaults.headers.common['Authorization'] = 'Bearer ' + token
      Vue.axios.defaults.headers.common['Content-Type'] = 'application/json'
      Vue.axios.defaults.headers.common['Accept'] = 'application/json'
      console.log('getters.token')
      await dispatch('fetchUser')
      if (getters.user) {
        console.log('getters.user')
        result = true
      } else {
        console.log('not getters.user')
      }
    } else {
      console.log('not getters.token')
    }
    if (typeof payload.callback === 'function') {
      console.log('payload.callback === function')
      payload.callback(result)
    }
  },

  [types.SET_TOKEN] ({commit}, token) {
    commit('setToken', token)
    if (!token) {
      Vue.axios.defaults.headers.common['Authorization'] = ''
      Vue.axios.defaults.headers.common['Content-Type'] = ''
      Vue.axios.defaults.headers.common['Accept'] = ''
    }
  },

  async nuxtServerInit ({dispatch}, {req}) {
    await dispatch('fetch')
  },

  // Update token
  async updateToken ({ commit }, token) {
    console.log('updateToken starts')
    // Update token in store's state
    commit('setToken', token)
    // Set Authorization token for all axios requests
    // await axios.this.$axios.setToken(token, '')
    // Update cookies
    console.log('updateToken :: process.browser: ', process.browser)
    if (process.browser) {
      console.log('with process.browser')
      // ...Browser
      if (token) {
        Cookies.set('ccmsToken', token, { expires: 1 })
      } else {
        Cookies.remove('ccmsToken')
      }
    } else {
      console.log('without process.browser')
      // ...Server
      let params = {
        domain: '/'
      }
      if (!token) {
        let expires
        let date = new Date()
        expires = date.setDate(date.getDate() + 1)
        params.expires = new Date(expires)
      }
    }
    Vue.axios.defaults.headers.common['Authorization'] = 'Bearer ' + token
    Vue.axios.defaults.headers.common['Content-Type'] = 'application/json'
    Vue.axios.defaults.headers.common['Accept'] = 'application/json'
    // this.app.context.res.setHeader('Authorization', Cookie.serialize('ccmsToken', token, params))
    // console.log('Axios: ', this.$axios.defaults.headers.common.Authorization)
    console.log('updateToken ends')
  },

  // Fetch Token
  async fetchToken ({ dispatch }) {
    let token
    // Try to extract token from cookies
    if (!token) {
      const cookieStr = process.browser ? document.cookie : this.app.context.req.headers.cookie
      const cookies = Cookie.parse(cookieStr || '') || {}
      token = cookies['ccmsToken']
    }
    if (token) {
      await dispatch('updateToken', token)
    }
    if (process.browser) {
      console.log('Browser token: ', token)
    } else {
      console.log('Server token: ', token)
    }
  },

  // Reset
  async reset ({ dispatch, commit }) {
    commit('setUser', null)
    await dispatch('updateToken', null)
  },

  // Fetch
//  async fetch ({ getters, state, commit, dispatch }, username = 'admin', {
  async fetchUser ({ getters, state, commit, dispatch }, callback) {
    console.log('fetchUser')
    // let token = getters.token
    let url = constants.apiUrl + '/user'
//     console.log('fetch')
// //    endpoint = 'https://climatecms-api.herokuapp.com/api/user' } = {}) {
//     // Fetch and update latest token
//     await dispatch('fetchToken')
//     // Skip if there is no token set
//     if (!state.token) {
//       return
//     }

    // Try to get user profile
    try {
      console.log('fetchUser :: axios.get("' + url + '")')
      await Vue.axios.get(url).then(function (response) {
        console.log('fetchUser :: after get: response: ', response)
        dispatch(types.SET_USER, {
          user: response.data,
          callback: callback
        })
      })
    } catch (e) {
      // Reset store
      // await dispatch('reset')
    }
    console.log('fetchUser ends')
  },

  async fetch ({ getters, state, commit, dispatch }) {
    console.log('fetch')
    let url = constants.apiUrl + '/user'
//    endpoint = 'https://climatecms-api.herokuapp.com/api/user' } = {}) {
    // Fetch and update latest token
    await dispatch('fetchToken')
    // Skip if there is no token set
    if (!state.token) {
      return
    }

    // Try to get user profile
    try {
      await Vue.axios.get(url).then(function (response) {
        commit('setUser', response.data.user)
      })
//      commit('setUser', data)
    } catch (e) {
      // Reset store
      await dispatch('reset')
    }
  },

  // Login
  /*
          let url = constants.apiUrl + '/auth'
        axios.post(url, vm.credentials).then(function (response) {
          let data = response.data
          if (data.status === 'ok') {
            vm.$store.dispatch('SET_USER', data.user)
            vm.$router.push({name: 'Meetings'})
          } else {
            vm.$dialog.alert('Access Denied!')
          }
        })
   */
//  async login ({ dispatch }, { fields, endpoint = 'https://climatecms-api.herokuapp.com/api/login' } = {}) {
  async login ({ commit, dispatch }, { credentials, callback }) {
    console.log('login : credentials: ', credentials)
    try {
      let url = constants.url + '/oauth/token'
      let data = {
        username: credentials.email,
        password: credentials.password,
        grant_type: 'password',
        client_id: constants.CLIENT_ID,
        client_secret: constants.CLIENT_SECRET
      }
      // Send credentials to API
      await Vue.axios.post(url, data).then(function (response) {
        console.log('/oauth/token: response: ', response)
        let data = response.data
//          commit('setUser', data.user)
        commit('setToken', data.access_token)
        // dispatch('updateToken', data.access_token)
        dispatch('fetchUser', callback)
//         if (typeof callback === 'function') {
//           console.log('login :: check callback is function')
// //          callback(data.status)
//         }
      }, function (error) {
        console.log('/oauth/token error: ', error)
      })
    } catch (error) {
      if (error.response && error.response.status === 401) {
        throw new Error('Bad credentials')
      }
      throw error
    }
  },

  // Logout
  async logout ({ dispatch, state }) {
    try {
      await dispatch('reset')
    } catch (e) {
      console.error('Error while logging out', e)
    }
  },

  [types.SET_USER] ({commit}, payload) {
    console.log('actions :: commit(setUser)')
    commit('setUser', payload)
  },

  [types.MOVE_PRODUCT_CATEGORY] (context, payload) {
    console.log('system.js actions[types.MOVE_PRODUCT_CATEGORY]')
    // let beforeParent = payload.beforeParent
    let afterParent = payload.afterParent
    let dataItem = payload.dataItem
    let targetIndex = payload.targetIndex
    // let childrenAttr = payload.childrenAttr
    // let originalIndex = beforeParent[childrenAttr].indexOf(dataItem)
    let dragToNode = payload.dragToNode

    // remove original node
    let beforeCategory = getCategoryParent(dataItem.id)
    console.log('MOVE_PRODUCT_CATEGORY ::  found beforeCategory: ' + beforeCategory.name)
    let originalIndex = beforeCategory.children.indexOf(dataItem)
    console.log('MOVE_PRODUCT_CATEGORY ::  originalIndex = ' + originalIndex)

    console.log('MOVE_PRODUCT_CATEGORY :: before commit removeCategoryChild')
    context.commit('removeCategoryChild', {
      parentId: beforeCategory.id,
      itemId: dataItem.id
    })
    console.log('MOVE_PRODUCT_CATEGORY :: after commit removeCategoryChild')
    // beforeCategory.children.splice(originalIndex, 1)

    let afterCategory = getCategory(afterParent.id)

    console.log('MOVE_PRODUCT_CATEGORY :: afterCategory = ' + afterCategory.name)
    console.log('MOVE_PRODUCT_CATEGORY :: dragToNode: ' + dragToNode)
    if (dragToNode) {
      console.log('MOVE_PRODUCT_CATEGORY :: afterCategory.children: ', afterCategory.children)
      context.commit('appendCategoryChild', {
        parentId: afterCategory.id,
        item: dataItem
      })
      // afterParent.children.push(dataItem)
    } else {
      if (beforeCategory.id === afterCategory.id) {
        if (targetIndex > originalIndex) {
          context.commit('insertCategoryChild', {
            parentId: afterCategory.id,
            item: dataItem,
            index: targetIndex - 1
          })
          // afterCategory.children.splice(targetIndex, 0, dataItem)
        } else {
          context.commit('insertCategoryChild', {
            parentId: afterCategory.id,
            item: dataItem,
            index: targetIndex
          })
//          afterCategory.children.splice(targetIndex - 1, 0, dataItem)
        }
      } else {
        context.commit('insertCategoryChild', {
          parentId: afterCategory.id,
          item: dataItem,
          index: targetIndex
        })
//        afterCategory.children.splice(targetIndex, 0, dataItem)
      }
    }
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
