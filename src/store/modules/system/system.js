import * as types from './system_types'
import data from '../data.json'
// import * as constants from '../../constants'
// import axios from 'axios'

const state = {
  ...data,
  user: null,
  activeMenu: ''
}

const getters = {
  token (state) {
    return localStorage.getItem('token')
  },
  user (state) {
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

// function containsChild (parent, category) {
//   console.log('containsChild :: parent.name = ' + parent.name)
//   let result = null
//   if (parent.children) {
//     for (var i = 0; i < parent.children.length; i++) {
//       console.log('containsChild :: parent.children[' + i + ']: ' + parent.children[i].name)
//       if (parent.children[i].id === category.id) {
//         result = parent
//         console.log('*** found')
//         break
//       } else {
//         result = containsChild(parent.children[i], category)
//         if (result) {
//           console.log('*** found')
//           break
//         }
//       }
//     }
//   }
//   return result
// }
//
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

// function getCategory (categoryId, categories) {
//   if (typeof categories === 'undefined') {
//     categories = state.categories
//   }
//   let result = null
//   for (var i = 0; i < categories.length; i++) {
//     console.log('#' + i + ': ' + categories[i].name)
//     if (categories[i].id === categoryId) {
//       result = categories[i]
//     } else {
//       if (categories[i].children && categories[i].children.length > 0) {
//         result = getCategory(categoryId, categories[i].children)
//       }
//     }
//     if (result) {
//       break
//     }
//   }
//   return result
// }

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
  [types.SET_USER] (state, data) {
    state.user = data
  },
  setToken (state, payload) {
    localStorage.setItem('token', payload)
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
  },
  setUser (state, payload) {
    state.user = payload
    console.log('setUser :: payload: ', payload)
  }
}

const actions = {
  [types.SET_TOKEN] ({commit}, payload) {
    commit('setToken', payload)
  },

  [types.SET_USER] ({commit}, payload) {
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
