<%@ page import="grails.persistence.Event" %>
<%@ page import="org.codehaus.groovy.grails.scaffolding.DomainClassPropertyComparator" %>
<html>
    <head>
        <!-- Compiled and minified CSS -->
	    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
	    <!-- Compiled and minified JavaScript -->
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
		
        <g:set var="entityName" value="${message(code: '${domainClass.propertyName}.label', default: domainClass.name)}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
	    <nav class="nav-extended btn waves-effect waves-light  blue lighten-2">  
			<div class="nav-content">
			   <ul class="tabs tabs-transparent">
				<li class="tab"><g:link class="list" action="list" params="[dc:params.dc]"><g:message code="Voltar" args="[entityName]" /></g:link></li>
				<li class="tab"><g:link class="create" action="create" params="[dc:params.dc]"><g:message code="Novo" args="[entityName]" /></g:link></li>
			  </ul>
			</div>
		</nav>
        <div class="body">
            <h1><g:message code="Dados" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
					  <div class="card-content blue lighten-2">
                           <h4 align="center" class="white-text">Cadastrar Dados Paciente</h4>
                      </div> 
                    <%  excludedProps = Event.allEvents.toList() << 'version'
                        allowedNames = domainClass.persistentProperties*.name << 'id' << 'dateCreated' << 'lastUpdated'
                        props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) }
                        props.sort(new DomainClassPropertyComparator(domainClass))
                        props.each { p -> %>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></td>
                            <%  if (p.isEnum()) { %>
                            <td valign="top" class="value">${fieldValue(bean: domainInstance, field: p.name)}</td>
                            <%  } else if (p.oneToMany || p.manyToMany) { %>
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <% items = domainInstance."$p.name" 
                                   items.each { item -> %>
                                    <li><g:link controller="ddc" action="show" id="${item.id}" params="[dc:p.referencedDomainClass.fullName]">${item?.encodeAsHTML()}</g:link></li>
                                                                <% } %>
                                </ul>
                            </td>
                            <%  } else if (p.manyToOne || p.oneToOne) { 
                                  item = domainInstance."$p.name" %>
                            <td valign="top" class="value"><g:link controller="ddc" action="show" id="${item.id}" params="[dc:p.referencedDomainClass.fullName]">${item?.encodeAsHTML()}</g:link></td>
                            <%  } else if (p.type == Boolean.class || p.type == boolean.class) { 
                                  value = domainInstance."$p.name" %>
                            <td valign="top" class="value"><g:formatBoolean boolean="${value}" /></td>
                            <%  } else if (p.type == Date.class || p.type == java.sql.Date.class || p.type == java.sql.Time.class || p.type == Calendar.class) { 
                                  value = domainInstance."$p.name" %>
                            <td valign="top" class="value"><g:formatDate date="${value}" /></td>
                            <%  } else if(!p.type.isArray()) { %>
                            <td valign="top" class="value">${fieldValue(bean: domainInstance, field: p.name)}</td>
                            <%  } %>
                        </tr>
                    <%  } %>
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${domainInstance?.id}" />
                    <g:hiddenField name="dc" value="${params.dc}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
