$(document).ready(function() {
    /**
     * Collections
     */
    var collection = $('.collection');
    if (collection.length) {
        collection.collection({
            'init_with_n_elements': 1,
            'down': '<a href="#"><i class="fa fa-chevron-down"></i></a>',
            'up': '<a href="#"><i class="fa fa-chevron-up"></i></a>',
            'add': '<a href="#"><i class="fa fa-plus"></i></a>',
            'remove': '<a href="#"><i class="fa fa-minus"></i></a>'
        });
    }

    /**
     * Custom Radio & Checkbox
     */
    $('input[type=checkbox]').wrap('<div class="checkbox-wrapper"/>');
    $('.checkbox-wrapper').append('<span class="indicator"></span>');

    $('input[type=radio]').wrap('<div class="radio-wrapper"/>');
    $('.radio-wrapper').append('<span class="indicator"></span>');

    /**
     * WYSIWYG
     */
    $('textarea.wysiwyg').summernote({
        popover: {},
        toolbar: [
            ['style', ['bold', 'italic', 'underline', 'link']],
            ['para', ['ul', 'ol']]
        ]
    });

    /**
     * Google Map
     */
    var map_container = $('#map-container');
    if (map_container.length) {
        var lat = map_container.data('latitude');
        var lon = map_container.data('longitude');

        var mapOptions = {
            scrollwheel: false,
            zoom: 15,
            scaleControl: true,
            center: new google.maps.LatLng(lat, lon),
            disableDefaultUI: true,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };

        var map = new google.maps.Map(document.getElementById('map-container'), mapOptions);
        var marker = new google.maps.Marker({
            map: map,
            position: new google.maps.LatLng(lat, lon)
        });
    }

    /**
     * Hero Carousel
     */
    $('.hero-jobs').css({'display': 'block'});

    $('.hero-jobs').owlCarousel({
        items: 5,
        dots: false,
        nav: true,
        navText: ['<i class="fa fa-chevron-left"></i>', '<i class="fa fa-chevron-right"></i>'],
        margin: 20,
        responsive:{
            0:{
                items: 1
            },
            768:{
                items: 2
            },
            992:{
                items: 3
            },
            1200:{
                items: 4
            },
            1400:{
                items: 5
            },        
            1600:{
                items: 6
            },
            2000:{
                items: 7
            }
        }
    });
});