/*!
 * ProgressArc 0.1
 * MIT licensed
 *
 * Copyright (C) 2012 Claire Sosset, http://clairesosset.fr
 */

;(function ( $, window, undefined ) {
    

    var pluginName = 'progressArc',
        document = window.document,
        defaults = {
            styles: {
                fgColor : "#f00",
                bgColor : "#eee",
                strokeWidth: 4
            },
            data: {
                min : 0,
                max : 100,
                start : 90
            },
            cursor: true
        };


    //UTILS

    //convert degree to radian
    var _degreeToRadian = function _degreeToRadian(deg){
        return Math.PI * deg / 180;
    };

    //convert radian to degree
    var _radianToDegree = function _radianToDegree(rad){
        return (180 * (rad)) / Math.PI;
    };


    //PLUGIN
    function Plugin( element, options ) {
        this.el = element;
        this.$el = $(this.el);

        this.options = $.extend( true, defaults, options);

        this.size = this.$el.outerWidth();
        this.radius = this.size / 2;
        this.ctx = null;
        this.center = {};
        this.origin = {};

        this._defaults = defaults;
        this._name = pluginName;

        this.init();
    }

    var p = Plugin.prototype;

    p.init = function () {
        this._setup();
        this._drawBackground();
        this._attachEvents();
        this._startView();
    };


    //setup
    p._setup = function _setup(){
        this.ctx = this.el.getContext('2d');

        this.origin.x = this.$el.offset().left + this.radius;
        this.origin.y = this.$el.offset().top + this.radius;
    };

    

    //draw the progress arc
    p._drawArc = function _drawArc(ea, o, color){
        this.ctx.beginPath();
        this.ctx.arc( this.radius, this.radius, ( this.radius - (this.options.styles.strokeWidth / 2) ), (Math.PI/180)* (-90), ea, o);
        this.ctx.strokeStyle = color;
        this.ctx.lineWidth = this.options.styles.strokeWidth;
        this.ctx.stroke();
    };

    //draw the backbround circle
    p._drawBackground = function _drawBackground(){
        var rad = _degreeToRadian(90);
        this._drawArc(((Math.PI/180)*360) - rad, 1, this.options.styles.bgColor);
    };

    p._updateData = function _updateData(angle){
        var deg,
            percent,
            currentVal,
            data = this.options.data,
            total = data.max - data.min;

            deg = _radianToDegree(angle);

            if(deg < 0){
                deg = 180 +( 180 - Math.abs(deg));
            }

            percent = Math.round(deg * 100 / 360);
            currentVal = percent * total / 100;
            
            this.$el.trigger('change',[currentVal]);
    };

    p._attachEvents = function _attachEvents(){

        var self = this,
            flag = false,
            cursorCoords,
            $doc = $(document),
            $html = $('html'),
            cls = 'state-dragging',
            touch = ('ontouchstart' in window),

            //events
            onDown = (touch) ? 'touchstart' : "mousedown",
            onMove = (touch) ? 'touchmove' : "mousemove",
            onUp = (touch) ? 'touchend' : "mouseup";

            function getCursorPos (e){

                if(touch){
                    var t = e.originalEvent.targetTouches[0];
                    return {
                        x : t.pageX,
                        y : t.pageY
                    };

                } else {
                    return {
                        x : e.clientX,
                        y : e.clientY
                    };
                }
            }

            if(this.options.cursor){
                this.$el.on(onDown, function(e){
                    flag = true;
                    $html.addClass(cls);
                    cursorCoords = getCursorPos(e);
                    self._drawProgress(cursorCoords);
                });

                $doc.on(onMove, function(e){
                    if(flag){
                        e.preventDefault();
                        cursorCoords = getCursorPos(e);
                        self._drawProgress(cursorCoords);
                    }
                    
                });

                $doc.on(onUp, function(e){
                    if(flag){
                        $html.removeClass(cls);
                        flag = false;
                    }
                });
            }

            this.$el.on('setProgress',function(e,val){
                self._drawProgress(self._getAngle(val));
            });
    };

    p._drawProgress = function _drawProgress(coords){
        var x,
            y,
            signX,
            signY,
            rad = _degreeToRadian(90),
            endAngle;

            this.ctx.clearRect(0, 0, this.size, this.size);
            this._drawBackground();


            if('object' == typeof coords){
                signX = (coords.x < this.origin.x) ? -1 : 1;
                signY = (coords.y < this.origin.y) ? 1  : -1;
                
                x = Math.abs(this.origin.x - coords.x) * signX;
                y = Math.abs(this.origin.y - coords.y) * signY;

                endAngle = Math.atan2(x,y);
            } else {
                //from startView \\ setProgress event
                endAngle = coords;
            }

            this._drawArc( endAngle - rad, 0, this.options.styles.fgColor);

            this._updateData(endAngle);
    };


    p._getAngle = function _getAngle(val){
        var currentPercent = val * 100 / (this.options.data.max - this.options.data.min),
            currentAngle = _degreeToRadian((currentPercent * 360 / 100));

            return currentAngle;
    };

    p._startView = function _startView(){
            this._drawProgress(this._getAngle(this.options.data.start));
    };

    $.fn[pluginName] = function ( options ) {
        return this.each(function () {
            if (!$.data(this, 'plugin_' + pluginName)) {
                $.data(this, 'plugin_' + pluginName, new Plugin( this, options ));
            }
        });
    };

}(jQuery, window));