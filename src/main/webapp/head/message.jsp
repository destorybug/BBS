<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的消息</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
</head>
<body>
<div class="modal fade" id="message" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content col-md-12">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h3 class="modal-title text-center" id="exampleModalLabel">消息列表</h3>
                </div>
                <div class="modal-body">
                    <form action="${APP_PATH }/messageController/updateUserSetup" method="post" class="form-horizontal">
                        <input type="hidden" class="form-control" id="userid" name="userid" value="${userid }">
                        <table class="table table-bordered tb-hover">
								<thead>
									<tr>
										<td>序号</td>
										<td>消息发送者</td>
										<td>消息发送时间</td>
										<td>消息内容</td>
										<td>消息状态</td>
										<td class="text-center">操作</td>
									</tr>
								</thead>
								<tbody>
									<!-- 循环开始 -->
									<c:forEach var="messages" items="${message }" varStatus="varStatus">
										<tr>
											<td>${varStatus.count}</td>
											<td>${messages.beuserid}</td>
											<td>${messages.time}</td>
											<td>${messages.mcontent}</td>
											<td>${messages.status}</td>								
											<td class=" text-center">
													<form action="${APP_PATH}/messageController/getUpdatePlate" method="post">
														<input type="hidden" name="bid" value="${messages.mid}">
														<button type="submit" class="btn btn-info btn-xs" data-toggle="modal" 
															data-target="#plateEdit"><a href="${APP_PATH }/articleController/getArticleFid?fid=${messages.fid }">详细</a></button>
														</form>
													<form action="${APP_PATH}/messageController/deleteMessage" method="post">
														<input type="hidden" name="mid" value="${messages.mid}">
														<button type="submit" class="btn btn-danger btn-xs" onclick="return m_del();">删除</button>
													</form>
											</td>
										</tr>
									</c:forEach>
									<!-- 循环结束 -->
									<tr>
										<td class=" text-right">
										<form action="${APP_PATH}/messageController/deleteMessageUserid" method="post">
											<input type="hidden" name="userid" value="${messages.userid}">
											<button type="submit" class="btn btn-danger btn-xs" onclick="return m_del();">全部删除</button>
										</form>
										</td>
									</tr>
								</tbody>
						</table>
                        </form>
                </div>
         	</div>
         </div>
</div>
<script>
		/**
		 * 消息删除确认框
		 * @returns
		 */
		function m_del() { 
			var msg = "您真的确定要删除该消息吗？\n\n删除后不能复原！"; 
			if (confirm(msg)==true){ 
				return true; 
			}else{ 
				return false; 
			}
		}
	</script>
</body>
</html>