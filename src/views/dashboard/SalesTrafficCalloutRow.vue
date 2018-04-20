<template>
  <div class="row">
    <div class="col-sm-6" v-for="item in data">
      <Callout :variant="item.variant">
        <small class="text-muted">{{ item.title }}</small><br>
        <strong class="h4">{{ item.value }}</strong>
      </Callout>
    </div><!--/.col-->
  </div><!--/.row-->
</template>

<script>
import {Callout} from '../../components/'

export default {
  components: {
    Callout
  },
  name: 'salesTrafficCalloutRow',
  props: [
    'data'
  ]
}
</script>
