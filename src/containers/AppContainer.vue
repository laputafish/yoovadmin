<template>
    <div class="animated fadeIn">
        <div class="row">
            <div class="col-12">
                <router-view></router-view>
            </div>
        </div>
    </div>
</template>

<script>
  export default {
    name: 'appContainer'
  }
</script>
