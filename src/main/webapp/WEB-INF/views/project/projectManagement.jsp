<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!-- 현재 사용자의 ID를 가져옴 -->
<sec:authentication property="name" var="userid" />

<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>OHappyToolgether</title>
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
<link href="css/projectManagement.css" rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<!-- swal2  -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</head>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>


$(document).ready(function() {
	
	const modal = document.getElementById("modal")
    const projectId = '${sessionScope.projectId}';
    const memberId = '${userid}'; 
    const managerId = '${managerId}'
    const tableBody = $("#memberList");
    const userTableBody = $("#userTableBody");
    const pageSize = 6; 
	let projectManagerId="";
	let projectBoardCnt = 0;
	
    // 프로젝트 정보
    let getUsersAndProjectInfo = function() {
        // 프로젝트 정보 가져오기
        let getProjectInfo = function() {
            $.ajax({
                url: "project/" + memberId,
                type: "GET",
                contentType: "application/json",
                success: function(response) {
                    let projectName = "";
                    for (let i = 0; i < response.length; i++) {
                        if (response[i].projectId == projectId) {
                            projectName = response[i].projectName;
                            projectManagerId = response[i].managerId;
                            $("#projectName").val(projectName);
                            $("#projectManagerId").val(projectManagerId);
                            $.ajax({
                		        url: "member/" + projectManagerId,
                		        type: "GET",
                		        contentType: "application/json",
                		        success: function(response) {
                		            let projectManagerName = "";
                		            for (let i = 0; i < response.length; i++) {
                		                if (response[i].userid == projectManagerId) {
                		                    projectManagerName = response[i].name;
                		                    console.log(projectManagerName);
                		                }
                		            }
                		            $("#projectManagerName").val(projectManagerName);
                		        },
                		        error: function(xhr, status, error) {
                		            console.log("에러 메시지:", xhr.status);
                		            $("#projectManagerName").val("에러 발생"); 
                		        }
                		    }); 
                            break;
                        }
                    }
                },
                error: function(xhr, status, error) {
                    console.log("에러 메시지:", xhr.status);
                }
            });
        };

        // 프로젝트 참가자 목록 가져오기
		let getUsers = function(page, pageSize) {
		    $.ajax({
		        url: `member/users/${projectId}`,
		        type: "GET",
		        contentType: "application/json",
		        success: function(response) {
		            let startIndex = (page - 1) * pageSize;
		            let endIndex = startIndex + pageSize;
		            let paginatedData = response.slice(startIndex, endIndex);
		
		            let tableBody = $("#memberList");
		            tableBody.empty();
		
		            if (paginatedData.length > 0) {
		                paginatedData.forEach(function(user) {
		                    let row = $("<tr>").addClass("table-active");
		                    $("<td>").text(user.name).appendTo(row);
		                    $("<td>").text(user.userid).appendTo(row);
		                    let removeButtonCell = $("<td>");
		                    let removeButton = $("<button>").addClass("btn btn-danger deleteUsersProject").text("내보내기");
		                    removeButtonCell.append(removeButton);
		                    row.append(removeButtonCell);
		                    tableBody.append(row);
		                });
		            }
		
		            // 프로젝트 참여인원 수 표시
		            let participantsInput = $("#projectParticipants");
		            participantsInput.val(response.length + " 명의 인원이 프로젝트에 참가중");
		
		            // 페이징 처리
		            let pagination = $("#pagination");
		            pagination.empty();
		
		            let totalPages = Math.ceil(response.length / pageSize);
		            if (totalPages > 1) {
		              let prevButton = $("<li>").addClass("page-item");
		              let prevLink = $("<a>").addClass("page-link").attr("href", "#").text("이전");
		              prevLink.on("click", function (event) {
		                event.preventDefault(); // 이벤트 기본 동작 방지
		                let currentPage = page > 1 ? page - 1 : 1;
		                getUsers(currentPage, pageSize);
		              });
		              prevButton.append(prevLink);
		              pagination.append(prevButton);
	
		              let startPage = Math.max(page - 2, 1);
		              let endPage = Math.min(page + 2, totalPages);
	
		              for (let i = startPage; i <= endPage; i++) {
		                let pageItem = $("<li>").addClass("page-item");
		                let pageLink = $("<a>").addClass("page-link").attr("href", "#").text(i);
		                if (i === page) {
		                  pageItem.addClass("active");
		                }
		                pageLink.on("click", function (event) {
		                  event.preventDefault(); // 이벤트 기본 동작 방지
		                  getUsers(i, pageSize);
		                });
		                pageItem.append(pageLink);
		                pagination.append(pageItem);
		              }
	
		              let nextButton = $("<li>").addClass("page-item");
		              let nextLink = $("<a>").addClass("page-link").attr("href", "#").text("다음");
		              nextLink.on("click", function (event) {
		                event.preventDefault(); // 이벤트 기본 동작 방지
		                let currentPage = page < totalPages ? page + 1 : totalPages;
		                getUsers(currentPage, pageSize);
		              });
		              nextButton.append(nextLink);
		              pagination.append(nextButton);
		            }
		        },
		        error: function(xhr, status, error) {
		            console.log("에러 메시지:", xhr.status);
		        }
		    });
		};


        // 프로젝트 관리자 정보 가져오기
         let getProjectManager = function() {
		     $.ajax({
		        url: "member/" + projectManagerId,
		        type: "GET",
		        contentType: "application/json",
		        success: function(response) {
		            let projectManagerName = "";
		            for (let i = 0; i < response.length; i++) {
		                if (response[i].userid == projectManagerId) {
		                    projectManagerName = response[i].name;
		                    console.log(projectManagerName);
		                }
		            }
		        },
		        error: function(xhr, status, error) {
		            console.log("에러 메시지:", xhr.status);
		        }
		    }); 
		}; 


        // 게시판 수 가져오기
        let getBoardCount = function() {
	            $.ajax({
	                url: "board/" + projectId,
	                type: "GET",
	                contentType: "application/json",
	                success: function(response) {
	                    let boardCount = response.length;
	
	                    let projectBoardCount = $("#projectBoardCount");
	                    projectBoardCount.val(boardCount + " 개의 게시판");
	                },
	                error: function(xhr, status, error) {
	                    console.log("에러 메시지:", xhr.status);
	                }
	            });
	        };
	
	        getProjectInfo();
	        getUsers(1, pageSize);
	        getProjectManager();
	        getBoardCount();
	    };

    			getUsersAndProjectInfo();
    			currentPage =1;
    	let getUsers = function(page, pageSize) {
		    $.ajax({
		        url: `member/users/${projectId}`,
		        type: "GET",
		        contentType: "application/json",
		        success: function(response) {
		            let startIndex = (page - 1) * pageSize;
		            let endIndex = startIndex + pageSize;
		            let paginatedData = response.slice(startIndex, endIndex);
		
		            let tableBody = $("#memberList");
		            tableBody.empty();
		
		            if (paginatedData.length > 0) {
		                paginatedData.forEach(function(user) {
		                    let row = $("<tr>").addClass("table-active");
		                    $("<td>").text(user.name).appendTo(row);
		                    $("<td>").text(user.userid).appendTo(row);
		                    let removeButtonCell = $("<td>");
		                    let removeButton = $("<button>").addClass("btn btn-danger deleteUsersProject").text("내보내기");
		                    removeButtonCell.append(removeButton);
		                    row.append(removeButtonCell);
		                    tableBody.append(row);
		                });
		            }
		
		            // 프로젝트 참여인원 수 표시
		            let participantsInput = $("#projectParticipants");
		            participantsInput.val(response.length + " 명의 인원이 프로젝트에 참가중");
		
		            // 페이징 처리
		            let pagination = $("#pagination");
		            pagination.empty();
		
		            let totalPages = Math.ceil(response.length / pageSize);
		            if (totalPages > 1) {
		              let prevButton = $("<li>").addClass("page-item");
		              let prevLink = $("<a>").addClass("page-link").attr("href", "#").text("이전");
		              prevLink.on("click", function (event) {
		                event.preventDefault(); // 이벤트 기본 동작 방지
		                let currentPage = page > 1 ? page - 1 : 1;
		                getUsers(currentPage, pageSize);
		              });
		              prevButton.append(prevLink);
		              pagination.append(prevButton);
	
		              let startPage = Math.max(page - 2, 1);
		              let endPage = Math.min(page + 2, totalPages);
	
		              for (let i = startPage; i <= endPage; i++) {
		                let pageItem = $("<li>").addClass("page-item");
		                let pageLink = $("<a>").addClass("page-link").attr("href", "#").text(i);
		                if (i === page) {
		                  pageItem.addClass("active");
		                }
		                pageLink.on("click", function (event) {
		                  event.preventDefault(); // 이벤트 기본 동작 방지
		                  getUsers(i, pageSize);
		                });
		                pageItem.append(pageLink);
		                pagination.append(pageItem);
		              }
	
		              let nextButton = $("<li>").addClass("page-item");
		              let nextLink = $("<a>").addClass("page-link").attr("href", "#").text("다음");
		              nextLink.on("click", function (event) {
		                event.preventDefault(); // 이벤트 기본 동작 방지
		                let currentPage = page < totalPages ? page + 1 : totalPages;
		                getUsers(currentPage, pageSize);
		              });
		              nextButton.append(nextLink);
		              pagination.append(nextButton);
		            }
		        },
		        error: function(xhr, status, error) {
		            console.log("에러 메시지:", xhr.status);
		        }
		    });
		};
		
		let getBoardCount = function() {
            $.ajax({
                url: "board/" + projectId,
                type: "GET",
                contentType: "application/json",
                success: function(response) {
                    let boardCount = response.length;

                    let projectBoardCount = $("#projectBoardCount");
                    projectBoardCount.val(boardCount + " 개의 게시판");
                    projectBoardCnt = boardCount;
                    console.log(boardCount + " / " + projectBoardCnt + "루룰루")
                },
                error: function(xhr, status, error) {
                    console.log("에러 메시지:", xhr.status);
                }
            });
        };


    	  // 프로젝트 이름 변경
    	  $("#changeProjectNameBtn").click(function() {
    	    let projectName = $("#projectName").val();

    	    $.ajax({
    	      url: "project/" + projectId + "/" + memberId,
    	      type: "PUT",
    	      contentType: "application/json",
    	      data: JSON.stringify({ projectName: projectName }),
    	      success: function() {
    	    	  Swal.fire({
  	                icon: 'success',
  	                title: '변경 성공',  	                
  	                showConfirmButton: false,
  	                timer: 1500
  	            })    	        
    	      },
    	      error: function(xhr) {
    	        console.log("에러 메시지:", xhr.status);
    	      }
    	    });
    	  });

    	  // 초대를 위한 유저 목록 가져오기
    	  $("#userSearch").keyup(function(e) {
    	    e.preventDefault();
    	    let userid = $("#userSearch").val();
    	    let url = (userid != "") ? "member/" + userid : "member";

    	    $.ajax({
    	      url: url,
    	      type: "GET",
    	      contentType: "application/json",
    	      success: function(response) {
    	        console.log("xhr 데이터")
    	        console.log(response);
    	        if (response.length > 0) {
    	          addUserToTable(response);
    	        } else {
    	          addUserToTable([]);
    	        }
    	      },
    	      error: function(xhr) {
    	        console.log("에러 메시지:", xhr.status);
    	        addUserToTable([]);
    	      }
    	    });
    	  });

			// 검색으로 받은 Users값에 따른 표시
			function addUserToTable(user) {
			  let tableBody = $("#userTableBody");
			  tableBody.empty();
			
			  if (Array.isArray(user)) {
			    for (let i = 0; i < user.length; i++) {
			      let currentUser = user[i];
			      let row = $("<tr>");
			
			      let nameCell = $("<td>").text(currentUser.name);
			      row.append(nameCell);
			
			      let userIdCell = $("<td>").text(currentUser.userid);
			      row.append(userIdCell);
			
			      let hasMatch = false;
			      $.ajax({
			        url: "member/users/" + projectId,
			        type: "GET",
			        contentType: "application/json",
			        success: function(response) {
			          for (let j = 0; j < response.length; j++) {
			            if (response[j].userid === currentUser.userid) {
			              hasMatch = true;
			              break;
			            }
			          }
			          if (!hasMatch) {
			            let inviteButtonCell = $("<td>");
			            let inviteButton = $("<a>").addClass("btn btn-outline-primary userInvite").text("초대");
			            inviteButtonCell.append(inviteButton);
			            row.append(inviteButtonCell);
			          } else {
			            let notAvailableCell = $("<td>").text("초대 불가").css("color", "red");
			            row.append(notAvailableCell);
			          }
			          tableBody.append(row);
			        },
			        error: function(xhr, status, error) {
			          console.log("에러 메시지:", xhr.status);
			        }
			      });
			    }
			  } else {
			    if (user.userid == null) {
			      tableBody.text("검색 결과가 없습니다.");
			    } else {
			      if (user.userid !== "") {
			        let row = $("<tr>");
			
			        let nameCell = $("<td>").text(user.name);
			        row.append(nameCell);
			
			        let userIdCell = $("<td>").text(user.userid);
			        row.append(userIdCell);
			
			        let hasMatch = false;
			        $.ajax({
			          url: "member/users/" + projectId,
			          type: "GET",
			          contentType: "application/json",
			          success: function(response) {
			            for (let i = 0; i < response.length; i++) {
			              if (response[i].userid === user.userid) {
			                hasMatch = true;
			                break;
			              }
			            }
			            if (!hasMatch) {
			              let inviteButtonCell = $("<td>");
			              let inviteButton = $("<a>").addClass("btn btn-outline-primary userInvite").text("초대");
			              inviteButtonCell.append(inviteButton);
			              row.append(inviteButtonCell);
			            } else {
			              let notAvailableCell = $("<td>").text("초대 불가").css("color", "red");
			              row.append(notAvailableCell);
			            }
			            tableBody.append(row);
			          },
			          error: function(xhr, status, error) {
			            console.log("에러 메시지:", xhr.status);
			          }
			        });
			      }
			    }
			  }
			}




    	 	//초대하기 기능
			$(document).on("click", ".userInvite", function(e) {
			    e.preventDefault();
			    
			    let tableBody = $(this).closest("tr");
			    let userId = tableBody.find("td:nth-child(2)").text();
			    let usersProject = {
			        projectId: projectId,
			        userid: userId
			    };
			    
			    $.ajax({
			        url: "project/" + userId,
			        type: "GET",
			        contentType: "application/json",
			        success: function(response) {			            
			            $.ajax({
			                url: "project/" + projectId + "/" + userId,
			                type: "POST",
			                contentType: "application/json",
			                data: JSON.stringify(usersProject),
			                success: function() {
			                    console.log("초대");
			                    tableBody.remove();
			                    Swal.fire({
			    	                icon: 'success',
			    	                title: '초대완료',
			    	                showConfirmButton: false,
			    	                timer: 1000
			    	            })
			                    updateProjectParticipantsAsync();
			                    getUsers(currentPage, pageSize); // 페이징 처리 유지
			                },
			                error: function(xhr) {
			                    console.log("에러 메시지:", xhr.status);
			                    Swal.fire({
			    	                icon: 'error',
			    	                title: '에러 발생',
			    	                text: xhr.responseText,
			    	                showConfirmButton: false,
			    	                timer: 1500
			    	            })
			                }
			            });
			        },
			        error: function(xhr, status, error) {
			        	Swal.fire({
	    	                icon: 'error',
	    	                title: '업로드 실패',
	    	                text: xhr.responseText,
	    	                showConfirmButton: false,
	    	                timer: 1500
	    	            })
			        }
			    });
			});

 
    	  // 초대한 유저 참가자에 비동기적 추가
    	  async function updateProjectParticipantsAsync() {
    	    try {
    	      $.ajax({
    	        url: "member/users/" + projectId,
    	        type: "GET",
    	        contentType: "application/json",
    	        success: function(response) {
    	          let tableBody = $("#memberList");
    	          tableBody.empty();

    	          response.forEach(function(user) {
    	            let row = $("<tr>").addClass("table-active");

    	            let nameCell = $("<td>").text(user.name);
    	            row.append(nameCell);

    	            let userIdCell = $("<td>").text(user.userid);
    	            row.append(userIdCell);

    	            let removeButtonCell = $("<td>");
    	            let removeButton = $("<button>").addClass("btn btn-danger deleteUsersProject").text("내보내기");
    	            removeButtonCell.append(removeButton);
    	            row.append(removeButtonCell);

    	            tableBody.append(row);
    	          });

    	          // 프로젝트 참여인원 수 업데이트
    	          let participantsInput = $("#projectParticipants");
    	          participantsInput.val(response.length + " 명의 인원이 프로젝트에 참가중");

    	        },
    	        error: function(xhr) {
    	          console.log("에러 메시지:", xhr.status);
    	        }
    	      });
    	    } catch (error) {
    	      console.log("에러 메시지:", error);
    	    }
    	  }
    	  
    	  //모달창
    	  	function modalOn() {
    		     modal.style.display = "flex"
    		 }
    		 function isModalOn() {
    		     return modal.style.display === "flex"
    		 }
    		 function modalOff() {
    		     modal.style.display = "none"
    		 }
    		 const btnModal = document.getElementById("boardCreateBtn")
    		 btnModal.addEventListener("click", e => {
    		     modalOn()
    		 })
    		 const closeBtn = modal.querySelector(".close-area")
    		 closeBtn.addEventListener("click", e => {
    		     modalOff()
    		 })
    		 modal.addEventListener("click", e => {
    		     const evTarget = e.target
    		     if(evTarget.classList.contains("modal-overlay")) {
    		         modalOff()
    		     }
    		 })
    		 window.addEventListener("keyup", e => {
    		     if(isModalOn() && e.key === "Escape") {
    		         modalOff()
    		     }
   		 	}) 
   		 

   		 	//현소현
			$('#projectImageInsertBtn').click(function() {
				  var fileInput = document.getElementById('projectMainImage');
				  var file = fileInput.files[0];
				  
				  if (!file) {
					  Swal.fire({
	    	                icon: 'error',
	    	                title: '파일을 선택해주세요',
	    	                showConfirmButton: false,
	    	                timer: 3000
	    	            })
				    return;
				  }

				  var formData = new FormData();
				  formData.append('uploadFile', file);

				  console.log(file);
				  console.log(formData);

				  $.ajax({
				    url: "${pageContext.request.contextPath}/file/projectimg/upload",
				    type: "POST",
				    contentType: false,
				    processData: false,
				    data: formData,
				    success: function(response) {				      
				       $.ajax({
			    	      url: "project/projectImg/" + projectId, 
			    	      type: "PUT",
			    	      contentType: "application/json",
			    	      data: JSON.stringify({ projectImage : projectId + file.name }),
			    	      success: function() {
			    	    	  Swal.fire({
			    	                icon: 'success',
			    	                title: '변경완료',
			    	                showConfirmButton: false,
			    	                timer: 1000
			    	            })
			    	      },
			    	      error: function(xhr) {
			    	        console.log("에러 메시지:", xhr.status);
			    	      }
			    	    }); 
				      var encodedFileName = encodeURIComponent(file.name); // 파일 이름 인코딩
				      var imageUrl = "../resource/projectimg/" + projectId + encodedFileName; // 이미지 경로
				      console.log(imageUrl);
				      $('#projectMainImage2').attr('src', imageUrl)
                      .css('width', '100%')
                      .css('height', 'auto'); 
				    },
				    error: function(xhr, status, error) {
				    	Swal.fire({
	    	                icon: 'error',
	    	                title: '업로드 실패',
	    	                text: xhr.responseText,
	    	                showConfirmButton: false,
	    	                timer: 3000
	    	            })				      
				      return;
				    }
				  });
				});

    		 //프로젝트 생성
    		 $('#boardInsertBtn').click(function() {
   			  let boardName = $('#boardInsertName').val();
   			  let getBoardCountSuper = $("#projectBoardCount").val();
   			  let boardCount = getBoardCountSuper.substring(0, getBoardCountSuper.indexOf(' '));
				
	   			if (boardCount >= 10) {
	   				Swal.fire({
    	                icon: 'error',
    	                title: '생성 오류',
    	                text: '게시판은 최대 10개까지만 생성가능합니다',
    	                showConfirmButton: false,
    	                timer: 3000
    	            })				    
				    $("#modal").css("display", "none");
				    return;
				  } else {
				    let boardData = {
				      projectId: projectId,
				      boardName: boardName
				    };
				    
				    // 서버로 AJAX POST 요청 보내기
				    $.ajax({
				      url: '/board',
				      type: 'POST',
				      contentType: 'application/json',
				      data: JSON.stringify(boardData),
				      success: function() {
				        getBoardCount();
				        console.log('게시판이 성공적으로 추가되었습니다.');
				        Swal.fire({
	    	                icon: 'success',
	    	                title: '생성 완료',	    	                
	    	                showConfirmButton: false,
	    	                timer: 1000
	    	            })
				        $("#modal").css("display", "none");
				        
				        // 추가 요청을 보내는 부분
				        $.ajax({
				          url: '/projectDetail.do/' + projectId,
				          type: 'GET',
				          success: function() {
				            console.log('프로젝트 상세 정보를 성공적으로 가져왔습니다.');
							window.location.reload();
				          },
				          error: function() {
				            console.log('프로젝트 상세 정보 가져오기에 실패했습니다.');
				          }
				        });
				      },
				      error: function() {
				        console.log('게시판 추가에 실패했습니다.');
				        Swal.fire({
	    	                icon: 'error',
	    	                title: '생성 실패',
	    	                text: xhr.responseText,
	    	                showConfirmButton: false,
	    	                timer: 3000
	    	            })
				        $("#modal").css("display", "none");
				      }
				    });
				  }
				});


    	  // 참가자 내쫓아 버리기
    	  $(document).on("click", ".deleteUsersProject", function(e) {
			  console.log("삭제버튼을 누름");
			  e.preventDefault();
			
			  let userId = $(this).closest("tr").find("td:nth-child(2)").text();
			  let usersProject = {
			    projectId: projectId,
			    userid: userId
			  };
			
			  console.log("userID ::" +userId);
			  console.log("memberID ::" +memberId);
			
			  let deleteButton = $(this);
			  if (userId == memberId) {
				  Swal.fire({
  	                icon: 'error',
  	                title: '내보내기 실패',
  	                text: '사유 : 관리자',
  	                showConfirmButton: false,
  	                timer: 3000
  	            })
			    return;
			  }
			
			  $.ajax({
			    url: "project/" + projectId + "/" + userId,
			    type: "DELETE",
			    contentType: "application/json",
			    data: JSON.stringify(usersProject),
			    success: function() {
			      console.log("삭제");
			      deleteButton.closest("tr").remove();
			      Swal.fire({
  	                icon: 'success',
  	                title: '내보내기 완료',  	                
  	                showConfirmButton: false,
  	                timer: 1000
  	            })
			      updateProjectParticipantsAsync();
			      addUserToTable([]);
			      getUsers(currentPage, pageSize); // 페이징 처리 유지
			      
			    },
			    error: function(xhr) {
			      console.log("에러 메시지:", xhr.status);
			    }
			  });
			});
    	  
    	  // 프로젝트 삭제 (미완)
    	  $("#projectDelteBtn").click(function() {
  		    console.log("프로젝트 삭제 버튼을 누름");

  		    $.ajax({
  		        url: "project/delete/" + projectId,
  		        type: "DELETE",
  		        contentType: "application/json",
  		        success: function() {
  		            console.log("프로젝트 삭제");
	  		          Swal.fire({
	  	                icon: 'success',
	  	                title: '삭제 완료',	  	                
	  	                showConfirmButton: false,
	  	                timer: 2000
	  	            })
  		             $.ajax({
				          url: '/projectDetail.do',
				          type: 'GET',
				          success: function() {
				            console.log('프로젝트 상세 정보를 성공적으로 가져왔습니다.');
							window.location.reload();
				          },
				          error: function() {
				            console.log('프로젝트 상세 정보 가져오기에 실패했습니다.');
				          }
				        }); 
							location.href = "/projectList.do";
  		        },
  		        error: function(xhr) {
  		            console.log("에러 메시지:", xhr.status);
  		        }
  		    });
  		}); 
    	  


		}); 
</script>

<body class="sb-nav-fixed">
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div id="layoutSidenav">
		<%@ include file="/WEB-INF/views/common/sidenav.jsp"%>
		<div id="layoutSidenav_content">
			<main>
				<div class="projectManagementTitle">
					<h1>프로젝트 관리자</h1>
				</div>

				<div class="projectinfo-container">
					<div class="card projectinfo">
						<div class="card-header projectinfo-header">
							<span class="sub-title-text">프로젝트 정보</span>
						</div>
						
						<div class="card-body d-flex">
							<div class="project-info-box">
								<div class="d-flex">
									<div class="project-input-name">
										<label class="form-label mt-1">프로젝트 이름</label>
									</div>
									<div class="form-group project-input">
										<div class="d-flex">
											<input type="text" class="form-control" id="projectName">
											<button type="button" class="btn btn-primary ml-2" id="changeProjectNameBtn">이름변경</button>
										</div>
									</div>
								</div>

								<hr class="hr">

								<div class="d-flex mt-3">
									<div class="project-input-name">
										<label class="form-label">프로젝트 참여인원</label>
									</div>
									<div class="form-group project-input ml-2">
										<input type="text" class="form-control" id="projectParticipants" disabled>
									</div>
								</div>

								<div class="d-flex mt-3">
									<div class="project-input-name">
										<label class="form-label">관리자 이름</label>
									</div>
									<div class="form-group project-input ml-2">
										<input type="text" class="form-control" id="projectManagerName" disabled>
									</div>
								</div>

								<div class="d-flex mt-3">
									<div class="project-input-name">
										<label class="form-label">관리자 ID</label>
									</div>
									<div class="form-group project-input ml-2">
										<input type="text" class="form-control" id="projectManagerId" disabled>
									</div>
								</div>

								<div class="d-flex mt-3">
									<div class="project-input-name">
										<label class="form-label">게시판 개수</label>
									</div>
									<div class="form-group project-input ml-2">
										<input type="text" class="form-control" id="projectBoardCount" disabled>
									</div>
								</div>

								<hr class="hr2">

								<button type="button" class="btn btn-primary projectDelteBtn float-right mt-3" id="boardCreateBtn">게시판 생성</button>
								<button type="button" class="btn btn-danger projectDelteBtn float-right mt-3" id="projectDelteBtn">프로젝트 삭제</button>
							</div>

							<div id="rightSideDiv">
								<div id="projectImg" class="text-center">
									<label class="form-label mt-1 projectImgLabel">프로젝트 이미지</label>
								</div>
								<div class="text-center">
									<img src="/resource/projectimg/${project.projectImage} " id="projectMainImage2" class="img-fluid img-fixed-size" style="width: 100%; height: auto;">
								</div>
								<div>
									<!--프로필사진파일 업로드 -->
									<div class="form-group">

										<input type="file" class="form-control float" id="projectMainImage" value="${project.projectImage}">
										<button type="button" id="projectImageInsertBtn" class="btn btn-primary mt-3 float-end">이미지 변경</button>

									</div>
								</div>
							</div>

						</div>
					</div>
				</div>

				<div class="projectinfo-container2">
					<div class="card mb-3 projectinfo projectMemberManagement">
						<div class="card-header projectinfo-header">
							<span class="sub-title-text">프로젝트 참가자</span>
						</div>
						<div class="card-body">
							<div class="form-group table-size">
								<table class="table table-hover" id="projectMemberTable">
									<thead>
										<tr>
											<th scope="col">이름</th>
											<th scope="col">아이디</th>
											<th scope="col">내보내기</th>
										</tr>
									</thead>
									<tbody id="memberList"></tbody>
								</table>
							</div>
							<div id="paginationContainer">
								<ul class="pagination justify-content-center" id="pagination"></ul>
							</div>
						</div>
					</div>

					<div class="card mb-3 projectinfo projectMemberManagement2">
						<div class="card-header projectinfo-header">
							<span class="sub-title-text">참가자 초대하기</span>
						</div>
						<div class="card-body">
							<form class="d-flex">
								<input class="form-control me-sm-2" type="search" placeholder="ID 검색" id="userSearch">
							</form>
							<table class="table table-hover table-title">
								<thead>
									<tr>
										<th scope="col">이름</th>
										<th scope="col">아이디</th>
										<th scope="col">초대</th>
									</tr>
								</thead>
							</table>
							<div class="table-wrapper">
								<table class="table table-hover">
									<tbody id="userTableBody">
										<!-- 페이징 처리로 동적으로 추가될 내용 -->
									</tbody>
								</table>
							</div>							
						</div>
					</div>
					
				</div>
			</div>
		</div>
	</main>

		
	</div>
	</div>
	<div id="modal" class="modal-overlay" style="display: none;">
		<div class="modal-window">
			<div class="title">
				<h2>게시판 생성</h2>
			</div>
			<hr class="hr3">
			<div class="close-area">X</div>
			<div class="content">
				<label class="form-label mt-1">게시판 이름</label>
			</div>
			<div class="form-group">
				<div class="d-flex">
					<input type="text" class="form-control-board" id="boardInsertName">
					<button type="button" class="btn btn-primary ml-2" id="boardInsertBtn">게시판 생성</button>
				</div>
			</div>
		</div>
	</div>
</body>



