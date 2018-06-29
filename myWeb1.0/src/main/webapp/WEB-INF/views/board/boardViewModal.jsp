<%@ page contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8"%>
    
    <!-- 게시글정보 보기(팝업) -->
	<div class="modal fade" id="myModal" role="dialog">
	  <div class="modal-dialog modal-sm">
	  
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">게시글 보기</h4>
	      </div>
	      
	      <div id="article_content" class="modal-body form-group">

              <label for="boardNum" class="col-sm-5 control-label label_top_padding">글번호 :</label>
              <div class="col-sm-7"> 
              	   <input type="text" id="boardNum" 
              	   		  class="form-control input-sm fld_back" readonly /><br>
              </div>
              
              <label for="boardName" class="col-sm-5 control-label label_top_padding">글쓴이 :</label>
              <div class="col-sm-7"> 
              	   <input type="text" id="boardName" 
              	   		  class="form-control input-sm fld_back" readonly /><br>
              </div>
              		
              <label for="boardSubject" class="col-sm-5 control-label label_top_padding">글제목 :</label>
              <div class="col-sm-7"> 
              		<input type="text" id="boardSubject" 
              			   class="form-control input-sm fld_back" readonly /><br>
              </div>
              		
              <label for="boardContent" class="col-sm-5 control-label label_top_padding">글내용 :</label><br>
           		<textarea id="boardContent" 
        				  class="form-control input-sm fld_back textarea_fld" 
        				  cols="40" rows="4" readonly></textarea>
        				  
        	  <label for="boardFile" class="col-sm-5 control-label">첨부파일 :</label>
           	  <div class="col-sm-7" id="boardFile"></div>
			   
	      </div>
	      
	      <div class="modal-footer">
	        <!-- 게시글 수정 버튼 -->
	        <button type="button" 
	                id="updateContentBtn_"
	        		class="btn btn-default"
   				    data-dismiss="modal"
   				    data-toggle="modal" 
					data-target="#updateModal">수정</button>
					
	        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	    
	  </div>
	</div> 