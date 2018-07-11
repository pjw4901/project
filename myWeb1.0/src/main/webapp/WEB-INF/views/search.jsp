<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html">
<html lang="ko-kr">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Bootstrap core CSS -->
    <link href="<c:url value='htmlst/vendor/bootstrap/css/bootstrap.min.css' /> " rel="stylesheet">
    
    <!-- Custom fonts for this template -->
    <link href="<c:url value='htmlst/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet' /> " type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>

    <!-- Custom styles for this template -->
	<link href="<c:url value='htmlst/css/clean-blog.min.css' /> " rel="stylesheet">
	
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>		
<title>${result.name} - 게임전적</title>

<style>
	body{
		font-family: Helvetica,"Malgun Gothic","Apple SD Gothic Neo",AppleGothic,Dotum,Arial,Tahoma;
	}
	#mainNav{
		width:100%;
		background: linear-gradient(52deg, #5383e8, #3991ef 31%, #3892f0 32%, #3594f1 36%, #3594f1);
	}
	.lol_logo{
		padding-right: 10px;
	}

	.btn{
		font-size: 20px;
		padding : 6px 12px;
		background: #1c87c3;
		border-color: #1c87c3;
	}
	.Level {
	    position: absolute;
	    /* top: 100%; */
		left: 85;
	    margin-top: -14px;
	    margin-left: -22px; 
	    width: 44px;
	    height: 24px;
	    padding-top: 3px;
	    box-sizing: border-box;
	    background: url(htmlst/css/lolimg/bg-levelbox.png);
	    background-size: 100%;
	    line-height: 17px;
	    font-family: Helvetica,AppleSDGothic,"Apple SD Gothic Neo",AppleGothic,Arial,Tahoma;
	    font-size: 14px;
	    text-align: center;
	    color: #eabd56;
	}
	.profileDiv{
		width: 150px;
		display: inline-block;
	}
	.summonerDiv {
	    position: relative;
	    display: inline-block;
	    height: 100px;
	    margin: 0 25px 0 25px;
	    vertical-align: top;
	    line-height: 1.1;
	}
	.name{
		font-size : 25px;
		font-weight: bold;
	    margin-right: 4px;
	    vertical-align: middle;
	    font-family: Helvetica,"Malgun Gothic","Apple SD Gothic Neo",AppleGothic,Dotum,Arial,Tahoma;
	}
	.buttons {
	    position: absolute;
	    left: 0;
	    right: 0;
	    bottom: 0;
	    font-size: 0;
	    margin: 15px 0 -30px;
	    white-space: nowrap;
	}
	.renew {
	    padding: 11px 14px 10px;
	    border-radius: 2px;
	    border: none;
	    background: none;
	    font-size: 14px;
	    border: 1px solid #1a78ae;
	    background: #1f8ecd;
	    color: #f2f2f2;
	    font-family: Helvetica,"Malgun Gothic","Apple SD Gothic Neo",AppleGothic,Dotum,Arial,Tahoma;
	}
	.navbar-brand{
		margin: 0;
	}
	
	ul.tabs{
	  margin: 0px;
	  padding: 0px;
	  list-style: none;
	}
	ul.tabs li{
	  background: none;
	  color: #222;
	  display: inline-block;
	  padding: 10px 15px;
	  cursor: pointer;
	}
	 
	ul.tabs li.current{
	  background: rgba(0, 123, 255, 0.03);
	  color: #222;
	}
	 
	.tab-content{
	  display: none;
	  background: rgba(0, 123, 255, 0.03);
	  padding: 15px;
	}
	 
	.tab-content.current{
	  display: inherit;
	}
	.tabContainer{
		background:none;
	}
	.card{
		background:none;
		border: 0px;
	}
	.tierPng{
		width: 250px;
	}
	.card-body{
		padding: 0px;
	}
	.pieChart{
		margin: auto;
		text-align: center;
	    width: 350px;
	    height: 280px;
	    margin-bottom: 5px;
	}
	.rankinfo{
		padding-top: 40px;
	}

</style>
<script>
	
	$(document).ready(function(){
		$('ul.tabs li').click(function(){
		    var tab_id = $(this).attr('data-tab');
		 
		    $('ul.tabs li').removeClass('current');
		    $('.tab-content').removeClass('current');
		 
		    $(this).addClass('current');
		    $("#"+tab_id).addClass('current');
		  }); //tab function
		  
		  if(${resultTeam.queueType == 'RANKED_FLEX_SR'&&modelSize == 1}){
			  $('#cardDiv').hide();
			  $('#progressDiv').hide();
			  $('#progressHeadDiv').hide();
			  $('#tierDiv').removeClass('col-lg-5');
			  $('#tierDiv').addClass('col-lg-12');
			  				  
		  }else if(${unranked == 0}){
			  alert("소환사 레벨이 30이 안되서 전적이 없습니다. 강해져서 와라 애송이")
		  }
		  
		  var reswins = ${resultTeam.queueType == 'RANKED_FLEX_SR' &&modelSize == 1? 0:resultSolo.wins};
		  var restotal = ${resultSolo.wins + resultSolo.losses};
		  var percentage = reswins/restotal+100;
		  
		  // chart colors
		  var colors = ['#007bff','#343a40'];
		  
		  /* 3 donut charts */
		  var donutOptions = {
		    cutoutPercentage: 70,
		    animateRotate: true,
		    legend: {position:'bottom', padding:5, labels: {pointStyle:'circle', usePointStyle:true}}
		  };
	
		  // donut 1
		  var chDonutData1 = {
		      labels: ['Wins', 'Losses'],
		      datasets: [
		        {
		          backgroundColor: colors.slice(0,2),
		          borderWidth: 0,
		          data: [${resultSolo.wins}, ${resultSolo.losses}]
		        }
			   ]  
		  };
	
		  var chDonut1 = document.getElementById("chDonut1");
		  if (chDonut1) {
		    new Chart(chDonut1, {
		        type: 'pie',
		        data: chDonutData1,
		        options: donutOptions
		    });
		  } //pie chart end
		  
		  //tab2 fun start
		  $('#tab-2-btn').click(function(){
			 
			  if(${resultSolo.queueType == 'RANKED_SOLO_5x5'&&modelSize == 1}){
				  $('#cardDiv2').hide();
				  $('#progressDiv2').hide();
				  $('#progressHeadDiv2').hide();
				  $('#tierDiv2').removeClass('col-lg-5');
				  $('#tierDiv2').addClass('col-lg-12');
				  				  
			  }
			  var reswins2 = ${resultSolo.queueType == 'RANKED_SOLO_5x5'&&modelSize == 1?0:resultTeam.wins};
			  var restotal2 = ${resultTeam.wins + resultSolo.losses};
			  var percentage2 = reswins2/restotal2+100;
			  
			  // chart colors
			  var colors = ['#007bff','#343a40'];
			  
			  /* 3 donut charts */
			  var donutOptions = {
			    cutoutPercentage: 70,
			    animateRotate: true,
			    legend: {position:'bottom', padding:5, labels: {pointStyle:'circle', usePointStyle:true}}
			  };
		
			  // donut 1
			  var chDonutData2 = {
			      labels: ['Wins', 'Losses'],
			      datasets: [
			        {
			          backgroundColor: colors.slice(0,2),
			          borderWidth: 0,
			          data: [${resultTeam.wins}, ${resultTeam.losses}]
			        }
				   ]
			  };
		
			  var chDonut2 = document.getElementById("chDonut2");
			  if (chDonut2) {
			    new Chart(chDonut2, {
			        type: 'pie',
			        data: chDonutData2,
			        options: donutOptions
			    });
			  } //pie chart end
		  });//tab2 fun end
		});

</script>
</head>
<body>


<nav class="navbar navbar-expand-lg navbar-light bg-light" id="mainNav">
  <a class="navbar-brand" href="${pageContext.request.contextPath}/index"><img src="htmlst/css/lolimg/logo-lol.png" class="lol_logo">LOL.DUO</a><hr style="height: 15px; width: 0; border: 2px solid #fff;">
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

<!-- nav bar start -->
  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/index">홈</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">게임리스트</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/board/list.do/1">게시판</a>
      </li>
    </ul>
    <form class="form-inline my-2 my-lg-0" id="searchForm" name="searchForm" action="<c:url value='/search' />" method="POST">
      <input class="form-control mr-sm-2" id="sumName" name="sumName" type="search" placeholder="Search" aria-label="Search">
      <button class="btn btn-secondary" type="submit">.DUO</button>
    </form>
  </div>
</nav>
<!-- navbar end -->

   <!-- Main Content -->
   <div class="container" style="padding-top: 100px;">
	<div class="row">
     <div class="col-lg-10 col-md-12 mx-auto">   
       	
       	<div class="profileDiv">
       		<div>
				<img src="http://ddragon.leagueoflegends.com/cdn/8.13.1/img/profileicon/${result.profileIconId}.png" style="width: 150px;">
				<span class="Level tip" title="레벨">${result.summonerLevel}</span>
			</div>
		</div>
		<div class="summonerDiv">
			<span class="name">${result.name}</span>
			<div class="buttons">
				<button class="renew">갱신하기</button>
			</div>
		</div>
		
		<hr>

		<div class="container tabContainer">
		 
		  <ul class="tabs">
		    <li class="tab-link current" data-tab="tab-1"><i class="fa fa-user" aria-hidden="true">&nbsp;</i>SOLO</li>
		    <li class="tab-link" data-tab="tab-2" id="tab-2-btn"><i class="fa fa-user" aria-hidden="true">&nbsp;</i>TEAM</li>
		  </ul>
		 

		 <!-- SOLO rank tab start -->
		 <div id="tab-1" class="tab-content row current">
		  	<h1><i class="fa fa-user" aria-hidden="true">&nbsp;&nbsp;</i>SOLO 전적</h1>
		  	
		  	<div class="row">
			  	<div id="tierDiv" class="col-lg-5" style="display: inline-block; text-align: center">
			  	
			  		<c:set var="tier1" value="${resultSolo.tier}" />
	
					<c:choose>
					    <c:when test="${tier1 eq 'BRONZE'}">
					    <div class="card" style="width:400px">
					        <img class="tierPng" src="htmlst/css/lolimg/bronze.png">
					        <h4 class="rankinfo">${resultSolo.tier}&nbsp;${resultSolo.rank}&nbsp;${resultSolo.leaguePoints}점</h4>
					    </div>
					    </c:when>
					    <c:when test="${tier1 eq 'SILVER'}">
					       <img class="tierPng" src="htmlst/css/lolimg/silver.png">
					       <h4 class="rankinfo">${resultSolo.tier}&nbsp;${resultSolo.rank}&nbsp;${resultSolo.leaguePoints}점</h4>
					    </c:when>
					    <c:when test="${tier1 eq 'GOLD'}">
					    	<img class="tierPng" src="htmlst/css/lolimg/gold.png">
    						<h4 class="rankinfo">${resultSolo.tier}&nbsp;${resultSolo.rank}&nbsp;${resultSolo.leaguePoints}점</h4>
					    </c:when>
					    <c:when test="${tier1 eq 'PLATINUM'}">
					        <img class="tierPng" src="htmlst/css/lolimg/platinum.png">
					        <h4 class="rankinfo">${resultSolo.tier}&nbsp;${resultSolo.rank}&nbsp;${resultSolo.leaguePoints}점</h4>
					    </c:when>
					    <c:when test="${tier1 eq 'DIAMOND'}">
					       <img class="tierPng" src="htmlst/css/lolimg/diamond.png">
					       <h4 class="rankinfo">${resultSolo.tier}&nbsp;${resultSolo.rank}&nbsp;${resultSolo.leaguePoints}점</h4>
					    </c:when>
					    <c:when test="${tier1 eq 'MASTER'}">
					        <img class="tierPng" src="htmlst/css/lolimg/master.png">
					        <h4 class="rankinfo">${resultSolo.tier}&nbsp;${resultSolo.rank}&nbsp;${resultSolo.leaguePoints}점</h4>
					    </c:when>
					    <c:when test="${tier1 eq 'CHALLENGER'}">
					       <img class="tierPng" src="htmlst/css/lolimg/challenger.png">
					       <h4 class="rankinfo">${resultSolo.tier}&nbsp;${resultSolo.rank}&nbsp;${resultSolo.leaguePoints}점</h4>
					    </c:when>
					    <c:otherwise>
					        <img class="tierPng" src="htmlst/css/lolimg/provisional.png">
					        <a>시즌 초에는 배치고사 게임 후에 전적측정이 가능합니다.</a>
					    </c:otherwise>
					</c:choose>
					
				</div>
				
<%-- 			<c:choose>
		 	  <c:when test="${resultTeam.queueType eq 'RANKED_FLEX_SR' || modelSize == 1 }">
		 	   <div class="hidden" style="visibility: hidden;"> --%>
				<div id="cardDiv" class="col-lg-7" style="display: inline-block;">
					<div class="card">
		                <div class="card-body">
			                <p class="pieChart" align="center">
			                    <canvas id="chDonut1" width="340px" height="280px"></canvas>
			                    <%--   "width: 340px; height: 280px;  padding-left: 60px;" --%>
			                </p>
		                </div>
		                <div class="card-footer" id="card-footer">
		                	<script>
			                  var reswins =  ${resultTeam.queueType == 'RANKED_FLEX_SR' &&modelSize == 1? 0:resultSolo.wins};
			          		  var restotal = ${resultSolo.wins + resultSolo.losses};
			        		  var percentage = reswins/restotal*100;
			        		  document.getElementById("card-footer").innerHTML =
			        			  '<div class="progress-bar progress-bar-striped progress-bar-animated bg-danger" style="width:'+ Math.floor(percentage) + '%">' + Math.floor(percentage) + '%</div>';
			        		</script>
		                </div>
		            </div>
				</div><!-- card END -->
<%-- 			   </div>
			  </c:when>
		 	</c:choose> --%>
			
			</div><!-- tab1 rowdiv End -->
			
			<div id="progressHeadDiv" class="row" style=" margin-left: 0px; margin-right: 0px; margin-top: 60px;">
				<h4>커뮤니티 전적</h4>
			</div>
			<div id="progressDiv" class="progress-bar progress-bar-striped progress-bar-animated " style="width:70%; margin-top: 10px;">70%</div>
		  	
		  </div><!-- tab1 end -->
		  
		  
		  <div id="tab-2" class="tab-content row">
		  	<h1><i class="fa fa-user" aria-hidden="true">&nbsp;&nbsp;</i>TEAM 전적</h1>
		  	
		  	<div class="row">
			  	<div id="tierDiv2" class="col-lg-5" style="display: inline-block; text-align: center">
			  	
				<c:set var="tier2" value="${resultTeam.tier}" />

				<c:choose>
				    <c:when test="${tier2 eq 'BRONZE'}">
				        <img class="tierPng" src="htmlst/css/lolimg/bronze.png">
				        <h4 class="rankinfo">${resultTeam.tier}&nbsp;${resultTeam.rank}&nbsp;${resultTeam.leaguePoints}점</h4>
				    </c:when>
				    <c:when test="${tier2 eq 'SILVER'}">
				       <img class="tierPng" src="htmlst/css/lolimg/silver.png">
				       <h4 class="rankinfo">${resultTeam.tier}&nbsp;${resultTeam.rank}&nbsp;${resultTeam.leaguePoints}점</h4>
				    </c:when>
				    <c:when test="${tier2 eq 'GOLD'}">
				       <img class="tierPng" src="htmlst/css/lolimg/gold.png">
				       <h4 class="rankinfo">${resultTeam.tier}&nbsp;${resultTeam.rank}&nbsp;${resultTeam.leaguePoints}점</h4>
				    </c:when>
				    <c:when test="${tier2 eq 'PLATINUM'}">
				        <img class="tierPng" src="htmlst/css/lolimg/platinum.png">
				        <h4 class="rankinfo">${resultTeam.tier}&nbsp;${resultTeam.rank}&nbsp;${resultTeam.leaguePoints}점</h4>
				    </c:when>
				    <c:when test="${tier2 eq 'DIAMOND'}">
				       <img class="tierPng" src="htmlst/css/lolimg/diamond.png">
				       <h4 class="rankinfo">${resultTeam.tier}&nbsp;${resultTeam.rank}&nbsp;${resultTeam.leaguePoints}점</h4>
				    </c:when>
				    <c:when test="${tier2 eq 'MASTER'}">
				        <img class="tierPng" src="htmlst/css/lolimg/master.png">
				        <h4 class="rankinfo">${resultTeam.tier}&nbsp;${resultTeam.rank}&nbsp;${resultTeam.leaguePoints}점</h4>
				    </c:when>
				    <c:when test="${tier2 eq 'CHALLENGER'}">
				       <img class="tierPng" src="htmlst/css/lolimg/challenger.png">
				       <h4 class="rankinfo">${resultTeam.tier}&nbsp;${resultTeam.rank}&nbsp;${resultTeam.leaguePoints}점</h4>
				    </c:when>
				    <c:otherwise>
				        <img class="tierPng" src="htmlst/css/lolimg/provisional.png">
				        <a>시즌 초에는 배치고사 게임 후에 전적측정이 가능합니다.</a>
				    </c:otherwise>
				</c:choose>
					
				</div>
				
				<div id="cardDiv2" class="col-lg-7" style="display: inline-block;">
					<div class="card">
		                <div class="card-body">
			                <p class="pieChart" align="center">
			                    <canvas id="chDonut2" width="340px" height="280px"></canvas>
			                </p>
		                </div>
		                <div class="card-footer" id="card-footer2">
		                	<script>
			                  var reswins2 = ${resultSolo.queueType == 'RANKED_SOLO_5x5'&&modelSize == 1?0:resultTeam.wins};
			          		  var restotal2 = ${resultTeam.wins + resultTeam.losses};
			        		  var percentage2 = reswins2/restotal2*100;
			        		  document.getElementById("card-footer2").innerHTML =
			        			  '<div class="progress-bar progress-bar-striped progress-bar-animated bg-danger" style="width:'+ Math.floor(percentage2) + '%">' + Math.floor(percentage2) + '%</div>';
			        		</script>
		                </div>
		            </div>
				</div><!-- card END -->
			
			</div><!-- tab2 rowdiv End -->
			
			<div id="progressHeadDiv2" class="row" style=" margin-left: 0px; margin-right: 0px; margin-top: 60px;">
				<h4>커뮤니티 전적</h4>
			</div>
			<div id="progressDiv2" class="progress-bar progress-bar-striped progress-bar-animated " style="width:70%; margin-top: 10px;">70%</div>	  
			</div> <!-- tab2 End -->

		</div><!-- tab container END -->
		
		</div>
	  </div>
	</div>
	
	<hr>    
    <!-- Footer -->
    <footer>
      <div class="container">
        <div class="row">
          <div class="col-lg-8 col-md-10 mx-auto">
            <ul class="list-inline text-center">
              <li class="list-inline-item">
                <a href="#">
                  <span class="fa-stack fa-lg">
                    <i class="fa fa-circle fa-stack-2x"></i>
                    <i class="fa fa-twitter fa-stack-1x fa-inverse"></i>
                  </span>
                </a>
              </li>
              <li class="list-inline-item">
                <a href="#">
                  <span class="fa-stack fa-lg">
                    <i class="fa fa-circle fa-stack-2x"></i>
                    <i class="fa fa-facebook fa-stack-1x fa-inverse"></i>
                  </span>
                </a>
              </li>
              <li class="list-inline-item">
                <a href="#">
                  <span class="fa-stack fa-lg">
                    <i class="fa fa-circle fa-stack-2x"></i>
                    <i class="fa fa-github fa-stack-1x fa-inverse"></i>
                  </span>
                </a>
              </li>
            </ul>
            <p class="copyright text-muted">Copyright &copy; LOL.DUO Website 2018</p>
          </div>
        </div>
      </div>
    </footer>
</body>
</html>