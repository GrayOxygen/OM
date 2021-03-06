<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
	<jsp:include page="../commons/head.jsp" />
	
	<body class="no-skin">
		<div class="main-container" id="main-container">
			<div>
				<div class="breadcrumbs" id="breadcrumbs">
					<script type="text/javascript">
						try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
					</script>

					<ul id="uiId" class="breadcrumb">
						<li>
							<i class="ace-icon fa fa-home home-icon"></i>
							<a href="#">首页</a>
						</li>
						<li><a href="#">车辆线路管理</a></li>
						<li><a href="${pageContext.request.contextPath}/view/car/carLineList.jsp">车辆线路管理</a></li>
						<li class="active">新增车辆线路</li>
					</ul><!-- /.breadcrumb -->

					<div class="nav-search" id="nav-search">
						<a href="javascript:history.back()" >
							<i class="ace-icon fa fa-arrow-left"></i>返回
						</a>
					</div><!-- /.nav-search -->
				</div>

				<div class="page-content">
					<div class="row">
						<form id="carLine" action="../carLine/saveOrUpdateCarLine.action" method="post"   class="form-horizontal" onsubmit="return check();">
							<!-- 添加站点 开始 -->
								
								<div class="col-xs-12">
									<div class="widget-box">
										<div class="widget-header widget-header-small">
											<h5>添加站点</h5>
										</div>
										<div class="widget-body">
											<div class="widget-main no-padding">
												<table id="tb" class="table table-condensed table-bordered">
													<thead>
														<tr>
														    <th class="center">行号</th>
															<th  style="width:150px">站点编号</th>
															<!-- <th class="center">商圈ID</th> -->
															<th class="center">商圈编号</th>
															<th class="center">商圈名称</th>
															<th class="center">商圈地址</th>
															<th class="center">操作</th>
														</tr>
													</thead>
													<tbody id="purchase_goods_list">
														<c:forEach var="pg" items="${carLineNode}" varStatus="rowIndex">
														<tr>
															<td class="center">${rowIndex.index + 1}</td>
															<td>
																<input type="hidden" id="lNodeId" name="carLineNodeList[${rowIndex.index}].lineNodeId"  value="${pg.lineNodeId}"/>
																<input type="text"   value="${pg.nodeNo}"/>
															</td>
															<td class="center">${pg.motionDistrict.districtNo}</td>
															<td class="center">${pg.nodePositionName}</td>
															<td class="center">${pg.motionDistrict.districtAddress}</td>
															<td class="center">
																<input class="center" type="hidden"  value="${pg.lineNodeId}"/>
																<a href="javascript:void(0)" onclick="removeGoodsItem(this)">移除</a>
															</td>
														</tr>
														</c:forEach>
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
								
								<div class="col-xs-12">
									<div class="row">
										<div class="col-xs-6">
											<a class="btn btn-xs no-border btn-info"
												onclick="batchChoiseGoods()">
												<i class="ace-icon fa glyphicon-plus bigger-120"></i>
												批量添加
											</a>
										</div>
										
									</div>
								</div>
							<!-- 添加站点 结束 -->

							<!-- 线路信息开始 -->
								<div class="col-xs-12">
									<div class="widget-box">
										<div class="widget-header widget-header-small">
											<h5>添加线路</h5>
										</div>
										<div class="widget-body" style=" width:100%;height:100% ">
												<div class="widget-main"  style="float:left;width:50%"  >
													<div class="form-group" style="display:none">
													    <label class="col-sm-2 control-label no-padding-right"><i class="red">*</i>
		                                          		          线路ID：
		                                                </label>
														<span class="input-icon input-icon-right">
															<input  type="text" value="${carLine.carLineId}"
	                                                               id="carLineId" class="required"
	                                                               style="width:300px" name="carLine.carLineId"/>
														</span>
												    </div>
													
													<div class="form-group">
														<label class="col-sm-2 control-label no-padding-right"><i class="red">*</i>
															所属服务站： 
														</label>
														<span class="input-icon input-icon-right">
															<c:if test="${account.dictName!='' && account.dictName!=null}">
				                                   				<c:if test="${carLine.org.dictName=='' || carLine.org.dictName==null}">
																	<input type="text" value="${account.dictName}"
				                                                    id="userPro" class="required" style="width:300px;" readonly="readonly"/>
				                                                    <input type="hidden" id="orgId" name="carLine.dictOrgId"
				                                                    value="${account.orgId}"/>       
				                                            	    <input type="hidden"  id="provinceId" name="carLine.dictProviceId"
				                                                    value="${account.dictProviceId}"/>
				                                            	    <input type="hidden" id="regionId" name="carLine.dictRegionId"
				                                                    value="${account.dictRegionId}"/>
				                                                 </c:if>
				                                                 <c:if test="${carLine.org.dictName!='' && carLine.org.dictName!=null}">
				                                                 	<input type="text" value="${carLine.org.dictName}"
				                                                    id="userPro" class="required" style="width:300px;" readonly="readonly"/>
						                                            <input type="hidden" id="orgId" name="carLine.dictOrgId"
						                                                   value="${carLine.dictOrgId}"/>       
						                                            <input type="hidden"  id="provinceId" name="carLine.dictProviceId"
						                                                   value="${carLine.dictProviceId}"/>
						                                            <input type="hidden" id="regionId" name="carLine.dictRegionId"
						                                                   value="${carLine.dictRegionId}"/>
				                                                 </c:if>
															</c:if>
															<c:if test="${account.dictName=='' || account.dictName==null}">
				                                   			<input type="text" value="${carLine.org.dictName}"
				                                                   id="userPro" class="required" style="width:300px;"
				                                                   onfocus="showMenu()"/>
				                                            <input type="hidden" id="orgId" name="carLine.dictOrgId"
				                                                   value="${carLine.dictOrgId}"/>       
				                                            <input type="hidden"  id="provinceId" name="carLine.dictProviceId"
				                                                   value="${carLine.dictProviceId}"/>
				                                            <input type="hidden" id="regionId" name="carLine.dictRegionId"
				                                                   value="${carLine.dictRegionId}"/>
				                                            </c:if>
														</span>
														<span id= "orgError" class="input-icon input-icon-right">
														</span>
													</div>
													<div class="form-group">
												    	<label class="col-sm-2 control-label no-padding-right"><i
															class="red">*</i>
															线路类型：
														 </label> 
														<span class="input-icon input-icon-right"> 
															<select id="lineType" name="carLine.lineType" style="width:300px;" >
																<option value="">请选择</option>
																<option value="0"
																	${carLine.lineType == 0 ?"selected= 'selected'" : ""}>时间最短</option>
																<option value="1"
																	${carLine.lineType == 1 ?"selected= 'selected'" : ""}>线路最短</option>
																<option value="2"
																	${carLine.lineType == 2 ?"selected= 'selected'" : ""}>花费最少</option>
															</select>
														</span>
														<span id= "carLineTypeError" class="input-icon input-icon-right">
														</span>
													</div>
													<div class="form-group">
														<label class="col-sm-2 control-label no-padding-right">
															线路名称： 
														</label>
														<span class="input-icon input-icon-right">
															<input type="text" id="lineName" class="required" maxlength="20" style="width:300px;" name="carLine.lineName" value="${carLine.lineName}"/>														
														</span>
														<span id= "carLineNameError" class="input-icon input-icon-right">
														</span>
													</div>
													<div class="form-group">
														<label class="col-sm-2 control-label no-padding-right">
															线路长度： 
														</label>
														<span class="input-icon input-icon-right">
															<input type="text" id="lineLength" class="required" style="width:300px;" name="carLine.lineLength" value="${carLine.lineLength}"/>														
														</span>
													</div>
													
													<div class="form-group">
														<label class="col-sm-2 control-label no-padding-right">
															维护人员： 
														</label>
														<span class="input-icon input-icon-right">
															<input id="userIdStr" type="hidden" name="carLine.agentUser" value="${carLine.agentUser}" />
															<input  type="text"  id="userNameStr" class="required" value="${carLine.user.realName}" style="width:300px" onclick="choiseUser(this)"/>
														</span>
														<span id= "carLineUserError" class="input-icon input-icon-right">
														</span>
													</div>
													
													<div class="form-group" >
														<label class="col-sm-2 control-label no-padding-right">
															有效开始日期： 
														</label>
														<span class="input-icon input-icon-right">
															<input name="carLine.startDate"  id="dp_expEndTime1"  class="col-xs-10 required" type="text"  style="width:200px;"  value="${carLine.startDate}" />																
															<i class="ace-icon fa fa-clock-o blue"></i>
														</span>
													</div>
													<div class="form-group">
														<label class="col-sm-2 control-label no-padding-right">
															有效结束日期： 
														</label>
														<span class="input-icon input-icon-right">
															<input name="carLine.endDate"  id="dp_expEndTime2"  class="col-xs-10 required" type="text"  style="width:200px;"  value="${carLine.endDate}" >																
															<i class="ace-icon fa fa-clock-o blue"></i>
														</span>
													</div>
													<div class="form-group">
														<label class="col-sm-2 control-label no-padding-right">
															在线控制时长： 
														</label>
														<span class="input-icon input-icon-right">
															<input type="text" id="ctlHour" class="required" style="width:300px;" name="carLine.ctlHour" value="${carLine.ctlHour}">														
														</span>
													</div>
											</div>
										</div>
									</div>
								</div>
							<!-- 线路信息结束 -->
							<!-- 表单操作按钮开始 -->
							<div class="row">
	                            <div id="form_action_btns" class="col-xs-12" style="text-align: center">
									<button type="submit" onclick="return  check()" class="btn btn-sm no-border btn-success">
										<i class="ace-icon fa fa-floppy-o"></i>保存</button>&nbsp;&nbsp;&nbsp;
									<a class="btn btn-sm no-border btn-default" onclick="javascript:history.back()">
										<i class="ace-icon fa fa-times red2"></i>取消</a>
								</div>
							</div>
							<!-- 表单操作按钮结束 -->
							<!-- 表单隐藏域开始 -->
							<%--
							<input type="hidden" id="purchaseId" name="purchase.purchaseId"  value="${op.purchaseId}"/>
							<input type="hidden" id="purchase_status" name="purchase.purchaseStatus" value="${op.purchaseStatus}" />
						 	<input type="hidden" id="purchase_isdel" name="purchase.isDel" value="${op.isDel}" />
							<input type="hidden" id="purchase_isApprove" name="purchase.isApprove" value="${op.purchaseStatus}" />
							 --%>
							<!-- 表单隐藏域结束 -->
						</form>
					</div><!-- /.row -->
				</div><!-- /.page-content -->
			</div><!-- /.main-content -->
			
			<!-- Modal -->
			<!-- 站点信息选择弹出窗开始 -->
			<div id="goods_choise_modal" class="modal hiden fade" 
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" style="width:860px;">
					<div class="modal-content" >
						<div class="modal-header thicktitle">
							<a class="close" data-dismiss="modal" aria-hidden="true">×</a>
							<span class="modal-title" id="myModalLabel">选择站点</span>
						</div>
						<div class="modal-body thickcon" style="width:858px;height: 650px; padding-left: 10px; padding-right: 10px;">
							<input type="hidden" id="purchase_goods_rowno" />
							<input type="hidden" id="choise_type" value="0"/>
							<div class="row">
								<div class="col-xs-3">
									<div style="height: 400px; overflow-y: scroll; border: 1px solid #ddd;">
										<ul id="org_tree" class="ztree"></ul>
									</div>
								</div>
								<div class="col-xs-9">
									<table id="search_goods_table" class="table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th class="center">
													<label class="position-relative">
														<input type="checkbox" class="ace" />
														<span class="lbl"></span>
													</label>
												</th>
												<th class="center">站点编号</th>
												<th class="center">商圈编号</th>
												<th class="center">商圈名称</th>
												<th class="center">商圈地址</th>
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
								</div>
							</div>
							<div id="choise_goods_action" class="col-xs-12" style="text-align:center;margin-top:10px;">
								<a id="choise_submit" class="btn btn-sm no-border btn-primary disabled"
								   onclick="batchAppendGoods()">添加站点</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 站点信息选择弹出窗结束 -->
		</div><!-- /.main-container -->
		
		<div id="user_choise_modal" class="modal hiden fade" 
			tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" style="width:860px;">
				<div class="modal-content" >
					<div class="modal-header thicktitle">
						<a class="close" data-dismiss="modal" aria-hidden="true">×</a>
						<span class="modal-title" id="myModalLabel">选择用户</span>
					</div>
					<div class="modal-body thickcon" style="width:858px;height: 650px; padding-left: 10px; padding-right: 10px;">
						<input type="hidden" id="purchase_goods_rowno" />
						<input type="hidden" id="choise_type" value="0"/>
						<div class="row">
							<div id="search-form" class="col-xs-12" style="padding-bottom: 5px;">
								<div class="input-group" style="float:right;width:300px;">
									<input type="text" id="keyword" class="form-control search-query" placeholder="用户帐号/用户姓名" /> 
									<span class="input-group-btn">
										<button id="searchGoodsBtn" type="button" class="btn btn-purple btn-sm no-border">
											<i class="ace-icon fa fa-search icon-on-right bigger-110"></i>
											搜索
										</button>
									</span>
								</div>
							</div>
							<div class="col-xs-12">
								<table id="user_list" class="table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<th class="center">用户账号</th>
											<th class="center">用户姓名</th>
											<th class="center">联系电话</th>
											<th class="center">用户邮箱</th>
											<th class="center">创建日期</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div id="gt_combobox" 
	         style=" display:none; position: absolute;border: 1px solid #ddd;background-color:#F0F0F0;overflow:auto">
	        <ul id="org_tree1" class="ztree" style="margin-top:0; "></ul>
	    </div>
		<!--[if !IE]> -->
		<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>

		<!-- <![endif]-->

		<!--[if !IE]> -->
		<script type="text/javascript">
			window.jQuery || document.write("<script src='${pageContext.request.contextPath}/js/jquery.min.js'>"+"<"+"/script>");
		</script>

		<!-- page specific plugin scripts -->
		<script src="${pageContext.request.contextPath}/js/bootstrap.min.js" ></script>
		<script src="${pageContext.request.contextPath}/js/assets/jquery.dataTables.min.js"></script>
		<script src="${pageContext.request.contextPath}/js/assets/jquery.dataTables.bootstrap.js"></script>
		<script src="${pageContext.request.contextPath}/js/date-time/bootstrap-datetimepicker.js"></script>
		<script src="${pageContext.request.contextPath}/js/date-time/bootstrap-datetimepicker.zh-CN.js"></script>
		<script src="${pageContext.request.contextPath}/js/jquery.form.min.js"></script>
		<script src="${pageContext.request.contextPath}/js/ace-extra.min.js"></script>
		<script src="${pageContext.request.contextPath}/js/ace-elements.min.js"></script>
		<script src="${pageContext.request.contextPath}/js/ace.min.js"></script>
		<script src="${pageContext.request.contextPath}/js/ycs.dateUtil.js" ></script>
		<script src="${pageContext.request.contextPath}/js/biz/car/carLineAdd.js"></script>
		<script src="${pageContext.request.contextPath}/plugins/zTree/js/jquery.ztree.core-3.5.min.js" ></script>
		<script src="${pageContext.request.contextPath}/plugins/zTree/js/jquery.ztree.core-3.5.js" ></script>
   		
		<script type="text/javascript">
		 	function check() {
				if (checkLineNode() && checkCarLineOrg &&checkCarLineType() && checkCarLineName() &&checkCarLineUser()) {
					return true;
				} else {
					return false;
				}
			} 
			function checkLineNode(){
				var trLength=  $("#tb tr").length;
				if(trLength < 3){
					alert("新线路站点不能少于两个" );
					return false;
				}else {
					return true;
				}
			}
			//验证线路所属服务站不为空
			function checkCarLineOrg(){
				var num = $("#userPro").val();
			    if (num == "") {
			    	$("#orgError").html("<div></div><font color='red'>所属服务站不能为空!</font>");
					return false;
				}else{
					$("#orgError").html("<div></div>");
					return true;
				}
			}
			//验证线路类型不为空
			function checkCarLineType(){
				var num = $("#lineType").val();
			    if (num == "") {
			    	$("#carLineTypeError").html("<div></div><font color='red'>线路类型不能为空!</font>");
					return false;
				}else{
					$("#carLineTypeError").html("<div></div>");
					return true;
				}
			}
			//验证线路名称不为空
			function checkCarLineName(){
				var num = $("#lineName").val();
			    if (num == "") {
			    	$("#carLineNameError").html("<div></div><font color='red'>线路名称不能为空!</font>");
					return false;
				}else{
					$("#carLineNameError").html("<div></div>");
					return true;
				}
			}
			//验证维护人员不为空
			function checkCarLineUser(){
				var num = $("#userNameStr").val();
			    if (num == "") {
			    	$("#carLineUserError").html("<div></div><font color='red'>维护人员不能为空!</font>");
					return false;
				}else{
					$("#carLineUserError").html("<div></div>");
					return true;
				}
			}
			</script>
	</body>
</html>



