<template>
    <div class="animated fadeIn">
        <div class="row">
            <div class="col-sm-12">
                <div class="card">
                    <div class="card-body">
                        <bCarousel id="carouselExampleSlidesOnly" class="slide" data-ride="carousel">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <img class="d-block w-100" src="/static/img/banners/banner2.jpg" alt="First slide">
                                </div>
                                <div class="carousel-item">
                                    <img class="d-block w-100" src="/static/img/banners/banner3.jpg" alt="Second slide">
                                </div>
                                <div class="carousel-item">
                                    <img class="d-block w-100" src="/static/img/banners/banner4.jpg" alt="Third slide">
                                </div>
                                <div class="carousel-item">
                                    <img class="d-block w-100" src="/static/img/banners/banner5.jpg" alt="Forth slide">
                                </div>
                                <div class="carousel-item">
                                    <img class="d-block w-100" src="/static/img/banners/banner6.jpg" alt="Fifth slide">
                                </div>
                            </div>
                        </bCarousel>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {

    }
</script>

<style>
.carousel-item img {
    max-height: 480px;
    object-fit: cover;
}
</style>