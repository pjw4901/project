<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<!-- 게시글정보 수정(팝업) -->
	<div class="modal fade" id="updateModal">
         
	  <div class="modal-dialog modal-sm">
	  
	  <!-- form -->
	  <form id="updateForm" 
	  		name="updateForm" 
	  		enctype="multipart/form-data" 
	  		method="post">
	  
	    <div class="modal-content">
	    
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">게시글 수정</h4>
	      </div>
	      
	      <div id="article_content" class="modal-body form-group" style="height:400px">

              <label for="update_boardNum" 
              		 class="col-sm-5 control-label label_top_padding">글번호 :</label>
              <div class="col-sm-7"> 
              	   <input type="text" 
              	   		  id="update_boardNum" 
              	   		  name="update_boardNum"
              	   		  class="form-control input-sm fld_back" readonly /><br>
              </div>
              
              <label for="update_boardName" 
              		 class="col-sm-5 control-label label_top_padding">글쓴이 :</label>
              <div class="col-sm-7"> 
              	   <input type="text" 
              	   		  id="update_boardName" 
              	   		  name="update_boardName"
              	   		  class="form-control input-sm fld_back" readonly /><br>
              </div>
              		
              <label for="update_boardSubject" 
              		 class="col-sm-5 control-label label_top_padding">글제목 :</label>
              <div class="col-sm-7"> 
            		<input type="text" 
            			   id="update_boardSubject"
            			   name="update_boardSubject" 
            			   class="form-control input-sm fld_back" />
             </div>
              		
              <label for="update_boardContent"
              		 class="col-sm-5 control-label label_top_padding">글내용 :</label><br>
           		<textarea id="update_boardContent" 
           				  name="update_boardContent" 
        				  class="form-control input-sm fld_back textarea_fld" 
        				  cols="40" rows="4"></textarea>
                     		  
        	 <label for="update_boardFile" class="col-sm-5 control-label">첨부파일 :</label>
          	    <div class="col-sm-7" id="update_boardFile"></div>
           	  
			  <div class="col-sm-12">
				
				<!-- file field -->
				<div class="fileinput fileinput-new" data-provides="fileinput">
				    <span class="btn btn-default btn-file"><span>파일 선택</span>
				   	 <input type="file" 
				   	        id="update_boardFile_new" 
				   	 		name="update_boardFile_new" />
				    </span>
				    <span class="fileinput-filename"></span>
				    <span class="fileinput-new">선택파일 없음</span>
				    <!-- 선택 ==> 선택 파일없을 경우 보완 -->
				    <span><a class="btn btn-default" 
			  			   	 id="uploadfile_init">초기화</a>
 					</span>
				    
				    <script>
				    $(document).ready(function() {
				    	// 업로드 파일 초기화
				    	$("a#uploadfile_init").click(function(){
				    		
				    		$(".fileinput-filename").text("");
				    		$("input#update_boardFile_new").val("");
				    	});
				    });	
				    </script>
				</div>            	  		   
			    
        	  </div>           	  
			   
	      </div>
	      
	      <div class="modal-footer">
	        <!-- 게시글 수정 버튼 -->
	        <button type="submit"
	                id="update_btn_" 
	        		class="btn btn-default" 
	        		>글수정</button><!-- data-dismiss="modal" -->
	        		
	        <button type="button" 
	        		class="btn btn-default" 
	        		data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	    
	    <!-- Spring Security Auth(CSRF) Token : 반드시 기입! 없으면 에러 출력됨 !-->
			<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
	    
	    </form>
	    
	  </div>
	</div>          
