(function() {
  var Image, InfiniteScroll;

  Image = {
    load: function(url, options) {
      var reallyLoading, xhr,
        _this = this;

      xhr = new XMLHttpRequest();
      xhr.open("GET", url);
      xhr.responseType = 'arraybuffer';
      xhr.overrideMimeType('text/plain; charset=x-user-defined');
      reallyLoading = false;
      xhr.onload = function(event) {
        if (xhr.readyState === 4) {
          if (xhr.status === 200) {
            return options.completed();
          }
        }
      };
      xhr.onprogress = function(event) {
        if (reallyLoading) {
          return options.progress((event.loaded / event.total) * 100);
        }
      };
      xhr.send(null);
      return setTimeout(function() {
        return reallyLoading = true;
      }, 500);
    },
    play: function($image) {
      var $canvas, loading, url;

      $canvas = $image.find('canvas');
      $image = $image.find('img');
      url = $image.data('url');
      loading = false;
      $canvas.show();
      $canvas.progressArc({
        styles: {
          fgColor: "#ffffff",
          bgColor: "transparent",
          strokeWidth: 6
        },
        data: {
          start: 0
        }
      });
      if (!$image.data('preview')) {
        $image.data('preview', $image.attr('src'));
      }
      $image.data('playing', true);
      return Image.load(url, {
        progress: function(progress) {
          return $canvas.trigger('setProgress', [progress]);
        },
        completed: function() {
          if ($image.data('playing')) {
            $image.attr('src', url);
            return $canvas.hide();
          }
        }
      });
    },
    pause: function($image) {
      $image = $image.find('img');
      $image.attr('src', $image.data('preview'));
      $image.data('playing', false);
      return $image.find('canvas').hide();
    },
    find: function(element) {
      return jQuery(element).closest('.image');
    }
  };

  InfiniteScroll = {
    scroll: _.throttle(function() {
      var bottom, buffer, callback, nextLink, scrollTop, url;

      scrollTop = $(window).scrollTop();
      bottom = $(document).height() - $(window).height();
      buffer = 1000;
      nextLink = $('.pagination .next a');
      if (nextLink.length && scrollTop > (bottom - buffer)) {
        url = nextLink.attr('href');
        callback = _.once(function(html) {
          return InfiniteScroll.refresh(html, url);
        });
        return $.get(url, callback);
      }
    }, 250),
    refresh: function(html, url) {
      var context;

      history.replaceState(null, null, url);
      context = jQuery(jQuery.parseHTML(html));
      context.find('img.lazy').each(function(idx, el) {
        el = jQuery(el);
        return el.attr('src', el.data('original'));
      });
      jQuery('#group-0').append(context.find('#group-0').html());
      jQuery('#group-1').append(context.find('#group-1').html());
      jQuery('#group-2').append(context.find('#group-2').html());
      jQuery('.pagination').replaceWith(context.find('.pagination'));
      return $('.pagination').hide();
    }
  };

  jQuery(function() {
    jQuery(document).on('mouseenter', '.image-preview', function(event) {
      return Image.play(Image.find(event.target));
    });
    jQuery(document).on('mouseleave', '.image-preview', function(event) {
      return Image.pause(Image.find(event.target));
    });
    $('a').tipsy({
      live: true,
      gravity: 'w',
      offset: 25
    });
    $(window).scroll(InfiniteScroll.scroll);
    InfiniteScroll.scroll();
    $("img.lazy").lazyload({
      failure_limit: 15
    });
    return $(window).trigger('scroll');
  });

}).call(this);
