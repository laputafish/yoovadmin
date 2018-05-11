<template>
  <div class="user-panel mt-3 pb-3 mb-3 d-flex">
    <div class="image">
      <img src="static/img/avatars/4.jpg" class="img-circle elevation-2" alt="User Image">
    </div>
    <div class="info">
      <p>{{ currentUser.name }}</p>
      <a href="#">
        <i class="fa fa-circle" :style="`color:${currentUser.state.color}`"></i>
        {{ currentUser.state.name }}
      </a>
    </div>
  </div>
</template>

<script>
  export default {
    props: {
      currentUser: {
        type: Object,
        default () {
          return {
            name: 'Testing',
            state: {
              color: 'blue',
              name: 'Unknown'
            }
          }
        }
      }
    }
  }
</script>

<style>
  .user-panel img {
    width: 2.1rem;
    height: auto;
  }
  .elevation-2 {
    box-shadow: 0 3px 6px rgba(0,0,0,.16), 0 3px 6px rgba(0,0,0,.23);
  }
  .img-circle {
    border-radius: 50%;
  }
</style>