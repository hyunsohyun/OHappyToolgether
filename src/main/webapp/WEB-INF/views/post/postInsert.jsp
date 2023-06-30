<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/sidenav.jsp"%>
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
            <label for="fileInput">파일 첨부</label>
            <input type="file" class="custom-file-input" id="fileInput" name="fileInput" multiple>
        </div>
        
        <textarea id="summernote" name="editordata"></textarea>
        
        <div class="text-right">
            <input type="button" onclick="reg()" value="글쓰기" class="btn btn-info">
            <input type="button" onclick="cancel()" value="취소" class="btn btn-info">
        </div>
    </form>
    
    <div class="selected-files">
        <p id="selectedFilesHeader">선택한 파일:</p>
        <ul id="selectedFiles"></ul>
    </div>

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
            var fileNames = "";
            for (var i = 0; i < this.files.length; i++) {
                fileNames += "<li>" + this.files[i].name + "</li>";
            }
            $("#selectedFiles").html(fileNames);
        });
    </script>
    
    <style>
        .note-editor .note-editing-area {
            height: 500px;
        }
        .selected-files {
            margin-top: 20px;
        }
        #selectedFilesHeader {
            font-weight: bold;
        }
        #selectedFiles li {
            list-style-type: none;
        }
    </style>
</main>