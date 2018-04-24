<template>
    <div class="animated fadeIn">
        <div class="row">
            <div class="col-sm-12">
                <h2>Button Toolbar</h2>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <b-card>
                    <p class="card-title"><h3>Default</h3></p>
                    <div>
                        <b-button-toolbar key-nav  aria-label="Toolbar with button groups">
                            <b-button-group class="mx-1">
                                <b-btn>&laquo;</b-btn>
                                <b-btn>&lsaquo;</b-btn>
                            </b-button-group>
                            <b-button-group class="mx-1">
                                <b-btn>Edit</b-btn>
                                <b-btn>Undo</b-btn>
                                <b-btn>Redo</b-btn>
                            </b-button-group>
                            <b-button-group class="mx-1">
                                <b-btn>&rsaquo;</b-btn>
                                <b-btn>&raquo;</b-btn>
                            </b-button-group>
                        </b-button-toolbar>
                    </div>
                    <br/><b/>

                    <p class="card-title"><h3>Mixture of small button groups and small input groups</h3></p>
                    <div>
                        <b-button-toolbar aria-label="Toolbar with button groups and input groups">
                            <b-button-group size="sm" class="mx-1">
                                <b-btn>New</b-btn>
                                <b-btn>Edit</b-btn>
                            </b-button-group>
                            <b-input-group size="sm" class="w-25 mx-1" prepend="$" append=".00">
                                <b-form-input value="100" class="text-right"></b-form-input>
                            </b-input-group>
                            <b-input-group  size="sm" class="w-25 mx-1" prepend="Size">
                                <b-form-select value="Medium" :options="['Large','Medium','Small']"></b-form-select>
                            </b-input-group>
                            <b-button-group  size="sm" class="mx-1">
                                <b-btn>Save</b-btn>
                                <b-btn>Cancel</b-btn>
                            </b-button-group>
                        </b-button-toolbar>
                    </div>
                    <br/><br/>

                    <p class="card-title"><h3>button groups and dropdown menu</h3></p>
                    <div>
                        <b-button-toolbar aria-label="Toolbar with button groups and dropdown menu">
                            <b-button-group class="mx-1">
                                <b-btn>New</b-btn>
                                <b-btn>Edit</b-btn>
                                <b-btn>Undo</b-btn>
                            </b-button-group>
                            <b-dropdown class="mx-1" right text="menu">
                                <b-dropdown-item>Item 1</b-dropdown-item>
                                <b-dropdown-item>Item 2</b-dropdown-item>
                                <b-dropdown-item>Item 3</b-dropdown-item>
                            </b-dropdown>
                            <b-button-group class="mx-1">
                                <b-btn>Save</b-btn>
                                <b-btn>Cancel</b-btn>
                            </b-button-group>
                        </b-button-toolbar>
                    </div>
                    <br/><br/>


                </b-card>
            </div>
        </div>
    </div>
</template>

<script>

</script>

<style>


</style>