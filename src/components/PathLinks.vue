<template>
<div id="path-link" class="d-flex d-row justify-contents-center">
  <button
          :disabled="ancestors.length===1"
          @click="enterFolder(ancestors[ancestors.length-2])"
          class="btn-level-up btn btn-xs btn-default float-left">
    <i class="fa fa-fw fa-level-up"></i>
  </button>
  <div id="path-link-paths" v-for="(ancestor, index) in ancestors">
    <span v-if="index!==0">&nbsp;
      /&nbsp;</span>
    <a href="javascript:"
       class="no-text-decoration" v-if="index<ancestors.length-1"
       @click="enterFolder(ancestor)">
      <i class="fa fa-folder"></i>
      {{ ancestor.description }}
    </a>
    <span v-else>
      <i class="fa fa-folder"></i>
      {{ ancestor.description }}
    </span>
  </div>
</div>
</template>

<script>
  export default {
    props: {
      ancestors: {
        type: Array,
        default () {
          return []
        }
      }
    },
    methods: {
      enterFolder (folder) {
        let vm = this
        console.log('PathLinks.vue :: enterFolder :: folder:', folder)
        if (folder) {
          console.log('PathLinks.vue folder.id = ' + folder.id)
          vm.$store.dispatch('FETCH_FOLDER', {folderId: folder.id}).then(function () {
            history.pushState({}, null, '/folders/' + folder.id)
          })
        }
      }
    }
  }
</script>

<style>
  #path-link {
    margin-bottom: 3px;
  }
  #path-link .btn-level-up {
    padding: .25rem;
    line-height: 1;
    margin-right: 5px;
  }
  #path-link #path-link-paths {
    line-height: 1
  }
  .inline {
    display: inline-block;
  }
</style>