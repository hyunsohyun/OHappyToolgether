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

<title>fullcalendar</title>

<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>

</head>

<body class="sb-nav-fixed">
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div id="layoutSidenav">
		<%@ include file="/WEB-INF/views/common/sidenav.jsp"%>
		<div id="layoutSidenav_content">
		
			<main>
				<div class="container" id="fullcalendarContainer">
                    <!-- fullcalendar 영역-->                    
                    <div id='calendar'></div>
                    <!-- fullcalendar 영역 끝 -->
                </div>
			</main>
			<!-- 스크립트영역 -->
            <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
            <script src="js/datatables-simple-demo.js"></script>

            <script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>

            <!-- fullcalendar -->
            <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
			<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>


<script>
$(document).ready(async function() {
    //console.log(1);
    let cardData = [];

    const fetchDataAndRenderKanban = async () => { // async를 이곳에 추가

        const getKanban = (projectId, kanbanboardId) => {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'card/' + projectId + '/' + kanbanboardId,
                    type: 'GET',
                    dataType: 'json',

                    success: function (data) {
                        resolve(data);
                    },

                    error: function (error) {
                        reject(error);
                    }
                });
            });
        };

        const projectData = [];

        // 각각의 데이터를 가져와서 배열에 추가
        projectData.push(getKanban(${sessionScope.projectId}, 10));
        projectData.push(getKanban(${sessionScope.projectId}, 20));
        projectData.push(getKanban(${sessionScope.projectId}, 30));
        projectData.push(getKanban(${sessionScope.projectId}, 40));
        projectData.push(getKanban(${sessionScope.projectId}, 50));

        try {
            const results = await Promise.all(projectData); // await를 이곳에 추가

            const flattenedResults = results.flat(); 
            console.log(flattenedResults);

            let data = flattenedResults;
            let updatedData = data.map(item => {
                let newItem = {...item};

                //키변경
                if (newItem.hasOwnProperty('startDate')) {
                    newItem.start = newItem.startDate;
                    delete newItem.startDate;
                }
                if (newItem.hasOwnProperty('endDate')) {
                    newItem.end = newItem.endDate;
                    delete newItem.endDate;
                }

                //값변경
                if (newItem.start !== null) {
                    let startDate = new Date(newItem.start);
                    newItem.start = startDate.toISOString().split('T')[0];  // YYYY-MM-DD format
                }
                if (newItem.end !== null) {
                    let endDate = new Date(newItem.end);
                    newItem.end = endDate.toISOString().split('T')[0];  // YYYY-MM-DD format
                }

                return newItem;
            });

            console.log("키와 값을 바꾼 데이터");
            console.log(updatedData);
            cardData = updatedData;
            return cardData;
        } catch (error) {
            console.error(error);
        }
    };

    cardData = await fetchDataAndRenderKanban();

    // //console.log(2);
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar( calendarEl,
        {
            // Tool Bar 목록 document : https://fullcalendar.io/docs/toolbar
            headerToolbar: {
                left: 'prevYear,prev,next,nextYear today',
                center: 'title',
                right: 'dayGridMonth,dayGridWeek,dayGridDay'
            },

            selectable: true,
            selectMirror: true,

            navLinks: true, // can click day/week names to navigate views
            editable: true,
            // Create new event
            select: function (arg) {
                Swal.fire(
                    {
                        html: "<div class='mb-7'>일정을 추가하시겠습니까?</div><div class='fw-bold mb-5'>Event Name:</div><input type='text' class='form-control' name='event_name' />",
                        icon: "info",
                        showCancelButton: true,
                        buttonsStyling: false,
                        confirmButtonText: "넹",
                        cancelButtonText: "아니용",
                        customClass: {
                            confirmButton: "btn btn-primary",
                            cancelButton: "btn btn-active-light"
                        }
                    }).then(
                        function (
                            result) {
                            if (result.value) {
                                var title = document
                                    .querySelector("input[name='event_name']").value;
                                if (title) {
                                    calendar
                                        .addEvent({
                                            title: title,
                                            start: arg.start,
                                            end: arg.end,
                                            allDay: arg.allDay
                                        })
                                }
                                calendar
                                    .unselect()
                            } else if (result.dismiss === "cancel") {
                                Swal
                                    .fire({
                                        text: "Event creation was declined!.",
                                        icon: "error",
                                        buttonsStyling: false,
                                        confirmButtonText: "Ok, got it!",
                                        customClass: {
                                            confirmButton: "btn btn-primary",
                                        }
                                    });
                            }
                        });
            },

            // Delete event
            eventClick: function (arg) {
                /* Swal.fire({
                    text: "Are you sure you want to delete this event?",
                    icon: "warning",
                    showCancelButton: true,
                    buttonsStyling: false,
                    confirmButtonText: "Yes, delete it!",
                    cancelButtonText: "No, return",
                    customClass: {
                        confirmButton: "btn btn-primary",
                        cancelButton: "btn btn-active-light"
                    }
                }).then(function (result) {
                    if (result.value) {
                        arg.event.remove()
                    } else if (result.dismiss === "cancel") {
                        Swal.fire({
                            text: "Event was not deleted!.",
                            icon: "error",
                            buttonsStyling: false,
                            confirmButtonText: "Ok, got it!",
                            customClass: {
                                confirmButton: "btn btn-primary",
                            }
                        });
                    }
                }); */
                console.log(arg);
                console.log(arg.event._def);
                let cardInfo = arg.event._def;
                /* alert(cardInfo.title); */
                popup(cardInfo);

            },
            dayMaxEvents: true, // allow "more" link when too many events
            // 이벤트 객체 필드 document : https://fullcalendar.io/docs/event-object
            events: cardData
        });

    calendar.render();
});

    

</script>
<script>
document.addEventListener('DOMContentLoaded', function () {
    //console.log(1);
    
});

function popup(eventDetail) {
    var url = "calendardetail.do?eventtitle="
        + eventDetail.title;
    var name = "popup test";
    var option = "width = 500, height = 500, top = 100, left = 200, location = no"
    window.open(url, name, option);
}
</script>

            <!-- fullcalendar -->
            <!-- 스크립트영역끝 -->
            <%@ include file="/WEB-INF/views/common/footer.jsp"%>
        </div>
    </div>
    <script src="js/scripts.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>