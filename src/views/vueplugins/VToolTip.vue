<template>
    <div class="animated fadeIn">
        <div class="card">
            <div class="card-body">
                <div class="row">
                    <div class="col-sm-12">
                        <button v-tooltip="'You have new messages.'">
                            Show
                        </button>
                    </div>

                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
  data () {
    return {
      count: 10
    }
  }
}
</script>

