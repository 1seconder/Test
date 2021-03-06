<%@page import="com.newenv.lpzd.Utils.FileUtil"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path;
%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
	<div class='onsubing' style="display:none; width:100%; height:100%; background:#fff; position:fixed; z-index:99999; opacity:0.8;-moz-opacity:0.8; filter:alpha(opacity=80); ">
		<div class="text-center" style="position:absolute; top:20%; left:50%;">
			<img src="<%=basePath%>/images/loading.gif" width="176" height="220"/>
			<span> 数据正在操作中....请稍等</span>
		</div>
	</div>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<meta name="description" content="Xenon Boostrap Admin Panel" />
		<meta name="author" content="" />
		<title>修改小区</title>
		<link rel="stylesheet" href="<%=basePath%>/assets/css/fonts/linecons/css/linecons.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/fonts/fontawesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/bootstrap.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/xenon-core.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/xenon-forms.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/xenon-components.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/xenon-skins.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/custom.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/xiaoqu.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/js/wysihtml5/src/bootstrap-wysihtml5.css">
		<link rel="stylesheet" type="text/css" href="<%=basePath%>/js/ext/exttab/css/ext-all.css"> 
		<link rel="stylesheet" href="<%=basePath%>/assets/js/bootbox/bootbox.css">
		<script src="<%=basePath%>/assets/js/jquery-1.11.1.min.js" type="text/javascript"></script>
		<script type="text/javascript" src="<%=basePath%>/js/ext/exttab/js/ext-base.js" ></script> 
		<script type="text/javascript" src="<%=basePath%>/js/ext/exttab/js/ext-all.js" ></script> 
		<script src="<%=basePath%>/assets/js/bootbox/bootbox.min.js"></script>
		<script src="<%=basePath%>/assets/js/page.js"></script>
		<script src="<%=basePath%>/js/comm/commInfo.js" type="text/javascript"></script>
		<script src="<%=basePath%>/js/campus/updCampus.js" type="text/javascript"></script>
		<script src="<%=basePath%>/js/campus/lpDong.js" type="text/javascript"></script>
		<script src="<%=basePath%>/js/campus/facilities.js" type="text/javascript"></script>
		<script src="<%=basePath%>/js/campus/weihudanwei.js" type="text/javascript"></script>
		<script src="<%=basePath%>/js/campus/uplptp.js" type="text/javascript"></script>
		<script src="<%=basePath%>/js/campus/jquery.rotate.js" type="text/javascript"></script>
		<script type="text/javascript">
			var basepath = "<%=basePath%>";
			var fromPageTab = "${param.fromPageTab}";	//来源页面当前的页签
			var curTabId = "";
			//选项卡的内容是否已加载
			var tabStatus = {"fwv-1":true, "fwv-2":false, "fwv-3":false, "fwv-4":false, "fwv-5":false};
			$(function(){
		$('#navtabs a[data-toggle="tab"]').on('show.bs.tab', function (e){
			curTabId = e.target.hash.substring(1);
			tabStatustable(curTabId);
        });       
      
     });
     
     function tabStatustable(curTabId){
     if(tabStatus[curTabId]==false){
				switch(curTabId){
					case "fwv-2":
						//	维护单位
						queryData();
					//	居住成本
						queryData1();
						getSyscsTypeCheck("维护单位","mType");
						getSyscsTypeCheck("居住成本","ctype");
						getSyscsTypeCheck("租赁支付方式","payingWay");
						break;
					case "fwv-3":
						//	图片
						uplptp();
						break;
					case "fwv-4":
					//加载所有栋信息
					showDongInfo($("#lpxxid").val());
					getSyscsTypeCheck("房屋朝向","chaoXiang");
					getSyscsTypeCheck("装修情况","decorationStandard");
					getSyscsTypeCheck("房屋朝向","chaoXiangup");
					getSyscsTypeCheck("装修情况","decorationStandardup");
						break;
					case "fwv-5":
					loadLpSchoolInfo();
					//加载地铁线路
					showAddMetor();
					//加载部门
					showDepart();
					//加载学校类型
					showShchoolAllType();
						//加载划分盘信息
						loadLpFuzh();
						//加载地铁信息
						metorInfo();
					 break;
				}
				tabStatus[curTabId]=true;
			}
     }
		</script>
					
<script type="text/javascript" src="<%=basePath%>/js/plupload/plupload.full.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/plupload/i18n/zh_CN.js"></script>
<script src="<%=basePath%>/js/campus/pluploadfile.js" type="text/javascript"></script>
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
	<style type="text/css">
	.thfont{
			font-weight:800;
		   }		
	</style>
	</head>
	<body class="page-body">
		<div class="page-container">
			<!-- add class "sidebar-collapsed" to close sidebar by default, "chat-visible" to make chat appear always -->

			<!-- Add "fixed" class to make the sidebar fixed always to the browser viewport. -->
			<!-- Adding class "toggle-others" will keep only one menu item open at a time. -->
			<!-- Adding class "collapsed" collapse sidebar root elements and show only icons. -->
			<div class="sidebar-menu toggle-others fixed">
				<jsp:include page="../include/left.jsp" />
			</div>
			<div class="main-content">
				<!-- User Info, Notifications and Menu Bar -->
				<jsp:include page="../include/top.jsp"/>
				<div class="page-title">
					<div class="breadcrumb-env pull-left">
						<ol class="breadcrumb bc-1">
							<li>
								<a href="<%=basePath%>/console/index.jsp"><i class="fa-home"></i>首页</a>
							</li>
							<s:if test='#parameters.from[0]=="check"'>
								<li>
									<a href="javascript:cancel()">采盘及地址审核列表</a>
								</li>
								<li class="active">
									<strong>小区信息</strong>
								</li>
							</s:if>
							<s:else>
								<li>
									<a href="<%=basePath%>/cam/campus.action?p=xq&k=lp">楼盘管理</a>
								</li>
								<li class="active">
									<strong>修改小区</strong>
								</li>
							</s:else>
						</ol>

					</div>
				</div>
				<div class="form-wizard validate" role="forl" id="rootwizard" novalidate="novalidate">

					<ul class="tabs" id="navtabs">
						<li class="active">
							<a href="#fwv-1" data-toggle="tab">
							楼盘信息
							<span>1</span>
						</a>
						</li>
						<li>
							<a href="#fwv-2"  id="fwvwh" data-toggle="tab">
							楼盘维护
							<span>2</span>
						</a>
						</li>
						<li>
							<a href="#fwv-3" data-toggle="tab" onclick="initUploader()">
							楼盘图库
							<span>3</span>
						</a>
						</li>
						<li>
							<a href="#fwv-4"  id="fwvdz" data-toggle="tab">
							栋座资料
							<span>4</span>
						</a>
						</li>
						<li>
							<a href="#fwv-5" data-toggle="tab">
							配套设施
							<span>5</span>
						</a>
						</li>
					</ul>

					<div class="progress-indicator" style="width: 0%;">
						<span></span>
					</div>
					<div class="tab-content no-margin panel panel-default">

						<!-- Tabs Content -->
						<div class="tab-pane with-bg active" id="fwv-1">
							<form role="form" class="form-horizontal" id="lpxxForm">
							<input type="hidden" id="lpxxid" value="${loadLpxx.id}" name="lpxx.id"/>
							<input type="hidden" name="from" value="${param.from}"/>
							<input type="hidden" name="lpxx.checkStatus" value="${loadLpxx.checkStatus}"/>
							<div class="row col-lg-10 col-md-12 col-xs-12 col-sm-12">
								<div class="h4">基本信息</div>
								<hr>
								<div class="col-md-3 "  style="display: none;">
													<select class="form-control" id="country" data-value="${loadLpxx.countryid}" name="lpxx.countryid" onchange="buildPro(this.value,false)">
														<option value="" >请选择</option>
													</select>
												</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon red">省份：</span>
											<select class="form-control" id="pro" data-value="${loadLpxx.provinceid}" name="lpxx.provinceid" onchange="buildCity(this.value,false)">
														<option value="0">请选择</option>
													</select>
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon red">城市：</span>
											<select class="form-control" id="city" data-value="${loadLpxx.cityId}" name="lpxx.cityId" onchange="buildQy(this.value,false)">
														<option value="0">请选择</option>
											</select>
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon red">城区：</span>
											<select class="form-control" id="sQy" data-value="${loadLpxx.stressId}" name="lpxx.stressId" onchange="buildSq(this.value,false)">
											<option value="0">请选择</option>
											</select>
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon red">商圈：</span>
											<select class="form-control" id="sSq" data-value="${loadLpxx.sqId}" name="lpxx.sqId">
												<option value="0">请选择</option>
											</select>
										</div>
									</div>
								</div>
								<div class="clearfix"></div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon red">用途：</span>
											<select class="form-control" id="yongtu" data-value="${loadLpxx.yongTu}" name="lpxx.yongTu">
											<option value="0">请选择</option>
											</select>
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon red">楼盘名称：</span>
											<input class="form-control" id="lpName" value="${loadLpxx.lpName}" name="lpxx.lpName">
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon red">别名：</span>
											<input class="form-control" id="bieMing" value="${loadLpxx.bieMing}"  name="lpxx.bieMing">
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon red">楼盘类型：</span>
											<select class="form-control" id ="lType" name ="lpxx.ltype" data-value="${loadLpxx.ltype}" >
												<option value="0">请选择</option>
											</select>
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon red">楼盘地址：</span>
											<input class="form-control" id="address" value="${loadLpxx.address}" name="lpxx.address">
										</div>
									</div>
								</div>
									<div class="col-md-6 col-sm-6" >
									<div class="form-group">
										<div class="input-group input-group-minimal" style="height:30px">
											<span class="input-group-addon red">坐标地址：</span>
											<input type="text" class="col-xs-6 wenbenkuan1" id="xxzbx" name="lpxx.x" value="${loadLpxx.x}" readonly>
											<input type="text" class="col-xs-6 wenbenkuan1" id="xxzby" name="lpxx.y" value="${loadLpxx.y}" readonly>
											<a href="#" class="input-group-addon" id="loadXY"  data-toggle="modal" data-target="#map-info-windom">选择</a>
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon red">行政地址：</span>
											<input class="form-control" id="xzgx" value="${loadLpxx.xzgx}" name="lpxx.xzgx">
										</div>
									</div>
								</div>
								<style>
									.progress{margin-bottom: 0px;}
								</style>
								<div class="clearfix"></div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon red">楼盘等级：</span>
											<select class="form-control" id ="level" name ="lpxx.level" data-value="${loadLpxx.level}" >
												<option value="0">请选择</option>
											</select>
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon red">环线位置：</span>
											<select class="form-control" id ="linkLocAtion" name ="lpxx.linkLocAtion" data-value="${loadLpxx.linkLocAtion}">
												<option value="0">请选择</option>
											</select>
										</div>
									</div>
								</div>
								
								<div class="hidden-lg">
									<div class="clearfix"></div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon red">产权地址：</span>
											<input class="form-control" id="propertyAddress" value="${loadLpxx.propertyAddress}" name="lpxx.propertyAddress" >
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon red">锁盘：</span>
											<div class="" style="height: 32px;padding-top: 5px; border: 1px solid #D5D5D5; border-left: none;">
												<label class="radio-inline">
													<input type="radio" name="lpxx.statuss" value="2" <s:if test="#loadLpxx.statuss==2">checked="checked"</s:if>>是
												</label>
												<label class="radio-inline">
													<input type="radio" name="lpxx.statuss" value="1" <s:if test="#loadLpxx.statuss==1">checked="checked"</s:if>> 否
												</label>
											</div>
										</div>
									</div>
								</div>
								
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon red">完成度：</span>
											<div class="" style="height: 32px; padding-top: 12px; padding-right: 10px; border: 1px solid #D5D5D5; border-left: none;" id ="endComplete" name = "lpxx.endComplete">
											★ ★ ★ ☆ ☆
											</div>
										</div>
									</div>
								</div>
								<style>
									.progress{margin-bottom: 0px;}
								</style>

								<div class="clearfix"></div>
								<div class="col-md-12 col-sm-12">
									<div class="form-group">
										<label class="control-label  red" for="about"  style='color: #FF0000'>备注：</label>
										<textarea class="form-control" id="beiZ"  name="lpxx.beiZ">${loadLpxx.beiZ}</textarea>
									</div>
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="row col-lg-10 col-md-12 col-xs-12 col-sm-12">
								<div class="col-lg-12">
									<div class="panel-heading">
									<ul class="nav nav-tabs">
										<li class="active"><a href="" data-toggle="tab"><h3>拓展信息</h3>
										</a></li>
									</ul>
								</div>
								</div>
								<hr>
									<div class="col-lg-12">
									<div class="panel-heading">
									<ul class="nav">
										<li><a href="" ><h4>项目信息</h4>
										</a></li>
									</ul>
								</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">占地面积：</span>
											<input type="text" class="form-control" value="${loadLpxx.sumZd}" id="sumZd" name="lpxx.sumZd">
											<span class="input-group-addon">㎡</span>
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">建筑面积：</span>
											<input type="text" class="form-control" value="${loadLpxx.sumJz}" id="sumJz" name="lpxx.sumJz">
											<span class="input-group-addon">㎡</span>
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">建筑年代：</span>
											 <select class="form-control" id="buildingAge" data-value="${loadLpxx.buildingAge}" name="lpxx.buildingAge">
												<option value="0">请选择</option>
											</select>
											<%-- <input type="text" class="form-control" value="${loadLpxx.buildingAge}" name="lpxx.buildingAge"> --%>
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">容积率：</span>
											<input type="text" class="form-control" value="${loadLpxx.rjl}" id="rjl"  name="lpxx.rjl">
											<span class="input-group-addon">%</span>
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">绿化率：</span>
											<input type="text" class="form-control" value="${loadLpxx.lhl}" id="lhl" name="lpxx.lhl">
											<span class="input-group-addon">%</span>
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">总栋数：</span>
											<input type="text" class="form-control" value="${loadLpxx.djs}" id="djs" name="lpxx.djs">
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">总户数：</span>
											<input type="text" class="form-control" value="${loadLpxx.hjs}" id="hjs" name="lpxx.hjs">
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">入住总户数：</span>
											<input type="text" class="form-control" value="${loadLpxx.rzhs}" id="rzhs"  name="lpxx.rzhs">
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">所获奖项：</span>
											<input type="text" class="form-control" value="${loadLpxx.lpJiangX}"  id="lpJiangX" name="lpxx.lpJiangX">
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">小区群：</span>
											<input type="text" class="form-control" value="${loadLpxx.qq}" id="qq" name="lpxx.qq">
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">得房率：</span>
											<input type="text" class="form-control" value="${loadLpxx.roomRate}" id="roomRate" name="lpxx.roomRate">
											<span class="input-group-addon">%</span>
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">街道办事处：</span>
											<input type="text" class="form-control" value="${loadLpxx.jieDao}"  id="jieDao" name="lpxx.jieDao">
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">人车分离：</span>
											<div class="" style="height: 32px;padding-top: 5px; border: 1px solid #D5D5D5; border-left: none;">
												<label class="radio-inline">
													<input type="radio" name="lpxx.renChe" value="1" <s:if test="#loadLpxx.renChe==1">checked="checked"</s:if>>是
												</label>
												<label class="radio-inline">
													<input type="radio" name="lpxx.renChe" value="0" <s:if test="#loadLpxx.renChe==0">checked="checked"</s:if>>否
												</label>
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-9 col-sm-9">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">内部设施：</span>
											<div class="form-block" id="supporting" data-value="${loadLpxx.propertySupporting}">
											</div>
										</div>
									</div>
								</div>
								<div class="clearfix"></div>
								<div class="col-md-12 col-sm-12">
									<div class="compose-message-editor col-sm-10">
										<label class="control-label" for="about">楼盘简介：</label>
										<textarea class="form-control" rows="5" id="more" name="lpxx.more">${loadLpxx.more}</textarea>
									</div>
								</div>
								<div class="clearfix"></div>
								<div class="col-md-12 col-sm-12">
									<div class="form-group">
										<label class="control-label" for="about">车库说明：</label>
										<textarea class="form-control"id="PNum" name="lpxx.PNum">${loadLpxx.PNum}</textarea>
									</div>
								</div>
								
								
								<div class="clearfix"></div>
									<div class="col-lg-12">
									<div class="panel-heading">
									<ul class="nav">
										<li ><a href="" data-toggle="tab"><h4>权属信息</h4>
										</a></li>
									</ul>
								</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">土地使用年限：</span>
											<select class="form-control" id="propertyAge" data-value="${loadLpxx.propertyAge}" name="lpxx.propertyAge">	
												<option  value="0">请选择</option>
											</select>
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">权属：</span>
											<select class="form-control" id="propertyInfo" data-value="${loadLpxx.propertyInfo}" name="lpxx.propertyInfo">	
												<option  value="0">请选择</option>
											</select>
										</div>
									</div>
								</div>
								<div class="clearfix"></div>
								<div class="col-lg-12">
									<div class="panel-heading">
									<ul class="nav">
										<li class="active"><a href="" data-toggle="tab"><h4>配套信息</h4>
										</a></li>
									</ul>
								</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">供气方式：</span>
											<select class="form-control" id="airSupply" data-value="${loadLpxx.airSupply}" name="lpxx.airSupply">
												<option value="0">请选择</option>
											</select>
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">采暖方式：</span>
									 	<select class="form-control" id="heatingWay" data-value="${loadLpxx.heatingWay}" name="lpxx.heatingWay">
												<option value="0">请选择</option>
											</select> 
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">供水方式：</span>
											<select class="form-control" id="waterSupply" data-value="${loadLpxx.waterSupply}" name="lpxx.waterSupply">
												<option value="0">请选择</option>
											</select>
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">供电方式：</span>
											<select class="form-control" id="powerSupply" data-value="${loadLpxx.powerSupply}" name="lpxx.powerSupply">
												<option value="0">请选择</option>
											</select>
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">通讯配置：</span>
											<select class="form-control" id="configuration" data-value="${loadLpxx.configuration}" name="lpxx.configuration">
												<option value="0">请选择</option>
											</select>
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">社区安全设置：</span>
											<select class="form-control" id="communitySafety" data-value="${loadLpxx.communitySafety}" name="lpxx.communitySafety">
												<option value="0">请选择</option>
											</select>
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">门窗材料：</span>
											<select class="form-control" id="materials" data-value="${loadLpxx.materials}" name="lpxx.materials">
												<option value="0">请选择</option>
											</select>
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">电梯品牌：</span>
											<select class="form-control" id="brand" data-value="${loadLpxx.brand}" name="lpxx.brand">
												<option value="0">请选择</option>
											</select>
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">外墙处理方：</span>
											<select class="form-control" id="facadesProcessing" data-value="${loadLpxx.facadesProcessing}" name="lpxx.facadesProcessing">
												<option value="0">请选择</option>
											</select>
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">建筑类型：</span>
											<select class="form-control" id="buildingType" data-value="${loadLpxx.buildingType}" name="lpxx.buildingType">
												<option value="0">请选择</option>
											</select>
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">建筑结构：</span>
											<select class="form-control" id ="buildingStructure" data-value="${loadLpxx.buildingStructure}" name = "lpxx.buildingStructure">
												<option  value="0">请选择</option>
											</select>
										</div>
									</div>
								</div>
								<div class="clearfix"></div>
								<div class="col-lg-12">
									<h4>系统配置</h4></div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">系统报价单价：</span>
											<input class="form-control" name="lpxx.price" value="${loadLpxx.price}" id="lpprice" placeholder="">
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">开盘起价：</span>
											<input class="form-control"  placeholder="" name="lpxx.openingPrice" id="openingPrice" value="${loadLpxx.openingPrice}">
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">开盘均价：</span>
											<input class="form-control" placeholder=""  name="lpxx.openingAvgPrice" id="openingAvgPrice" value="${loadLpxx.openingAvgPrice}">
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
									<div class="form-group">
										<div class="input-group input-group-minimal">
											<span class="input-group-addon">当前均价：</span>
												<input class="form-control"  placeholder=""  name="lpxx.avgPrice" id="avgPrice" value="${loadLpxx.avgPrice}">
										</div>
									</div>
								</div>

								<div class="text-center">
									<input type="submit" class="btn btn-success" value="保存"/>
									<input type="button" class="btn btn-success" onclick="cancel()" value="返回列表"/>
								</div>
							</div>
							<div class="clearfix"></div>
							</form>
						</div>

						<div class="tab-pane with-bg" id="fwv-2">

							<div class="row">
								<div class="panel panel-default">
									<div class="panel-heading">
										<div class="panel-options pull-left">
											<ul class="nav nav-tabs">
												<li class="active">
													<a href="#tab-1" data-toggle="tab">维护单位</a>
												</li>
												<li>
													<a href="#tab-2" data-toggle="tab">居住成本</a>
												</li>
											</ul>
										</div>
									</div>

									<div class="panel-body">
										<div class="tab-content">
											<div class="tab-pane active" id="tab-1">
												<div>
													<button class="btn btn-secondary" onclick="tosave();"><i class="fa-plus"></i>新增</button>
													<a href="#" data-toggle="modal" id="weihudanweiApp" data-target="#weihudanwei"></a>
												</div>
												<div class="table-responsive">
													<table class="table table-bordered table-striped">
														<thead>
															<tr>
																<%-- <th width="50">
																	<div class="cbr-replaced">
																		<div class="cbr-input">
																			<input type="checkbox" class="cbr cbr-done">
																		</div>
																		<div class="cbr-state"><span></span></div>
																	</div>
																</th> --%>
																<th>类型</th>
																<th>企业单位名称</th>
																<th>联系方式</th>
																<th>单位地址</th>
																<th>备注</th>
																<th>操作</th>
															</tr>
														</thead>
														<tbody class="middle-align" id="tbodyData">
														</tbody>
													</table>
												</div>
											</div>

											<div class="tab-pane" id="tab-2">
												<div>
													<button class="btn btn-secondary" onclick="juzhuchengbenAdd();"><i class="fa-plus"></i> 新增 </button>
													<a href="#" data-toggle="modal" id="juzhuchengbenAdd" data-target="#juzhuchengben"></a>
												</div>
												<div class="table-responsive">
													<table class="table table-bordered table-striped">
														<thead>
															<tr>
																<th width="50">
																	<div class="cbr-replaced">
																		<div class="cbr-input">
																			<input type="checkbox" class="cbr cbr-done">
																		</div>
																		<div class="cbr-state"><span></span></div>
																	</div>
																</th>
																<th>费用类型</th>
																<th>计收方式</th>
																<th>金额/单价</th>
																<th>计量单位</th>
																<th>备注</th>
																<th>操作</th>
															</tr>
														</thead>
														<tbody class="middle-align" id="tbodyData1">
														</tbody>
													</table>
												</div>
											</div>

											<div class="tab-pane" id="tab-3">

												<div class="table-responsive">
													<table class="table table-bordered table-striped">
														<thead>
															<tr>
																<th width="50">
																	<div class="cbr-replaced">
																		<div class="cbr-input">
																			<input type="checkbox" class="cbr cbr-done">
																		</div>
																		<div class="cbr-state"><span></span></div>
																	</div>
																</th>
																<th>日期</th>
																<th>门店名称</th>
																<th>专家姓名</th>
																<th>联系方式</th>
																<th>门店地址</th>
																<th>备注</th>
															</tr>
														</thead>
														<tbody class="middle-align">
															<tr>
																<td>
																	<div class="cbr-replaced">
																		<div class="cbr-input">
																			<input type="checkbox" class="cbr cbr-done" value="1">
																		</div>
																		<div class="cbr-state"><span></span></div>
																	</div>
																</td>
																<td><a href="#">天心区</a></td>
																<td><a href="#">白沙路</a></td>
																<td>201</td>
																<td>2015</td>
																<td>2015</td>
																<td>2015</td>
															</tr>
														</tbody>
													</table>
												</div>
											</div>

										</div>

									</div>
								</div>
							</div>

						</div>

						<div class="tab-pane with-bg" id="fwv-3">
								<div class="panel-body">
										<form role="form" class="form-horizontal" id="lpimageForm">
										<input type="hidden" name="tuplpid" id="tuplpid" value="${loadLpxx.id}">
										<div id="webImageofhouse_image_hidden"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="field-3"><span class="red">图片类型</span></label>
											<div class="col-sm-3">
												<select class="form-control" id="houseExclusiveImgType" >
													<option value="3">环境图</option>
													<option value="1">户型图</option>
													<option value="2">交通图</option>
													<option value="4">样板图</option>
													<option value="5">效果图</option>
												</select>
											</div>
										</div>
											<div style="display: none" id="selectshi">
												<div class="form-group">
													<label class="col-sm-2 control-label" for="field-3"><span class="red">居室：</span></label>
													<div class="col-sm-3">
													<select class="form-control" id="jushi">
														<option value="1">一居室</option>
														<option value="2">二居室</option>
														<option value="3">三居室</option>
														<option value="4">四居室</option>
														<option value="5">五居室</option>
														<option value="6">五居室以上</option>
													</select>
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-2 control-label" for="field-3"><span class="red">厅：</span></label>
													<div class="col-sm-3">
													<select class="form-control" id="tpting">
														<option value="1">一厅</option>
														<option value="2">二厅</option>
														<option value="3">三厅</option>
														<option value="4">四厅</option>
														<option value="5">五厅</option>
														<option value="6">五厅以上</option>
													</select>
												</div>
											</div>
												<div class="form-group">
													<label class="col-sm-2 control-label" for="field-3"><span class="red">卫：</span></label>
													<div class="col-sm-3">
													<select class="form-control" id="tpwei">
														<option value="1">一卫</option>
														<option value="2">二卫</option>
														<option value="3">三卫</option>
														<option value="4">四卫</option>
														<option value="5">五卫</option>
														<option value="6">五卫以上</option>
													</select>
												</div>
											</div>
										</div>
										<div id="fenggediv" style="display: none;">
											<div class="form-group">
														<label class="col-sm-2 control-label" for="field-3"><span class="red">风格：</span></label>
														<div class="col-sm-3">
														<select class="form-control" id="fengge">
															<option value="1">新古典</option>
															<option value="2">美式</option>
															<option value="3">现代简约</option>
															<option value="4">公寓</option>
															<option value="5">地中海风格</option>
															<option value="6">厨卫</option>
														</select>
													</div>
											</div>
										</div>
										
										<%-- <div class="form-group">
											<label class="col-sm-2 control-label" for="field-3"><span class="red">图片名称</span></label>

											<div class="col-sm-8">
												<input type="input" class="form-control" id="imgNameAll" name="imgNameAll" placeholder="">
											</div>
										</div> --%>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="field-3" >图片名称</label>
											<div class="col-sm-6">
					                			<input type="text" class="form-control" id="uptpName"  placeholder="可自定义名称，不填写则采用图片默认名称"> 
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="field-3" >上传图片</label>
											<div class="col-sm-6" id="fkContainer">
					                				<input type="button" class="btn btn-success" id="fkPickfiles"  value="上传"> 
												<span class="red">(请上传大小在800*640、5M以内的jpg、png、gif格式图片)</span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="field-3">全部图片</label>
											<div class="col-sm-8">
												<div class="panel-heading">
													<ul class="quanbu nav nav-tabs">
														<li  class="active"><a href="#ulHouseExclusiveFiles3" id="houseExclusiveImgType3" data-toggle="tab">环境图</a></li>
														<li><a href="#ulHouseExclusiveFiles1" id="houseExclusiveImgType1" data-toggle="tab">户型图</a></li>
														<li><a href="#ulHouseExclusiveFiles2" id="houseExclusiveImgType2" data-toggle="tab">交通图</a></li>
														<li><a href="#ulHouseExclusiveFiles4" id="houseExclusiveImgType4" data-toggle="tab">样板图</a></li>
														<li><a href="#ulHouseExclusiveFiles5" id="houseExclusiveImgType5" data-toggle="tab">效果图</a></li>
													</ul>
												</div>

												<div class="tab-content" style="width:550px">
													<div class="tab-pane active" id="ulHouseExclusiveFiles3">
														<div class="panel-body">
														</div>
													</div>

													<div class="tab-pane" id="ulHouseExclusiveFiles2">
														<div class="panel-body">
														</div>

													</div>
													<div class="tab-pane" id="ulHouseExclusiveFiles1">
														<div class="panel-body">
														</div>
													</div>
													<div class="tab-pane" id="ulHouseExclusiveFiles4">
														<div class="panel-body">
														</div>
													</div>
													<div class="tab-pane" id="ulHouseExclusiveFiles5">
														<div class="panel-body">
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="form-group">
											<div class="col-md-5 col-md-offset-5">
												<button type="submit" class="btn btn-success">保存</button>
												<input type="button" class="btn btn-success" onclick="cancel()" value="返回列表"/>
											</div>
										</div>
									</form>
								</div>
							

						</div>

						<div class="tab-pane with-bg" id="fwv-4">
							<div class="panel-body col-lg-3">
										<div class="col-lg-12" style="padding-top: 10px;">
											<div class="input-group" style="margin-bottom:10px;margin-right:0px; width:45%;heigth:22px;float:left;">
												<input type="text"  style="heigth:22px; width:100%;"  placeholder="请输栋座名称" id="lpdong_lpdName">
												<span class="input-group-btn"  >
													<a href="javascript:queryDong()" style="float:right;margin-right:3px"  class="btn btn-success btn-xs">搜索</a>
												</span>
											</div>
											<a href="javascript:void(0)" class="btn btn-success btn-xs" style="float:left;" data-toggle="modal" onclick="showAddDongDlg()" data-target="#Donglou">新增栋楼</a>
											<button class="btn btn-danger btn-xs" style="float:right;margin-left:0px" onclick="batchDeleteLpD()">批量删除</button>
										</div>
											<div class="col-lg-12">
												<div class=" scrollable" data-max-height="500">
													<table class="table table-bordered" id="tblLpdong">
														<thead >
															<tr>
																<th class="text-center thfont" style="width:47px"><input type="checkbox" class="lpdz"/>序号</th>
																<th  class="text-center thfont">栋座</th>
																<th  class="text-center thfont" style="width:70px">操作</th>
															</tr>
														</thead>
														<tbody class="middle-align Color"  id="dongTbody">
														</tbody>
													</table>
												</div>
											</div>
										</div>		
							<div class="panel-body col-lg-5">
											<div class="col-lg-12" style="padding-top: 10px;">
												<button class="btn btn-success btn-xs" onclick="showAddDanyuanDlg()">新增单元</button>
												<a data-toggle="modal" id="addDanYuan" data-target="#Danyuan"></a>
												<a data-toggle="modal" id="updateDanYan" data-target="#danyuanxiugai"></a>
												<button class="btn btn-success btn-xs" onclick="showCorHouseInitDanYan()">查询关联房源</button>
												<a href="" data-toggle="modal" id="showCrrHouseModalDanYan" data-target="#Guanlianfangyuan"></a>
												<button class="btn btn-danger btn-xs" onclick="batchdeleteDanyuan()">批量删除</button>
												<div class="input-group" style="margin-bottom:10px; width: 39%;heigth:22px; float: right;">
													<input type="text" style="heigth:22px; width:100%;float:right;"  placeholder="请输层名称" id="fangHao_ceng">
													<span class="input-group-btn">
														<a href="javascript:queryCeng()" class="btn btn-success btn-xs">搜索</a>
													</span>
												</div>
											</div>
											<div class="col-lg-7">
												<div class="scrollable" data-max-height="500">
													<table class="table table-bordered " id="tblLpdanyuan">
														<thead>
															<tr>
																<th class="thfont text-center" style="width:47px"><input type="checkbox" class="lpdy"/>序号</th>
																<th  class="thfont text-center">单元</th>
																<th  class="thfont text-center" style="width:70px">操作</th>
															</tr>
														</thead>
														<tbody class="middle-align Color">
															
														</tbody>
													</table>
												</div>
											</div>
											
											<div class="col-lg-5">
												<div class="table-responsive scrollable" data-max-height="500">
													<table class="table table-bordered"  id="tblLpceng">
														<thead>
															<tr>
																<th class="thfont text-center" style="width:47px">序号</th>
																<th class="thfont text-center">层号</th>
															</tr>
														</thead>
														<tbody class="middle-align Color">
															
														</tbody>
													</table>
												</div>
											</div>
										</div>
							<div class="panel-body col-lg-4">
											<div class="col-lg-12" style="padding-top: 10px;">
											<button class="btn btn-success btn-xs" onclick="showAddFanghaoDlg()">新增房号</button>
											<a data-toggle="modal" id="addFanghao" data-target="#Fanghao"></a>
											<a data-toggle="modal" id="updFanghao" data-target="#Fanghaoxiugai"></a>
											<button class="btn btn-success btn-xs" onclick="showCorHouseInit()">查询关联房源</button>
											<a href="" data-toggle="modal" id="showCrrHouseModal" data-target="#Guanlianfangyuan"></a>
											<button class="btn btn-danger btn-xs" onclick="batchDeleteFanghao()">批量删除</button>
											<div class="input-group" style="margin-bottom:10px; width:29%;heigth:22px; float: right;">
												<input type="text" style="heigth:22px; width:100%;float:right;"  placeholder="请输房号名称" id="fangHao_ceng1">
												<span class="input-group-btn">
													<a href="javascript:queryFanghao()" class="btn btn-success btn-xs">搜索</a>
												</span>
											</div>
										</div>
											<div class="col-lg-12">
												<div class="scrollable" data-max-height="500">
													<table class="table table-bordered" id="tblLpfanghao">
														<thead>
															<tr>
																<th class="thfont text-center" style="width:47px"><input type="checkbox" class="cbALL"/>序号</th>
																<th class="thfont text-center">房号</th>
																<th class="thfont text-center" style="width:70px">操作</th>
															</tr>
														</thead>
														<tbody class="middle-align Color">
															
														</tbody>
													</table>
												</div>
											</div>
										</div>
										<div class="panel-body">
										<div class="text-center ">
											<textarea class="form-control" id="dzRemark" cols="5" id="field-5" >${loadLpxx.dzRemark}</textarea>
											<br>
											<button onclick="saveDzRemark()" class="btn btn-success">保存备注</button>
											<input type="button" class="btn btn-success" onclick="cancel()" value="返回列表"/>
										</div>
									</div>		
							<div class="clearfix"></div>
						</div>
						<div class="tab-pane with-bg" id="fwv-5">
							<div class="panel panel-default">
								<!-- Add class "collapsed" to minimize the panel -->
								<div class="panel-heading">
									<div class="panel-options pull-left">
										<ul class="nav nav-tabs">
											<li class="active">
												<a href="#tab-001" data-toggle="tab">划片学校</a>
											</li>
											<li>
												<a href="#tab-002" data-toggle="tab">服务网点</a>
											</li>
											<li>
												<a href="#tab-003" data-toggle="tab">地铁</a>
											</li>
											<li>
												<a href="#tab-004" data-toggle="tab">地图配套</a>
											</li>
										</ul>
									</div>
								</div>
								<div class="panel-body">
									<div class="tab-content">
										<div class="tab-pane active" id="tab-001">
												<div>
													<button class="btn btn-success" onclick="schoolInit();">新增</button>
													<a href="#" data-toggle="modal" id="showSchoolAdd" data-target="#xinzenhuapian"></a>
													<a href="#" data-toggle="modal" id="showUpd" data-target="#xinzenhuapian1"></a>
												</div>
											<div class="table-responsive">
												<table class="table table-bordered table-striped">
													<thead>
														<tr>
															<th>学校类型</th>
															<th>学校名称</th>
															<th>划片范围</th>
															<th>划片类型</th>
															<th>操作</th>
														</tr>
													</thead>
													<tbody class="middle-align" id="lpSchoolInfo">
													
													</tbody>
												</table>
											</div>
										</div>
										<div class="tab-pane" id="tab-002">
											<div class="row">
												<div class="col-lg-3 col-md-3 col-sm-3">
													<div class="form-group">
														<div class="input-group input-group-sm input-group-minimal">
															<span class="input-group-addon">服务范围：</span>
															<select class="form-control" id="serFindFw">
																<option value="0">请选择</option>
																<option value="1">责任盘</option>
																<option value="2">维护盘</option>
																<option value="3">范围盘</option>
															</select>
														</div>
													</div>
												</div>
												<div class="col-lg-3 col-md-3 col-sm-3">
													<div class="form-group">
														<div class="input-group input-group-sm input-group-minimal">
															<span class="input-group-addon">服务网点：</span>
															<select class="form-control s2example-1" id="serviceWD">
															</select>
														</div>
													</div>
												</div>
												<div class="col-lg-3 col-md-3 col-sm-3">
													<div class="form-group">
														<button class="btn btn-secondary" onclick="loadLpFuzh()">查询</button>
													</div>
												</div>
											</div>
											<div class="clearfix"></div>
											<div>
												<div>
													<button class="btn btn-success" onclick="addZerenInit()">新增责任盘</button>
													<a data-toggle="modal" id="zerenModal" data-target="#xinzenhuapian4"></a>
													<button class="btn btn-success" onclick="addWeihInit('weih')">新增维护盘</button>
													<a data-toggle="modal" id="weihModal" data-target="#xinzenhuapian2"></a>
													<button class="btn btn-success" onclick="addWeihInit('fanw')">新增范围盘</button>
													<a data-toggle="modal" id="fanwModal" data-target="#xinzenhuapian3"></a>
													<!-- <a class="btn btn-danger btn-xs">批量删除</a> -->
												</div>
											</div>
											<div class="table-responsive">
												<table class="table table-bordered table-striped">
													<thead>
														<tr>
															<th class="text-center">
														<input name="headBox"type="checkbox" onclick="checkAll(this);">
															</th>
															<th>服务范围</th>
															<th>服务来源</th>
															<th>服务网店（店组）</th>
															<th>网点地址</th>
															<th>服务电话</th>
															<th>操作</th>
														</tr>
													</thead>
													<tbody class="middle-align" id="showLpHuaPanInfo">
														
													</tbody>
												</table>
												<div id="macPageWidget"></div>
											</div>
										</div>
										<div class="tab-pane" id="tab-003">
											<div>
													<button class="btn btn-success" onclick="addMetorInit(this)"; >新增地铁</button>
													<a data-toggle="modal" herf="" data-target="#xinzendite1"></a>
												</div>
											<div class="table-responsive">
												<table class="table table-bordered table-striped">
													<thead>
														<tr>
															<th>序号</th>
															<th>路线</th>
															<th>名称</th>
															<th>操作</th>
														</tr>
													</thead>
													<tbody class="middle-align" id="metorInfo">
													</tbody>
												</table>
											</div>
										</div>
										<div class="tab-pane" id="tab-004">
											<div class="tab-content" >
												<jsp:include page="../include/zhoubiansousuo.jsp?x=${loadLpxx.x}&y=${loadLpxx.y}"></jsp:include>
												</div>
										</div>
									</div>

								</div>
							</div>

						</div>

					</div>

				</div>
			</div>
		</div>
		<!-- Main Footer -->

		<div class="go-up" style="position: fixed;right: 15px; bottom: 10px; z-index: 9999;">
			<a href="#" rel="go-top">
				<i class="el-up-open"></i>
			</a>
		</div>
	</body>

</html>
<!-- Bottom Scripts -->
<script src="<%=basePath%>/assets/js/bootstrap.min.js"></script>
<script src="<%=basePath%>/assets/js/TweenMax.min.js"></script>
<script src="<%=basePath%>/assets/js/resizeable.js"></script>
<script src="<%=basePath%>/assets/js/joinable.js"></script>
<script src="<%=basePath%>/assets/js/xenon-api.js"></script>
<script src="<%=basePath%>/assets/js/xenon-toggles.js"></script>
<script src="<%=basePath%>/assets/js/moment.min.js"></script>

<script src="<%=basePath%>/assets/js/rwd-table/js/rwd-table.js"></script>

<!-- Imported scripts on this page -->
<script src="<%=basePath%>/assets/js/devexpress-web-14.1/js/globalize.min.js"></script>
<script src="<%=basePath%>/assets/js/devexpress-web-14.1/js/dx.chartjs.js"></script>

<!-- Imported scripts on this page  xiala-->
<link rel="stylesheet" href="<%=basePath%>/assets/js/daterangepicker/daterangepicker-bs3.css">
<link rel="stylesheet" href="<%=basePath%>/assets/js/select2/select2.css">
<link rel="stylesheet" href="<%=basePath%>/assets/js/select2/select2-bootstrap.css">
<link rel="stylesheet" href="<%=basePath%>/assets/js/multiselect/css/multi-select.css">
<script src="<%=basePath%>/assets/js/rwd-table/js/rwd-table.js"></script>
<script src="<%=basePath%>/assets/js/daterangepicker/daterangepicker.js"></script>
<script src="<%=basePath%>/assets/js/datepicker/bootstrap-datepicker.js"></script>
<script src="<%=basePath%>/assets/js/timepicker/bootstrap-timepicker.min.js"></script>
<script src="<%=basePath%>/assets/js/colorpicker/bootstrap-colorpicker.min.js"></script>
<script src="<%=basePath%>/assets/js/select2/select2.min.js"></script>
<script src="<%=basePath%>/assets/js/xenon-custom.js"></script>
<script type="text/javascript" src="<%=basePath%>/assets/images/new_file.js"></script>

<script type="text/javascript">
// 	$('.form_date').datetimepicker({
// 		language: 'zh-CN',
// 		weekStart: 1,
// 		todayBtn: 1,
// 		autoclose: 1,
// 		todayHighlight: 1,
// 		startView: 2,
// 		minView: 2,
// 		forceParse: 0
// 	});
// 	$(".form_datetime").datetimepicker({
// 		format: 'yyyy-mm-dd:hh:ii',
// 		language: 'zh-CN',
// 	});
</script>

<script type="text/javascript">
	jQuery(document).ready(function($) {
		$(".s2example").select2({
		placeholder: '请输入搜索条件.',
		allowClear: true
		}).change('select2-open', function()
		{
		$(this).data('select2').results.addClass('overflow-hidden').perfectScrollbar();
		});
	});
	
</script>

<script type="text/javascript">
	// Sample Javascript code for this page
	jQuery(document).ready(function($) {
		// Edit Modal
	// 			<a href="#" class="thumb" data-action="edit">
// 		$('.gallery-env a[data-action="edit"]').on('click', function(ev) {
// 			ev.preventDefault();
// 				$('#editimg').attr("src", $(this).attr("src"));
// 			$("#gallery-image-modal").modal('show');
// 		});
		// Delete Modal
		$('.gallery-env a[data-action="trash"]').on('click', function(ev) {
			ev.preventDefault();
			$("#gallery-image-delete-modal").modal('show');
		});
		// Sortable
		$('.gallery-env a[data-action="sort"]').on('click', function(ev) {
			ev.preventDefault();
			var is_sortable = $(".album-images").sortable('instance');
			if (!is_sortable) {
				$(".gallery-env .album-images").sortable({
					items: '> div'
				});
				$(".album-sorting-info").stop().slideDown(300);
			} else {
				$(".album-images").sortable('destroy');
				$(".album-sorting-info").stop().slideUp(300);
			}
		});
	});
</script>

<!--维护单位-->
<div class="modal fade" id="weihudanwei" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">新增维护单位</h4>
			</div>
			<div class="modal-body">
				<div class="scrollable ps-container" data-max-height="400" style="max-height: 400px;">
				<input type="hidden" class="form-control" id ="lpmId" value="0"/>
				<input type="hidden" class="form-control" id ="lpmlpid"  value="${loadlpxx.id}"/>
					<form role="form" class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-3 control-label">类型：</label>
							<div class="col-sm-9">
								<!-- <input type="text" class="form-control" id ="mType" /> -->
								 <select class="form-control" id="mType" >
										<option value="0">请选择</option>
									</select>	
							</div>
							
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label">企业单位名称：</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id ="enterprise"  />
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label">联系方式：</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id ="phone" />
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label">单位地址：</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id ="dizhi"/>
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label">备注：</label>
							<div class="col-sm-9">
								<textarea class="form-control" id ="remark"></textarea>
							</div>
						</div>
					</form>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="addData()">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="buttong()">关闭</button>
			</div>
		</div>
	</div>
</div>

<!--居住成本-->
<div class="modal fade" id="juzhuchengben" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">新增居住成本</h4>
			</div>
			<input type="hidden" class="form-control" id ="costId" value="0"/>
			<input type="hidden" class="form-control" id ="costlpid"  value="${loadlpxx.id}"/>
			<div class="modal-body">
				<div class="scrollable ps-container" data-max-height="400" style="max-height: 400px;">
					<form role="form" class="form-horizontal">
						<div class="form-group"> 
							<label class="col-sm-2 control-label">类型：</label>
							<div class="col-sm-9">
								<!-- <input type="text" class="form-control" id = "ctype"/> -->
									<select class="form-control" id="ctype" onchange="action1111(this)">
										<option value="0">请选择</option>
									</select>	
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">计收方式：</label>
							<div class="col-sm-9">
								<select class="form-control" id ="payingWay">
								<option value="0">请选择</option>
								</select>
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">金额/单价：</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id ="price"/>
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">计量单位：</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id ="unit" readonly="true"/>
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">备注：</label>
							<div class="col-sm-9">
								<textarea class="form-control" row="5" id ="jzcbRemarks"></textarea>
							</div>
						</div>
					</form>

				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="addData1()">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="uopdayt()">关闭</button>
			</div>
		</div>
	</div>
</div>
									
<!-- JavaScripts initializations and stuff -->
<script src="<%=basePath%>/assets/js/xenon-custom.js"></script>
<div class="modal fade" id="Donglou" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">新增栋座</h4>
			</div>
			<form role="form" class="form-horizontal" id="donglouForm">
			<div class="modal-body">
				<div class="scrollable" data-max-height="600">
					<table class="table" id="tblAddDong">
						<tbody>
							<tr>
								<td width="90">新增方式</td>
								<td>
									<label class="radio-inline"> 
										<input type="radio" id="status1" name="xhjLpdong.type" value="Single" checked="checked" class="checkbox" onclick="dongAddTypeClicked(this)"> <span>单个添加</span>
									</label>
									<label class="radio-inline"> 
										<input type="radio" id="status1" name="xhjLpdong.type" value="Batch" onclick="dongAddTypeClicked(this)"> <span>批量新增</span>
									</label>
								</td>
							</tr>
							<input type="hidden" name="xhjLpdong.lpId" value="${loadLpxx.id}">
							<!--点击批量新增出现 -->
							<tr class="dongBatch">
								<td>名称前缀</td>
								<td><input type="text" name="xhjLpdong.prefix" class="form-control"  placeholder=""></td>
							</tr>
							<tr class="dongBatch">
								<td><font color="#f00">批量序号</font></td>
								<td><div class="col-md-3">
										<input type="text" name="xhjLpdong.start" class="form-control" placeholder="">
									</div>
									<div class=" pull-left">-</div><div class="col-md-3">
										<input type="text" name="xhjLpdong.end" class="form-control" placeholder="">
									</div>
								</td>
							</tr>
							<tr class="dongBatch">
								<td>名称后缀</td>
								<td><input type="text" name="xhjLpdong.suffix" class="form-control" placeholder=""></td>
							</tr>
						<!-- 单个新增点击隐藏 End -->
							<tr class="dongSingle">
								<td><font color="#f00">栋座名称</font></td>
								<td><input type="text" name="xhjLpdong.lpdName" class="form-control" placeholder=""></td>
							</tr>
						</tbody>
						
					</table>
					<div class="table-responsive">
						<table class="table">
							<thead>
								<tr>
									<th colspan="4">栋座其他信息</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>单元定义类型</td>
									<td>
										<select class="form-control" id = "dType" name ="xhjLpdong.dtype">
											<option value="0">请选择</option>
											<option value="1">不限</option>
										</select>
									</td>
									<td>每栋总单元数</td>
									<td><input type="text" class="form-control" id ="dyNum" name = "xhjLpdong.dyNum"></td>
								</tr>
								<tr>
									<td>建筑年代</td>
									<td><input type="text" class="form-control" id ="ages" name = "xhjLpdong.ages"></td>
									<td>建筑面积</td>
									<td><input type="text" class="form-control" id ="size" name ="xhjLpdong.size"></td>
								</tr>
								<tr>
									<td>地上总层数</td>
									<td><input type="text" class="form-control" id ="topNum" name ="xhjLpdong.topNum"></td>
									<td>地下总层数</td>
									<td><input type="text" class="form-control" id ="underNum" name = "xhjLpdong.underNum"></td>
								</tr>
								<tr>
									<td>座落</td>
									<td>
										<select class="form-control" id ="located" name= "xhjLpdong.located">
											<option value="0">请选择</option>
											<option value="1">不限</option>
										</select>
									</td>
									<td>权属</td>
									<td>
										<select class="form-control" id ="ownership" name ="xhjLpdong.ownership">
											<option value="0">请选择</option>
											<option value="1">不限</option>										
										</select>
									</td>
								</tr>
								<tr>
									<td>备注</td>
									<td colspan="3">
										<textarea class="form-control" rows="5" id ="remarks" name ="xhjLpdong.remarks"></textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="doAddDong()">保存</button>
				<button type="button" class="btn btn-danger" id="dongClose" data-dismiss="modal">关闭</button>
			</div>
		</form>
		</div>
	</div>
</div>



<!-- Modal 4 (新增单元)-->
<div class="modal fade" id="Danyuan" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">新增单元</h4>
			</div>
			<form role="form" class="form-horizontal" id="danyuanForm">
			<div class="modal-body">
				<div class="scrollable" data-max-height="600">
					<table class="table" id="tblAddDanyuan">
						<tbody>
							<tr>
								<td width="90">新增方式</td>
								<input type="hidden" name="lpid" value="${loadLpxx.id}">
							<input type="hidden" id="dydzid"  name="xhjLpdanyuan.dzid"/>
								<td>
									<label class="radio-inline" for="status1">
										<input type="radio" id="status1" name="xhjLpdanyuan.type" value="Single" class="checkbox" onclick="danyuanAddTypeClicked(this)">
										<span>单个添加</span>
									</label>
									<label class="radio-inline" for="status1">
										<input type="radio" id="status1" name="xhjLpdanyuan.type" value="Batch" class="checkbox" onclick="danyuanAddTypeClicked(this)">
										<span>批量新增</span>
									</label>
								</td>
							</tr>
							<!-- 点击批量新增出现 -->
							<tr class="danyuanBatch">
								<td>名称前缀</td>
								<td><input type="text" name="xhjLpdanyuan.prefix" class="form-control" placeholder=""></td>
							</tr>
							<tr class="danyuanBatch">
								<td><font color="#f00">批量序号</font></td>
								<td>
									<div class="col-md-3">
										<input type="text" name="xhjLpdanyuan.start" class="form-control" placeholder="">
									</div>
									<div class=" pull-left">-</div>
									<div class="col-md-3">
										<input type="text" name="xhjLpdanyuan.end" class="form-control" placeholder="">
									</div>
								</td>
							</tr>
							<tr class="danyuanBatch">
								<td>名称后缀</td>
								<td><input type="text" name="xhjLpdanyuan.suffix" class="form-control" placeholder=""></td>
							</tr>
							<!-- 单个新增点击隐藏 End -->
							<tr class="danyuanSingle">
								<td><font color="#f00">单元名称</font></td>
								<td><input type="text" name="xhjLpdanyuan.dyName" class="form-control" placeholder=""></td>
							</tr>
						</tbody>
					</table>
					<div class="table-responsive">
						<table class="table">
						<tbody>
							<thead>
								<tr>
									<th colspan="4">单元其他信息</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>楼层定义类型</td>
									<td>
										<select class="form-control"  id ="dType1" name = "xhjLpdanyuan.dtype">
											<option value="0" selected="selected">请选择</option>
											<option value="1">不限</option>
										</select>
									</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td>地上总层数</td>
									<td><input type="text" class="form-control"  id ="topNum1" name = "xhjLpdanyuan.topNum"></td>
									<td>地下总层数</td>
									<td><input type="text" class="form-control"  id ="underNum1" name = "xhjLpdanyuan.underNum"></td>
								</tr>
								<tr>
									<td>每单元总楼层数</td>
									<td><input type="text" class="form-control"  id ="totalNum" name = "xhjLpdanyuan.totalNum"></td>
									<td>一梯几户</td>
									<td><input type="text" class="form-control"  id ="dihu" name = "xhjLpdanyuan.dihu"></td>
								</tr>
								<tr>
									<td>备注</td>
									<td colspan="3">
										<textarea class="form-control" rows="5"   id ="remarks1" name = "xhjLpdanyuan.remarks"></textarea>
									</td>
								</tr>
						</tbody>
						</table>
					
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="doAddDanyuan()">保存</button>
				<button type="button" class="btn btn-danger" id="danyClose" data-dismiss="modal" onclick="Empty1()">关闭</button>
			</div>
		</div>
		</form>
	</div>
</div>
</div>


<!-- Modal 4 (修改)-->
<div class="modal fade" id="Xiugai" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">修改栋座</h4>
			</div>
			<form role="form" class="form-horizontal" id="donglouUpForm">
			<div class="modal-body" id="formUpdateDong">
				<div class="scrollable" data-max-height="600">
					<table class="table">
						<tbody>
							<tr>
								<td><span class="red">栋座名称</span></td>
								<td>
									<input type="hidden"  id="xhjLpdonglpId" name="xhjLpdong.lpId" value="${loadLpxx.id}">
									<input type="hidden" name="xhjLpdong.id">
									<input type="input" class="form-control" name="xhjLpdong.lpdName">
								</td>
							</tr>
						</tbody>
					</table>
					<div class="table-responsive">
						<table class="table">
							<thead>
								<tr>
									<th colspan="4">栋座其他信息</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>单元定义类型</td>
									<td>
										<select class="form-control" id = "dTypeup" name ="xhjLpdong.dtype">
											<option value="0">请选择</option>
											<option value="1">不限</option>
										</select>
									</td>
									<td>每栋总单元数</td>
									<td><input type="text" class="form-control" id ="dyNumup" name = "xhjLpdong.dyNum"></td>
								</tr>
								<tr>
									<td>建筑年代</td>
									<td><input type="text" class="form-control" id ="agesup" name = "xhjLpdong.ages"></td>
									<td>建筑面积</td>
									<td><input type="text" class="form-control" id ="sizeup" name ="xhjLpdong.size"></td>
								</tr>
								<tr>
									<td>地上总层数</td>
									<td><input type="text" class="form-control" id ="topNumup" name ="xhjLpdong.topNum"></td>
									<td>地下总层数</td>
									<td><input type="text" class="form-control" id ="underNumup" name = "xhjLpdong.underNum"></td>
								</tr>
								<tr>
									<td>座落</td>
									<td>
										<select class="form-control" id ="locatedup" name= "xhjLpdong.located">
											<option value="0">请选择</option>
											<option value="1">不限</option>
										</select>
									</td>
									<td>权属</td>
									<td>
										<select class="form-control" id ="ownershipup" name ="xhjLpdong.ownership">
											<option value="0">请选择</option>
											<option value="1">不限</option>									
										</select>
									</td>
								</tr>
								<tr>
									<td>备注</td>
									<td colspan="3">
										<textarea class="form-control" rows="5" id ="remarksup" name ="xhjLpdong.remarks"></textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="lpDongUpd()">修改</button>
				<button type="button" class="btn btn-danger" id="dongUpdClose" data-dismiss="modal">关闭</button>
			</div>
			</form>
		</div>
	</div>
</div>

<!-- Modal 4 (修改)-->
<div class="modal fade" id="XiugaiDy" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">修改单元</h4>
			</div>
			<form role="form" class="form-horizontal" id="danyuanUpForm">
			<div class="modal-body" id="formUpdateDanyuan">
				<div class="scrollable" data-max-height="400">
					<table class="table">
						<tbody>
							<tr>
							<input type="hidden" name="lpid" value="${loadLpxx.id}">
								<td><span class="red">单元名称</span></td>
								<td>
									<input type="hidden" name="xhjLpdanyuan.id">
									<input type="input" class="form-control" name="xhjLpdanyuan.dyName">
								</td>
							</tr>
						</tbody>
					</table>
					<div class="table-responsive">
						<table class="table">
						<tbody>
							<thead>
								<tr>
									<th colspan="4">单元其他信息</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>楼层定义类型</td>
									<td>
										<select class="form-control"  id ="dTypeup1" name = "xhjLpdanyuan.dtype">
											<option value="0">请选择</option>
											<option value="1">不限</option>
										</select>
									</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td>地上总层数</td>
									<td><input type="text" class="form-control"  id ="topNumup1" name = "xhjLpdanyuan.topNum"></td>
									<td>地下总层数</td>
									<td><input type="text" class="form-control"  id ="underNumup1" name = "xhjLpdanyuan.underNum"></td>
								</tr>
								<tr>
									<td>每单元总楼层数</td>
									<td><input type="text" class="form-control"  id ="totalNumup" name = "xhjLpdanyuan.totalNum"></td>
									<td>一梯几户</td>
									<td><input type="text" class="form-control"  id ="dihuup" name = "xhjLpdanyuan.dihu"></td>
								</tr>
								<tr>
									<td>备注</td>
									<td colspan="3">
										<textarea class="form-control" rows="5"   id ="remarksup1" name = "xhjLpdanyuan.remarks"></textarea>
									</td>
								</tr>
						</tbody>
						</table>
					
				</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="danYuanUpd()">修改</button>
				<button type="button" class="btn btn-danger" id="danyUpdClose" data-dismiss="modal">关闭</button>
			</div>
			</form>
		</div>
	</div>
</div>


<!-- Modal 4 (新增房号)-->
<div class="modal fade" id="Fanghao" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">新增房号</h4>
			</div>
			<form role="form" class="form-horizontal" id="fanghaoForm">
			<div class="modal-body">
				<div class="scrollable ps-container ps-active-y" data-max-height="600" id="formAddFanghao">
					<table class="table" id="tblAddFanghao">
					<tbody>
			              <tr>
			              	<td width="90">新增方式</td>
			              	<input type="hidden" name="xhjLpfanghao.lpid" value="${loadLpxx.id}" />
							<input type="hidden" id="fanghaodyId"  name="xhjLpfanghao.dyId"/>
							<td>
								<div class="qwe">
									<label class="radio-inline" for="status1">
										<input type="radio" id="status1" name="fanghaoAddType" value="Batch" onclick="fanghaoAddTypeClicked(this)">
										<span>批量新增</span>
									</label>
									<label class="radio-inline" for="status1">
										<input type="radio" id="status1" name="fanghaoAddType" value="Single" checked="checked" class="checkbox" onclick="fanghaoAddTypeClicked(this)">
									<span>单个添加</span>
								</label>
								</div>
							</td>
			              </tr>
			              <tr>
					      	<td>房号类型</td>
							<td>
								<div class="qwe">
								<label class="radio-inline" for="status1">
									<input type="radio" id="status1" name="xhjLpfanghao.leixing" value="41" checked="checked" class="checkbox">
									<span>住宅</span>
								</label>
								<label class="radio-inline" for="status1">
									<input type="radio" id="status1" name="xhjLpfanghao.leixing" value="43" class="checkbox">
									<span>商铺</span>
								</label>
								</div>
							</td>
						  </tr>
						  <!--  <tr class="fanghaoBatch">
								<td width="90">命名规则</td>
								<td>
									<label class="radio-inline">
										<input type="radio" name="namingrules" checked value="1"> 层+编号
									</label>
									<label class="radio-inline">
										<input type="radio" name="namingrules" value="2"> 前缀+编号
									</label>
									<label class="radio-inline">
										<input type="radio" name="namingrules" value="3"> 编号+后缀
									</label>
									<label class="radio-inline">
										<input type="radio" name="namingrules" value="4"> 前缀+层+编号
									</label>
								</td>
							</tr> -->
			              <tr class="fanghaoSingle">
						  	  <td>
						  	  	  <font color="#f00">层数</font>
						  	  </td>
							  <td>
							  	  <input type="number" name="xhjLpfanghao.ceng" class="form-control">
							  </td>
						  </tr>
						  <tr class="fanghaoSingle">
							  <td><font color="#f00">房号名称</font></td>
							  <td><input type="text" name="xhjLpfanghao.fangHao" class="form-control"></td>
						  </tr>
			              <tr class="fanghaoBatch">
			              	<td>名称前缀</td>
			                <td>
								<input type="text" class="form-control" id="txtFhPrefix" >
			              	</td>
			              </tr>
			              <tr class="fanghaoBatch">
			              	<td><span class="red">起始层数</span></td>
			                <td>
								<div class="col-lg-4">
										<input type="text" id="txtFhFloorStart" class="form-control">
									</div>
								<div class="col-lg-1"><span>-</span></div>
								<div class="col-lg-4">
										<input type="text" id="txtFhFloorEnd" class="form-control">
								</div>
			              	</td>
			              </tr>
			              <tr class="fanghaoBatch">
			              	<td><span class="red">起始编号</span></td>
			                <td>
								<div class="col-lg-4">
										<input type="text" id="txtFhStart" class="form-control">
									</div>
								<div class="col-lg-1"><span>-</span></div>
								<div class="col-lg-4">
										<input type="text" id="txtFhEnd" class="form-control">
								</div>
			              	</td>
			              </tr>
			              <tr class="fanghaoBatch">
			              	<td>名称后缀</td>
			                <td>
								<input type="email" class="form-control" id="txtFhSuffix">
			              	</td>
			              </tr>
			              <tr class="fanghaoBatch">
			              	<td colspan="2" align="center">
			              		<button type="button" class="btn btn-info" onclick="previewFanghao()">生成房号</button>
			              	</td>
			              	<input type="hidden" name="datas" id="datas">
			              </tr>
			              <tr class="fanghaoBatch">
							<td colspan="2" class="text-center">
								<div id="tdFanghaoPreview" style="width:480px;overflow-x:auto">
								</div>
							</td>
			              </tr>
			              <tr>
			              	<td colspan="2">
			              		<div class="col-lg-4">
										<input type="text" class="form-control">
								</div>
								<div class="col-lg-4">
										<input type="text" class="form-control">
								</div>
								<div class="col-lg-4">
										<input type="text" class="form-control">
								</div>
			              	</td>
			              </tr>
			           	 
			            </tbody>
		          </table>
		          
		          <div class="table-responsive">
						<table class="table">
							<thead>
								<tr>
									<th colspan="4">房号其他信息</th>
								</tr>
							</thead>
							<tbody>
							 <tr class="fanghaoBatch">
			              	<td>总层数</td>
			                <td>
								<input type="text" class="form-control" id="totalFloor" name="xhjLpfanghao.totalFloor">
			              	</td>
			              </tr>
								<tr>
									<td>户型</td>
									<td colspan="3">
										<div class="input-group input-group-minimal">
											<input type="text" class="form-control" id ="shi" name="xhjLpfanghao.shi"/>
											<span class="input-group-addon">室</span>
											<input type="text" class="form-control" id ="ting" name="xhjLpfanghao.ting"/>
											<span class="input-group-addon">厅</span>
											<input type="text" class="form-control" id ="chu" name="xhjLpfanghao.chu"/>
											<span class="input-group-addon">厨</span>
											<input type="text" class="form-control" id ="wei" name="xhjLpfanghao.wei"/>
											<span class="input-group-addon">卫</span>
										</div>
									</td>
								</tr>
								<tr>
									<%-- <td>用途</td>
									<td>
										<select class="form-control" id ="leibei2">
											<option value="1">请选择</option>
										</select>
									</td> --%>
									<td>朝向</td>
									<td>
										<select class="form-control" id ="chaoXiang" name="xhjLpfanghao.chaoXiang">
											<option value="1">请选择</option>
										</select>
									</td>
								</tr>
								<tr>
									<td>装修情况</td>
									<td>
										<select class="form-control" id ="decorationStandard" name="xhjLpfanghao.decorationStandard">
											<option value="1">请选择</option>
										</select>
									</td>
									<td>建筑面积</td>
									<td><input type="text" class="form-control" id= "cqmj" name="xhjLpfanghao.cqmj"></td>
								</tr>
								<tr>
									<td>使用面积</td>
									<td><input type="text" class="form-control" id ="tnmj" name="xhjLpfanghao.tnmj"></td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td>房屋点评</td>
									<td colspan="3">
										<textarea class="form-control" rows="5" id ="remark2" name="xhjLpfanghao.beiZhu"></textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="doAddLpFanghao(this)">保存</button>
				<button type="button" class="btn btn-danger" id="fanghaoClose" data-dismiss="modal">关闭</button>
			</div>
			</form>
		</div>
	</div>
</div>


<!-- Modal 4 (查看关联房源)-->
<div class="modal fade custom-width" id="Guanlianfangyuan">
	<div class="modal-dialog" style="width: 80%;">
		<div class="modal-content">

			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">查看关联房源</h4>
			</div>

			<div class="tab-content">
				<div class="panel-body">
					<div class="col-lg-12">
						<div class="table-responsive">
							<table class="table table-bordered table-striped table-condensed">
								<thead>
									<tr>
										<th>房号</th>
										<th>房源编号</th>
										<th>租售类型</th>
										<th>归属人</th>
										<th>归属人部门</th>
										<th>录入人</th>
										<th>录入人部门</th>
										<th>房源状态</th>
										<th>房东姓名</th>
										<th>房东电话</th>
										<th>创建时间</th>
									</tr>
								</thead>
								<tbody class="middle-align" id="crrHouse">
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>

<!-- Modal 4 (修改房号)-->
<div class="modal fade" id="Fanghaoxiugai" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">修改房号</h4>
			</div>
			<form role="form" class="form-horizontal" id="fangHaoUpForm">
			<div class="modal-body">
				<div class="scrollable" data-max-height="400">
					<table class="table" id="formUpdateFanghao">
						<tbody>
							<tr>
								<td width="100">房号类型</td>
								<input type="hidden"  class="form-control" name="xhjLpfanghao.dyId" id="fanghaoDyid" />
								<input type="hidden" class="form-control" name="xhjLpfanghao.id" id="fangHaoId" />
								<input type="hidden" class="form-control" name="xhjLpfanghao.lpid"  value="${loadLpxx.id}" />
								<td>
									<label class="radio-inline"> 
										<input type="radio" name="xhjLpfanghao.leixing" dd="41" value="41" > 住宅
									</label>
									<label class="radio-inline">
										<input type="radio" name="xhjLpfanghao.leixing" dd="43" value="43"> 商铺
									</label>
								</td>
							</tr>
							<tr>
								<td><font color="#f00">门牌名称</font></td>
								<td >
									<input type="text" class="form-control" name="xhjLpfanghao.fangHao">
								</td>
							</tr>
							<tr>
								<td><font color="#f00">单元房号</font></td>
								<td>
									<input type="text" class="form-control" name="xhjLpfanghao.fhName">
								</td>
							</tr>
							<tr>
			              	<td>总层数</td>
			                <td>
								<input type="text" class="form-control" id="totalFloorup" name="xhjLpfanghao.totalFloor">
			              	</td>
			              </tr>
						</tbody>
					</table>
					<div class="table-responsive">
						<table class="table">
							<thead>
								<tr>
									<th colspan="4">房号其他信息</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>户型</td>
									<td colspan="3">
										<div class="input-group input-group-minimal">
											<input type="text" class="form-control" id = "shiup" name="xhjLpfanghao.shi"/>
											<span class="input-group-addon">室</span>
											<input type="text" class="form-control" id ="tingup" name="xhjLpfanghao.ting"/>
											<span class="input-group-addon">厅</span>
											<input type="text" class="form-control" id ="chuup" name="xhjLpfanghao.chu"/>
											<span class="input-group-addon">厨</span>
											<input type="text" class="form-control" id ="weiup" name="xhjLpfanghao.wei"/>
											<span class="input-group-addon">卫</span>
										</div>
									</td>
								</tr>
								<tr>
									<td>朝向</td>
									<td>
										<select class="form-control" id ="chaoXiangup" name="xhjLpfanghao.chaoXiang">
											<option value="1">请选择</option>
										</select>
									</td>
								</tr>
								<tr>
									<td>装修情况</td>
									<td>
										<select class="form-control" id ="decorationStandardup" name="xhjLpfanghao.decorationStandard">
											<option value="1">请选择</option>
										</select>
									</td>
									<td>建筑面积</td>
									<td><input type="text" class="form-control" id= "cqmjup" name="xhjLpfanghao.cqmj"></td>
								</tr>
								<tr>
									<td>使用面积</td>
									<td><input type="text" class="form-control" id ="tnmjup" name="xhjLpfanghao.tnmj"></td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td>房屋点评</td>
									<td colspan="3">
										<textarea class="form-control" rows="5" id ="remarkup2" name="xhjLpfanghao.beiZhu"></textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="doUpdateFanghao(this)">保存</button>
				<button type="button" class="btn btn-danger" id="fanghaoUpdClose" data-dismiss="modal">关闭</button>
			</div>
			</form>
		</div>
	</div>
</div>

<!--修改划片-->
<div class="modal fade custom-width" id="xinzenhuapian1">
	<div class="modal-dialog">
		<div class="modal-content">

			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">修改划片</h4>
			</div>
			<div class="modal-body">
				<div class="scrollable" data-max-height="400">
					<table class="table">
						<tbody>
							<tr>
								<td width="100">学校类型</td>
								<td>
									<input id="lpschoolpUpdId" type="hidden"/>
									<input id="lpschoolpUpdType" type="hidden"/>
									<select class="form-control" id="schoolUpdType" onchange="showSchoolUpdDetail(this.value)";>
									</select>
								</td>
							</tr>
							<tr>
								<td width="100">学校名称</td>
								<td>
									<select class="form-control  s2example-1" id="schoolUpdNameDetail">
									</select>
								</td>
							</tr>
							<tr>
								<td>类型</td>
								<td>
									<div class="row">
										<div class="form-block nav nav-tabs xuequleixin">
											<div class="col-sm-4 text-center" style="line-height: 25px; background-color: #f4f4f4;"
												href="#tab10" data-toggle="tab">
												<label id="schoolTitle">学区</label>
											</div>
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<td>选择户型</td>
								<td>
									<div class="tab-content">
										<div class="tab-pane active" id="tab10">
											<div class="form-block">
												<div class="row" id="schoolUpdDong" style="height:200px; OVERFLOW-Y:auto;">
												</div>
												<div class="row" id="schoolUpdFang" style="height:200px; OVERFLOW-Y:auto;">
												</div>
											</div>
											</div>
										</div>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-white" onclick="updSchool();">修改</button>
				<button type="button" class="btn btn-info" id="addLpSchoolUpdClose" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>
<!-- Modal 4 (新增责任盘)-->
<div class="modal fade custom-width" id="xinzenhuapian4">
	<div class="modal-dialog">
		<div class="modal-content">

			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">责任盘</h4>
			</div>
			<div class="modal-body">
				<div class="scrollable" data-max-height="400">
					<table class="table">
						<tbody>
							<tr>
								<td width="100">服务范围</td>
								<td>责任盘</td>
							</tr>
							<tr>
								<td width="100">服务来源</td>
								<td>
									<select class="form-control" id="zeirSource">
										<option value="0">请选择</option>
										<option value="1">公司内部</option>
										<option value="2">外部加盟</option>
										<option value="3">其他</option>
									</select>
								</td>
							</tr>
							<tr>
								<td>服务网点</td>
								<td>
									<div class="w200">
										<select class="form-control s2example-1" id="addZrService" onchange="setAddress(this.value,'ser')">
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<td>网点地址</td>
								<td><label id="serAddress"></label></td>
							</tr>
							<tr>
								<td>服务电话</td>
								<td><label id="serTel"></label></td>
							</tr>
							<tr>
								<td>栋座信息</td>
								<td>
									<div class="row" id="zerDong" style="height:200px; OVERFLOW-Y:auto;">
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-white" onclick="saveZeren(1);">保存</button>
				<button type="button" class="btn btn-info" id="zerModalClose" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>
<!-- Modal 4 (新增维护盘)-->
<div class="modal fade custom-width" id="xinzenhuapian2">
	<div class="modal-dialog">
		<div class="modal-content">

			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">维护盘</h4>
			</div>
			<div class="modal-body">
				<div class="scrollable" data-max-height="400">
					<table class="table">
						<tbody>
							<tr>
								<td width="100">服务范围</td>
								<td>维护盘</td>
							</tr>
							<tr>
								<td width="100">服务来源</td>
								<td>
									<select class="form-control" id="weihSource">
										<option value="0">请选择</option>
										<option value="1">公司内部</option>
										<option value="2">外部加盟</option>
										<option value="3">其他</option>
									</select>
								</td>
							</tr>
							<tr>
								<td>服务网点</td>
								<td>
									<div class="w200">
										<select class="form-control s2example-1" id="weihaddService" onchange="setAddress(this.value,'weih')">
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<td>网点地址</td>
								<td><label id="weihAddress"></label></td>
							</tr>
							<tr>
								<td>服务电话</td>
								<td><label id="weihTel"></label></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-white" onclick="saveWeih(2,'weih')">保存</button>
				<button type="button" class="btn btn-info" id="weihModalClose" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>
<!-- Modal 4 (新增范围盘)-->
<div class="modal fade custom-width" id="xinzenhuapian3">
	<div class="modal-dialog">
		<div class="modal-content">

			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">范围盘</h4>
			</div>
			<div class="modal-body">
				<div class="scrollable" data-max-height="400">
					<table class="table">
						<tbody>
							<tr>
								<td width="100">服务范围</td>
								<td>范围盘</td>
							</tr>
							<tr>
								<td width="100">服务来源</td>
								<td>
									<select class="form-control" id="fanwSource">
										<option value="0">请选择</option>
										<option value="1">公司内部</option>
										<option value="2">外部加盟</option>
										<option value="3">其他</option>
									</select>
								</td>
							</tr>
							<tr>
								<td>服务网点</td>
								<td>
									<div class="w200">
										<select class="form-control s2example-1" id="fanwaddService" onchange="setAddress(this.value,'fanw')">
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<td>网点地址</td>
								<td><label id="fanwAddress"></label></td>
							</tr>
							<tr>
								<td>服务电话</td>
								<td><label id="fanwTel"></label></td>
							</tr>
							<tr class="fuzDong">
								<td>栋座信息</td>
								<td>
									<div class="row" id="zerDong">
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" onclick="saveWeih(3,'fanw')" class="btn btn-white">保存</button>
				<button type="button" id="fanwModalClose" class="btn btn-info" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>
<!--修改-->
<div class="modal fade custom-width" id="xinzenhuapian5">
	<div class="modal-dialog">
		<div class="modal-content">

			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">修改</h4>
			</div>
			<div class="modal-body">
				<div class="scrollable" data-max-height="400">
					<table class="table">
						<tbody>
							<tr>
								<td width="100">服务范围</td>
								<td class="fuzTitle"></td>
							</tr>
							<tr>
								<td width="100">服务来源</td>
								<td>
									<input id="fanwUpdId" type="hidden">
									<input id="fanwUpdSta" type="hidden">
									<select class="form-control" id="fanwUpdSource">
										<option value="0">请选择</option>
										<option value="1">公司内部</option>
										<option value="2">外部加盟</option>
										<option value="3">其他</option>
									</select>
								</td>
							</tr>
							<tr>
								<td>服务网点</td>
								<td>
									<div class="w200">
										<select class="form-control s2example-1" id="updFuzhuWd" onchange="setAddress(this.value,'fuz')">
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<td>网点地址</td>
								<td><label id="fuzAddress"></td>
							</tr>
							<tr >
								<td>服务电话</td>
								<td><label id="fuzTel"></td>
							</tr>
							<tr class="fuzDong">
								<td>栋座信息</td>
								<td>
									<div class="row" id="fuzDong" style="height:200px; OVERFLOW-Y:auto;">
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-white" onclick="updLpFuzh();">保存</button>
				<button type="button" class="btn btn-info" id="updLpFuzModelClose" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>
<!--(新增地铁)-->
<div class="modal fade custom-width" id="xinzendite1">
	<div class="modal-dialog">
		<div class="modal-content">

			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">新增地铁</h4>
			</div>
			<div class="modal-body">
				<div class="scrollable" data-max-height="800">
					<table class="table" id="addMetros">
						<tbody>
							<tr>
								<td width="100">地铁线路</td>
								<td>
									<select class="form-control" id="dtxianlu" onchange="loadZhan(this.value)">
										<option value="0">请选择</option>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<div style="height:320px;overflow-y:auto">
										<table class="table table-bordered table-striped">
											<thead>
											<tr>
												<th class="no-sorting"></th>
												<th>名称</th>
											</tr>
										</thead>
										<tbody class="middle-align" id="zhanTbody">
										</tbody>
									</table>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-white" onclick="saveMetorsInfo()">保存</button>
				<button  type="button" class="btn btn-danger" data-dismiss="modal" id="addMetorClose">关闭</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade custom-width" id="xinzenhuapian">
	<div class="modal-dialog">
		<div class="modal-content">

			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">新增学校</h4>
			</div>
			<div class="modal-body">
				<div class="scrollable" data-max-height="800">
					<table class="table">
						<tbody>
							<tr>
								<td width="100">学校类型</td>
								<td>
									<select class="form-control" id="schoolType" onchange="showSchoolDetail(this.value)";>
									</select>
								</td>
							</tr>
							<tr>
								<td width="100">学校名称</td>
								<td>
								<select class="form-control s2example-1" id="schoolNameDetail">
								</select>
								</td>
							</tr>
							<tr>
								<td>类型</td>
								<td>
									<div class="row">
										<div class="form-block nav nav-tabs xuequleixin">
											<div class="col-sm-4 text-center"
												style="line-height: 25px; background-color: #f4f4f4;"
												href="#tab9" data-toggle="tab">
												<label> 学区 </label>
											</div>
											<div class="col-sm-4 text-center" style="line-height: 25px;"
												href="#tab8" data-toggle="tab">
												<label> 学位 </label>
											</div>

										</div>
									</div>
								</td>
							</tr>
							<tr>
								<td>选择户型</td>
								<td>
									<div class="tab-content">
										<div class="tab-pane active" id="tab9">
											<div class="form-block">
												<div class="row" id="schoolDong" style="height:200px; OVERFLOW-Y:auto;">
												</div>
											</div>
										</div>
										<div class="tab-pane" id="tab8">
											<div class="form-block">
												<div class="row" id="schoolFang" style="height:200px; OVERFLOW-Y:auto;">
													
												</div>
											</div>
										</div>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-white" onclick="saveSchool()">保存</button>
				<button type="button" class="btn btn-info" id="addLpSchoolClose" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>
<input type="hidden" id="shitp">
<input type="hidden" id="fenggetp">
<!-- Modal 4 (幻灯片)-->
<div class="modal fade" id="huandengpian" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">

			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">图库</h4>
			</div>
			<div class="modal-body">
				<div class='Homeslide'>
					<div class='Homeslide_bigwrap'>
						<div class='Homeslide_hand0'></div>
						<div class='Homeslide_hand1'></div>
						<a href="#" class='Homeslide_bigpicdiv_mask'>loading...</a>
						<div class='Homeslide_bigpicdiv'>
							<a href='#'><img src=""></a>
						</div>
					</div>
					<div class="hidden-xs">
						<div class='Homeslide_thumb'>
							<ul>loading...</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" id="map-info-windom">
  <div class="modal-dialog modal-lg" style="width:100%">
  	<div class="modal-header">
<!--       <button type="button" class="close" id="mapModalClose" onclick="$('#mapModal').modal('hide')" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button> -->
      <h4 class="modal-title">地图</h4>
    </div>
    <div class="modal-content">
     	<iframe name ="bankWaterRecordList" id="bankWaterRecordList" src="<%=basePath%>/include/seekCoord.jsp" width="100%" height="500px" frameborder="0" marginheight="0" marginwidth="0" border="0"></iframe>
	    <div class="modal-footer">
			<button type="button" id="windowClose" class="btn btn-danger" data-dismiss="modal">关闭</button>
		</div>
    </div>
  </div>
</div>
<script type="text/javascript" src="<%=basePath%>/js/kindeditor/kindeditor-min.js" charset="UTF-8"></script>
<script type="text/javascript">

		KE.show({
			 id : "more",
		     width : "100%",
		     height : "200px",		    
		     resizeMode : 1,
		     allowFileManager : true,
		     items : [
		     	"source","preview","|","fullscreen","undo","redo",
				"plainpaste","wordpaste","|","justifyleft","justifycenter","justifyright","justifyfull",
				"insertorderedlist","insertunorderedlist","indent","outdent",
				"date","time","|","-","title","fontname","fontsize","|","textcolor","bgcolor","bold","italic","underline",
				"strikethrough","removeformat","|","image","flash","media","specialchar"
			 ],
		     /*图片上传的SERVLET路径*/
		     imageUploadJson : "<%=basePath%>/uploadImages", 
		     /*图片管理的SERVLET路径*/
		     fileManagerJson : "<%=basePath%>/uploadImgManager",
		     /*允许上传的附件类型*/
		     accessoryTypes : "doc|xls|pdf|txt|ppt|rar|zip|xlsx|docx",
		     /*附件上传的SERVLET路径*/
		     accessoryUploadJson : "<%=basePath%>/uploadAccessory"
		});
		
		KE.show({
			 id : "PNum",
		     width : "100%",
		     height : "200px",		    
		     resizeMode : 1,
		     allowFileManager : true,
		     items : [
		     	"source","preview","|","fullscreen","undo","redo",
				"plainpaste","wordpaste","|","justifyleft","justifycenter","justifyright","justifyfull",
				"insertorderedlist","insertunorderedlist","indent","outdent",
				"date","time","|","-","title","fontname","fontsize","|","textcolor","bgcolor","bold","italic","underline",
				"strikethrough","removeformat","|","image","flash","media","specialchar"
			 ],
		     /*图片上传的SERVLET路径*/
		     imageUploadJson : "<%=basePath%>/uploadImages", 
		     /*图片管理的SERVLET路径*/
		     fileManagerJson : "<%=basePath%>/uploadImgManager",
		     /*允许上传的附件类型*/
		     accessoryTypes : "doc|xls|pdf|txt|ppt|rar|zip|xlsx|docx",
		     /*附件上传的SERVLET路径*/
		     accessoryUploadJson : "<%=basePath%>/uploadAccessory"
		});
		
		KE.show({
			 id : "wyRemark",
		     width : "100%",
		     height : "200px",		    
		     resizeMode : 1,
		     allowFileManager : true,
		     items : [
		     	"source","preview","|","fullscreen","undo","redo",
				"plainpaste","wordpaste","|","justifyleft","justifycenter","justifyright","justifyfull",
				"insertorderedlist","insertunorderedlist","indent","outdent",
				"date","time","|","-","title","fontname","fontsize","|","textcolor","bgcolor","bold","italic","underline",
				"strikethrough","removeformat","|","image","flash","media","specialchar"
			 ],
		     /*图片上传的SERVLET路径*/
		     imageUploadJson : "<%=basePath%>/uploadImages", 
		     /*图片管理的SERVLET路径*/
		     fileManagerJson : "<%=basePath%>/uploadImgManager",
		     /*允许上传的附件类型*/
		     accessoryTypes : "doc|xls|pdf|txt|ppt|rar|zip|xlsx|docx",
		     /*附件上传的SERVLET路径*/
		     accessoryUploadJson : "<%=basePath%>/uploadAccessory"
		});
</script>


<!-- Gallery Modal Image -->
<div class="modal fade" id="gallery-image-modal" data-backdrop="static">
	<div class="modal-dialog" style="width:600px;heigth:450px">
		<div>
			<div class="modal-gallery-image">
<!-- 				<img src="../assets/images/tupian.jpg"  id="editimg" class="img-responsive" /> -->
			</div>
<!-- 			<div class="modal-body"> -->
<!-- 				<div class="row"> -->
<!-- 					<div class="col-md-12"> -->
<!-- 						<div class="form-group"> -->
<!-- 							<label for="field-1" class="control-label">名称</label> -->
<!-- 							<input type="text" class="form-control" id="field-1" placeholder="输入图片标题"> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
			<div class="modal-gallery-top-controls" style="margin-left:300px">
				<button type="button" class="btn btn-xs btn-secondary"  onclick="zuoxuanzhuan($('#editimg'))">左旋转（90°）</button>
				<button type="button" class="btn btn-xs btn-secondary" onclick="youxuanzhuan($('#editimg'))">右旋转（90°）</button>
				<button type="button" class="btn btn-xs btn-white" data-dismiss="modal" onclick="closeImage()">关闭</button>
			</div>
		</div>
	</div>
</div>

<!-- 图库删除图像（确认）-->
<div class="modal fade" id="gallery-image-delete-modal" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">

			<div class="modal-header">
				<h4 class="modal-title">确认图像删除</h4>
			</div>

			<div class="modal-body">
				你真的要删除这个图片吗？
			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-danger">删除</button>
				<button type="button" class="btn btn-white" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>
