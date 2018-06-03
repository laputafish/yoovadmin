import Cookie from 'cookie'
import Cookies from 'js-cookie'
import * as types from './system_types'
import data from '../data.json'
import * as constants from '../../constants'
import axios from 'axios'
import Vue from 'vue'

const state = {
  ...data,
  token: null,
  user: null,
  activeMenu: '',
  publicFolders: []
}

const transformFolders = folders => {
  let result = []
  for (var i = 0; i < folders.length; i++) {
    result.push({
      name: folders[i].name,
      expanded: true,
      children: folders[i].children ? transformFolders(folders[i].children) : []
    })
  }
  return result
}

const getters = {
  token (state) {
    return state.token
  },
  loggedIn (state) {
    console.log('store :: getters.loggedIn')
    return Boolean(state.user && state.token)
  },
  user (state) {
    console.log('store :: getters.user')
    return state.user
  },
  userFolders (state) {
    console.log('system.js :: getters.userFolders: state.user.folder: ', state.user.folder)
    let folder = state.user.folder
    let result = [{
      name: folder.name,
      expanded: true,
      children: folder.children ? transformFolders(folder.children) : []
    }]
    return result
  },
  publicScanFolder (state) {
    console.log('userScanFolder :: folders:', state.publicFolders)
    let result = null
    for (var i = 0; i < state.publicFolders.length; i++) {
      if (state.publicFolders[i].name === 'scan') {
        result = state.publicFolders[i]
        break
      }
    }
    return result
  },
  userScanFolder (state) {
    console.log('userScanFolder :: folders:', state.user.folders)
    let result = null
    for (var i = 0; i < state.user.folders.length; i++) {
      if (state.user.folders[i].name === 'scan') {
        result = state.user.folders[i]
        break
      }
    }
    return result
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
        console.log('store :: getCategory i=' + i + ': child.name = ' + child.name)
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
  console.log('store :: getCategoryParent :: categoryId: ', categoryId)
  if (typeof categoryNode === 'undefined') {
    categoryNode = state.categoryRoot
  }
  let result = null
  console.log('store :: getCategoryParent :: categoryNode.children.length = ' + categoryNode.children.length)
  for (var i = 0; i < categoryNode.children.length; i++) {
    var children = categoryNode.children[i]
    console.log('store :; getCategoryParent :: check i=' + i + ' child#' + children.id + ' "' + children.name)
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
  console.log('store :: moveCategory: beforeParent: ', beforeParent)
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
    console.log('store :: setToken :: localStorage.setItem :: token = ' + token)
  },
  [types.SET_ACTIVE_MENU] (state, data) {
    state.activeMenu = data
  },
  [types.REPOSITION_CATEGORY] (state, payload) {
    let afterParent = getCategory(payload.afterParent.id)
    let beforeParent = getCategory(payload.beforeParent.id)
    let item = getCategory(payload.data.id)

    console.log('store :: REPOSITION_CATEGORY : afterParent.id = ' + payload.afterParent.id)
    console.log('store :: REPOSITION_CATEGORY : beforeParent.id = ' + payload.beforeParent.id)

    console.log('store :: system.js :: REPOSITION_CATEGORY :: item: ', item)
    let currentParent = getCategoryParent(item)
    console.log('store :: system.js :: REPOSITION_CATEGORY :: currentParent is ' + currentParent.name)

    if (currentParent.id !== afterParent.id) {
      moveCategory(item, afterParent, beforeParent)
    }
  },
  removeCategoryChild (state, payload) {
    let parentId = payload.parentId
    let itemId = payload.itemId
    console.log('store :: removeCategoryChild :: parentId = ' + parentId)
    console.log('store :: removeCategoryChild :: itemId = ' + itemId)
    let parent = getCategory(parentId)
    let item = getCategory(itemId)

    let index = parent.children.indexOf(item)
    console.log('store :: removeCategoryChild :: index = ' + index)

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
  },
  setPublicFolders (state, payload) {
    state.publicFolders = payload
  }

}

const actions = {
  async checkToken ({ commit, getters, dispatch }, payload) {
    let token = localStorage.getItem('token')
    this.token = token
    dispatch(types.SET_TOKEN, token)
    console.log('store :: checkToken :: token=' + token.substr(0, 10))
    let result = false
    if (token) {
      Vue.axios.defaults.headers.common['Authorization'] = 'Bearer ' + token
      Vue.axios.defaults.headers.common['Content-Type'] = 'application/json'
      Vue.axios.defaults.headers.common['Accept'] = 'application/json'
      console.log('store :: checkToken :: getters.token')
      dispatch('fetchUser').then(function () {
        console.log('store :: fetchUser :: user:', getters.user)
        if (getters.user) {
          console.log('store :: checkToken :: getters.user')
          result = true
          if (typeof payload.callback === 'function') {
            console.log('store :: checkToken :: payload.callback === function')
            payload.callback(result)
          }
        } else {
          console.log('store :: checkToken :: not getters.user')
          if (typeof payload.callback === 'function') {
            console.log('store :: checkToken :: payload.callback === function')
            payload.callback(result)
          }
        }
      })
    } else {
      console.log('store :: checkToken :: not getters.token')
      if (typeof payload.callback === 'function') {
        console.log('store :: checkToken :: payload.callback === function')
        payload.callback(result)
      }
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
    console.log('store :: updatetoken => commit(updateToken) starts')
    // Update token in store's state
    commit('setToken', token)
    // Set Authorization token for all axios requests
    // await axios.this.$axios.setToken(token, '')
    // Update cookies
    console.log('store :: updateToken => commit(updateToken) :: process.browser: ', process.browser)
    if (process.browser) {
      console.log('store :: updateToken => commit(updateToken) :: with process.browser')
      // ...Browser
      if (token) {
        Cookies.set('ccmsToken', token, { expires: 1 })
      } else {
        Cookies.remove('ccmsToken')
      }
    } else {
      console.log('store commit(updateToken) :: without process.browser')
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
    console.log('store :: commit(updateToken) ends')
  },

  // Fetch Token
  async fetchToken ({ dispatch }) {
    console.log('store :: fetchToken')
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
      console.log('store :: fetchtoken :: Browser token: ' + getters.token.substr(0, 10))
    } else {
      console.log('store :: fetchtoken :: Server token: ' + getters.token.substr(0, 10))
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
    console.log('store :: fetchUser')
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
        }).then(function () {
          console.log('fetchUser >> dispatch(ser_user).then: user', getters.user)
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
  async login ({ commit, dispatch, getters }, { credentials, callback }) {
    console.log('store :: login starts :: credentials: ', credentials)
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
        console.log('store :: axios :: /oauth/token: response: ', response)
        let data = response.data
//          commit('setUser', data.user)
        console.log('store :: login >> commit(setToken)')
        commit('setToken', data.access_token)
        // dispatch('updateToken', data.access_token)
        console.log('store :: login >> dispatch(fetchUser)')
        dispatch('fetchUser', callback).then(function () {
          console.log('store :; login :: commit >> fetchUser :: user:', getters.user)
        })
//         if (typeof callback === 'function') {
//           console.log('login :: check callback is function')
// //          callback(data.status)
//         }
      }, function (error) {
        console.log('store :: login :: /oauth/token error: ', error)
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

  async [types.GET_PUBLIC_FOLDERS] ({commit}, payload) {
    let apiUrl = constants.apiUrl + '/folders'
    let data = {
      type: 'public'
    }
    await axios.get(apiUrl, {params: data}).then(function (response) {
      commit('setPublicFolders', response.data)
    })
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
