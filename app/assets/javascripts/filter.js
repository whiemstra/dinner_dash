$(document).ready(function () {
    $('.mix-wrapper').mixItUp({
        animation: {
            effects: 'fade rotateZ(-180deg)', /* fade scale */
            duration: 700 /* 600 */
        },
        selectors: {
            target: '.mix-target', /* .mix */
            filter: '.filter-btn' /* .filter */
        },
        callbacks: {
            onMixEnd: function (state) {
                console.log(state)
                /* null */
            },
            onMixLoad: function() {
                console.log("loaded");
            },
            onMixStart: function() {
                console.log("started");
            },
            onMixEnd: function() {
                console.log("endd");
            },
            onMixBusy: function() {
                console.log("busy")
            }
        }
    });
});
