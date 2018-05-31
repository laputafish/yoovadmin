export default {
  items: [
    {
      sectionTitle: 'Account',
      menuItems: [
        {icon: 'fa-address-card', link: '/profile', title: 'Profile'},
        {icon: 'fa-lock', command: 'logout', title: 'Logout'}

        // {icon: 'fa-bell-o', link: '/pages/login', title: 'Updates', badgeClass: 'badge-info', badgeNo: 42},
        // {icon: 'fa-envelope-o', title: 'Messages', badgeClass: 'badge-success', badgeNo: 42},
        // {icon: 'fa-tasks', title: 'Tasks', badgeClass: 'badge-danger', badgeNo: 42},
        // {icon: 'fa-comments', title: 'Comments', badgeClass: 'badge-warning', badgeNo: 42}
      ]
    }
    // {
    //   sectionTitle: 'Settings',
    //   menuItems: [
    //     {icon: 'fa-user', title: 'Profile'},
    //     {icon: 'fa-wrench', title: 'Settings'},
    //     {icon: 'fa-usd', title: 'Payments'},
    //     {icon: 'fa-file', title: 'Projects'}
    //   ]
    // },
    // {
    //   sectionTitle: 'System',
    //   menuItems: [
    //     // {icon: 'fa-shield', title: 'Lock Account'},
    //     {icon: 'fa-lock', command: 'logout', title: 'Logout'}
    //   ]
    // }
  ]
}
