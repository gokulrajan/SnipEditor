/*
 * generated by Xtext
 */
package org.eclipse.recommenders.internal.snipmatch.rcp;

import org.eclipse.recommenders.internal.snipmatch.rcp.editors.MultiPageSnipEditor;
import org.eclipse.recommenders.templates.rcp.contentassist.SnipDSLProposalProvider;
import org.eclipse.ui.plugin.AbstractUIPlugin;
import org.eclipse.xtext.ui.editor.XtextEditor;

/**
 * Use this class to register components to be used within the IDE.
 */
public class SnipDSLUiModule extends
        org.eclipse.recommenders.templates.rcp.AbstractSnipDSLUiModule {
    public SnipDSLUiModule(AbstractUIPlugin plugin) {
        super(plugin);
    }

    // contributed by org.eclipse.xtext.ui.generator.ImplicitUiFragment
    public Class<MultiPageSnipEditor> bindMultiPageEditor() {
        System.out.print("my editor is binded");
        return MultiPageSnipEditor.class;
    }
}
