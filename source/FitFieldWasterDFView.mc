import Toybox.Activity;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;

class FitFieldWasterDFView extends WatchUi.DataField {
    private var mValue as String?;

    // Set the label of the data field here.
    function initialize() {
        // label = "FitFieldWaster";
        DataField.initialize();
    }

    // The given info object contains all the current workout
    // information. Calculate a value and return it in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info as Activity.Info) as Void {
        // See Activity.Info in the documentation for available information.
        var value = getApp().fitContributor.setData();
        if (value != mValue) {
            mValue = value;
            WatchUi.requestUpdate();
        }
    }

    function onUpdate(dc as Graphics.Dc) as Void {
        var bgColor = getBackgroundColor();
        var fgColor = bgColor == Graphics.COLOR_BLACK ? Graphics.COLOR_WHITE : Graphics.COLOR_BLACK;
        dc.setColor(fgColor, bgColor);
        dc.clear();
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_XTINY, mValue, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }

    public function onTimerLap() as Void {
        getApp().fitContributor.onTimerLap();
    }

}