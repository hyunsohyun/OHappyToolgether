<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<title>OHappyToolgether</title>
	<link
		href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="css/styles.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"	crossorigin="anonymous"></script>
	
	<style>
        .note-editor .note-editing-area {
            height: 500px;
        }

    </style>
    
</head>
<body class="sb-nav-fixed">
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div id="layoutSidenav">
	
	<%@ include file="/WEB-INF/views/common/sidenav.jsp"%>
	<div id="layoutSidenav_content">
	

	
<main>
    <h1 class="mt-4" id='qwerqwer'>게시판 글쓰기</h1>
    <ol class="breadcrumb mb-4">
        <li class="breadcrumb-item"><a href="/kanvan.do">칸반보드</a></li>
        <li class="breadcrumb-item"><a href="/board.do">게시판</a></li>
        <li class="breadcrumb-item"><a href="/project.do">프로젝트</a></li>
        <li class="breadcrumb-item"><a href="/loginForm.do">로그아웃</a></li>
    </ol>
    <form method="post" id="testform" name="testform" action="">
        <div class="form-group">
            <label for="Input">제목</label>
            <input type="input" class="form-control" id="Input" name="title" placeholder="제목을 입력해주세요">
        </div>
        
        <div class="form-group">
            <input class="form-control" type="file" id="fileInput" name="fileInput" multiple>
            <div class="selected-files">
		        <ul id="selectedFiles"></ul>
		    </div>
          </div>
        
        <textarea id="summernote" name="editordata"></textarea>


        <div class="text-right">
            <input type="button" onclick="reg()" value="글쓰기" class="btn btn-info">
            <input type="button" onclick="cancel()" value="취소" class="btn btn-info">
        </div>
    </form>


    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <!-- include summernote css/js -->
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $('#summernote').summernote();
        });
        
        function reg(){
            console.log(testform.title.value);
            console.log(testform.editordata.value);
        }   
        
        function cancel(){
            console.log(testform.title.value);
            console.log(testform.editordata.value);
        }
        
        // 파일 첨부 시 선택한 파일명 표시
        $("#fileInput").on("change", function() {
            let fileNames = "";
            for (let i = 0; i < this.files.length; i++) {
                fileNames += "<li>" + this.files[i].name + "</li>";
            }
            $("#selectedFiles").html(fileNames);
        });
    </script>
    
    
</main>
			<%@ include file="/WEB-INF/views/common/footer.jsp"%>
		</div>
	</div>
	<script src="js/scripts.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>


