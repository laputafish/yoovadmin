import Vue from 'vue'
import Router from 'vue-router'

// Containers
import Full from '@/containers/Full'

// Views
import Dashboard from '@/views/Dashboard'
import Charts from '@/views/Charts'
import Widgets from '@/views/Widgets'

// View: /Auth
// import Login from '@/pages/login'
// import Register from '@/pages/register'

// View: /bootstrapcdn
import Alerts from '@/views/bootstrap/Alerts'
// import Alerts from '@/views/bootstrap/Alerts'
import Badge from '@/views/bootstrap/Badge'
import Breadcrumb from '@/views/bootstrap/Breadcrumb'
import BootstrapButtons from '@/views/bootstrap/Buttons'
import BootstrapButtonGroup from '@/views/bootstrap/ButtonGroup'
import BootstrapButtonToolbar from '@/views/bootstrap/ButtonToolbar'
import Carousel from '@/views/bootstrap/Carousel'
import Collapse from '@/views/bootstrap/Collapse'
import Dropdown from '@/views/bootstrap/Dropdown'
import BootstrapForms from '@/views/bootstrap/Forms'
import InputGroup from '@/views/bootstrap/InputGroup'
import Jumbotron from '@/views/bootstrap/Jumbotron'
import ListGroup from '@/views/bootstrap/ListGroup'
import Modal from '@/views/bootstrap/Modal'

// Application Modules
import AppContainer from '@/containers/AppContainer'
import ProductList from '@/views/products/ProductList'
import AttributeList from '@/views/attributes/AttributeList'
import BundleList from '@/views/bundles/BundleList'
import MenuSectionList from '@/views/menuSections/MenuSectionList'

import VToolTip from '@/views/vueplugins/VToolTip'

// View: /Components
import Buttons from '@/views/components/Buttons'
import SocialButtons from '@/views/components/SocialButtons'
import Cards from '@/views/components/Cards'
import Forms from '@/views/components/Forms'
import Modals from '@/views/components/Modals'
import Switches from '@/views/components/Switches'
import Tables from '@/views/components/Tables'

// Views - Custom
// Views - DragDropTree
import DragDropTree from '@/views/custom/DragDropTree'
import DraggableTree from '@/views/custom/DraggableTree'
import VueDragTree from '@/views/custom/VueDragTree'
import SortableTree from '@/views/custom/SortableTree'
import VueDraggable from '@/views/custom/VueDraggable'
import Vue2DataTable from '@/views/custom/Vue2DataTable'

// Views - Icons
import FontAwesome from '@/views/icons/FontAwesome'
import SimpleLineIcons from '@/views/icons/SimpleLineIcons'

// Views - pages
import Page404 from '@/views/pages/Page404'
import Page500 from '@/views/pages/Page500'
import Login from '@/views/pages/Login'
import Register from '@/views/pages/Register'

// Main Panel
// import ProductMenu from '@/views/MainPanel/ProductMenu'

// Views - header Pages
import HeaderPage1 from '@/views/headerPages/HeaderPage1'
import HeaderPage2 from '@/views/headerPages/HeaderPage2'
import HeaderPage3 from '@/views/headerPages/HeaderPage3'

// import jQuery from 'jquery'
// window.jQuery = jQuery
// window.$ = jQuery

Vue.use(Router)

export default new Router({
  mode: 'history',
  linkActiveClass: 'open active',
  scrollBehavior: () => ({ y: 0 }),
  routes: [
    {
      path: '/',
      redirect: '/dashboard',
      name: 'Home',
      component: Full,
      children: [
        {
          path: '/app',
          redirect: '/app/products',
          name: 'Home',
          component: AppContainer,
          children: [
            {
              path: 'products',
              name: '食品列表',
              component: ProductList
            },
            {
              path: 'attributes',
              name: '選項列表',
              component: AttributeList
            },
            {
              path: 'bundles',
              name: '套餐列表',
              component: BundleList
            },
            {
              path: 'menu_sections',
              name: '菜品分類列表',
              component: MenuSectionList
            }
          ]
        },
        {
          path: 'dashboard',
          name: 'Dashboard',
          component: Dashboard
        },
        {
          path: 'charts',
          name: 'Charts',
          component: Charts
        },
        {
          path: 'widgets',
          name: 'Widgets',
          component: Widgets
        },
        {
          path: 'auth',
          name: 'Auth',
          component: {
            render (c) { return c('router-view') }
          },
          children: [
            {
              path: 'login',
              name: 'BootstrapLogin',
              component: Login
            },
            {
              path: 'register',
              name: 'BootstrapRegister',
              component: Register
            }
          ]
        },
        {
          path: 'pages/header_page1',
          name: 'HeaderPage1',
          component: HeaderPage1
        },
        {
          path: 'pages/header_page2',
          name: 'HeaderPage2',
          component: HeaderPage2
        },
        {
          path: 'pages/header_page3',
          name: 'HeaderPage3',
          component: HeaderPage3
        },
        {
          path: 'custom',
          redirect: '/custom/draggable_tree',
          name: 'Custom',
          component: {
            render (c) {
              return c('router-view')
            }
          },
          children: [
            {
              path: 'dragdrop_tree',
              name: 'Tree',
              component: DragDropTree
            },
            {
              path: 'draggable_tree',
              name: 'Draggable Tree',
              component: DraggableTree
            },
            {
              path: 'vue_drag_tree',
              name: 'Vue Drag Tree',
              component: VueDragTree
            },
            {
              path: 'sortable_tree',
              name: 'Sortable Tree',
              component: SortableTree
            },
            {
              path: 'vue_draggable',
              name: 'VueDraggable',
              component: VueDraggable
            },
            {
              path: 'vue2_datatable',
              name: 'Vue2DataTable',
              component: Vue2DataTable
            }
          ]
        },
        {
          path: 'bootstrap',
          redirect: '/bootstrap/alerts',
          name: 'Bootstrap',
          component: {
            render (c) {
              return c('router-view')
            }
          },
          children: [
            {
              path: 'alerts',
              name: 'Alerts',
              component: Alerts
            },
            {
              path: 'badge',
              name: 'Badges',
              component: Badge
            },
            {
              path: 'breadcrumb',
              name: 'Breadcrumb',
              component: Breadcrumb
            },
            {
              path: 'buttons',
              name: 'BootstrapButtons',
              component: BootstrapButtons
            },
            {
              path: 'button_group',
              name: 'Button Group',
              component: BootstrapButtonGroup
            },
            {
              path: 'button_toolbar',
              name: 'Button Toolbar',
              component: BootstrapButtonToolbar
            },
            {
              path: 'carousel',
              name: 'Carousel',
              component: Carousel
            },
            {
              path: 'collapse',
              name: 'Collapse',
              component: Collapse
            },
            {
              path: 'dropdown',
              name: 'Dropdown',
              component: Dropdown
            },
            {
              path: 'forms',
              name: 'BootstrapForms',
              component: BootstrapForms
            },
            {
              path: 'inputgroup',
              name: 'InputGroup',
              component: InputGroup
            },
            {
              path: 'jumbotron',
              name: 'Jumbotron',
              component: Jumbotron
            },
            {
              path: 'listgroup',
              name: 'ListGroup',
              component: ListGroup
            },
            {
              path: 'modal',
              name: 'Modal',
              component: Modal
            }
          ]
        },

        {
          path: 'vueplugins',
          redirect: '/vueplugins/vtooltip',
          name: 'VuePlugins',
          component: {
            render (c) {
              return c('router-view')
            }
          },
          children: [
            {
              path: 'vtooltip',
              name: 'VToolTip',
              component: VToolTip
            }
          ]
        },
        {
          path: 'components',
          redirect: '/components/buttons',
          name: 'Components',
          component: {
            render (c) {
              return c('router-view')
            }
          },
          children: [
            {
              path: 'buttons',
              name: 'Buttons',
              component: Buttons
            },
            {
              path: 'social-buttons',
              name: 'Social Buttons',
              component: SocialButtons
            },
            {
              path: 'cards',
              name: 'Cards',
              component: Cards
            },
            {
              path: 'forms',
              name: 'Forms',
              component: Forms
            },
            {
              path: 'modals',
              name: 'Modals',
              component: Modals
            },
            {
              path: 'switches',
              name: 'Switches',
              component: Switches
            },
            {
              path: 'tables',
              name: 'Tables',
              component: Tables
            }
          ]
        },
        {
          path: 'icons',
          redirect: '/icons/font-awesome',
          name: 'Icons',
          component: {
            render (c) { return c('router-view') }
          },
          children: [
            {
              path: 'font-awesome',
              name: 'Font Awesome',
              component: FontAwesome
            },
            {
              path: 'simple-line-icons',
              name: 'Simple Line Icons',
              component: SimpleLineIcons
            }
          ]
        }
      ]
    },
    {
      path: '/main_panel',
      redirect: '/main_panel/product_menu',
      name: 'Main Panel',
      component: {
        render (c) { return c('router-view') }
      }
      // ,
      // children: [
      //   {
      //     path: 'product_menu',
      //     name: 'Menu',
      //     component: ProductMenu
      //   }
      // ]
    },
    {
      path: '/pages',
      redirect: '/pages/p404',
      name: 'Pages',
      component: {
        render (c) { return c('router-view') }
      },
      children: [
        {
          path: '404',
          name: 'Page404',
          component: Page404
        },
        {
          path: '500',
          name: 'Page500',
          component: Page500
        },
        {
          path: 'login',
          name: 'Login',
          component: Login
        },
        {
          path: 'register',
          name: 'Register',
          component: Register
        }
      ]
    }
  ]
})
