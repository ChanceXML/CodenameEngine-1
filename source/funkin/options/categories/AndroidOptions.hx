package funkin.options.categories;

class AndroidOptions extends TreeMenuScreen {
	public function new() {
		super('optionsTree.android-name', 'optionsTree.android-desc', 'AndroidOptions');

		add(new Checkbox(getNameID('hitboxHints'), getDescID('hitboxHints'), 'hitboxHints'));
		add(new SliderOption(getNameID('hitboxOpacity'), getDescID('hitboxOpacity'), 0, 1, 0.05, 5, 'hitboxOpacity'));
	}
}
