export default {
  items0: [
    {
      name: 'Dashboard',
      url: '/dashboard',
      icon: 'icon-speedometer',
      badge: {
        variant: 'primary',
        text: 'NEW'
      }
    },
    {
      title: true,
      name: 'UI elements'
    },
    {
      name: 'Custom',
      url: '/custom',
      icon: 'icon-settings',
      children: [
        {
          name: 'Drag Drop Tree',
          url: '/custom/dragdrop_tree',
          icon: 'icon-share'
        },
        {
          name: 'Draggable Tree',
          url: '/custom/draggable_tree',
          icon: 'icon-share'
        },
        {
          name: 'Vue Drag Tree',
          url: '/custom/vue_drag_tree',
          icon: 'icon-share'
        },
        {
          name: 'Sortable Tree',
          url: '/custom/sortable_tree',
          icon: 'icon-share'
        },
        {
          name: 'Vue Draggable',
          url: '/custom/vue_draggable',
          icon: 'icon-share'
        },
        {
          name: 'Vue2 DataTable',
          url: '/custom/vue2_datatable',
          icon: 'icon-share'
        }
      ]
    },
    {
      name: 'Bootstrap',
      url: '/bootstrap',
      icon: 'icon-settings',
      children: [
        {
          name: 'Alerts',
          url: '/bootstrap/alerts',
          icon: 'icon-link'
        },
        {
          name: 'Badge',
          url: '/bootstrap/badge',
          icon: 'icon-link'
        },
        {
          name: 'Breadcrumb',
          url: '/bootstrap/breadcrumb',
          icon: 'icon-link'
        },
        {
          name: 'Buttons',
          url: '/bootstrap/buttons',
          icon: 'icon-link'
        },
        {
          name: 'Button Group',
          url: '/bootstrap/button_group',
          icon: 'icon-link'
        },
        {
          name: 'Button Toolbar',
          url: '/bootstrap/button_toolbar',
          icon: 'icon-link'
        },
        {
          name: 'Carousel',
          url: '/bootstrap/carousel',
          icon: 'icon-link'
        },
        {
          name: 'Collapse',
          url: '/bootstrap/collapse',
          icon: 'icon-link'
        },
        {
          name: 'Dropdown',
          url: '/bootstrap/dropdown',
          icon: 'icon-link'
        },
        {
          name: 'Forms',
          url: '/bootstrap/forms',
          icon: 'icon-link'
        },
        {
          name: 'InputGroups',
          url: '/bootstrap/inputgroup',
          icon: 'icon-link'
        },
        {
          name: 'Jumbotron',
          url: '/bootstrap/jumbotron',
          icon: 'icon-link'
        },
        {
          name: 'ListGroup',
          url: '/bootstrap/listgroup',
          icon: 'icon-link'
        },
        {
          name: 'Modal',
          url: '/bootstrap/modal',
          icon: 'icon-link'
        }

      ]
    },
    {
      name: 'Vue Plugins',
      url: '/vueplugins',
      icon: 'icon-puzzle',
      children: [
        {
          name: 'VToolTip',
          url: '/vueplugins/vtooltip',
          icon: 'icon-puzzle'
        }
      ]
    },
    {
      name: 'Components',
      url: '/components',
      icon: 'icon-puzzle',
      children: [
        // {
        //   name: 'Alerts',
        //   url: '/components/alerts',
        //   icon: 'icon-puzzle'
        // },
        {
          name: 'Buttons',
          url: '/components/buttons',
          icon: 'icon-puzzle'
        },

        {
          name: 'Social Buttons',
          url: '/components/social-buttons',
          icon: 'icon-puzzle'
        },
        {
          name: 'Cards',
          url: '/components/cards',
          icon: 'icon-puzzle'
        },
        {
          name: 'Forms',
          url: '/components/forms',
          icon: 'icon-puzzle'
        },
        {
          name: 'Modals',
          url: '/components/modals',
          icon: 'icon-puzzle'
        },
        {
          name: 'Switches',
          url: '/components/switches',
          icon: 'icon-puzzle'
        },
        {
          name: 'Tables',
          url: '/components/tables',
          icon: 'icon-puzzle'
        }
      ]
    },
    {
      name: 'Icons',
      url: '/icons',
      icon: 'icon-star',
      children: [
        {
          name: 'Font Awesome',
          url: '/icons/font-awesome',
          icon: 'icon-star'
        },
        {
          name: 'Simple Line Icons',
          url: '/icons/simple-line-icons',
          icon: 'icon-star'
        }
      ]
    },
    {
      name: 'Widgets',
      url: '/widgets',
      icon: 'icon-calculator',
      badge: {
        variant: 'danger',
        text: 'NEW'
      }
    },
    {
      name: 'Charts',
      url: '/charts',
      icon: 'icon-pie-chart'
    },
    {
      divider: true
    },
    {
      title: true,
      name: 'Extras'
    },
    {
      name: 'Pages',
      url: '/pages',
      icon: 'icon-star',
      children: [
        {
          name: 'Product Menu',
          url: '/main_panel/product_menu',
          icon: 'icon-menu'
        },
        {
          name: 'Login',
          url: '/pages/login',
          icon: 'icon-star'
        },
        {
          name: 'Register',
          url: '/pages/register',
          icon: 'icon-star'
        },
        {
          name: 'Error 404',
          url: '/pages/404',
          icon: 'icon-star'
        },
        {
          name: 'Error 500',
          url: '/pages/500',
          icon: 'icon-star'
        }
      ]
    }
  ],
  items: [
    {
      type: 'item',
      isHeader: true,
      name: 'MAIN NAVIGATION'
    },
    {
      type: 'tree',
      name: 'Dashboard',
      url: '/dashboard',
      icon: 'icon-speedometer',
      badge: {
        variant: 'primary',
        text: 'NEW'
      },
      children: [

      ]
    },
    {
      type: 'item',
      isHeader: true,
      name: 'UI elements'
    },
    {
      type: 'tree',
      name: 'Custom',
      url: '/custom',
      icon: 'icon-settings',
      children: [
        {
          type: 'item',
          name: 'Drag Drop Tree',
          url: '/custom/dragdrop_tree',
          icon: 'icon-share'
        },
        {
          type: 'item',
          name: 'Draggable Tree',
          url: '/custom/draggable_tree',
          icon: 'icon-share'
        },
        {
          type: 'item',
          name: 'Vue Drag Tree',
          url: '/custom/vue_drag_tree',
          icon: 'icon-share'
        },
        {
          type: 'item',
          name: 'Sortable Tree',
          url: '/custom/sortable_tree',
          icon: 'icon-share'
        },
        {
          type: 'item',
          name: 'Vue Draggable',
          url: '/custom/vue_draggable',
          icon: 'icon-share'
        },
        {
          type: 'item',
          name: 'Vue2 DataTable',
          url: '/custom/vue2_datatable',
          icon: 'icon-share'
        }
      ]
    },
    {
      type: 'tree',
      name: 'Bootstrap',
      url: '/bootstrap',
      icon: 'icon-settings',
      children: [
        {
          type: 'item',
          name: 'Alerts',
          url: '/bootstrap/alerts',
          icon: 'icon-link'
        },
        {
          type: 'item',
          name: 'Badge',
          url: '/bootstrap/badge',
          icon: 'icon-link'
        },
        {
          type: 'item',
          name: 'Breadcrumb',
          url: '/bootstrap/breadcrumb',
          icon: 'icon-link'
        },
        {
          type: 'item',
          name: 'Buttons',
          url: '/bootstrap/buttons',
          icon: 'icon-link'
        },
        {
          type: 'item',
          name: 'Button Group',
          url: '/bootstrap/button_group',
          icon: 'icon-link'
        },
        {
          type: 'item',
          name: 'Button Toolbar',
          url: '/bootstrap/button_toolbar',
          icon: 'icon-link'
        },
        {
          type: 'item',
          name: 'Carousel',
          url: '/bootstrap/carousel',
          icon: 'icon-link'
        },
        {
          type: 'item',
          name: 'Collapse',
          url: '/bootstrap/collapse',
          icon: 'icon-link'
        },
        {
          type: 'item',
          name: 'Dropdown',
          url: '/bootstrap/dropdown',
          icon: 'icon-link'
        },
        {
          type: 'item',
          name: 'Forms',
          url: '/bootstrap/forms',
          icon: 'icon-link'
        },
        {
          type: 'item',
          name: 'InputGroups',
          url: '/bootstrap/inputgroup',
          icon: 'icon-link'
        },
        {
          type: 'item',
          name: 'Jumbotron',
          url: '/bootstrap/jumbotron',
          icon: 'icon-link'
        },
        {
          type: 'item',
          name: 'ListGroup',
          url: '/bootstrap/listgroup',
          icon: 'icon-link'
        },
        {
          type: 'item',
          name: 'Modal',
          url: '/bootstrap/modal',
          icon: 'icon-link'
        }

      ]
    },
    {
      type: 'tree',
      name: 'Vue Plugins',
      url: '/vueplugins',
      icon: 'icon-puzzle',
      children: [
        {
          type: 'item',
          name: 'VToolTip',
          url: '/vueplugins/vtooltip',
          icon: 'icon-puzzle'
        }
      ]
    },
    {
      type: 'tree',
      name: 'Components',
      url: '/components',
      icon: 'icon-puzzle',
      children: [
        // {
        //   name: 'Alerts',
        //   url: '/components/alerts',
        //   icon: 'icon-puzzle'
        // },
        {
          type: 'item',
          name: 'Buttons',
          url: '/components/buttons',
          icon: 'icon-puzzle'
        },
        {
          type: 'item',
          name: 'Social Buttons',
          url: '/components/social-buttons',
          icon: 'icon-puzzle'
        },
        {
          type: 'item',
          name: 'Cards',
          url: '/components/cards',
          icon: 'icon-puzzle'
        },
        {
          type: 'item',
          name: 'Forms',
          url: '/components/forms',
          icon: 'icon-puzzle'
        },
        {
          type: 'item',
          name: 'Modals',
          url: '/components/modals',
          icon: 'icon-puzzle'
        },
        {
          type: 'item',
          name: 'Switches',
          url: '/components/switches',
          icon: 'icon-puzzle'
        },
        {
          type: 'item',
          name: 'Tables',
          url: '/components/tables',
          icon: 'icon-puzzle'
        }
      ]
    },
    {
      type: 'tree',
      name: 'Icons',
      url: '/icons',
      icon: 'icon-star',
      children: [
        {
          type: 'item',
          name: 'Font Awesome',
          url: '/icons/font-awesome',
          icon: 'icon-star'
        },
        {
          type: 'item',
          name: 'Simple Line Icons',
          url: '/icons/simple-line-icons',
          icon: 'icon-star'
        }
      ]
    },
    {
      type: 'tree',
      name: 'Widgets',
      url: '/widgets',
      icon: 'icon-calculator',
      badge: {
        variant: 'danger',
        text: 'NEW'
      }
    },
    {
      type: 'item',
      name: 'Charts',
      url: '/charts',
      icon: 'icon-pie-chart'
    },
    {
      type: 'divider'
    },
    {
      type: 'item',
      isHeader: true,
      name: 'Extras'
    },
    {
      type: 'tree',
      name: 'Pages',
      url: '/pages',
      icon: 'icon-star',
      children: [
        {
          type: 'item',
          name: 'Product Menu',
          url: '/main_panel/product_menu',
          icon: 'icon-menu'
        },
        {
          type: 'item',
          name: 'Login',
          url: '/pages/login',
          icon: 'icon-star'
        },
        {
          type: 'item',
          name: 'Register',
          url: '/pages/register',
          icon: 'icon-star'
        },
        {
          type: 'item',
          name: 'Error 404',
          url: '/pages/404',
          icon: 'icon-star'
        },
        {
          type: 'item',
          name: 'Error 500',
          url: '/pages/500',
          icon: 'icon-star'
        }
      ]
    }
  ]

}
