<%
String defaultDomainClassCode = """
package nomePacote

class NomeClasse {
    
}
"""
 %>
<html>
    <head>
        <title>jcloud - Paulo</title>
        <!-- Compiled and minified CSS -->
	    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
	    <!-- Compiled and minified JavaScript -->
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
        <style type="text/css" media="screen">

        #nav {
            margin-top:20px;
            margin-left:30px;
            width:228px;
            float:left;

        }
        .homePagePanel * {
            margin:0px;
        }
        .homePagePanel .panelBody ul {
            list-style-type:none;
            margin-bottom:10px;
        }
        .homePagePanel .panelBody h1 {
            text-transform:uppercase;
            font-size:1.1em;
            margin-bottom:10px;
        }
        .homePagePanel .panelBody {
            background: url(images/leftnav_midstretch.png) repeat-y top;
            margin:0px;
            padding:15px;
        }
        .homePagePanel .panelBtm {
            background: url(images/leftnav_btm.png) no-repeat top;
            height:20px;
            margin:0px;
        }

        .homePagePanel .panelTop {
            background: url(images/leftnav_top.png) no-repeat top;
            height:11px;
            margin:0px;
        }
        h2 {
            margin-top:15px;
            margin-bottom:15px;
            font-size:1.2em;
        }
        #pageBody {
            margin-left:280px;
            margin-right:20px;
        }
        </style>
    </head>
    <body>
       
        <div id="pageBody">
            <h1>jcloud</h1>
            <p></p>
						<div id="domainClassCreationPanel" class="dialog">  
						<h2>Criar Classes:</h2>       
						  <%
							if (params?.domainClassCode && params?.domainClassCode.stripIndent() != "") {
							def dds = grailsApplication.mainContext.dynamicDomainService
							params?.domainClassCode.stripIndent().split("package").each {
							if (it != "") {
								dds.registerDomainClass "package$it"
	                                    }
                                    }
								dds.updateSessionFactory grailsApplication.mainContext
                               }		
						    %>  
						  <g:form>
						    <p></p> 
							  
							  <g:textArea name="domainClassCode" cols="100" rows="100" value="${params?.domainClassCode?:defaultDomainClassCode}" style="width:1000px;height:400px"/>
                <p>
                   <span class="button">
                       <g:submitButton name="create" class="save" value="Criar Classe(s)" />
                       <input type="button" value="Limpar" onclick="javascript: document.forms[0].domainClassCode.value=''"/>
                   </span>
                </p>
							</g:form>
						</div>
            <div id="controllerList" class="dialog">
                <ul>
				    Menu:
					
                    <g:each var="dc" in="${grailsApplication.domainClasses.sort { it.fullName } }">
                      <% if (!grailsApplication.getControllerClass("${dc.fullName}Controller")) { %>
                        <li class="controller"><g:link controller="ddc" params="[dc:dc.fullName]">${dc.name}</g:link></li>
                      <% } %>
                    </g:each>
                </ul>
            </div>
            <div id="controllerList" class="dialog">
                
                <ul>
                    <g:each var="c" in="${grailsApplication.controllerClasses.sort { it.fullName } }">
                    		<g:if test="${c.fullName != 'org.grails.dynamicdomain.DdcController'}">
                       	 	<li class="controller"><g:link controller="${c.logicalPropertyName}">${c.name}</g:link></li>
                       	</g:if>
                    </g:each>
                </ul>
            </div>                
        </div>
    </body>
</html>
