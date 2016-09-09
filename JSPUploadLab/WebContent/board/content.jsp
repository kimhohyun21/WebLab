<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="com.sist.dao.*, java.net.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>�� �󼼺���</title>
	<style type="text/css">
		#title_img{
			height: 100px;
			width: 500px;
		}
		table{
			border: 0px;
			width: 800px;
			border-collapse: collapse;
		}
		#content_table{
			margin-top: 30px;
			margin-bottom: 10px;
			border-top: 2px solid black;
			border-bottom: 2px solid black;
			background-color: ivory;	
		}
		td{
			background-color: ivory;
			border-bottom: 1px solid gray;
			text-align: center;
			padding-left: 10px;
			padding-right: 10px;
		}
		.title_td{
			border-right: 1px solid gray;
			background-color: pink;
			font-weight: bolder;
		}
		.field_td{
			text-align: left;
		}
		#cont_td{
			height: 300px;
			padding: 20px;
			vertical-align: top;
			text-align: left;		
		}
		.btn_td{
			text-align: right;
			background-color: white;
			border: 0px;
		}
		a{
			text-decoration:none;
			color: black;
		}
		a:hover{
			text-decoration: underline;
			color: green;
			opacity: 0.3; 
			filter: alpha(opacity=30);
		}		
		#del{
			display:none;
		}		
	</style>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
	<script type="text/javascript">
		var i=0;
		$(function(){
			$('#delBtn').click(function(){
				if(i==0){
					$('#del').show();
					i=1;
				}else{
					$('#del').hide();
					i=0;
				}
			})
			$('#delButton').click(function(){
				var pwd=$('#pwd').val();
				if(pwd==""){
					$('#print').html('<font color=red>��й�ȣ�� �Է��ϼ���.</font>')
					$('#pwd').focus();
					return;
				}
				$('#delFrm').submit();
			})				
		});
	</script>
</head>
<%
	request.setCharacterEncoding("EUC-KR");
	String no=request.getParameter("no");
	String curPage=request.getParameter("page");
	DataBoardDAO dao=new DataBoardDAO();
	DataBoardVO vo=dao.contentDetail(no, 1);
	int num=dao.countRow(no);
%>
<body>
	<div align="center">
		<img src="img/content.jpg" id="title_img">
		<table id="content_table">
			<tr>
				<td width="20%" class="title_td">
					��ȣ
				</td >
				<td width="30%">
					<%=num %>
				</td>
				<td width="20%" class="title_td">
					�ۼ���
				</td >
				<td width="30%">
					<%=vo.getRegDate() %>
				</td>
			</tr>
			<tr>
				<td width="20%" class="title_td">
					�̸�
				</td >
				<td width="30%">
					<%=vo.getName() %>
				</td>
				<td width="20%" class="title_td">
					��ȸ��
				</td >
				<td width="30%">
					<%=vo.getHit() %>
				</td>
			</tr>
			<tr>
				<td width="20%" class="title_td">
					����
				</td>
				<td colspan="3" class="field_td">
					<%=vo.getSubject() %>
				</td>
			</tr>
			<tr>
				<td width="20%" class="title_td">
					÷������
				</td>
				<td colspan="3" class="field_td">
				<%
					String filename="���Ͼ���";
					int filesize=0;
					if(vo.getFilename()!=null){	
						filename=vo.getFilename();
						filesize=vo.getFilesize();
				%>		
						<a href="download.jsp?fn=<%=URLEncoder.encode(filename, "UTF-8") %>"><%=filename %>(<%=filesize %>bytes)</a>
				<%
					}else{
				%>
						<%=filename %>(<%=filesize %>bytes)
				<% 
					}
				%>
				</td>
			</tr>
			<tr>
				<td colspan="4" id="cont_td">
					<%=vo.getContent() %>
				</td>
			</tr>
		</table>
		<table>
			<tr>
				<td class="btn_td">
					<a href="update.jsp?page=<%=curPage %>&no=<%=no %>"><img src="img/modify.gif"></a>
					<a><img src="img/delete.gif" id="delBtn"></a>
					<a href="list.jsp"><img src="img/list.gif"></a>
				</td>
			</tr>
			<tr id="del">
				<td class="btn_td">
				<span id="print"></span>
					<form action="delete.jsp?page=<%=curPage %>&no=<%=no %>"  method="post" id="delFrm">
						��й�ȣ : <input type="password" name="pwd" id="pwd" size="12">
								<input type="button" value="����" id="delButton">
					</form>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>