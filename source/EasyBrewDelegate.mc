import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Timer;

class EasyBrewDelegate extends WatchUi.BehaviorDelegate {

    private var _inProgress = false;

    private var _currentDuration = 0;
    private var _currentState = 1;
    private var _stateMinDuration = 0;
    private var _stateMaxDuration = 0;
    private var _totalDuration = 0;
    private var _finalPourDurations = 0;
    private var _finalBrewDurations = 0;

    private var _timer;

    private var _view = getView(); 

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelect() as Boolean {
        //System.println("onSelect: click happened: _currentState=" +_currentState.toString());
        if (_currentState == 2) {
            _finalPourDurations = _currentDuration;
        } else if (_currentState == 3) {
            _finalBrewDurations = _currentDuration;
        }
        //  bug
        // bug
        // bug

        //System.println("onSelect: _currentState = " + _currentState.toString() + " ,_currentDuration = " + _currentDuration.toString());
        //System.println("onSelect: _stateMinDuration = " + _stateMinDuration.toString() + " ,_stateMaxDuration = " + _stateMaxDuration.toString());
        if (_inProgress == false) {
            _inProgress = true; 
            //System.println("onSelect: first round");     
        } else {
            _timer.stop();
            //System.println("onSelect: " + _currentState.toString() + " round");
        }
        if (_currentState <4) {
                _currentState++;
                //System.println("onSelect: increased _currentState=" +_currentState.toString());
        }
      /*  switch(_currentState) {
            case StateType.Ready:
                break;
            case StateType.Pouring:
                _stateMinDuration = DataManager.getPourMinDuration();
                _stateMaxDuration = DataManager.getPourMaxDuration();
                _finalPourDurations = _currentDuration;
                break;
            case StateType.Extraction:
                _stateMinDuration = DataManager.getBrewMinDuration();
                _stateMaxDuration = DataManager.getBrewMaxDuration();
                _finalBrewDurations = _currentDuration;
                break;
            case StateType.Done:
                break;
        } 
        // Swith replaced by if and else if
        */ 
        if (_currentState == StateType.Pouring) {
            _stateMinDuration = DataManager.getPourMinDuration();
            _stateMaxDuration = DataManager.getPourMaxDuration();
            _finalPourDurations = _currentDuration;

        } else if (_currentState == StateType.Extraction) {
            _stateMinDuration = DataManager.getBrewMinDuration();
            _stateMaxDuration = DataManager.getBrewMaxDuration();
            _finalBrewDurations = _currentDuration;

        }

        startCountdown();
    
        _view.setStateTypeValue(_currentState);
        // redraw also middle timer
        _view.setTimerValue(0, Graphics.COLOR_WHITE);
    }


    // Starts countdown
    function startCountdown() {
         _view.setStateTypeValue(_currentState);
         _currentDuration = 0;

         _timer = new Timer.Timer();
         _timer.start(method(:updateCountdownValue), 1000, true);

         _view.setTotalTimer(_totalDuration);
    }

    function updateCountdownValue() {
        var color;
        //results = _finalPourDurations;
        if ( _currentState == StateType.Done) {
            //System.println("_finalBrewDurations:" + _finalBrewDurations.toString());
            _timer.stop();
            // and here I need to update the view with results and add posibility to start over
            //System.println("_finalPourDurations:" + _finalPourDurations.toString());
            //_view.showResults(_finalPourDurations.toString(),_finalBrewDurations.toString());
            _view.showResults(_finalPourDurations,_finalBrewDurations);

            return;
        }

        _currentDuration++;
        _totalDuration++;

        if (_currentDuration < _stateMinDuration || _currentDuration > _stateMaxDuration) {
            color = Graphics.COLOR_PINK;
        } else {
            color = Graphics.COLOR_GREEN;
        }
        //System.println("updateCountdownValue: _currentState = " + _currentState.toString() + " ,_currentDuration = " + _currentDuration.toString());
        //System.println("updateCountdownValue: _stateMinDuration = " + _stateMinDuration.toString() + " ,_stateMaxDuration = " + _stateMaxDuration.toString());


        // adding vibration feature
        if (_currentDuration == _stateMinDuration || _currentDuration == _stateMaxDuration) {
            Attention.vibrate([new Attention.VibeProfile(50, 500)]);
        }

        _view.setTimerValue(_currentDuration, color);
        _view.setTotalTimer(_totalDuration);
    }
}