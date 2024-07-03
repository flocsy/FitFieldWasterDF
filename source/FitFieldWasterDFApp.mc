import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class FitFieldWasterDFApp extends Application.AppBase {
    private var mView as FitFieldWasterDFView;
    public var fitContributor as FitFieldWasterFitContributor;

    function initialize() {
        AppBase.initialize();
        mView = new FitFieldWasterDFView();
        self.fitContributor = new FitFieldWasterFitContributor(mView);
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ mView ] as [Views];
    }

    // triggered by settings change in GCM
    public function onSettingsChanged() as Void {
        self.fitContributor.onSettingsChanged(mView);
    }
}

function getApp() as FitFieldWasterDFApp {
    return Application.getApp() as FitFieldWasterDFApp;
}