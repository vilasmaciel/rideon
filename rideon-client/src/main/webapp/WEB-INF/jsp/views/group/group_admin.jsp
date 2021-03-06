<%-- 
    Document   : groups
    Created on : 30-sep-2013, 8:54:50
    Author     : Fer
--%>
<%@include file="../../includes/includes.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<body>
    <div class="row">
        <ol class=" breadcrumb">
            <li><a href="<c:url value="/groups"/>"><spring:message code="jsp.group.groups"/></a></li>
            <li class="active">${group.name}</li>
        </ol>
        <div class="col-sm-7 col-md-8">
            <div class="well">
                <div class="row">
                    <div class="col-sm-4 col-md-3 col-lg-2" style="">
                        <div style="max-width: 100px; margin:auto">
                            <a href="<c:url value="/groups/${group.id}/image"/>">
                                <img src="<c:url value="/groups/${group.id}/image"/>" class="img-thumbnail img-responsive"/>
                            </a>
                        </div>
                    </div>
                    <div class="col-sm-8 col-md-9" style="border:0px solid red;">
                        <h4>${group.name}</h4>
                        <blockquote class="">
                            <c:choose>
                                <c:when test="${not empty group.description}">
                                    ${group.description}
                                </c:when>
                                <c:otherwise>
                                    <em><spring:message code="jsp.form.nodescription"/></em>
                                </c:otherwise>
                            </c:choose>
                        </blockquote>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-8 col-md-9"><span style="color:transparent">Admin</span></div>
                    <div class="col-sm-4 col-md-3">
                        <div class="btn-group" style="text-align: left">
                            <button class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown">
                                <spring:message code="jsp.event.admin"/> <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu pull-left" style="z-index: 1005;" >
                                <li><a href="<c:url value='/groups/${group.id}/edit'/>"><i class="fa fa-fw fa-pencil"></i> <spring:message code="jsp.group.edit"/></a></li>
                                <li><a href="<c:url value='/groups/${group.id}/members'/>"><i class="fa fa-fw fa-group"></i> <spring:message code="jsp.group.members"/></a></li>
                                <li>
                                    <sec:authentication property="principal" var="user"/>
                                    <a href="" id="leave"><i class="fa fa-fw fa-trash-o"></i> <spring:message code="jsp.group.leavegroup"/></a >
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <h1><small><spring:message code="jsp.group.wall"/></small></h1>
            <div class="panel panel-default">
                <div class="panel-body">
                    <c:choose>
                        <c:when test="${fn:length(messages) gt 0}">
                            <ul class="media-list">
                                <c:forEach var="message" items="${messages}">
                                    <li class="media list-group-item " style="overflow:visible;">
                                        <a class="pull-left" href="<c:url value='/${message.owner.username}'/>" >
                                            <img class="media-object img-thumbnail" style="margin:auto" src="<c:url value='/${message.owner.username}/thumbnail'/>" />
                                        </a>
                                        <div class="media-body" style="overflow:visible;">
                                            <div class="media-heading">
                                                <a class="btn btn-default btn-xs dropdown-toggle pull-right" data-mid="${message.id}"><span class="glyphicon glyphicon-trash"></span></a>
                                                <b><small><a href="<c:url value='/${message.owner.username}'/>">${message.owner.username} </a>- ${message.writtingDate}</small></b>
                                            </div>
                                            <p class="caption list-group-item-heading">${message.text}</p>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <em><spring:message code="jsp.message.nomessage"/></em>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="well well-sm">
                <c:url value="/groups/${group.id}/message" var="addMessageUrl"/>
                <div class="form-group">
                    <form:form commandName="message" action="${addMessageUrl}">
                        <spring:message code="jsp.form.writeacomment" var="placeholder"/>
                        <form:input class="form-control" path="text" placeholder="${placeholder}" ></form:input>
                        </div>
                        <input class="btn btn-success btn-sm" type="submit" align="center" value="<spring:message code="jsp.form.send"/>" />
                </form:form>
            </div>
        </div>
        <div class=" col-sm-5 col-md-4 col-lg-4 ">
            <div class="panel panel-default hidden-xs">
                <div class="panel-heading">
                    <span class=""><spring:message code="jsp.group.members"/></span>
                </div>
                <div class="panel-body">
                    <c:choose>
                        <c:when test="${fn:length(members) gt 0}">
                            <table class="table table-hover table-bordered">
                                <c:forEach var="member" items="${members}">
                                    <tr>
                                        <td>
                                            <a href="<c:url value='/${member.username}'/>" style="display:inline-block; width: 100%; height: 100%;">
                                                <img src="<c:url value='/${member.username}/thumbnail'/>" class="media img-thumbnail" 
                                                     style="width: 30px; height: 30px; margin-right: 5px; position: relative" />
                                                ${member.fullName}
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </c:when>
                    </c:choose>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <span><spring:message code="jsp.event.events"/></span>                    
                    <a class="btn btn-success btn-xs pull-right" href="<c:url value='/groups/${group.id}/events/add'/>">
                        <span class="fa fa-plus" style="margin-right: 5px;"></span>
                        <spring:message code="jsp.event.newevent"/></a>
                </div>
                <div class="panel-body">
                    <c:choose>
                        <c:when test="${fn:length(events) gt 0}">
                            <table class="table table-hover table-bordered">
                                <c:forEach var="event" items="${events}">
                                    <tr>
                                        <td>
                                            <a href="<c:url value='/events/${event.id}'/>" style="display:inline-block; width: 100%; height: 100%;">
                                                <img src="<c:url value='/events/${event.id}/thumbnail'/>" class="media img-thumbnail" 
                                                     style="width: 30px; height: 30px; margin-right: 5px; position: relative" />
                                                ${event.name} 
                                        </td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <em><spring:message code="jsp.events.message.noeventsfound"/></em>

                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="myModal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title"><spring:message code="jsp.group.deletegroup"/></h4>
                </div>
                <div class="modal-body">
                    <p>Al salir del grupo, este será elminado junto a todos sus registros asociados.</p>
                    <p><b>¿Estas seguro que quieres eliminar el grupo?</b></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-dismiss="modal"><spring:message code="jsp.form.nodelete"/></button>
                    <button type="button" class="btn btn-danger"  id="confirmLeave"><spring:message code="jsp.form.delete"/></button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    <script>
        $(".group-item").addClass("active");

        $("a[data-mid]").click(function(event) {
            event.preventDefault();
            var baseUrl = "<c:url value="/groups/${group.id}/message/"/>";
            var fullUrl = baseUrl + $(this).data("mid");
            $.ajax({
                url: fullUrl,
                type: 'DELETE',
                // The type of data that is getting returned.
                dataType: "html",
                success: function(response) {
                    console.log("res" + response);
                    window.location.href = "<c:url value="/groups/${group.id}" />";
                },
                error: function(e) {
                    alert("Some error ocurred. Please try it again later");
                    console.log(e);
                }
            });
        });
        $("#confirmLeave").click(function(e) {
            e.preventDefault();
            leaveGroup();
        });
        $("#leave").click(function(e) {
            e.preventDefault();

            var membersSize = ${fn:length(members)};
            if (membersSize === 1) {
                $('#myModal').modal('show')
            }
            else {
                leaveGroup();
            }

        });
        function leaveGroup() {
            var url = '<c:url value='/groups/${group.id}/members/${user.username}'/>';
            $.ajax({
                url: url,
                type: 'DELETE',
                // The type of data that is getting returned.
                dataType: "html",
                success: function(response) {
                    console.log("res" + response);
                    window.location.href = "<c:url value="/groups/" />";
                },
                error: function(e) {
                    alert("Some error ocurred. Please try it again later");
                    console.log(e);
                }
            });
        }
    </script>
</body>