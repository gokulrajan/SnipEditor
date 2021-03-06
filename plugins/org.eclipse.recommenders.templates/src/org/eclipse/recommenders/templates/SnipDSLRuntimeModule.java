/*******************************************************************************
 * Copyright (c) 2013 Stefan Prisca.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * 
 * Contributors:
 *     Stefan Prisca - initial API and implementation
 ******************************************************************************/

package org.eclipse.recommenders.templates;

import org.eclipse.xtext.xbase.compiler.XbaseCompiler;

/**
 * Use this class to register components to be used at runtime / without the
 * Equinox extension registry.
 */
public class SnipDSLRuntimeModule extends
        org.eclipse.recommenders.templates.AbstractSnipDSLRuntimeModule {
    @SuppressWarnings("restriction")
    public Class<? extends XbaseCompiler> bindXbaseCompiler() {
        return org.eclipse.recommenders.templates.compiler.SnipDSLSpecificCompiler.class;

    }

    @org.eclipse.xtext.service.SingletonBinding(eager = true)
    public Class<? extends org.eclipse.recommenders.templates.validation.AbstractSnipDSLValidator> bindAbstractSnipDSLValidator() {
        return org.eclipse.recommenders.templates.validation.SnipDSLValidator.class;
    }

    /*
     * public Class<? extends XbaseBatchScopeProvider>
     * bindXbaseBatchScopeProvider() {
     * System.out.println("Scope has changed#1"); return
     * SnipDSLLocalScope.class; }
     */
    // public Class<? extends org.eclipse.xtext.scoping.IScopeProvider>
    // bindIScopeProvider() {
    // System.out.println("Scope has changed");
    // return SnipDSLScopeProvider.class;
    // }

    public Class<? extends org.eclipse.xtext.xbase.typesystem.computation.ITypeComputer> bindITypeComputer() {
        return org.eclipse.recommenders.templates.typing.SnipDSLTypeComputer.class;
    }
}
