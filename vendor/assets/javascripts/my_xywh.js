/**
 * Implements the spatial media fragments dimension of the W3C Media Fragments
 * URI specification as a polyfill. See
 * http://www.w3.org/TR/media-frags/#naming-space for the full details.
 *
 * The polyfill works for both images and videos, albeit for videos, your
 * mileage may vary, as this requires a wrapper element to be inserted, which
 * may interfere with already existing event handlers on the video and/or
 * existing style definitions that could affect the wrapper element.
 *
 * @author: Thomas Steiner (tomac@google.com) (this particular script sligthly edited by Carlo Andrea Conte for customization)
 * @version: 0.0.2
 * @license: CC0
 */
function applyImageMediaFragments(opt_startElement) {
    var selector = 'img';
    if(opt_startElement!=undefined) selector = opt_startElement;
    var mediaItems = document.querySelectorAll(selector);
    for (var i = 0, len = mediaItems.length; i < len; i++) {
      var mediaItem = mediaItems[i];
      // Make sure we support <video> with multiple <source> child elements:
      // in this case, the <video> @src attribute is empty, but the
      // @currentSrc is set
      var source = mediaItem.src || mediaItem.currentSrc;
      // See http://www.w3.org/TR/media-frags/#naming-space
      var xywhRegEx = /[#&\?]xywh\=(pixel\:|percent\:)?(\d+),(\d+),(\d+),(\d+)/;
      var match = xywhRegEx.exec(source);
      if (match) {
        var mediaFragment = {
          mediaItem: mediaItem,
          mediaType: mediaItem.nodeName.toLowerCase(),
          unit: (match[1] ? match[1] : 'pixel:'),
          x: match[2],
          y: match[3],
          w: match[4],
          h: match[5]
        };
        
          applyFragment(mediaFragment);
          mediaFragment.mediaItem.src = 'data:image/gif;base64,R0lGODlhAQABAPAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==';
        
      }
    }
  }
  
  function applyFragment(fragment) {
    var mediaItem = fragment.mediaItem;
    var x, y, w, h;
    var originalWidth, originalHeight;
    // Unit is pixel:
    if (fragment.unit === 'pixel:') {
      w = fragment.w + 'px';
      h = fragment.h + 'px';
      x = '-' + fragment.x + 'px';
      y = '-' + fragment.y + 'px';
    // Unit is percent:
    } else {
      originalWidth = mediaItem.width || mediaItem.videoWidth;
      originalHeight = mediaItem.height || mediaItem.videoHeight;
      w = (originalWidth * fragment.w / 100) + 'px';
      h = (originalHeight * fragment.h / 100) + 'px';
      x = '-' + (originalWidth * fragment.x / 100) + 'px';
      y = '-' + (originalHeight * fragment.y / 100) + 'px';
    }
   
    
      mediaItem.style.cssText += 'width:' + w + ';' +
          'height:' + h + ';' +
          'background:url(' + mediaItem.src + ') ' + // background-image
          'no-repeat ' + // background-repeat
          x + ' ' + y + '; ' + // background-position
          'background-size: '+originalWidth+'px '+originalHeight+'px;'; 
  }
  
function addMediaFragmentOnImageLoad(){
	$("img").load(function(){
		applyImageMediaFragments("#"+$(this).attr("id"));
	});
}
