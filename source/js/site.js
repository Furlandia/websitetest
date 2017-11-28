//= require jquery
//= require bootstrap
//= require jquery.ui.all
//= require ./vendor/flipclock.min
//= require ./vendor/jscookie

(function($) {
    function markNavigation() {
        var page = window.location.pathname;
        page = page.split("/").pop();

        var navLink = $('.navbar-nav a[href="'+page+'"]').parent();
        if(navLink.parent().hasClass('dropdown-menu')) {
            navLink.parent().parent().addClass('active');
        }
        navLink.addClass('active');
    }

    function showMatureEvents() {
        $('#mature-modal').modal('hide');
        $('td.event-mature').off('click').css('cursor', 'default');
        Cookies.set('mature', 'true');
        $.get('mature-events.json').done(function(events) {
            $('td.event-mature').each(function() {
                this.innerHTML = events[$(this).attr('id')]['name'] + '<br/>(18+ Only)';
            });
        }).fail(function() {
            console.log('Error loading mature events...');
        });
    }

    function showMaturePrompt() {
        $('#mature-modal').modal('show');
    }

    $(document).ready(function() {
        markNavigation();
        $('[data-toggle="tooltip"]').tooltip()
        $("[data-toggle=popover]").popover();
        $('nav.navbar').affix({
            offset: {
                top: function() {
                    return (this.top = $('.header').outerHeight(true));
                },
            }
        });

        $("#accordion").accordion({
            active: 0,
            collapsible: true,
            heightStyle: "content"
        });

        var date = new Date(2017, 4, 26, 17); // May 26th 2017, 5:00pm (Opening Ceremonies)
        var now = new Date();
        var diff = (date.getTime()/1000) - (now.getTime()/1000);
        if (diff >= 0) {
            var clock = $('.countdown').FlipClock(diff, {clockFace: 'DailyCounter', countdown: true});
        }

        if (Cookies.get('mature')) {
            showMatureEvents();
        } else {
            $('td.event-mature').click(showMaturePrompt);
            $('.schedule').on('touchstart', 'td.event-mature', showMaturePrompt);
            $('#over-18-button').click(showMatureEvents);
        }

        if (parseInt($(window).width()) < 700) {
            $('#live-stream').attr('width', '100%');
        }
    });
})(jQuery);
