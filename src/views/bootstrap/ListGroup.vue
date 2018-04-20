<template>
    <div class="animated fadeIn">
        <div class="card">
            <div class="card-body">
                <div class="card-title">Basic</div>
                <ul class="list-group">
                    <li class="list-group-item">Cras justo odio</li>
                    <li class="list-group-item">Dapibus ac facilisis in</li>
                    <li class="list-group-item">Morbi leo risus</li>
                    <li class="list-group-item">Porta ac consectetur ac</li>
                    <li class="list-group-item">Vestibulum at eros</li>
                </ul>
                <br/>

                <div class="card-title">Active items</div>
                <ul class="list-group">
                    <li class="list-group-item active">Cras justo odio</li>
                    <li class="list-group-item">Dapibus ac facilisis in</li>
                    <li class="list-group-item">Morbi leo risus</li>
                    <li class="list-group-item">Porta ac consectetur ac</li>
                    <li class="list-group-item">Vestibulum at eros</li>
                </ul>
                <br/>

                <div class="card-title">Disabled items</div>
                <ul class="list-group">
                    <li class="list-group-item disabled">Cras justo odio</li>
                    <li class="list-group-item">Dapibus ac facilisis in</li>
                    <li class="list-group-item">Morbi leo risus</li>
                    <li class="list-group-item">Porta ac consectetur ac</li>
                    <li class="list-group-item">Vestibulum at eros</li>
                </ul>
                <br/>

                <div class="card-title">Links</div>
                <div class="list-group">
                    <a href="#" class="list-group-item list-group-item-action active">
                        Cras justo odio
                    </a>
                    <a href="#" class="list-group-item list-group-item-action">Dapibus ac facilisis in</a>
                    <a href="#" class="list-group-item list-group-item-action">Morbi leo risus</a>
                    <a href="#" class="list-group-item list-group-item-action">Porta ac consectetur ac</a>
                    <a href="#" class="list-group-item list-group-item-action disabled">Vestibulum at eros</a>
                </div>
                <br/>

                <div class="card-title">Buttons</div>
                <div class="list-group">
                    <button type="button" class="list-group-item list-group-item-action active">
                        Cras justo odio
                    </button>
                    <button type="button" class="list-group-item list-group-item-action">Dapibus ac facilisis in</button>
                    <button type="button" class="list-group-item list-group-item-action">Morbi leo risus</button>
                    <button type="button" class="list-group-item list-group-item-action">Porta ac consectetur ac</button>
                    <button type="button" class="list-group-item list-group-item-action" disabled>Vestibulum at eros</button>
                </div>
                <br/>

                <div class="card-title">Flush (no border)</div>
                <ul class="list-group list-group-flush">
                    <li class="list-group-item">Cras justo odio</li>
                    <li class="list-group-item">Dapibus ac facilisis in</li>
                    <li class="list-group-item">Morbi leo risus</li>
                    <li class="list-group-item">Porta ac consectetur ac</li>
                    <li class="list-group-item">Vestibulum at eros</li>
                </ul>
                <br/>

                <div class="card-title">Contextual classes</div>
                <ul class="list-group">
                    <li class="list-group-item">Dapibus ac facilisis in</li>
                    <li class="list-group-item list-group-item-primary">A simple primary list group item</li>
                    <li class="list-group-item list-group-item-secondary">A simple secondary list group item</li>
                    <li class="list-group-item list-group-item-success">A simple success list group item</li>
                    <li class="list-group-item list-group-item-danger">A simple danger list group item</li>
                    <li class="list-group-item list-group-item-warning">A simple warning list group item</li>
                    <li class="list-group-item list-group-item-info">A simple info list group item</li>
                    <li class="list-group-item list-group-item-light">A simple light list group item</li>
                    <li class="list-group-item list-group-item-dark">A simple dark list group item</li>
                </ul>
                <br/>
                <div class="list-group">
                    <a href="#" class="list-group-item list-group-item-action">Dapibus ac facilisis in</a>
                    <a href="#" class="list-group-item list-group-item-action list-group-item-primary">A simple primary list group item</a>
                    <a href="#" class="list-group-item list-group-item-action list-group-item-secondary">A simple secondary list group item</a>
                    <a href="#" class="list-group-item list-group-item-action list-group-item-success">A simple success list group item</a>
                    <a href="#" class="list-group-item list-group-item-action list-group-item-danger">A simple danger list group item</a>
                    <a href="#" class="list-group-item list-group-item-action list-group-item-warning">A simple warning list group item</a>
                    <a href="#" class="list-group-item list-group-item-action list-group-item-info">A simple info list group item</a>
                    <a href="#" class="list-group-item list-group-item-action list-group-item-light">A simple light list group item</a>
                    <a href="#" class="list-group-item list-group-item-action list-group-item-dark">A simple dark list group item</a>
                </div>
                <br/>

                <div class="card-title">With badges</div>
                <ul class="list-group">
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        Cras justo odio
                        <span class="badge badge-primary badge-pill">14</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        Dapibus ac facilisis in
                        <span class="badge badge-primary badge-pill">2</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        Morbi leo risus
                        <span class="badge badge-primary badge-pill">1</span>
                    </li>
                </ul>
                <br/>

                <div class="card-title">Custom content</div>
                <div class="list-group">
                    <a href="#" class="list-group-item list-group-item-action flex-column align-items-start active">
                        <div class="d-flex w-100 justify-content-between">
                            <h5 class="mb-1">List group item heading</h5>
                            <small>3 days ago</small>
                        </div>
                        <p class="mb-1">Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.</p>
                        <small>Donec id elit non mi porta.</small>
                    </a>
                    <a href="#" class="list-group-item list-group-item-action flex-column align-items-start">
                        <div class="d-flex w-100 justify-content-between">
                            <h5 class="mb-1">List group item heading</h5>
                            <small class="text-muted">3 days ago</small>
                        </div>
                        <p class="mb-1">Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.</p>
                        <small class="text-muted">Donec id elit non mi porta.</small>
                    </a>
                    <a href="#" class="list-group-item list-group-item-action flex-column align-items-start">
                        <div class="d-flex w-100 justify-content-between">
                            <h5 class="mb-1">List group item heading</h5>
                            <small class="text-muted">3 days ago</small>
                        </div>
                        <p class="mb-1">Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.</p>
                        <small class="text-muted">Donec id elit non mi porta.</small>
                    </a>
                </div>
                <br/>

                <div class="card-title">JavaScript behavior</div>
                <div class="row">
                    <div class="col-4">
                        <div class="list-group" id="list-tab" role="tablist">
                            <a class="list-group-item list-group-item-action active" id="list-home-list" data-toggle="list" href="#list-home" role="tab" aria-controls="home">Home</a>
                            <a class="list-group-item list-group-item-action" id="list-profile-list" data-toggle="list" href="#list-profile" role="tab" aria-controls="profile">Profile</a>
                            <a class="list-group-item list-group-item-action" id="list-messages-list" data-toggle="list" href="#list-messages" role="tab" aria-controls="messages">Messages</a>
                            <a class="list-group-item list-group-item-action" id="list-settings-list" data-toggle="list" href="#list-settings" role="tab" aria-controls="settings">Settings</a>
                        </div>
                    </div>
                    <div class="col-8">
                        <div class="tab-content" id="nav-tabContent">
                            <div class="tab-pane fade show active" id="list-home" role="tabpanel" aria-labelledby="list-home-list">Tab #1: Home</div>
                            <div class="tab-pane fade" id="list-profile" role="tabpanel" aria-labelledby="list-profile-list">Tab #2: Profile</div>
                            <div class="tab-pane fade" id="list-messages" role="tabpanel" aria-labelledby="list-messages-list">Tab #3: Messages</div>
                            <div class="tab-pane fade" id="list-settings" role="tabpanel" aria-labelledby="list-settings-list">Tab #4: Settings</div>
                        </div>
                    </div>
                </div>
                <br/>

                <div class="card-title">Using data attributes</div>
                <!-- List group -->
                <div class="list-group" id="myList" role="tablist">
                    <a class="list-group-item list-group-item-action active" data-toggle="list" href="#home" role="tab">Home</a>
                    <a class="list-group-item list-group-item-action" data-toggle="list" href="#profile" role="tab">Profile</a>
                    <a class="list-group-item list-group-item-action" data-toggle="list" href="#messages" role="tab">Messages</a>
                    <a class="list-group-item list-group-item-action" data-toggle="list" href="#settings" role="tab">Settings</a>
                </div>
                <!-- Tab panes -->
                <div class="tab-content">
                    <div class="tab-pane active" id="home" role="tabpanel">Tab #1: Home</div>
                    <div class="tab-pane" id="profile" role="tabpanel">Tab #2: Profile</div>
                    <div class="tab-pane" id="messages" role="tabpanel">Tab #3: Messages</div>
                    <div class="tab-pane" id="settings" role="tabpanel">Tab #4: Settings</div>
                </div>
                <br/>

                <div class="card-title">Fade effect</div>
                <!-- List group -->
                <div class="list-group" id="myList" role="tablist">
                    <a class="list-group-item list-group-item-action active" data-toggle="list" href="#fade_effect_home" role="tab">Home</a>
                    <a class="list-group-item list-group-item-action" data-toggle="list" href="#fade_effect_profile" role="tab">Profile</a>
                    <a class="list-group-item list-group-item-action" data-toggle="list" href="#fade_effect_messages" role="tab">Messages</a>
                    <a class="list-group-item list-group-item-action" data-toggle="list" href="#fade_effect_settings" role="tab">Settings</a>
                </div>
                <!-- Tab panes -->
                <div class="tab-content">
                    <div class="tab-pane fade show active" id="fade_effect_home" role="tabpanel">Tab #1: Home</div>
                    <div class="tab-pane fade" id="fade_effect_profile" role="tabpanel">Tab #2: Profile</div>
                    <div class="tab-pane fade" id="fade_effect_messages" role="tabpanel">Tab #3: Messages</div>
                    <div class="tab-pane fade" id="fade_effect_settings" role="tabpanel">Tab #4: Settings</div>
                </div>
                <br/>


            </div>
        </div>
    </div>
</template>

<script>

</script>

<style></style>