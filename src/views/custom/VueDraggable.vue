<template>
  <div class="animated fadeIn">
    <div class="row" v-drag-and-drop:options="options">
      <div class="col-sm-6">
        <ul>
          <li>Item 1</li>
          <li>Item 2</li>
          <li>Item 3</li>
        </ul>
      </div>
      <div class="col-sm-6">
        <ul>
          <li>Item 4</li>
          <li>Item 5</li>
          <li>Item 6</li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    data () {
      return {
        dropzoneSelector: 'ul',
        draggableSelector: 'li',
        excludeOlderBrowsers: true,
        multipleDropzonesItemsDraggingEnabled: true,
        showDropzoneAreas: true,
        onDrop: function (event) {},
        onDragstart: function (event) {},
        onDragend: function (event) {}
      }
    }
  }
</script>

<style>
  @keyframes nodeInserted {
    from { opacity: 0.2; }
    to { opacity: 0.8; }
  }

  .item-dropzone-area {
    height: 2rem;
    background-color: #cce4ff;
    opacity: 0.8;
    border-radius: 0.2rem;
    animation-duration: 0.5s;
    animation-name: nodeInserted;
  }
</style>