<template>
    <div class="animated fadeIn">
        <div class="row">
            <div class="col-sm-12">
                <h2>Button Group</h2>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <b-card title="Default">
                    <b-card-body>
                        <div>
                            <b-button-group>
                                <b-button>Button 1</b-button>
                                <b-button>Button 2</b-button>
                                <b-button>Button 3</b-button>
                                <b-button>Button 4</b-button>
                                <b-button>Button 5</b-button>
                            </b-button-group>
                            <br><br/>
                            <b-button-group>
                                <b-button variant="success">Success</b-button>
                                <b-button variant="info">Info</b-button>
                                <b-button variant="warning">Warning</b-button>
                                <b-button variant="primary">Primary</b-button>
                                <b-button variant="danger">Danger</b-button>
                                <b-button variant="link">Link</b-button>
                            </b-button-group>
                        </div>
                        <br/><br/>

                        <p class="card-title">
                            <h4>Sizing</h4>
                        </p>
                        <div>
                            <b-button-group>
                                <b-button>Button 1</b-button>
                                <b-button>Button 2</b-button>
                                <b-button>Button 3</b-button>
                            </b-button-group>
                            <br><br>
                            <b-button-group size="sm">
                                <b-button>Left</b-button>
                                <b-button>Middle</b-button>
                                <b-button>Right</b-button>
                            </b-button-group>
                            <br><br>
                            <b-button-group size="lg">
                                <b-button>Left</b-button>
                                <b-button>Middle</b-button>
                                <b-button>Right</b-button>
                            </b-button-group>
                        </div>
                        <br/><br/>

                        <p class="card-title">
                            <h4>Vertical variation</h4>
                        </p>
                        <div>
                            <b-button-group vertical>
                                <b-button>Top</b-button>
                                <b-button>Middle</b-button>
                                <b-button>Bottom</b-button>
                            </b-button-group>
                        </div>
                        <br/><br/>

                        <p class="card-title">
                            <h4>Dropdown menu support</h4>
                        </p>
                        <div>
                            <b-button-group id="dropdown-menu">
                                <b-button>Button 1</b-button>
                                <b-button>Button 2</b-button>
                                <b-dropdown right text="Menu">
                                    <b-dropdown-item>Item 1</b-dropdown-item>
                                    <b-dropdown-item>Item 2</b-dropdown-item>
                                    <b-dropdown-divider></b-dropdown-divider>
                                    <b-dropdown-item>Item 3</b-dropdown-item>
                                </b-dropdown>
                                <b-button>Button 3</b-button>
                                <b-dropdown right split text="Split Menu">
                                    <b-dropdown-item>Item 1</b-dropdown-item>
                                    <b-dropdown-item>Item 2</b-dropdown-item>
                                    <b-dropdown-divider></b-dropdown-divider>
                                    <b-dropdown-item>Item 3</b-dropdown-item>
                                </b-dropdown>
                            </b-button-group>
                        </div>
                        <br/>

                    </b-card-body>
                </b-card>
            </div>
        </div>
    </div>
</template>

<script>


</script>

<style>
#dropdown-menu button {
    margin-right: 2px;
}
</style>