
console.log('Executing...', $('.sidebar > div'));
var stickySidebar = $('.sidebar > div').offset().top;

$(window).on('scroll', onScroll); 

function onScroll() {
    console.log("Scrooll!!!");
    if ($(this).scrollTop() > stickySidebar) {
        console.log('Overpassed');
        $('.sidebar > div').addClass('affix');
    }
    else {
        console.log('Underpassed');
        $('.sidebar > div').removeClass('affix');
    }
}