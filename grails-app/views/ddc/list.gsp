<%@ page import="grails.persistence.Event" %>
<%@ page import="org.codehaus.groovy.grails.scaffolding.DomainClassPropertyComparator" %>
<html>
    <head>
        <!-- Compiled and minified CSS -->
	    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
	    <!-- Compiled and minified JavaScript -->
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
	
        <g:set var="entityName" value="${message(code: '${domainClass.propertyName}.label', default: domainClass.name)}" />
        <title><g:message code="default.list.label" args="[entityName]" />Paulo</title>
    </head>
	
	<nav class="nav-extended btn waves-effect waves-light  blue lighten-2 z-depth-5">
		<div class="nav-content">
		  <ul class="tabs tabs-transparent">
			<li class="tab"><a class="active" href="${createLink(uri: '/demo.gsp')}" >Voltar</a></li>
			<li class="tab  disabled"><a class="active" class="active">Lista</a></li>
			<li class="tab"><g:link class="create" action="create" params="[dc:params.dc]"><g:message code="Novo" args="[entityName]" /></g:link></li>
		  </ul>
		</div>
	</nav>
	<body class="white lighten-2">
   	<div class="container" style="margin-top:40px;">
	
    <body>	
		<g:form action="buscar" method="post" class="paciente">
			<div class="list">
				<div class="input-field col s8 ">
				<input type="text" placeholder="Buscar ${domainClass.name}" id="nome" name="nome" ><br/>
			</div>
			<div class="buttons" align="center">
				<span class="button"><input  class="btn waves-effect waves-light blue lighten-2" style="padding:10px;margin:10px;size:30px;width:110px;" type="submit" value="Buscar"/></span>
			</div><br>
		</g:form>
		
		<div class="card">
		  <div class="card-image"></div>
        <div class="body">
		
        <!--<div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/demo.gsp')}"><g:message code="Voltar"/></a></span>
            <span class="menuButton"><g:link class="create" action="create" params="[dc:params.dc]"><g:message code="Novo" args="[entityName]" /></g:link></span>
        </div>-->
        <div class="body">
	        <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
				 <div class="card-content blue lighten-2 z-depth-5">
					<h4 align="center" class="white-text">Listar ${domainClass.name}(s)</h4>
				</div>	
                 <table class="striped left grey lighten-2 z-depth-5">
                    <thead>
                        <tr>
                        <%  excludedProps = Event.allEvents.toList() << 'version'
                            allowedNames = domainClass.persistentProperties*.name << 'id' << 'dateCreated' << 'lastUpdated'
                            props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && !Collection.isAssignableFrom(it.type) }
                            props.sort(new DomainClassPropertyComparator(domainClass))
                            props.eachWithIndex { p, i ->
                                if (i < 6) {
                                    if (p.isAssociation()) { %>
                            <th><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></th>
                        <%      } else { %>
                            <g:sortableColumn property="${p.name}" title="${message(code: '${domainClass.propertyName}.${p.name}.label', default: p.naturalName)}" params="[dc:params.dc]" />
                        <%  }   }   } %>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${domainInstanceList}" status="i" var="domainInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        <%  props.eachWithIndex { p, j ->
                                if (j == 0) { %>
                            <td><g:link action="show" id="${domainInstance.id}" params="[dc:params.dc]">${fieldValue(bean: domainInstance, field: p.name)}</g:link></td>
                        <%      } else if (j < 6) {
                                    if (p.type == Boolean.class || p.type == boolean.class) { %>
                            <td><g:formatBoolean boolean="domainInstance.${p.name}" /></td>
                        <%          } else if (p.type == Date.class || p.type == java.sql.Date.class || p.type == java.sql.Time.class || p.type == Calendar.class) { %>
                            <td><g:formatDate date="domainInstance.${p.name}" /></td>
                        <%          } else { %>
                            <td>${fieldValue(bean: domainInstance, field: p.name)}</td>
                        <%  }   }   } %>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <!--<g:paginate total="${domainInstanceTotal}" params="[dc:params.dc]" />-->
				 <ul class="pagination" align="center"><li class="active"><g:paginate total="${domainInstanceTotal}" params="[dc:params.dc]"/></ul>
            </div>
        </div>
    </body>
</html>
