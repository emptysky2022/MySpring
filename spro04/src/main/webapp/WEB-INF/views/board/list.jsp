<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../includes/header.jsp" %>


            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">게시판</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            게시판 목록
                            
                            <button id="regBtn" type="button" class="btn btn-xs pull-right">게시글 등록</button>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table width="100%" class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th>제목</th>
                                        <th>작성자</th>
                                        <th>등록일자</th>
                                        <th>수정일자</th>
                                    </tr>
                                </thead>
                                
                                <tbody>
                                <c:forEach items="${list }" var="board">
                                  <tr>
                                    <td><c:out value="${board.bno }" /></td>
                                    <td><a class="move" href="${board.bno}">
                                    	<c:out value="${board.title }" />
                                    	  <b>[${board.replyCnt}]</b>
                                    	</a></td>
                                    <td><c:out value="${board.writer }" /></td>
                                    <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regDate }"/></td>
                                    <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate }"/></td>
                                  </tr>
                                </c:forEach>                                
                                </tbody>
                            </table>
                            <!-- /.table-responsive -->
                            <div class="row">
                            	<div class="col-lg-12">
                            		<form id="searchForm" action="/board/list" method="get">
                            			<select name="type">
                            				<option value="" <c:out value="${pageMaker.cri.type==null?'selected':'' }" />>--</option>
                            				<option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':'' }" />>제목</option>
                            				<option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':'' }" />>내용</option>
                            				<option value="W" <c:out value="${pageMaker.cri.type eq 'W'?'selected':'' }" />>작성자</option>
                            				<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':'' }" />>제목 & 내용</option>
                            				<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW'?'selected':'' }" />>제목 & 작성자</option>
                            				<option value="TCW" <c:out value="${pageMaker.cri.type eq 'TCW'?'selected':'' }" />>제목 & 내용 & 작성자</option>
                            			</select>
                            			<input type="text" name="keyword" value="${pageMaker.cri.keyword }">
                            			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
                            			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
                            			<button class="btn btn-default">검색</button>
                            		</form>
                            	</div>
                            </div>
                        </div>
                        <!-- Modal -->
                        <!-- 페이지 네비게이션 -->
            <div class='pull-right'>
            <nav aria-label="Page navigation example">
               <ul class="pagination">
               <c:if test="${pageMaker.prev}">
                  <li class="paginate_button previous">
                     <a class="page-link" href="${pageMaker.startPage - 1 }">Previous</a>
                  </li>
               </c:if>
               <c:forEach var="num" begin="${pageMaker.startPage}"
                        end = "${pageMaker.endPage}">
                  <li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active' : ''}"><a href="${num }">${num }</a></li>
               </c:forEach>
                  
                  
                  <c:if test="${pageMaker.next}">
                  <li class="paginate_button">
                     <a href="${pageMaker.endPage +1 }">Next</a>
                  </li>
                  </c:if>
               </ul>
               <form action="/board/list" id="actionForm" method="get">
                  <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
                  <input type="hidden" name="amount" value="${pageMaker.cri.amount }">
                  <input type="hidden" name="type" value="${pageMaker.cri.type }">
                  <input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
               </form>
               
            </nav>
            </div>
                            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                                        </div>
                                        <div class="modal-body">
                                        	처리가 완료되었습니다.
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                            
                                            <!-- <button type="button" class="btn btn-primary">Save changes</button> -->
                                        </div>
                                    </div>
                                    <!-- /.modal-content -->
                                </div>
                                <!-- /.modal-dialog -->
                            </div>
                            <!-- /.modal -->
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
            <script type="text/javascript">
            	$(document).ready(function(){
            		var result = "<c:out value='${result}' />"
            		checkModal(result);
            		history.replaceState({}, null, null);
            		
            		function checkModal(result){
            			if(result==='' || history.state){
            				return
            			}
            			if(parseInt(result) > 0){
            				$(".modal-body").html("게시글 " + parseInt(result) + "번 글이 등록되었습니다.")
            			}
            			
            			$("#myModal").modal("show")
            		}
	            	$("#regBtn").on("click",function(){
	            		self.location="/board/register"
	            	})
	            	
	            	var actionForm = $("#actionForm")
	            	
	            	$(".paginate_button a").on("click", function(e){
	            		e.preventDefault()
	            		console.log("click")
	            		actionForm.find("input[name='pageNum']").val($(this).attr("href"))
	            		actionForm.submit()
	            	})
	            	
	            	$(".move").on("click", function(e){
	            		e.preventDefault()
	            		actionForm.append("<input type='hidden' name='bno' value='"+ $(this).attr("href") +"'>")
	            		actionForm.attr("action", "/board/get")
	            		actionForm.submit()
	            	})
	            	
	            	var searchForm = $("#searchForm")
	            	$("#searchForm button").on("click", function(e){
	            		if(!searchForm.find('option:selected').val()){
	            			alert("검색할 종류를 선택해주세요.")
	            			return false
	            		}
	            		if(!searchForm.find('input[name="keyword"]').val()){
	            			alert("검색할 내용을 입력해주세요.")
	            			return false
	            		}
	            		searchForm.find("input[name='pageNum']").val("1")
	            		e.preventDefault()
	            		searchForm.submit()
	            	})
	            	
	            	
            	})
            </script>
<%@include file="../includes/footer.jsp"%>