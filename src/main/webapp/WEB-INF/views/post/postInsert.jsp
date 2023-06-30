<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/sidenav.jsp"%>
<style>
        .note-editor .note-editing-area {
            height: 500px;
        }

    </style>
<main>
    <h1 class="mt-4">게시판 글쓰기</h1>
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
		    <input type="file" class="custom-file-input btn btn-info" id="fileInput" name="fileInput" multiple>
		    <div class="selected-files">
		        <ul id="selectedFiles"></ul>
		    </div>
		</div>
		
		<div style="text-align: center;">
	배경 이미지 업로드 :
	<p>
		<label for="customFile" class="btn btn-primary">Choose file</label>
		<input type="file" id="customFile" accept="image/*" class="custom-file-input real-upload" style="display: none;" multiple>
	</p>
	<div class="upload"></div>
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
        
        let getImageFiles = (e) => {
            const files = e.currentTarget.files;
            const file = files[0];

            if (files.length > 1) {
                alert('이미지는 하나만 등록됩니다.');
            }

            // 파일 타입 검사
            if (!file.type.match("image/.*")) {
                alert('이미지 파일만 업로드가 가능합니다.');
                return;
            }

            // 파일 갯수 검사
            const reader = new FileReader();
            reader.onload = (e) => {
                const preview = changeBgImg(e);
            };
            reader.readAsDataURL(file);
        }

        let changeBgImg = (e, file) => {
            backImg.src= e.target.result;
        }

        const realUpload = document.querySelector('.real-upload');
        realUpload.addEventListener('change', getImageFiles);
        
    </script>
    
    
</main>
