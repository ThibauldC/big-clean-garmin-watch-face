import Toybox.Graphics;
import Toybox.Lang;
//import Toybox.System;
import Toybox.WatchUi;
using Toybox.Time.Gregorian;
using Toybox.ActivityMonitor;
using Toybox.UserProfile;
using Toybox.System;

class BigCleanFaceView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
    
        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        var view = View.findDrawableById("TimeLabel") as Text;
        view.setText(timeString);

        var days = {
            1 => "SUNDAY",
            2 => "MONDAY",
            3 => "TUESDAY",
            4 => "WEDNESDAY",
            5 => "THURSDAY",
            6 => "FRIDAY",
            7 => "SATURDAY"
        };

        var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
	    var dateString = Lang.format(
	    "$1$ $2$",
	    [
            today.day,
            days[today.day_of_week]
	    ]);

        var dateView = View.findDrawableById("DateLabel") as Text;
        dateView.setText(dateString);

        var steps = ActivityMonitor.getInfo().steps;
        //var floors = ActivityMonitor.getInfo().floorsClimbed;
        var rhr = UserProfile.getProfile().restingHeartRate;

        var stepCountView = View.findDrawableById("StepCountLabel") as Text;
        var stepCountString = Lang.format("$1$", [steps.format("%02d")]);
        stepCountView.setText(stepCountString);

        var rhrView = View.findDrawableById("RhrLabel") as Text;
        var rhrString = Lang.format("$1$", [rhr]);
        rhrView.setText(rhrString);

        var stepView = View.findDrawableById("StepLabel") as Text;
        var stepString = Lang.format("$1$", ["STEPS"]);
        stepView.setText(stepString);

        var activityView = View.findDrawableById("ActivityLabel") as Text;
        var activityString = Lang.format("$1$", ["RHR"]);
        activityView.setText(activityString);

        //var profile = UserProfile.getUserActivityHistory().next();


        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        //dc.drawLine(displayWidthMid, displayHeight, displayWidthMid, 0);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
