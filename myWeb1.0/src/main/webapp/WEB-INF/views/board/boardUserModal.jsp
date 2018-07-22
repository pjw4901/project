<%@ page contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8"%>
    	 
    	   
    <!-- 유저정보 보기(팝업) -->
	<div class="modal fade" id="userModal" role="dialog">
	  <div class="modal-dialog modal-sm">
	  
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">유저정보</h4>
	      </div>
	      
	      <div class="modal-body" style="display: inline-block;">
	      
	            <div class="card bg-light" id="usercard" style=" margin: auto;">
             	  <img class="card-img-top" src="http://ddragon.leagueoflegends.com/cdn/img/champion/splash/Aatrox_0.jpg" alt="Card image" style="width: 100%;">
				  <div class="card-body">
				  <h4 class="card-title" id="username"></h4>
				  
				  	<div class=row>
					    <lable lang="ko"><b>게임아이디 :</b></lable><p class="card-text" id="userid" style="display: inline-block;"></p><br/>
				    </div>
				    <label lang="ko">커뮤니티승률</label>
				    <div class="progress" id="progress">
					</div><br />
					<label lang="ko">자기소개글</label>
					<p class="card-text" id="usercontent"></p>
				    
				 </div>
				</div>
	      
	   		</div>


	    </div>
	    
	  </div>
	</div> 