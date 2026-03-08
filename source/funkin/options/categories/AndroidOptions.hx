package funkin.options.categories;

import flixel.FlxG;
import funkin.options.Options;
import funkin.ui.menu.Checkbox;
import funkin.ui.menu.SliderOption;
// android options
class AndroidOptions extends TreeMenuScreen {

    public function new() {
        super('optionsTree.android-name', 'optionsTree.android-desc', '');

        add(new Checkbox(
            getNameID('hitboxHints'),      // Display name
            getDescID('hitboxHints'),      // Description
            'hitboxHints'                  // Save key
        ));

        add(new SliderOption(
            getNameID('hitboxOpacity'),    // Display name
            getDescID('hitboxOpacity'),    // Description
            0,                             // Min value
            1,                             // Max value
            0.05,                          // Step
            5,                             // Precision
            'hitboxOpacity'                // Save key
        ));
    }
}
