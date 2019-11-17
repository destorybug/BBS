<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人中心主体内容</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<link href="${APP_PATH}/static/css/css.css" rel="stylesheet">
</head>
<body>
	<div class="container">
		<!--上半部分-->
		<div class="row">
			<div class="col-md-10 col-md-offset-1"
				style="background-color: #ffffff; border-radius: 2px;">
				<div class="row">
					<div>
						<img
							style="position: relative; width: 100%; height: 280px; border-top-left-radius: 2px; border-top-right-radius: 2px;"
							src="${APP_PATH }/static/img/beijing.jpg">
					</div>
				</div>
				<div class="row">
					<div class="col-md-2">
						<a href="#" data-toggle="modal" data-target="#userPhoto">
						<c:if test="${myListUser.userphoto==null }">
							<img class="img-thumbnail"
								style="position: relative; width: 140px; height: 140px; left: 10px; top: -20px;"
								src="${APP_PATH }/static/img/head.jpg">
						</c:if>
						<c:if test="${myListUser.userphoto!=null }">
							<img class="img-thumbnail"
								style="position: relative; width: 140px; height: 140px; left: 10px; top: -20px;"
								src="${APP_PATH }/static/upload/user/${myListUser.userphoto }">
						</c:if>
						</a>
					</div>
					<div class="col-md-12 col-xs-12">
						<div class="row">
							<div class="col-md-12">
								<!-- 用户名 -->
								<b style="font-size: 22px;">${myListUser.name }</b> &nbsp;&nbsp;&nbsp; <span>程序员</span>
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-md-12">
								<b>居住地</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span>${myListUser.family }</span>
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-md-12">
								<b>个人简介</b> &nbsp;&nbsp;&nbsp; <span>${myListUser.intro }</span>
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-md-12">
								<b>电子邮箱</b> &nbsp;&nbsp;&nbsp; <span>${myListUser.email }</span>
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-md-10 col-xs-7">
								<b>性别年龄</b> &nbsp;&nbsp;&nbsp; <span>${myListUser.sex }、${myListUser.age }</span>
							</div>
							<div class="col-md-2 col-xs-2">
								<button type="button" class="btn btn-info" data-toggle="modal" data-target="#edit">
								编辑个人资料</button>
							</div>
						</div>
						<br>
						
					</div>
				</div>
			</div>
		</div>

		<!--下半部分-->
		<div class="row" style="position: relative; top: 10px;">
			<div class="col-md-10 col-md-offset-1"
				style="background-color: #ffffff; border-radius: 2px;">
				<div>
					<!-- Nav tabs -->
					<ul class="nav nav-tabs" role="tablist">
						<!-- 动态 -->
						<c:forEach items="${myListArticles }" varStatus="varStatus">
							<c:set var="count_Article" value="${varStatus.count }"></c:set>
						</c:forEach>
						<!-- 回复 -->
						<c:forEach items="${myComments_huifu }" varStatus="varStatus">
							<c:set var="count_Comment" value="${varStatus.count }"></c:set>
						</c:forEach>
						<!-- 收藏 -->
						<c:forEach var="myListCollect" items="${myListCollects }" varStatus="varStatus">
							<c:set var="count_Collect" value="${varStatus.count }"></c:set>
						</c:forEach>
						<!-- 消息 -->
						<c:forEach var="message" items="${myListMessages }" varStatus="varStatus">
							<c:set var="count_Message" value="${varStatus.count }"></c:set>
						</c:forEach>
						
						<li role="presentation" class="active">
							<a href="#home" aria-controls="home" role="tab" data-toggle="tab">动态 <samp>${count_Article }</samp></a>
						</li>
						<li role="presentation">
							<a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">回答 <samp>${count_Comment }</a>
						</li>
						<li role="presentation">
							<a href="#attention" aria-controls="attention" role="tab" data-toggle="tab">关注</a>
						</li>
						<li role="presentation">
							<a href="#collect" aria-controls="collect" role="tab" data-toggle="tab">我的收藏 <samp>${count_Collect }</samp></a>
						</li>
						<li role="presentation">
							<a href="#message" aria-controls="message" role="tab" data-toggle="tab">我的消息 <samp>${count_Message }</samp></a>
						</li>
					</ul>

					<!-- Tab panes -->
					<div class="tab-content">
						<br>
						<!-- 帖子循环-开始（动态） -->
						<div role="tabpanel" class="tab-pane active" id="home">
							<c:if test="${myListArticles==\"[]\" }">
								<br><br><br><br>
								<div class="text-center">
									<img alt="没发过帖子" src="${APP_PATH }/static/img/article.png">
									<p style="color: #999999">你很懒，还没有发过帖子</p>
								</div>
								<br><br><br><br>
							</c:if>
							<c:forEach var="myListArticle" items="${myListArticles }">
								<!--动态-->
								<div class="row">
									<div class="col-xs-7 col-md-6">
										<!-- 帖子审核状态 -->
										<small>审核状态：</small>
										<!-- 待审核状态 -->
										<c:if test="${myListArticle.status==0 }">
											<small class="btn-warning">待审核。。。</small>
										</c:if>
										<!-- 审核通过状态 -->
										<c:if test="${myListArticle.status==1 }">
											<small class="text-success"><b>审核通过</b></small>
										</c:if>
										<!-- 审核未通过状态 -->
										<c:if test="${myListArticle.status==2 }">
											<small class="btn-danger">审核未通过</small>
										</c:if>
									</div>
									<div class="col-xs-5 col-md-2 col-md-offset-4"
										style="position: relative;">
										<!-- 时间 -->
										<small>${myListArticle.time }</small>
									</div>
									
									<div class="col-xs-12 col-md-12">
										<h4>
											<!-- 标题 -->
											<b>${myListArticle.titles }</b>
										</h4>
									</div>
									<div class="col-xs-12 col-md-12">
										<!-- 内容 -->
										<p>${myListArticle.fcontent }</p>
									</div>
									<div class="col-xs-12 col-md-12">
										<c:if test="${myListArticle.photo!=\"photo\" }">
											<a href="${APP_PATH }/static/upload/article/${myListArticle.photo }" target="_blank">
												<c:if test="${myListArticle.photo.endsWith(\".mp4\")||myListArticle.photo.endsWith(\".avi\") }">
													<video controls="controls" src="${APP_PATH }/static/upload/article/${myListArticle.photo }"
														style="position: relative; width: 30%; height: 30%;"></video>
												</c:if>
												<c:if test="${!myListArticle.photo.endsWith(\".mp4\")&&!myListArticle.photo.endsWith(\".avi\") }">
													<img src="${APP_PATH }/static/upload/article/${myListArticle.photo }"
														style="position: relative; width: 30%; height: 30%;">
												</c:if>
											</a>
										</c:if>
									</div>
									<div class="col-xs-7 col-md-10"></div>
									<div class="col-xs-2 col-md-1">
										<form action="${APP_PATH }/articleController/getUpdateArticle">
											<input type="hidden" name="fid" value="${myListArticle.fid }">
											<input type="hidden" name="titles" value="${myListArticle.titles }">
											<input type="hidden" name="bname" value="${myListArticle.bname }">
											<input type="hidden" name="fcontent" value="${myListArticle.fcontent }">
											<input type="hidden" name="photo" value="${myListArticle.photo }">
											
											<button type="submit" class="btn btn-info btn-sm">修改</button>
										</form>
									</div>
									<div class="col-xs-3 col-md-1">
										<form action="${APP_PATH }/articleController/deleteArticle">
											<input type="hidden" name="fid" value="${myListArticle.fid }">
											<button type="submit" class="btn btn-danger btn-sm" onclick="return f_del();">删除</button>
										</form>
									</div>
								</div>
	
								<!--评论-循环开始（动态）-->
								<c:set var="myListComment_Fid" value="myListComment_${myListArticle.fid }"></c:set>
								<c:forEach var="myComment_list" items="${map[myListComment_Fid]}">
									<hr style="position: relative; margin-top: 2px;height:1px;border:none;border-top:1px dashed #dddddd;">
									<div class="row" style="position: relative; margin-top: -10px;">
										<div class="col-xs-9 col-md-11">
											<a href="${APP_PATH}/userController/getOthers?userid=${myComment_list.userid }" class="a_p">
												<!-- 评论者姓名 -->
												<b>${myComment_list.name }</b>
											</a>
											&nbsp;&nbsp;&nbsp;
											<small>${myComment_list.time }</small>
											<!-- 评论者内容 -->
											<p>${myComment_list.pcontent }</p>
										</div>
										<div class="col-xs-3 col-md-1">
											<form action="${APP_PATH }/commentController/deleteComment">
												<input type="hidden" name="pid" value="${myComment_list.pid }">
												<input type="hidden" name="fid" value="${myListArticle.fid }">
												<input type="hidden" name="userid" value="${myComment_list.userid }">
												<button type="submit" class="btn btn-danger btn-sm" onclick="return p_del();">删除</button>
											</form>
										</div>
									</div>
								</c:forEach>
								<!--评论-循环结束（动态）-->
								<hr style="height:1px;border:none;border-top:1px solid #bbbbbb;">
							</c:forEach>
							<!-- 帖子循环-结束（动态） -->
						</div>
						
						
						
						<!--回答-->
						<!-- 帖子循环-开始（动态） -->
						<div role="tabpanel" class="tab-pane" id="profile">
							<c:if test="${myComments_huifu==\"[]\" }">
								<br><br><br><br>
								<div class="text-center">
									<img alt="没评论过帖子" src="${APP_PATH }/static/img/comment.png">
									<p style="color: #999999">你很懒，还没有评论过任何帖子</p>
								</div>
								<br><br><br><br>
							</c:if>
							<c:forEach var="myComment_huifu" items="${myComments_huifu }">
								<c:set var="myArticle_Fid" value="myArticle_${myComment_huifu.fid }"></c:set>
								<!-- 只显示通过审核的帖子 -->
								<c:if test="${map_huifu[myArticle_Fid].status==1 }">
									<div class="row">
										<div class="col-xs-7 col-md-6">
											<!-- 帖子作者 -->
											<small>作者：${map_huifu[myArticle_Fid].username }</small>
										</div>
										<div class="col-xs-5 col-md-2 col-md-offset-4"
											style="position: relative;">
											<!-- 时间 -->
											<small>${map_huifu[myArticle_Fid].time }</small>
										</div>
									
										<div class="col-xs-12 col-md-12">
											<h4>
												<!-- 标题 -->
												<b>${map_huifu[myArticle_Fid].titles}</b>
											</h4>
										</div>
										<div class="col-xs-12 col-md-12">
											<!-- 内容 -->
											<p>${map_huifu[myArticle_Fid].fcontent}</p>
										</div>
										<div class="col-xs-12 col-md-12">
											<c:if test="${map_huifu[myArticle_Fid].photo!=\"photo\" }">
												<a href="${APP_PATH }/static/upload/article/${map_huifu[myArticle_Fid].photo }" target="_blank">
													<c:if test="${map_huifu[myArticle_Fid].photo.endsWith(\".mp4\")||map_huifu[myArticle_Fid].photo.endsWith(\".avi\") }">
														<video controls="controls" src="${APP_PATH }/static/upload/article/${map_huifu[myArticle_Fid].photo }"
															style="position: relative; width: 30%; height: 30%;"></video>
													</c:if>
													<c:if test="${!map_huifu[myArticle_Fid].photo.endsWith(\".mp4\")&&!map_huifu[myArticle_Fid].photo.endsWith(\".avi\") }">
														<img src="${APP_PATH }/static/upload/article/${map_huifu[myArticle_Fid].photo }"
															style="position: relative; width: 30%; height: 30%;">
													</c:if>
												</a>
											</c:if>
										</div>
									</div>
		
									<!--评论-循环开始（回复）-->
									<c:set var="myListComment_Fid" value="myListComment_huifu_${myComment_huifu.fid }"></c:set>
									<c:forEach var="myComment_list" items="${map_huifu_p[myListComment_Fid]}">
										<hr style="position: relative; margin-top: 2px;height:1px;border:none;border-top:1px dashed #dddddd;">
										<div class="row" style="position: relative; margin-top: -10px;">
											<div class="col-xs-10 col-md-11">
												<a href="${APP_PATH}/userController/getOthers?userid=${myComment_list.userid }" class="a_p">
													<!-- 评论者姓名 -->
													<b>${myComment_list.name }</b>
												</a>
												&nbsp;&nbsp;&nbsp;
												<!-- 时间 -->
												<small>${myComment_list.time }</small>
												<!-- 评论者内容 -->
												<p>${myComment_list.pcontent }</p>
											</div>
											<!-- 如果该评论者是本用户时可以修改自己的评论，否则不能 -->
											<c:if test="${myComment_list.userid==userid }">
												<form action="${APP_PATH }/commentController/deleteComment">
													<input type="hidden" name="pid" value="${myComment_list.pid }">
													<input type="hidden" name="fid" value="${myComment_huifu.fid }">
													<input type="hidden" name="userid" value="${myComment_list.userid }">
													<button type="submit" class="btn btn-danger btn-sm" onclick="return p_del();">删除</button>
												</form>
											</c:if>
										</div>
									</c:forEach>
									<!--评论-循环结束（回复）-->
									<hr style="height:1px;border:none;border-top:1px solid #bbbbbb;">
								</c:if>
							</c:forEach>
							<!-- 帖子循环-结束（回复） -->
						</div>
						
						
						<!--关注-->
						<div role="tabpanel" class="tab-pane" id="attention">
							<ul class="nav nav-tabs" role="tablist">
								<!-- 我关注的 -->
								<c:forEach var="myListAttention" items="${myListAttentions }" varStatus="varStatus">
									<c:set var="icare_count" value="${varStatus.count }"></c:set>
								</c:forEach>
								<!-- 关注我的 -->
								<c:forEach var="myListAttention" items="${myListAttentions_be }" varStatus="varStatus">
									<c:set var="careme_count" value="${varStatus.count }"></c:set>
								</c:forEach>
								<li role="presentation" class="active">
									<a href="#icare" aria-controls="icare" role="tab" data-toggle="tab">我关注的人 <samp>${icare_count }</samp></a>
								</li>
								<li role="presentation">
									<a href="#careme" aria-controls="careme" role="tab" data-toggle="tab">关注我的人 <samp>${careme_count }</samp></a>
								</li>
							</ul>
							<div class="tab-content">
								<div role="tabpanel" class="tab-pane active" id="icare">
									<c:if test="${myListAttentions==\"[]\" }">
										<br><br><br><br>
										<div class="text-center">
											<img alt="没关注过人" src="${APP_PATH }/static/img/attention.png">
											<p style="color: #999999">可能，你还没遇见感兴趣的人</p>
										</div>
										<br><br><br><br>
									</c:if>
									<c:if test="${myListAttentions!=\"[]\" }">
										<br>
										<c:forEach var="myListAttention" items="${myListAttentions }">
											<div class="row">
												<div class="col-xs-3 col-md-2">
													<a href="${APP_PATH}/userController/getOthers?userid=${myListAttention.userid }">
														<!-- 该用户有修改头像 -->
														<c:if test="${myListAttention.userphoto!=null }">
															<img class="img-thumbnail" alt="Brand" style="position:relative;width: 70px;height: 70px;"
																src="${APP_PATH }/static/upload/user/${myListAttention.userphoto }">
														</c:if>
														<!-- 该用户没有修改头像，只有默认头像 -->
														<c:if test="${myListAttention.userphoto==null }">
															<img class="img-thumbnail" alt="Brand" style="position:relative;width: 70px;height: 70px;"
																src="${APP_PATH }/static/img/head.jpg">
														</c:if>
													</a>
												</div>
												<div class="col-xs-5 col-md-8">
													<a class="a_b" href="${APP_PATH}/userController/getOthers?userid=${myListAttention.userid }">
														<!-- 发帖人名字 -->
														<b style="font-size: 16px;">${myListAttention.name }</b>
													</a>
													<br>
													<samp>${myListAttention.intro }</samp>
													<br>
													<samp>有<b class="text-success">${myListAttention.attcount }</b>人关注</samp>
												</div>
												<div class="col-xs-4 col-md-2 attention">
													<form action="${APP_PATH }/attentionController/deleteAttentionMyself">
													<input type="hidden" name="userid" value="${userid }">
													<input type="hidden" name="beuserid" value="${myListAttention.userid }">
														<a href="#">
															<button type="submit" class="btn button2" style="width:80px;">取消关注</button>
															<button type="submit" class="btn" style="width:80px;">已关注</button>
														</a>
													</form>
												</div>
											</div>
											<hr>
										</c:forEach>
									</c:if>
								</div>
								<div role="tabpanel" class="tab-pane" id="careme">
									<c:if test="${myListAttentions_be==\"[]\" }">
										<br><br><br><br>
										<div class="text-center">
											<img alt="没人关注你" src="${APP_PATH }/static/img/attention.png">
											<p style="color: #999999">可能，你并不是别人的菜</p>
										</div>
										<br><br><br><br>
									</c:if>
									<c:if test="${myListAttentions_be!=\"[]\" }">
										<br>
										<c:forEach var="myListAttention_be" items="${myListAttentions_be }">
											<div class="row">
												<div class="col-xs-3 col-md-2">
													<a href="${APP_PATH}/userController/getOthers?userid=${myListAttention_be.userid }">
														<!-- 该用户有修改头像 -->
														<c:if test="${myListAttention_be.userphoto!=null }">
															<img class="img-thumbnail" alt="Brand" style="position:relative;width: 70px;height: 70px;"
																src="${APP_PATH }/static/upload/user/${myListAttention_be.userphoto }">
														</c:if>
														<!-- 该用户没有修改头像，只有默认头像 -->
														<c:if test="${myListAttention_be.userphoto==null }">
															<img class="img-thumbnail" alt="Brand" style="position:relative;width: 70px;height: 70px;"
																src="${APP_PATH }/static/img/head.jpg">
														</c:if>
													</a>
												</div>
												<!--  <div class="col-xs-5 col-md-8" style="margin-left: -70px;"> -->
												<div class="col-xs-9 col-md-8">
													<a class="a_b" href="${APP_PATH}/userController/getOthers?userid=${myListAttention_be.userid }">
														<!-- 发帖人名字 -->
														<b style="font-size: 16px;">${myListAttention_be.name }</b>
													</a>
													<br>
													<samp>${myListAttention_be.intro }</samp>
													<br>
													<samp>有<b class="text-success">${myListAttention_be.attcount }</b>人关注</samp>
												</div>
											</div>
											<hr>
										</c:forEach>
									</c:if>
								</div>
							</div>
						</div>
						
						<!-- 我的收藏 -->
						<div role="tabpanel" class="tab-pane" id="collect">
							<c:if test="${myListCollects==\"[]\" }">
								<br><br><br><br>
								<div class="text-center">
									<img alt="没收藏过帖子" src="${APP_PATH }/static/img/attention.png">
									<p style="color: #999999">可能，你还没遇见感兴趣的帖子</p>
								</div>
								<br><br><br><br>
							</c:if>
							<c:if test="${myListCollects!=\"[]\" }">
								<br>
								<c:forEach var="myListCollect" items="${myListCollects }">
									<div class="row">
										<div class="col-xs-2 col-md-1">
											<form action="${APP_PATH }/collectController/deleteCollectUseridAndFid" method="post">
												<input type="hidden" name="userid" value="${userid }">
												<input type="hidden" name="fid" value="${myListCollect.fid }">
												<button type="submit" style="border: none;background-color: #ffffff;">
													<samp title="取消收藏" class="glyphicon glyphicon-heart collect_end"></samp>
												</button>
											</form>
										</div>
										<div class="col-xs-10 col-md-9">
											<a href="${APP_PATH }/articleController/getArticleFid?fid=${myListCollect.fid }">${myListCollect.titles }</a>
										</div>
										<div class="col-xs-5 col-md-2 col-xs-offset-7">
											<small>${myListCollect.time }</small>
										</div>
									</div>
									<hr>
								</c:forEach>
							</c:if>
						</div>
						<!-- 我的消息 -->
						<div role="tabpanel" class="tab-pane" id="message">
							<c:if test="${myListMessages==\"[]\" }">
								<br><br><br><br>
								<div class="text-center">
									<img alt="没消息" src="${APP_PATH }/static/img/attention.png">
									<p style="color: #999999">没有消息！</p>
								</div>
								<br><br><br><br>
							</c:if>
							<c:if test="${myListMessages!=\"[]\" }">
								<br>
								<c:forEach var="myListMessage" items="${myListMessages }">
									<div class="row">
										<div class="col-xs-2 col-md-1">
											<form action="${APP_PATH }/messageController/deleteMessage" method="post">
												<input type="hidden" name="mid" value="${myListMessage.mid }">
												<button type="submit" style="border: none;background-color: #22ffff;">删除消息
													<!--
													<samp title="删除消息" class="glyphicon glyphicon-heart message_end"></samp>
													-->
												</button>
											</form>
										</div>
										<div class="col-xs-3 col-md-3">
										<c:if test="${myListMessage.fid!=null }">
										<a href="${APP_PATH }/articleController/getArticleFid?fid=${myListMessage.fid }">消息内容：${myListMessage.mcontent }</a>
										</c:if>
										<c:if test="${myListMessage.fid==null }">
											消息内容：${myListMessage.mcontent }
										</c:if>
										</div>
										<div class="col-xs-3 col-md-3 col-xs-offset-1">
										<c:if test="${myListMessage.beuserid!=0 }">
										<a href="${APP_PATH}/userController/getOthers?userid=${myListMessage.beuserid }">操作者id：${myListMessage.beuserid }</a>
										</c:if>
										<c:if test="${myListMessage.beuserid==0 }">
											操作者：管理员
										</c:if>
										</div>
										<div class="col-xs-2 col-md-2">
											<small>${myListMessage.time }</small>
										</div>
									</div>
									<hr>
								</c:forEach>
								<div class="col-xs-6 col-md-6 col-xs-offset-6">
									<form action="${APP_PATH }/messageController/deleteMessageUserid" method="post">
										<input type="hidden" name="userid" value="${myListUser.userid }">
										<button type="submit" style="border: none;background-color: #00ffff;">删除全部消息
											<!--
											<samp title="删除消息" class="glyphicon glyphicon-heart message_end"></samp>
											-->
										</button>
									</form>
								</div>
							</c:if>
						</div>
						</div>						
					</div>
				</div>
			</div>
		</div>
		<br>
	</div>
	
	<script src="${APP_PATH }/static/js/delete.js">	</script>
</body>
</html>