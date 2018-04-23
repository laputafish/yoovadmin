<template>
    <div class="d-flex flex-column flex-grow-1">
        <div class="flex-grow-0 bg-dark text-white justify-content-around mb-2">
            <h4 class="text-center py-1">Order #234232</h4>
        </div>
        <div class="d-flex flex-grow-1 text-body bg-info" style="padding-right:0px;position:relative;">
            <div class="d-flex flex-column"
                 style="overflow-y:scroll;padding-right:10px;width:100%;height:100%;position:absolute;">
                <div class="flex-grow-1">
                    <ul class="list-group" style="position:relative;">
                        <li class="d-flex flex-row list-group-item p-1" v-for="i in (1,20)">
                            <div class="row">
                                <div class="d-flex flex-column pl-3 col-4 justify-content-center">
                                    <h5 class="m-0">叉雞飯</h5>
                                </div>
                                <div class="col-5">
                                    <div class="flex-grow-1">
                                        <div class="form-group m-1">
                                            <div class="input-group">
                                                <button class="btn btn-sm">
                                                    <i class="fa fa-fw fa-plus d-block"></i>
                                                </button>
                                                <input class="text-center form-control" value="2"/>
                                                <button class="btn btn-sm">
                                                    <i class="fa fa-fw fa-minus d-block"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="d-flex flex-column justify-content-center col-3">
                                    <input class="text-right form-control-plaintext" readonly value="100.00"/>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="d-flex flex-row flex-grow-0 bg-dark text-white justify-content-end">
            <div class="text-right align-items-center flex-grow-0">Total</div>
            <div class="text-right flex-grow-0">
                <input class="text-right flex-grow-1 form-control-plaintext" readonly value="200.00"/>
            </div>
        </div>
    </div>
</template>

<script>
  export default {
    data () {
      return {

      }
    },
    props: {}
  }
</script>

<style>

</style>
