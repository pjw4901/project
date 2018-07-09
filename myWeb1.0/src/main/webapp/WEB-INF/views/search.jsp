<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		background: rgba(0, 123, 255, 0.03);
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
		  });
		  
		// chart colors
		  var colors = ['#007bff','#343a40'];
		  
		  /* 3 donut charts */
		  var donutOptions = {
		    cutoutPercentage: 85, 
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
		  }
		  
		  
		 
		});

</script>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-light" id="mainNav">
  <a class="navbar-brand" href="${pageContext.request.contextPath}/html/index.html"><img src="htmlst/css/lolimg/logo-lol.png" class="lol_logo">LOL.DUO</a><hr style="height: 15px; width: 0; border: 2px solid #fff;">
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/html/index.html">홈</a>
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
		    <li class="tab-link" data-tab="tab-2"><i class="fa fa-user" aria-hidden="true">&nbsp;</i>TEAM</li>
		  </ul>
		 
		  <div id="tab-1" class="tab-content row current">
		  	<h1><i class="fa fa-user" aria-hidden="true">&nbsp;&nbsp;</i>SOLO 전적</h1>
		  	<div class="col-lg-5" style="display: inline-block;">
		  	
		  	
		  		<c:set var="tier" value="${resultSolo.tier}" />

				<c:choose>
				    <c:when test="${tier eq 'BRONZE'}">
				        <img class="tierPng" src="htmlst/css/lolimg/bronze.png">
				    </c:when>
				    <c:when test="${tier eq 'SILVER'}">
				       <img class="tierPng" src="htmlst/css/lolimg/silver.png">
				    </c:when>
				    <c:when test="${tier eq 'GOLD'}">
				       <img class="tierPng" src="htmlst/css/lolimg/gold.png">
				    </c:when>
				    <c:when test="${tier eq 'PLATINUM'}">
				        <img class="tierPng" src="htmlst/css/lolimg/platinum.png">
				    </c:when>
				    <c:when test="${tier eq 'DIAMOND'}">
				       <img class="tierPng" src="htmlst/css/lolimg/diamond.png">
				    </c:when>
				    <c:when test="${tier eq 'MASTER'}">
				        <img class="tierPng" src="htmlst/css/lolimg/master.png">
				    </c:when>
				    <c:when test="${tier eq 'CHALLENGER'}">
				       <img class="tierPng" src="htmlst/css/lolimg/challenger.png">
				    </c:when>
				    <c:otherwise>
				        <img class="tierPng" src="htmlst/css/lolimg/provisional.png">
				        <a>시즌 초에는 배치고사 게임 후에 전적측정이 가능합니다.</a>
				    </c:otherwise>
				</c:choose>
				
			</div>
			<div class="col-lg-5" style="display: inline-block;">
				<div class="card">
	                <div class="card-body">
	                    <canvas id="chDonut1"></canvas>
	                </div>
	            </div>
			</div>
		  	
<%-- 				<input type="text" id="queueType" name="queueType" value="${resultSolo.queueType}"/>
				<input type="text" id="hotStreak" name="hotStreak" value="${resultSolo.hotStreak}"/>
				<input type="text" id="wins" name="wins" value="${resultSolo.wins}"/>
				<input type="text" id="veteran" name="veteran" value="${resultSolo.veteran}"/>
				<input type="text" id="losses" name="losses" value="${resultSolo.losses}"/>
				<input type="text" id="playerOrTeamId" name="playerOrTeamId" value="${resultSolo.playerOrTeamId}"/>
				<input type="text" id="leagueName" name="leagueName" value="${resultSolo.leagueName}"/>
				<input type="text" id="playerOrTeamName" name="playerOrTeamName" value="${resultSolo.playerOrTeamName}"/>
				<input type="text" id="inactive" name="inactive" value="${resultSolo.inactive}"/>
				<input type="text" id="rank" name="rank" value="${resultSolo.rank}"/>
				<input type="text" id="freshBlood" name="freshBlood" value="${resultSolo.freshBlood}"/>
				<input type="text" id="leagueId" name="leagueId" value="${resultSolo.leagueId}"/>	
				<input type="text" id="tier" name="tier" value="${resultSolo.tier}"/>
				<input type="text" id="leaguePoints" name="leaguePoints" value="${resultSolo.leaguePoints}"/>	 --%>	
		  </div>
		  
		  <div id="tab-2" class="tab-content col-lg-5">
				<c:set var="tier" value="${resultTeam.tier}" />

				<c:choose>
				    <c:when test="${tier eq 'BRONZE'}">
				        <img class="tierPng" src="htmlst/css/lolimg/bronze.png">
				    </c:when>
				    <c:when test="${tier eq 'SILVER'}">
				       <img class="tierPng" src="htmlst/css/lolimg/silver.png">
				    </c:when>
				    <c:when test="${tier eq 'GOLD'}">
				       <img class="tierPng" src="htmlst/css/lolimg/gold.png">
				    </c:when>
				    <c:when test="${tier eq 'PLATINUM'}">
				        <img class="tierPng" src="htmlst/css/lolimg/platinum.png">
				    </c:when>
				    <c:when test="${tier eq 'DIAMOND'}">
				       <img class="tierPng" src="htmlst/css/lolimg/diamond.png">
				    </c:when>
				    <c:when test="${tier eq 'MASTER'}">
				        <img class="tierPng" src="htmlst/css/lolimg/master.png">
				    </c:when>
				    <c:when test="${tier eq 'CHALLENGER'}">
				       <img class="tierPng" src="htmlst/css/lolimg/challenger.png">
				    </c:when>
				    <c:otherwise>
				        <img class="tierPng" src="htmlst/css/lolimg/provisional.png">
				    </c:otherwise>
				</c:choose>

<%-- 				<input type="text" id="queueType" name="queueType" value="${resultTeam.queueType}"/>
				<input type="text" id="hotStreak" name="hotStreak" value="${resultTeam.hotStreak}"/>
				<input type="text" id="wins" name="wins" value="${resultTeam.wins}"/>
				<input type="text" id="veteran" name="veteran" value="${resultTeam.veteran}"/>
				<input type="text" id="losses" name="losses" value="${resultTeam.losses}"/>
				<input type="text" id="playerOrTeamId" name="playerOrTeamId" value="${resultTeam.playerOrTeamId}"/>
				<input type="text" id="leagueName" name="leagueName" value="${resultTeam.leagueName}"/>
				<input type="text" id="playerOrTeamName" name="playerOrTeamName" value="${resultTeam.playerOrTeamName}"/>
				<input type="text" id="inactive" name="inactive" value="${resultTeam.inactive}"/>
				<input type="text" id="rank" name="rank" value="${resultTeam.rank}"/>
				<input type="text" id="freshBlood" name="freshBlood" value="${resultTeam.freshBlood}"/>
				<input type="text" id="leagueId" name="leagueId" value="${resultTeam.leagueId}"/>	
				<input type="text" id="tier" name="tier" value="${resultTeam.tier}"/>
				<input type="text" id="leaguePoints" name="leaguePoints" value="${resultTeam.leaguePoints}"/> --%>			
		  </div>
		</div> <!-- tab container END -->

		
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