<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>OHappyToolgether</title>
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
				<div id='calendar'></div>
			</main>
			<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
			<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
			<script>
				document
						.addEventListener(
								'DOMContentLoaded',
								function() {
									var calendarEl = document
											.getElementById('calendar');
									var calendar = new FullCalendar.Calendar(
											calendarEl,
											{
												// Tool Bar 목록 document : https://fullcalendar.io/docs/toolbar
												headerToolbar : {
													left : 'prevYear,prev,next,nextYear today',
													center : 'title',
													right : 'dayGridMonth,dayGridWeek,dayGridDay'
												},

												selectable : true,
												selectMirror : true,

												navLinks : true, // can click day/week names to navigate views
												editable : true,
												// Create new event
												select : function(arg) {
													Swal
															.fire(
																	{
																		html : "<div class='mb-7'>일정을 추가하시겠습니까?</div><div class='fw-bold mb-5'>Event Name:</div><input type='text' class='form-control' name='event_name' />",
																		icon : "info",
																		showCancelButton : true,
																		buttonsStyling : false,
																		confirmButtonText : "넹",
																		cancelButtonText : "아니용",
																		customClass : {
																			confirmButton : "btn btn-primary",
																			cancelButton : "btn btn-active-light"
																		}
																	})
															.then(
																	function(
																			result) {
																		if (result.value) {
																			var title = document
																					.querySelector("input[name='event_name']").value;
																			if (title) {
																				calendar
																						.addEvent({
																							title : title,
																							start : arg.start,
																							end : arg.end,
																							allDay : arg.allDay
																						})
																			}
																			calendar
																					.unselect()
																		} else if (result.dismiss === "cancel") {
																			Swal
																					.fire({
																						text : "Event creation was declined!.",
																						icon : "error",
																						buttonsStyling : false,
																						confirmButtonText : "Ok, got it!",
																						customClass : {
																							confirmButton : "btn btn-primary",
																						}
																					});
																		}
																	});
												},

												// Delete event
												eventClick : function(arg) {
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
												dayMaxEvents : true, // allow "more" link when too many events
												// 이벤트 객체 필드 document : https://fullcalendar.io/docs/event-object
												events : [
														{
															title : 'All Day Event',
															start : '2022-07-01'
														},
														{
															title : 'Long Event',
															start : '2022-07-07',
															end : '2022-07-10'
														},
														{
															groupId : 999,
															title : 'Repeating Event',
															start : '2022-07-09T16:00:00'
														},
														{
															groupId : 999,
															title : 'Repeating Event',
															start : '2022-07-16T16:00:00'
														},
														{
															title : 'Conference',
															start : '2022-07-11',
															end : '2022-07-13'
														},
														{
															title : 'Meeting',
															start : '2022-07-12T10:30:00',
															end : '2022-07-12T12:30:00'
														},
														{
															title : 'Lunch',
															start : '2022-07-12T12:00:00'
														},
														{
															title : 'Meeting',
															start : '2022-07-12T14:30:00'
														},
														{
															title : 'Happy Hour',
															start : '2022-07-12T17:30:00'
														},
														{
															title : 'Dinner',
															start : '2022-07-12T20:00:00'
														},
														{
															title : 'Birthday Party',
															start : '2022-07-13T07:00:00'
														},
														{
															title : 'Click for Google',
															url : 'http://google.com/',
															start : '2022-07-28'
														} ]
											});

									calendar.render();
								});

				function popup(eventDetail) {
					var url = "calendardetail.do?eventtitle="
							+ eventDetail.title;
					var name = "popup test";
					var option = "width = 500, height = 500, top = 100, left = 200, location = no"
					window.open(url, name, option);
				}
			</script>

			<%@ include file="/WEB-INF/views/common/footer.jsp"%>
		</div>
	</div>
	<script src="js/scripts.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>



