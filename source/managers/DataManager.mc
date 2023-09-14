import Toybox.Application;

class DataManager {
    static function getPourMinDuration() {
        return Application.Properties.getValue("pourMinDuration");
    }

    static function getPourMaxDuration() {
        return Application.Properties.getValue("pourMaxDuration");
    }

    static function setPourMinDuration(duration) {
        Application.Properties.setValue("pourMinDuration", duration);
    }

    static function setPourMaxDuration(duration) {
        Application.Properties.setValue("pourMaxDuration", duration);
    }

    static function getBrewMinDuration() {
        return Application.Properties.getValue("brewMinDuration");
    }

    static function getBrewMaxDuration() {
        return Application.Properties.getValue("brewMaxDuration");
    }

    static function setBrewMinDuration(duration) {
        Application.Properties.setValue("brewMinDuration", duration);
    }

    static function setBrewMaxDuration(duration) {
        Application.Properties.setValue("brewMaxDuration", duration);
    }
}