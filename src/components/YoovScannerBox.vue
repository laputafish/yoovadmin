<template>
  <b-card id="scanner-block" no-body class="p-0">
    <b-card-body class="p-2">
      <table>
        <tr>
          <td style="padding-right:5px;">
            <img src="/static/img/scanner.png" class="office-scanner">
          </td>
          <td style="vertical-align:middle;">
            <i
                    :class="{'text-success':scanner.occupied_by===0,'text-gray-out':scanner.occupied_by!==0}"
                    class="scan-target-direction fa fa-caret-right"></i>
          </td>
          <td style="vertical-align:bottom;">
            <scanner-folder
              :scanner="scanner"
              mode="scanner"
              label="Public"
              :user="user"></scanner-folder>
            <!--<i class="fa fa-folder" style="font-size:64px;"></i>-->
            <!--<folder-icon-->
              <!--iconType="close"-->
              <!--label="Public"></folder-icon>-->
          </td>
        </tr>
        <!-- down arrow -->
        <tr>
          <td class="text-center" style="line-height: 0.5;">
            <i style="line-height: 0.5;"
               :class="{'text-success':scanner.occupied_by===user.id,'text-black-20':scanner.occupied_by===0,'text-black-50':(scanner.occupied_by!==0 && scanner.occupied_by!==user.id)}"
               class="scan-target-direction fa fa-caret-down"></i>
          </td>
          <td colspan="2"></td>
        </tr>
        <!-- user folder -->
        <tr v-if="scanner.occupied_by!==0 && scanner.occupied_by!==user.id">
          <td colspan="3" class="text-center">
            <span class="badge badge-danger">Held by {{ scanner.occupied_by_user.name }}</span>
            <hr/>
          </td>
        </tr>
        <!-- occupied by current user -->
        <tr>
          <td>
            <scanner-folder
              :scanner="scanner"
              mode="user"
              :label="user.name"
              :user="user"></scanner-folder>
            <!--<folder-icon-->
                    <!--iconType="close"-->
                    <!--label="Peter"></folder-icon>-->
          </td>
          <td></td>
          <td style="vertical-align:middle;">
            <b-button variant="default"
                      class="mb-1"
                      :disabled="scanner.occupied_by!==0 && scanner.occupied_by!==user.id"
                      v-if="scanner.occupied_by===0 || scanner.occupied_by!==user.id"
                      @click="onHoldButtonClicked">Hold</b-button>
            <b-button variant="default"
                      class="mb-1"
                      style="padding-left:0.2rem;padding-right:0.2rem;"
                      v-if="scanner.occupied_by===user.id"
                      @click="onReleaseButtonClicked">Release</b-button>
          </td>
        </tr>
      </table>
    </b-card-body>

  </b-card>
</template>

<script>
  import FolderIcon from '@/components/FolderIcon'
  import ScannerFolder from '@/components/ScannerFolder'

  export default {
    data () {
      return {
        scanner2: {
          name: 'scanner',
          description: 'Scanner',
          occupied_by: 2,
          occupied_by_user: {
            id: 3,
            name: 'John'
          },
          last_occupied_at: '2018-05-26 17:56:00',
          remark: ''
        }
      }
    },
    components: {
      'folder-icon': FolderIcon,
      'scanner-folder': ScannerFolder
    },
    methods: {
      onHoldButtonClicked () {
        this.$store.dispatch('HOLD_SCANNER', this.user)
      },
      onReleaseButtonClicked () {
        this.$store.dispatch('RELEASE_SCANNER')
      }
    },
    computed: {
      user () {
        return this.$store.getters.user
      },
      scanner () {
        return this.$store.getters.scanner
      }
    }
  }
</script>

<style>
#scanner-block {
  min-width: 160px;
}

#scanner-block table tr td {
  vertical-align: middle;
}

  #scanner-block .scan-target-direction {
    font-size: 24px;
  }

.text-black-20 {
  color: rgba(0,0,0,.2);
}
.text-gray-out {
  color: rgba(0,0,0,.1);
}
.text-gray-out small {
  color: rgba(0, 0, 0, .2);
}

</style>
