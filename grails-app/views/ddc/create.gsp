<%@ page import="grails.persistence.Event" %>
<%@ page import="org.codehaus.groovy.grails.plugins.PluginManagerHolder" %>
<%@ page import="org.codehaus.groovy.grails.scaffolding.DomainClassPropertyComparator" %>

<html>
    <head>
	    <!-- Compiled and minified CSS -->
	    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
	    <!-- Compiled and minified JavaScript -->
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
		
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <g:set var="entityName" value="${message(code: '${domainClass.propertyName}.label', default: domainClass.name)}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
	
	<nav class="nav-extended btn waves-effect waves-light blue lighten-2">  
		<div class="nav-content">
		  <ul class="tabs tabs-transparent">
			<li class="tab"><g:link class="list" action="list" params="[dc:params.dc]"><g:message code="Voltar" args="[entityName]" /></g:link></li>
		  </ul>
		</div>
	</nav>
	<body class="white lighten-2">   
	<div class="container" style="margin-top:40px;">
    <body>
        <!--<div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/demo.gsp')}"><g:message code="Voltar"/></a></span>
            <span class="menuButton"><g:link class="list" action="list" params="[dc:params.dc]"><g:message code="Lista" args="[entityName]" /></g:link></span>
        </div>-->
        <div class="body">
              <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${domainInstance}">
            <div class="errors">
                <g:renderErrors bean="${domainInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" enctype="${multiPart?'multipart/form-data':'application/x-www-form-urlencoded'}">
                <div class="dialog">
                    <table>
						  <div class="card"><div class="card-image"></div>

			            <div class="card-content blue lighten-2">
			                <h4 align="center" class="white-text">Cadastrar ${domainClass.name}</h4>
			            </div>
                        <tbody>
                        <%  excludedProps = Event.allEvents.toList() << 'version' << 'id' << 'dateCreated' << 'lastUpdated'
                            persistentPropNames = domainClass.persistentProperties*.name
                            props = domainClass.properties.findAll { persistentPropNames.contains(it.name) && !excludedProps.contains(it.name) }
                            props.sort(new DomainClassPropertyComparator(domainClass))
                            display = true
                            boolean hasHibernate = PluginManagerHolder.pluginManager.hasGrailsPlugin('hibernate')
                            props.each { p ->
                                if (!Collection.class.isAssignableFrom(p.type)) {
                                    if (hasHibernate) {
                                        cp = domainClass.constrainedProperties[p.name]
                                        display = (cp ? cp.display : true)
                                    }
                                    if (display) { %>
                            <tr class="prop">
                                    <label for="${p.name}"><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></label>
									 ${grailsApplication.mainContext.renderEditor.render(out, domainClass, p)}
                         	</tr>	
                                <!--
								<td valign="top" class="name">
								</td>
								<td valign="top" class="value ${hasErrors(bean: domainInstance, field: p.name, 'errors')}">
                                    ${grailsApplication.mainContext.renderEditor.render(out, domainClass, p)}
                                </td>-->
                            
                        <%  }   }   } %>
                        </tbody>
                    </table>
                </div>
                <div class="buttons" align="center">
                    <span class="button"><g:submitButton name="create" class="btn waves-effect waves-light blue lighten-2" style="padding:10px;margin:10px;size:30px;width:110px;" value="${message(code: 'default.button.create.label', default: 'Salvar')}" /></span>
                </div>
                <g:hiddenField name="dc" value="${params.dc}" />
            </g:form>
        </div>
    </body>
</html>
