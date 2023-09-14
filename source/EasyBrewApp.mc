import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class EasyBrewApp extends Application.AppBase {
    private var _view;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        _view = new EasyBrewView();
        return [ _view, new EasyBrewDelegate() ] as Array<Views or InputDelegates>;
    }

    // Returns mail view instance
    function getView() as Void {
        return _view;
    }

}

function getApp() as EasyBrewApp {
    return Application.getApp() as EasyBrewApp;
}

// Returns main view instance
function getView() as EasyBrewView {
    return Application.getApp().getView();
}