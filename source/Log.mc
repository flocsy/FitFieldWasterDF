import Toybox.Ant;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time;

(:release, :inline)
function log(msg as String) as Void {}
(:debug, :inline)
function log(msg as String) as Void {
    if (LOG) {
        logRelease(msg);
    }
}

(:release, :inline)
function logIf(isEnabled as Boolean, msg as String?) as Void  {}
(:debug, :inline)
function logIf(isEnabled as Boolean, msg as String?) as Void  {
    if (isEnabled) {
        logRelease(msg);
    }
}

(:release, :inline)
function logDebug(msg as String?) as Void {}
(:debug, :inline)
function logDebug(msg as String?) as Void {
    logRelease(msg);
}

(:foreground)
function logRelease(msg as String?) as Void {
    // System.println(Time.now().value() + " " + msg);
    var time = timeFormat(Time.now());
    System.println(time + " " + msg);
}

(:foreground, :inline)
function errorRelease(msg as String?) as Void {
    // var time = timeFormat(Time.now());
    // System.error(time + " " + msg);
    logRelease(msg);
}

(:no_inline)
function timeFormat(moment as Moment) as String {
    var time = Time.Gregorian.info(moment as Moment, Time.FORMAT_SHORT);
    // var time = System.getClockTime(); // -13
    return "" + time.hour.format("%02d") + ':' + time.min.format("%02d") + ':' + time.sec.format("%02d");
}

(:inline)
function timestampFormat(timestamp as Number) as String {
    return timeFormat(new Time.Moment(timestamp));
}
