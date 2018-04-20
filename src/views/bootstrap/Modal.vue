<template>
    <div class="animated fadeIn">
        <b-btn v-b-modal.modal1>Launch demo modal</b-btn>

        <!-- Modal Component -->
        <b-modal id="modal1" title="Modal title">
            <p class="my-4">Modal body text goes here.</p>
            <b-btn class="mt-3" variant="outline-danger" block @click="(ref)=>ref.close()">Close Me</b-btn>
        </b-modal>

    </div>
</template>

<script>

</script>

<style>

</style>