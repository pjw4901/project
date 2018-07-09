
// 중복 점검 아이디 전송 : 클라이언트 -> 서버 전송
function sendId() {
	
	 $.ajax({
			 // url : 'http://localhost:8181/memberValidAngular/idAsyncCheck.do',
		 	 url : 'idAsyncCheck.do',
			 type : 'post',
			 dataType:'text',
			 data : {
				 id : $('#userid').val()
			 }, // data 
			 success : function(data) {
				
				console.log("아이디 중복 점검 수신 !"); 
		        var listView = document.getElementById('id_msg2');
		       
		        // 보완 : 아이디 폼점검 메시지와 중복/충돌 방지
		        var id_msg1 = document.all["id_msg1"];
		        
		        listView.innerText = ''; // 초기화
		        
		        if (id_msg1.innerText == '아이디는 8~20자로 작성해야합니다.') {
		        	listView.innerText = '';
		        }
		        
		        // CSS 적용
		        listView.style.fontSize = "12px"; // font-size
		        listView.style.paddingLeft = "10px"; // padding-left
		        listView.style.paddingTop = "6px"; // padding-top
		        
				if(data == 0) { // 서버 리턴 전송값 = 0
				 
				  listView.innerHTML = "사용할 수 있는 ID 입니다";
				  listView.style.color = "blue";
				  
				} else { // 서버 리턴 전송값 = 1
				 
				  listView.innerHTML = "이미 등록된 ID 입니다";
				  listView.style.color = "red";
				  
				  document.getElementById('userid').value = "";
				}
				 
			}, // success
		 	
		 	error : function(xhr, status) {
		        console.log(xhr+" : "+status); // 에러 코드
	        } 
 
	 }); // $.ajax
}