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

package org.eclipse.recommenders.templates.jvmmodel

import com.google.inject.Inject
import org.eclipse.xtext.xbase.jvmmodel.AbstractModelInferrer
import org.eclipse.xtext.xbase.jvmmodel.IJvmDeclaredTypeAcceptor
import org.eclipse.xtext.xbase.jvmmodel.JvmTypesBuilder
import org.eclipse.recommenders.templates.snipDSL.domainmodel
import org.eclipse.xtext.naming.IQualifiedNameProvider
import org.eclipse.recommenders.templates.snipDSL.method
import org.eclipse.recommenders.templates.snipDSL.jFaceVariableDeclaration
import org.eclipse.recommenders.templates.snipDSL.entity
import org.eclipse.recommenders.templates.snipDSL.jFaceDeclarationType
import java.util.Collection

/**
 * <p>Infers a JVM model from the source model.</p> 
 *
 * <p>The JVM model should contain all elements that would appear in the Java code 
 * which is generated from the source model. Other models link against the JVM model rather than the source model.</p>     
 */
class SnipDSLJvmModelInferrer extends AbstractModelInferrer {

    /**
     * convenience API to build and initialize JVM types and their members.
     */
	@Inject extension JvmTypesBuilder
	@Inject extension IQualifiedNameProvider
		/**
		 * The whole domain model is treated as a class in order to allow any elements inside it's body
		 * to be treated as members.
		 * This might not be the best approach, but it does the job.
		 * Maybe change it in the future.
		 */
	def dispatch void infer(domainmodel element, IJvmDeclaredTypeAcceptor acceptor, boolean isPreIndexingPhase){
	//	scopeProvider.getScope(element, null);
		//println(this)
		var name=new String();
		name = "CodeSnippet_"+System.currentTimeMillis%100
	
		acceptor.accept(element.toClass(name)).initializeLater[
			if(element.body!=null){
				var dbody=element.body;
				for(feature : dbody.expressions){
			switch feature
			{
				method :{
   								//if(feature.JType!=null){
          						  	members+=feature.toMethod(feature.name.convertJfaceName, feature.computeType) [
              						documentation = feature.documentation
              						for (p : feature.params) {
                					parameters += p.toParameter(p.name.convertJfaceName, p.parameterType)
              						}
             	 					body =feature.body  
             	 				]
             	 				}
             	
   						
   						}
				
			}
			members+=element.toMethod("main", newTypeRef(Void::TYPE))[
					body=element.body
				]
				
			}
		]
		
		
	}
	
	/**
	 * same as the domainmodel method, but for a class
	 */
   	def dispatch void infer(entity element, IJvmDeclaredTypeAcceptor acceptor, boolean isPreIndexingPhase) {
   		// Here you explain how your model is mapped to Java elements, by writing the actual translation code.
   		
   	acceptor.accept( element.toClass( element.fullyQualifiedName )
   			 ).initializeLater [
     			 documentation = element.documentation
      				if (element.JType != null)
        			superTypes += element.JType.type.cloneWithProxies 
   				for (feature : element.features) {
   					switch feature{
   						jFaceVariableDeclaration //sets the name of the feature accordingly
   								:{ 
   									
   									if(feature.JType.type==null)
   									{
   										feature.JType.setType(newTypeRef(feature, typeof(Object) , null));
   									}
   									members+=feature.toField(feature.simpleName.convertJfaceName, feature.JType.type)
   								}
   						method 
   								:{
   								//if(feature.JType!=null){
          						  	members += feature.toMethod(feature.name.convertJfaceName,feature.computeType) [
              						documentation = feature.documentation
              						for (p : feature.params) {
                					parameters += p.toParameter(p.name.convertJfaceName, p.parameterType)
              						}
             	 					body =feature.body  
             	 				]
             	 				}
   						
   						}
   					
   				}
   		
   			]
   	}
 
 def computeType(method expression){
 	var type = expression.newTypeRef(typeof(Object));
 	if(expression.JType==null){
 		type = expression.newTypeRef(Void.TYPE);
 	}else
 	if (expression.getJType().getType() != null) {
            type = expression.getJType().getType();

        } else if (expression.getJType().getJFaceType() != null) {
            var jfaceType = expression.getJType()
                    .getJFaceType();
            if (jfaceType.getType().contains("array")) {
                type = expression.newTypeRef(typeof(Object)).addArrayTypeDimension;

            } else if (jfaceType.getType().contains("interable")) {
                type =expression.newTypeRef(typeof(Iterable))
            } else if (jfaceType.getType().contains("collection")) {
                type = expression.newTypeRef(typeof(Collection))

            }

        }
        return type
 }
 
 def convertJfaceName(String jfaceName){
 	if(jfaceName.contains("newName")){
   						return '${'+jfaceName.substring(jfaceName.indexOf('{')+1,jfaceName.indexOf(':')) +'}'
   	}
   	else return jfaceName
 }
   
}


