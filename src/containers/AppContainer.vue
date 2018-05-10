<template>
    <div class="animated fadeIn">
        <div class="row">
            <div class="col-12">
                <b-card>
                    <div slot="header">
                        <strong>{{ $route.name }}</strong>
                    </div>
                    <router-view></router-view>
                </b-card>
            </div>
        </div>
    </div>
</template>

<script>
  export default {
    name: 'appContainer'
  }
</script>
