<template>
    <div class="animated fadeIn">
        <div class="row">
            <div class="col-sm-12">
                <h2>Buttons</h2>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-6">
                <div class="card">
                    <div class="card-header">
                        <div>Buttons</div>
                    </div>
                    <div class="card-body">
                        <button type="button" class="btn btn-primary">Primary</button>
                        <button type="button" class="btn btn-secondary">Secondary</button>
                        <button type="button" class="btn btn-success">Success</button>
                        <button type="button" class="btn btn-danger">Danger</button>
                        <button type="button" class="btn btn-warning">Warning</button>
                        <button type="button" class="btn btn-info">Info</button>
                        <button type="button" class="btn btn-light">Light</button>
                        <button type="button" class="btn btn-dark">Dark</button>

                        <button type="button" class="btn btn-link">Link</button>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="card">
                    <div class="card-header">
                        <div>Button Group</div>
                    </div>
                    <div class="card-body">
                        <div class="btn-group" role="group" aria-label="Basic example">
                            <button type="button" class="btn btn-secondary">Left</button>
                            <button type="button" class="btn btn-secondary">Middle</button>
                            <button type="button" class="btn btn-secondary">Right</button>
                        </div>

                        <div class="btn-toolbar" role="toolbar" aria-label="Toolbar with button groups">
                            <div class="btn-group mr-2" role="group" aria-label="First group">
                                <button type="button" class="btn btn-secondary">1</button>
                                <button type="button" class="btn btn-secondary">2</button>
                                <button type="button" class="btn btn-secondary">3</button>
                                <button type="button" class="btn btn-secondary">4</button>
                            </div>
                            <div class="btn-group mr-2" role="group" aria-label="Second group">
                                <button type="button" class="btn btn-secondary">5</button>
                                <button type="button" class="btn btn-secondary">6</button>
                                <button type="button" class="btn btn-secondary">7</button>
                            </div>
                            <div class="btn-group" role="group" aria-label="Third group">
                                <button type="button" class="btn btn-secondary">8</button>
                            </div>
                        </div>

                        <div class="btn-toolbar mb-3" role="toolbar" aria-label="Toolbar with button groups">
                            <div class="btn-group mr-2" role="group" aria-label="First group">
                                <button type="button" class="btn btn-secondary">1</button>
                                <button type="button" class="btn btn-secondary">2</button>
                                <button type="button" class="btn btn-secondary">3</button>
                                <button type="button" class="btn btn-secondary">4</button>
                            </div>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <div class="input-group-text" id="btnGroupAddon">@</div>
                                </div>
                                <input type="text" class="form-control" placeholder="Input group example" aria-label="Input group example" aria-describedby="btnGroupAddon">
                            </div>
                        </div>

                        <div class="btn-toolbar justify-content-between" role="toolbar" aria-label="Toolbar with button groups">
                            <div class="btn-group" role="group" aria-label="First group">
                                <button type="button" class="btn btn-secondary">1</button>
                                <button type="button" class="btn btn-secondary">2</button>
                                <button type="button" class="btn btn-secondary">3</button>
                                <button type="button" class="btn btn-secondary">4</button>
                            </div>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <div class="input-group-text" id="btnGroupAddon2">@</div>
                                </div>
                                <input type="text" class="form-control" placeholder="Input group example" aria-label="Input group example" aria-describedby="btnGroupAddon2">
                            </div>
                        </div>

                        <div class="btn-group btn-group-lg" role="group" aria-label="Large button group">
                            <button type="button" class="btn btn-secondary">Left</button>
                            <button type="button" class="btn btn-secondary">Middle</button>
                            <button type="button" class="btn btn-secondary">Right</button>
                        </div><br/>
                        <div class="btn-group" role="group" aria-label="Default button group">
                            <button type="button" class="btn btn-secondary">Left</button>
                            <button type="button" class="btn btn-secondary">Middle</button>
                            <button type="button" class="btn btn-secondary">Right</button>
                        </div><br/>
                        <div class="btn-group btn-group-sm" role="group" aria-label="Small button group">
                            <button type="button" class="btn btn-secondary">Left</button>
                            <button type="button" class="btn btn-secondary">Middle</button>
                            <button type="button" class="btn btn-secondary">Right</button>
                        </div><br/>

                        <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
                            <button type="button" class="btn btn-secondary">1</button>
                            <button type="button" class="btn btn-secondary">2</button>

                            <div class="btn-group" role="group">
                                <button id="btnGroupDrop1" type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    Dropdown
                                </button>
                                <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
                                    <a class="dropdown-item" href="#">Dropdown link</a>
                                    <a class="dropdown-item" href="#">Dropdown link</a>
                                </div>
                            </div>
                        </div><br/>

                        <div class="btn-group-vertical">
                            <button type="button" class="btn btn-secondary">Left</button>
                            <button type="button" class="btn btn-secondary">Middle</button>
                            <button type="button" class="btn btn-secondary">Right</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>



</template>

<script>
    export default {
      name: 'buttons'
    }
</script>


<style>
.card-body button {
    margin-bottom: 4px;
}
</style>