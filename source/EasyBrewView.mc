import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Attention;

class EasyBrewView extends WatchUi.View {
    private var _typeStateElement;
    private var _typeDurationElement;
    private var _currentTimerElement;
    private var _totalTimerElement;
    private var _resultsPourElement;
    private var _resultsBrewElement;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));

        _typeStateElement = findDrawableById("type_title");
        _typeDurationElement = findDrawableById("type_duration");
        _currentTimerElement = findDrawableById("current_timer");
        _totalTimerElement = findDrawableById("total_timer");
        _resultsPourElement = findDrawableById("resultsPour");
        _resultsBrewElement = findDrawableById("resultsBrew");

        setStateTypeValue(StateType.Ready);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }



// vybrace? Attention.vibrate([new Attention.VibeProfile(50, 1000)]);


    // This will draw the state label to the screen based on status
    function setStateTypeValue(stateType as StateType) as Void {
        var label = "";
        var durationLabel = "";
        var color = Graphics.COLOR_GREEN;

        switch(stateType) {
            case StateType.Ready:
                label = "Ready";
                color = Graphics.COLOR_GREEN;
                break;
            case StateType.Pouring:
                label = "Pouring";
                durationLabel = "(" + DataManager.getPourMinDuration().toString() + "-" + DataManager.getPourMaxDuration().toString() + "s)";
                color = Graphics.COLOR_YELLOW;
                Attention.vibrate([new Attention.VibeProfile(50, 1000)]);
                break;
            case StateType.Extraction:
                label = "Extraction";
                durationLabel = "(" + DataManager.getBrewMinDuration().toString() + "-" + DataManager.getBrewMaxDuration().toString() + "s)";
                color = Graphics.COLOR_WHITE;
                Attention.vibrate([new Attention.VibeProfile(50, 1000)]);
                break;
            case StateType.Done:
                label = "Done";
                color = Graphics.COLOR_GREEN;
                break;
        }
        _typeStateElement.setText(label);
        _typeDurationElement.setText(durationLabel);
        _typeStateElement.setColor(color);

        WatchUi.requestUpdate(); 
    }


    function setTimerValue(value, color) as Void {
        var minutes = value/60;
        var seconds = value%60;
        var secondsFormatted = seconds > 9 ? seconds.toString() : "0" + seconds.toString();
        var formattedValue;

        if (value == 0) {
            formattedValue = "-:--";
        } else  {
            formattedValue = minutes.toString() + ":" + secondsFormatted;
        }
        _currentTimerElement.setText(formattedValue);
        _currentTimerElement.setColor(color);
        WatchUi.requestUpdate();
    }

    function setTotalTimer(value) as Void {
        var minutes = value/60;
        
        var seconds = value%60;
        var secondsFormatted = seconds > 9 ? seconds.toString() : "0" + seconds.toString();

        var formattedValue = minutes.toString() + ":" + secondsFormatted;

        _totalTimerElement.setText(formattedValue);

        WatchUi.requestUpdate();
    }

    function showResults(pourValue, brewValue) as Void {
        var _stateMinDuration;
        var _stateMaxDuration;
        
        //System.println("A hotovo: pour=" + pourTime.toString() + ", brew=" + + brewTime.toString());
        
        // clean old
        _currentTimerElement.setText("");
        _typeStateElement.setText("Results");
        _typeStateElement.setColor(Graphics.COLOR_YELLOW);

        // pour data and color :)
        _stateMinDuration = DataManager.getPourMinDuration();
        _stateMaxDuration = DataManager.getPourMaxDuration();
        if (_stateMinDuration <= pourValue && pourValue <= _stateMaxDuration) {
            _resultsPourElement.setColor(Graphics.COLOR_GREEN);
        } else {
            _resultsPourElement.setColor(Graphics.COLOR_PINK);
        }
        // console debug
        System.println("pour: " + _stateMinDuration.toString() + " < " + + pourValue.toString() + " < " + _stateMaxDuration.toString());
        _resultsPourElement.setText("Brew: " + pourValue.toString() + "s");

        // brew data and color :)
        _stateMinDuration = DataManager.getBrewMinDuration();
        _stateMaxDuration = DataManager.getBrewMaxDuration();
        if (_stateMinDuration > brewValue || brewValue > _stateMaxDuration) {
            _resultsBrewElement.setColor(Graphics.COLOR_PINK);
        } else {
            _resultsBrewElement.setColor(Graphics.COLOR_GREEN);
        }
        _resultsBrewElement.setText("Extraction: " + brewValue.toString()+ "s");

        WatchUi.requestUpdate();
    }
}
