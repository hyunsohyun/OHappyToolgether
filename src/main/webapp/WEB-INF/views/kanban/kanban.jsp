<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 현재 사용자의 ID를 가져옴 -->
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="name" var="userid" />

<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

<title>Kanban</title>

<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" />

<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>

<!-- 스크립트 -->
<!-- 제이쿼리 min -->
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<!-- 제이쿼리 font -->
<script src="https://ajax.googleapis.com/ajax/libs/webfont/1.4.7/webfont.js"></script>
<!-- 제이쿼리 ui-->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- 아이콘 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<!-- swal2  -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- 스크립트끝 -->

</head>

<!-- 스타일 -->
<style>
    body {
        padding: 0px;
        font: 14px "Lato";
        margin: 0px;
        background-color: rgba(186, 186, 186, 1.0);
    }

    ul {
        list-style-type: none;
        padding: 0;
        margin: 0;
        height: 100%;
    }



    /**********************************************************
    Body Section Styles
    ***********************************************************/
    .body-section {
        padding: 0px 20px 20px 20px;
    }


    .jobs-list-wrapper {
        padding-top: 20px;
        display: flex;
        flex-direction: row;
        flex-wrap: nowrap;
        justify-content: start;
        align-items: stretch;
        align-content: stretch;
        height: 100%;
        overflow-x: auto;
        width: 100%;
    }

    .jobs-list {
        width: 270px;
        margin: 0 6px 30px 6px;
        height: 100%;
        display: inline-block;
        vertical-align: top;
        white-space: nowrap;
        background-color: #ebece0;
        border-radius: 12px;
    }

    h2.jobs-list-heading {
        font-family: "Lato";
        font-size: 24px;
        font-weight: 600;
        padding: 4px 0px 8px 0px;
        text-align: center;
    }

    /* 크기 */
    .jobs-list-body {
        /* height: 500px; */
        height: 100%;
        margin-right: 10px;
        margin-left: 9px;
        overflow: auto;
        border-radius: 10px;
    }

    .jobs-list-body::-webkit-scrollbar {
        width: 0.4em;
    }

    .jobs-list-body::-webkit-scrollbar-thumb {
        background-color: rgba(0, 0, 0, 0.2);
        border-radius: 5px;
    }

    .jobs-list-body::-webkit-scrollbar-track {
        background-color: #e2e4e6;
    }

    .jobs-list-footer {
        height: 50px;
        display: flex;
        justify-content: center;
        align-items: center;
        margin-bottom: 20px;
    }

    .job-block {
        background-color: #fff;
        border-bottom: 1px solid #ccc;
        border-radius: 3px;
        cursor: pointer;
        display: block;
        margin-bottom: 6px;
        /* width: 94%; */
        max-width: 300px;
        min-height: 20px;
        position: relative;
        text-decoration: none;
        z-index: 0;
        padding-left: 5px;
        padding-right: 5px;
        padding-bottom: 10px;
        padding-top: 10px;
        border-radius: 12px;
        box-shadow: var(--ds-shadow-raised, 1px 1px 1px #091e4240, 0 0 0px #091e424f);
    }

    .job-block:hover {
        background-color: #f1f2f4;
    }

    .job-name {
        font-family: "Lato";
        width: 100%;
    }

    .job-info-block {
        margin-top: 10px;
        display: flex;
        flex-direction: column;
        flex-wrap: nowrap;
        justify-content: space-between;
        align-items: center;
        align-content: center;
    }

    .job-name-block {
        display: flex;
        flex-direction: row;
        flex-wrap: nowrap;
        justify-content: space-between;
        align-items: center;
        align-content: center;
        margin-bottom: 15px;
    }

    .job-date {
        font-size: 10px;
        padding: 2px 8px 3px 8px;
        background-color: #61bd4f;
        color: #fff;
        display: inline-block;
        border-radius: 5px;
    }

    .edit-job-icon {
        width: 10px;
        height: 10px;
    }

    .edit-job-icon:hover {
        opacity: 0.3;
    }

    .user-email {
        font-size: 10px;
        color: rgba(0, 0, 0, 0.6);
        font-weight: 700;
    }

    .kanban-title-block {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .job-edit {
        padding: 4px 0px;
        border-radius: 10px;
    }

    .job-edit:hover {
        background-color: #bbbbbb;
    }

    .icon-sm {
        font-size: 16px;
        margin: 0 7px 4px
            /* height: 20px;
        line-height: 20px;
        width: 20px; */
    }

    .kanban-title {
        word-wrap: break-word;
        clear: both;
        color: var(--ds-text, #172b4d);
        display: block;
        overflow: hidden;
        text-decoration: none;
        padding-left: 10px;
    }

    .ui-sortable {
        min-height: 20px;
        padding-top: 5px;
        padding-left: 5px;
        padding-bottom: 5px;
        padding-right: 5px;
    }

    .ui-sortable-handle {
        /* border-left: 1px solid tomato; */
        border-radius: 10px;
    }

    /* #backLog-list          #F94144
    #ToDo-jobs-list        #F8961E
    #inProgress-jobs-list  #F9C74F
    #testing-jobs-list  #90BE6D
    #done-jobs-list    #577590 */

    #backLog-list>li>div {
        background-color: #F94144;
    }

    #ToDo-jobs-list>li>div {
        background-color: #F8961E;
    }

    #inProgress-jobs-list>li>div {
        background-color: #F9C74F;
    }

    #testing-jobs-list>li>div {
        background-color: #90BE6D;
    }

    #done-jobs-list>li>div {
        background-color: #577590;
    }

    .kanban-root {
        --board-header-background-color: #0000003d;
    }

    .kanban-root-content {
        height: auto;
        position: relative;
        display: inline-flex;
        flex-direction: row;
        flex-wrap: wrap;
        flex-grow: 1;
        gap: 4px;
        width: calc(100% - 23px);
        align-items: center;
        padding: 12px 10px 12px 30px;

        backdrop-filter: blur(4px);
        background: var(--board-header-background-color);
        
    }

    .title-span {
        position: relative;
        display: flex;
        align-items: center;
        min-height: 32px;
        max-width: 100%;
    }

    .project-text {
        font-size: 20px;
        font-weight: 600;
        padding-right: 15px;
    }

    .title-span-auto {
        position: relative;
        display: flex;
        align-items: center;
        min-height: 32px;
        margin-left: auto;
    }

    .bg-trello-mountain{
        /* background-image: url("https://trello-backgrounds.s3.amazonaws.com/SharedBackground/1281x1920/f4713e4c8cebdb8cdba78f37495a9238/photo-1686922187671-510b88dfc927.jpg"); */
        /* background-size: cover; */
        /* background-position: left; */
    }
    
    .deleteBtn {
        position: absolute;
        top: 10px;
        right: 4%;
    }
</style>
<!-- 스타일 끝 -->

<body class="sb-nav-fixed">
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div id="layoutSidenav">
		<%@ include file="/WEB-INF/views/common/sidenav.jsp"%>
		<div id="layoutSidenav_content">
		
			<main class="bg-trello-mountain">
				<div class="container-xxl" id="projectContainer">
<!-- 칸반 영역-->
<div class="kanban-root">
    <div class="kanban-root-content" style="display: none;">
        <span class="title-span">
            <div class="project-text">프로젝트 ${sessionScope.projectId}</div>
        </span>
        <span class="title-span-auto">
            <div class="project-text">관리자이름 ${userid}</div>
        </span>
    </div>
</div>



<div class="body-section">
    <div class="jobs-list-wrapper">

        <div class="jobs-list">
            <h2 class="jobs-list-heading">Back Log</h2>
            <div class="jobs-list-body" id="backLog" style="background-color: rgba(0, 0, 0, 0);">
                <ul id="backLog-list" class="ui-sortable">
                    <!--  -->
                </ul>
            </div>
            <div class="jobs-list-footer">
                <div>
                    <button id="plusBtn1" class="btn btn-secondary 10">+</button>
                </div>
            </div>
        </div>

        <div class="jobs-list">
            <h2 class="jobs-list-heading">To Do</h2>
            <div class="jobs-list-body" id="ToDo" style="background-color: rgba(0, 0, 0, 0);">
                <ul id="ToDo-jobs-list" class="ui-sortable">
                    <!--  -->
                </ul>
            </div>
            <div class="jobs-list-footer">
                <div>
                    <button id="plusBtn2" class="btn btn-secondary 20">+</button>
                </div>
            </div>
        </div>

        <div class="jobs-list">
            <h2 class="jobs-list-heading">In Progress</h2>
            <div class="jobs-list-body" id="inProgress">
                <ul id="inProgress-jobs-list" class="ui-sortable">
                    <!--  -->
                </ul>
            </div>
            <div class="jobs-list-footer">
                <div>
                    <button id="plusBtn3" class="btn btn-secondary 30">+</button>
                </div>
            </div>
        </div>

        <div class="jobs-list">
            <h2 class="jobs-list-heading">Testing</h2>
            <div class="jobs-list-body" id="testing">
                <ul id="testing-jobs-list" class="ui-sortable">
                    <!--  -->
                </ul>
            </div>
            <div class="jobs-list-footer">
                <div>
                    <button id="plusBtn4" class="btn btn-secondary 40">+</button>
                </div>
            </div>
        </div>

        <div class="jobs-list">
            <h2 class="jobs-list-heading">Done</h2>
            <div class="jobs-list-body" id="done">
                <ul id="done-jobs-list" class="ui-sortable">
                    <!--  -->
                </ul>
            </div>
            <div class="jobs-list-footer">
                <div>
                    <button id="plusBtn5" class="btn btn-secondary 50">+</button>
                </div>
            </div>
        </div>

    </div>
</div>
<!-- 칸반 영역 끝 -->
				</div>
			</main>
			
		<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
		<script src="js/datatables-simple-demo.js"></script>
		<!--
		<script type="text/javascript">
		</script>
		-->
<!-- 스크립트영역 -->

<script>
$(document).ready(function () {
    //console.log(3);
    fetchDataAndRenderKanban();

    // 드래그 & 드롭 인터페이스를 위한 정렬 가능한 함수
    // https://jqueryui.com/sortable/

    // "backLog-list"에 대한 정렬 가능 설정
    $("#backLog-list").sortable({
        // 다른 정렬 가능 목록과 연결
        connectWith: ["#ToDo-jobs-list", "#inProgress-jobs-list", "#testing-jobs-list", "#done-jobs-list"],

        // 정렬 가능한 요소가 정렬 가능 목록 위에 있을 때 실행됨
        over: function (event, ui) {
            $('#backLog').css('background-color', 'rgba(0,0,0,.1)');
            $("#new-job-" + ui.item[0].id).css('background-color', '#F94144');

        },

        // 정렬 가능한 아이템이 정렬 가능 목록에서 움직여져 나갈 때 실행됨
        out: function (event, ui) {
            $('#backLog').css('background-color', 'rgba(0,0,0,.0)');
        },

        // 연결된 정렬 가능 목록의 아이템이 다른 목록에 드롭될 때 실행됨
        receive: function (event, ui) {
            $('#backLog').css('background-color', 'rgba(0,0,0,.0)');
            $("#new-job-" + ui.item[0].id).find('.kanbanboardId').text('10');
        },

        // 원래 위치로 되돌아갈 때까지의 시간 설정(단위: ms)
        revert: 100,

        // 정렬이 시작되면 아이템을 약간 회전
        start: function (event, ui) {
            var elementId = ui.item[0].id;
            $('#' + elementId).css('transform', 'rotate(4deg)');
        },

        // 정렬이 멈추면 원래대로 회전 복귀
        stop: function (event, ui) {
            var elementId = ui.item[0].id;
            $('#' + elementId).css('transform', 'rotate(0deg)');
            saveBtnClick();
        }
    });

    // 위와 같은 원리로 다른 id들에 대한 정렬 가능 설정도 같은 방식으로 진행
    $(function () {
        $("#ToDo-jobs-list").sortable({
            connectWith: ["#backLog-list", "#inProgress-jobs-list", "#testing-jobs-list", "#done-jobs-list"],
            over: function (event, ui) {
                $('#ToDo').css('background-color', 'rgba(0,0,0,.1)');
                $("#new-job-" + ui.item[0].id).css('background-color', '#F8961E');
            },
            out: function (event, ui) {
                $('#ToDo').css('background-color', 'rgba(0,0,0,.0)');
            },
            receive: function (event, ui) {
                $('#ToDo').css('background-color', 'rgba(0,0,0,.0)');
                $("#new-job-" + ui.item[0].id).find('.kanbanboardId').text('20');
            },
            revert: 100,
            start: function (event, ui) {
                var elementId = ui.item[0].id;
                $('#' + elementId).css('transform', 'rotate(4deg)');
            },
            stop: function (event, ui) {
                var elementId = ui.item[0].id;
                $('#' + elementId).css('transform', 'rotate(0deg)');
                saveBtnClick();
            }
        });
    });

    $(function () {
        $("#inProgress-jobs-list").sortable({
            connectWith: ["#backLog-list", "#ToDo-jobs-list", "#testing-jobs-list", "#done-jobs-list"],
            over: function (event, ui) {
                $('#inProgress').css('background-color', 'rgba(0,0,0,.1)');
                $("#new-job-" + ui.item[0].id).css('background-color', '#F9C74F');
            },
            out: function (event, ui) {
                $('#inProgress').css('background-color', 'rgba(0,0,0,.0)');
            },
            receive: function (event, ui) {
                $('#inProgress').css('background-color', 'rgba(0,0,0,.0)');
                var status = 'inProgress';
                var orderId = ui.item[0].firstChild.id;
                $("#new-job-" + ui.item[0].id).find('.kanbanboardId').text('30');
            },
            revert: 100,
            start: function (event, ui) {
                var elementId = ui.item[0].id;
                $('#' + elementId).css('transform', 'rotate(4deg)');
            },
            stop: function (event, ui) {
                var elementId = ui.item[0].id;
                $('#' + elementId).css('transform', 'rotate(0deg)');
                saveBtnClick();
            }
        });
    });

    $(function () {
        $("#testing-jobs-list").sortable({
            connectWith: ["#backLog-list", "#ToDo-jobs-list", "#inProgress-jobs-list", "#done-jobs-list"],
            over: function (event, ui) {
                $('#testing').css('background-color', 'rgba(0,0,0,.1)');
                $("#new-job-" + ui.item[0].id).css('background-color', '#90BE6D');
            },
            out: function (event, ui) {
                $('#testing').css('background-color', 'rgba(0,0,0,.0)');
            },
            receive: function (event, ui) {
                $('#testing').css('background-color', 'rgba(0,0,0,.0)');
                $("#new-job-" + ui.item[0].id).find('.kanbanboardId').text('40');
            },
            revert: 100,
            start: function (event, ui) {
                var elementId = ui.item[0].id;
                $('#' + elementId).css('transform', 'rotate(4deg)');
            },
            stop: function (event, ui) {
                var elementId = ui.item[0].id;
                $('#' + elementId).css('transform', 'rotate(0deg)');
                saveBtnClick();
            }
        });
    });

    $(function () {
        $("#done-jobs-list").sortable({
            connectWith: ["#backLog-list", "#ToDo-jobs-list", "#inProgress-jobs-list", "#testing-jobs-list"],
            over: function (event, ui) {
                $('#done').css('background-color', 'rgba(0,0,0,.1)');
                //console.log(51);
                $("#new-job-" + ui.item[0].id).css('background-color', '#577590');
            },
            out: function (event, ui) {
                $('#done').css('background-color', 'rgba(0,0,0,.0)');
                //console.log(52);
            },
            receive: function (event, ui) {
                $('#done').css('background-color', 'rgba(0,0,0,.0)');
                $("#new-job-" + ui.item[0].id).find('.kanbanboardId').text('50');
                //console.log(53);
            },
            revert: 100,
            start: function (event, ui) {
                var elementId = ui.item[0].id;
                $('#' + elementId).css('transform', 'rotate(4deg)');
                //console.log(54);
            },
            stop: function (event, ui) {
                var elementId = ui.item[0].id;
                $('#' + elementId).css('transform', 'rotate(0deg)');
                saveBtnClick();
                //console.log(55);
            }
        });
    });
});


const fetchDataAndRenderKanban = async () => {
    const data10 = await getKanban(${sessionScope.projectId}, 10);
    const data20 = await getKanban(${sessionScope.projectId}, 20);
    const data30 = await getKanban(${sessionScope.projectId}, 30);
    const data40 = await getKanban(${sessionScope.projectId}, 40);
    const data50 = await getKanban(${sessionScope.projectId}, 50);
    await renderKanban(data10, data20, data30, data40, data50);
}


const getKanban = (projectId, kanbanboardId) => {
    return new Promise((resolve, reject) => { // Promise를 반환합니다
        $.ajax({
            url: 'card/' + projectId + '/' + kanbanboardId, // API URL
            type: 'GET', // HTTP 메서드
            dataType: 'json', // 받아올 데이터 타입

            success: function (data) {
                //console.log(data); // 요청 성공 시 콘솔에 데이터 출력
                resolve(data); // 데이터를 Promise의 결과 값으로 설정합니다
            },

            error: function (error) {
                //console.log('Error:', error); // 요청 실패 시 콘솔에 오류 메시지 출력
                reject(error); // 오류를 Promise의 결과 값으로 설정합니다
            }
        });
    });
}

const deleteCard = (cardId) => {
    return new Promise((resolve, reject) => { 
        $.ajax({
            url: 'card/' + cardId, 
            type: 'DELETE', 
            dataType: 'json', 
            success: function (data) {
                resolve(data); 
            },
            error: function (error) {
                reject(error); 
            }
        });
    });
}

const renderKanban = (data10, data20, data30, data40, data50) => {
    const listIds = ["backLog-list", "ToDo-jobs-list", "inProgress-jobs-list", "testing-jobs-list", "done-jobs-list"];
    // 지우기

    for (const listId of listIds) {
        const sortableList = document.getElementById(listId);
        while (sortableList.firstChild) {
            sortableList.removeChild(sortableList.firstChild);
        }
    }

    // 데이터 생성
    let ulElement = document.getElementById('backLog-list');
    data10.forEach(function (item) {
        var li = createListItem(item);
        ulElement.appendChild(li);
    });
    ulElement = document.getElementById('ToDo-jobs-list');
    data20.forEach(function (item) {
        var li = createListItem(item);
        ulElement.appendChild(li);
    });
    ulElement = document.getElementById('inProgress-jobs-list');
    data30.forEach(function (item) {
        var li = createListItem(item);
        ulElement.appendChild(li);
    });
    ulElement = document.getElementById('testing-jobs-list');
    data40.forEach(function (item) {
        var li = createListItem(item);
        ulElement.appendChild(li);
    });
    ulElement = document.getElementById('done-jobs-list');
    data50.forEach(function (item) {
        var li = createListItem(item);
        ulElement.appendChild(li);
    });
};


const createListItem = (item) => {
    //console.log(item);
    let li = document.createElement('li');
    li.className = 'ui-sortable-handle';
    li.id = item.cardId;

    let divJobBlock = document.createElement('div');
    divJobBlock.className = 'job-block';
    divJobBlock.id = 'new-job-' + item.cardId;

    let divKanbanTitleBlock = document.createElement('div');
    divKanbanTitleBlock.className = 'kanban-title-block';

    let divKanbanTitle = document.createElement('div');
    divKanbanTitle.className = 'kanban-title';
    divKanbanTitle.textContent = item.title;

    let divJobEdit = document.createElement('div');
    divJobEdit.className = 'job-edit';

    let iJobEdit = document.createElement('i');
    iJobEdit.className = 'bi bi-pencil icon-sm';

    divJobEdit.appendChild(iJobEdit);

    divKanbanTitleBlock.appendChild(divKanbanTitle);
    divKanbanTitleBlock.appendChild(divJobEdit);

    let divJobInfoBlock = document.createElement('div');
    divJobInfoBlock.className = 'job-info-block';
    divJobInfoBlock.style.display = 'none';

    let keys = ['cardId', 'projectId', 'kanbanboardId', 'title', 'content', 'createDate', 'startDate', 'endDate', 'pos', 'completeDate'];
    keys.forEach(key => {
        let divKanbanItem = document.createElement('div');
        divKanbanItem.className = 'kanban-item ' + key;

        if (key === 'createDate' || key === 'startDate' || key === 'endDate' || key === 'completeDate') {
            divKanbanItem.textContent = formatDate(item[key]);
        } else {
            divKanbanItem.textContent = item[key];
        }
        divJobInfoBlock.appendChild(divKanbanItem);
    });

    let divKanbanName = document.createElement('div');
    divKanbanName.className = 'kanban-name';
    divKanbanName.textContent = item.name;

    divJobInfoBlock.appendChild(divKanbanName);

    divJobBlock.appendChild(divKanbanTitleBlock);
    divJobBlock.appendChild(divJobInfoBlock);

    li.appendChild(divJobBlock);

    return li;
}
//

const formatDate = (timestamp) => {
    if (timestamp != null) {
        const date = new Date(timestamp);
        const year = date.getFullYear();
        const month = (date.getMonth() + 1 < 10 ? '0' : '') + (date.getMonth() + 1);
        const day = (date.getDate() < 10 ? '0' : '') + date.getDate();
        const formattedDate = year + '-' + month + '-' + day;
        return formattedDate;
    }
};



$(document).on('click', '.job-block', async function () {
    const id = this.id;
    const number = id.replace('new-job-', '');
    //console.log(number);

    // 클릭한 요소의 텍스트 가져오기
    const cardId = $(this).closest('.job-block').find('.cardId').text();
    const title = $(this).closest('.job-block').find('.kanban-title').text();
    const content = $(this).closest('.job-block').find('.content').text();
    const startDate = $(this).closest('.job-block').find('.startDate').text();
    const endDate = $(this).closest('.job-block').find('.endDate').text();
    const name = $(this).closest('.job-block').find('.kanban-name').text();
    const completeDate = $(this).closest('.job-block').find('.completeDate').text();

    const { value: formValues } = await Swal.fire({
        title: '카드 보기',

        html:
            '<div class="pt-3">제목</div>' +
            '<input id="swal-input1" class="swal2-input" value="' + title + '" disabled>' +

            '<div class="pt-3">내용</div>' +
            '<input id="swal-input2" class="swal2-input" value="' + content + '" disabled>' +

            '<div class="pt-3">시작날짜</div>' +
            '<input type="text" id="swal-input3" name="from" class="swal2-input" value="' + startDate + '" disabled>' +

            '<div class="pt-3">종료날짜</div>' +
            '<input type="text" id="swal-input4" name="to" class="swal2-input" value="' + endDate + '" disabled>' +

            '<div class="pt-3">담당자이름</div>' +
            '<input id="swal-input5" class="swal2-input" value="' + name + '" disabled>' +

            '<div class="pt-3">완료날짜</div>' +
            '<input type="text" id="swal-input6" name="to" class="swal2-input" value="' + completeDate + '" disabled>' +

            '<div id="cardIdForDelete" style="display: none">' + cardId + '</div>'+
            '<div><button id="deleteBtn" class="btn btn-danger deleteBtn">삭제</button></div>',

        focusConfirm: false,
        preConfirm: () => {
            return null;
        }
    })

    if (formValues) {
        Swal.fire(JSON.stringify(formValues))
    }

});

$(document).on('click', '.job-edit', async function (event) {
    event.stopPropagation();

    const id = this.id;
    const number = id.replace('edit', '');
    //console.log(number);

    // 클릭한 요소의 텍스트 가져오기
    const cardId = $(this).closest('.job-block').find('.cardId').text();
    const title = $(this).closest('.job-block').find('.kanban-title').text();
    const content = $(this).closest('.job-block').find('.content').text();
    const startDate = $(this).closest('.job-block').find('.startDate').text();
    const endDate = $(this).closest('.job-block').find('.endDate').text();
    const name = $(this).closest('.job-block').find('.kanban-name').text();
    const completeDate = $(this).closest('.job-block').find('.completeDate').text();

    const { value: formValues } = await Swal.fire({
        title: '카드 수정',

        html:
            '<div class="pt-3">제목</div>' +
            '<input id="swal-input1" class="swal2-input" value="' + title + '">' +

            '<div class="pt-3">내용</div>' +
            '<input id="swal-input2" class="swal2-input" value="' + content + '">' +

            '<div class="pt-3">시작날짜</div>' +
            '<input type="text" id="swal-input3" name="from" class="swal2-input" value="' + startDate + '">' +

            '<div class="pt-3">종료날짜</div>' +
            '<input type="text" id="swal-input4" name="to" class="swal2-input" value="' + endDate + '">' +

            '<div class="pt-3">담당자이름</div>' +
            '<input id="swal-input5" class="swal2-input" value="' + name + '">' +

            '<div class="pt-3">완료날짜</div>' +
            '<input type="text" id="swal-input6" name="to" class="swal2-input" value="' + completeDate + '">',


        focusConfirm: false,
        preConfirm: async () => {

            const targetLi = $('li.ui-sortable-handle[id$="' + cardId + '"]');
            targetLi.find('.kanban-title').text(document.getElementById('swal-input1').value);
            targetLi.find('.title').text(document.getElementById('swal-input1').value);
            targetLi.find('.content').text(document.getElementById('swal-input2').value);
            targetLi.find('.startDate').text(document.getElementById('swal-input3').value);
            targetLi.find('.endDate').text(document.getElementById('swal-input4').value);
            targetLi.find('.kanban-name').text(document.getElementById('swal-input5').value);
            targetLi.find('.completeDate').text(document.getElementById('swal-input6').value);

            Swal.fire({
                icon: 'success',
                title: '수정 완료',
                showConfirmButton: false,
                timer: 1500
            })

            console.log("카드수정 완료");
            await saveBtnClick();
            await fetchDataAndRenderKanban();

            return null;
        }
    })

    if (formValues) {
        Swal.fire(JSON.stringify(formValues))
    }
});

// 버튼
const saveBtnClick = () => {
    let listIds = ["#backLog-list", "#ToDo-jobs-list", "#inProgress-jobs-list", "#testing-jobs-list", "#done-jobs-list"];
    let jsonDataSets = [];  // 단일 배열로 데이터를 저장

    for (let i = 0; i < 5; i++) {
        // li 태그를 선택하여 각각의 작업들을 가져옵니다
        let tasks = document.querySelectorAll(listIds[i] + " li");
        tasks.forEach((task, index) => {
            let taskData = {
                "title": task.querySelector(".title").innerText,
                "content": task.querySelector(".content").innerText,
                "kanbanboardId": task.querySelector(".kanbanboardId").innerText,
                "startDate": task.querySelector(".startDate").innerText,
                "endDate": task.querySelector(".endDate").innerText,
                "name": task.querySelector(".kanban-name").innerText,
                "pos": index + 1,
                "completeDate": task.querySelector(".completeDate").innerText
                //"listId": listIds[i]  // 어떤 리스트에서 작업이 왔는지 추적하기 위해 리스트 ID를 추가
            };
            jsonDataSets.push(taskData);  // 생성된 객체를 dataSet에 추가
        });
    }

    // dataSet 출력
    //console.log("jsonDataSets", jsonDataSets);

    const cardIdList = Array.from(document.querySelectorAll('.jobs-list-wrapper .ui-sortable-handle')).map(handle => handle.id);
    //console.log(cardIdList);

    //updateKanban시작
    for (i = 0; i < jsonDataSets.length; i++) {
    	updateKanban(cardIdList[i], jsonDataSets[i]);
    }
    console.log("업데이트 완료");
}

// 함수
const updateKanban = (cardId, jsonData) => {
    $.ajax({
        url: 'card/' + cardId,
        type: 'PUT', // HTTP 메서드
        dataType: 'json', // 받아올 데이터 타입
        contentType: 'application/json', // 서버에 보낼 데이터의 Content-Type
        data: JSON.stringify(jsonData), // 서버에 보낼 데이터

        success: function (data) {// 요청 성공 시 콘솔에 데이터 출력
            //console.log(data);
        },
        error: function (error) { // 요청 실패 시 콘솔에 오류 메시지 출력
            //console.log('Error:', error);
        }
    });
}



$("[id^='plusBtn']").click(function () {
    // 칸반보드id 계산용
    const btnValue = $(this).attr("class").split(' ')[2];
    //console.log(btnValue);

    // pos값 계산용
    let listIds = ["backLog-list", "ToDo-jobs-list", "inProgress-jobs-list", "testing-jobs-list", "done-jobs-list"];
    let keys = [10, 20, 30, 40, 50];
    let itemCountMap = new Map();

    listIds.forEach((listId, index) => {
        let itemList = document.getElementById(listId)?.getElementsByTagName("li");
        let itemCount = itemList ? itemList.length : 0; // 한개도 없는 경우
        itemCountMap.set(keys[index], itemCount);
    });
    //console.log(itemCountMap.get(Number(btnValue)));

    const { value: formValues } = Swal.fire({
        title: '카드 등록',

        html:
            '<div class="pt-3">제목</div>' +
            '<input id="swal-input1" class="swal2-input" >' +

            '<div class="pt-3">내용</div>' +
            '<input id="swal-input2" class="swal2-input" >' +

            '<div class="pt-3">시작날짜</div>' +
            '<input type="text" id="swal-input3" name="from" class="swal2-input" >' +

            '<div class="pt-3">종료날짜</div>' +
            '<input type="text" id="swal-input4" name="to" class="swal2-input" >' +

            '<div class="pt-3">담당자이름</div>' +
            '<input id="swal-input5" class="swal2-input" >' +
            
            '<div class="pt-3">완료날짜</div>' +
            '<input type="text" id="swal-input6" name="to" class="swal2-input" >' ,


        focusConfirm: false,
        preConfirm: async () => {

            const projectId = ${sessionScope.projectId};
            const kanbanboardId = btnValue;
            const title = document.getElementById('swal-input1').value;
            const content = document.getElementById('swal-input2').value;
            const startDate = document.getElementById('swal-input3').value;
            const endDate = document.getElementById('swal-input4').value;
            const name = document.getElementById('swal-input5').value;
            const pos = itemCountMap.get(Number(btnValue)) + 1; // 잘계산..
            const completeDate = document.getElementById('swal-input6').value;

            const jsonPostData = {
                "projectId": projectId,
                "kanbanboardId": kanbanboardId,
                "title": title,
                "content": content,
                "startDate": startDate,
                "endDate": endDate,
                "name": name,
                "pos": pos,
                "completeDate":completeDate,
            }

            const response = await new Promise((resolve, reject) => {
                $.ajax({
                    url: 'card', // API URL
                    type: 'POST', // HTTP 메서드
                    dataType: 'json', // 받아올 데이터 타입
                    contentType: 'application/json', // 서버에 보낼 데이터의 Content-Type
                    data: JSON.stringify(jsonPostData), // 서버에 보낼 데이터

                    success: function (data) {
                        //console.log(data); // 요청 성공 시 콘솔에 데이터 출력
                        resolve(data);
                    },

                    error: function (error) {
                        //console.log('Error:', error); // 요청 실패 시 콘솔에 오류 메시지 출력
                        reject(error);
                    }
                });
            });

            console.log("등록 완료");
            await saveBtnClick();
            await fetchDataAndRenderKanban();

            Swal.fire({
                icon: 'success',
                title: '등록 완료',
                showConfirmButton: false,
                timer: 1500
            })
            
            return null;
        }
    })
});
</script>		
<script>
$(document).on('click', '#deleteBtn', async function () {  // async keyword added
    //console.log("delete 버튼 클릭");
    const cardId = $('#cardIdForDelete').text();
    //console.log(cardId);

    const { value: confirmDelete } = await Swal.fire({  // await keyword added
        title: '삭제 확인',
        text: '정말로 삭제하시겠습니까?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: '예',
        cancelButtonText: '아니오'
    });

    if (confirmDelete) {
        await deleteCard(cardId);
        await fetchDataAndRenderKanban();
        console.log("삭제 완료");
        Swal.fire({
            icon: 'success',
            title: '삭제 완료',
            showConfirmButton: false,
            timer: 1500
        })
    } else {
        //console.log('취소');
    }
});

</script>
<!-- 스크립트영역끝 -->
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
		</div>
	</div>
	<script src="js/scripts.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>

</html>






