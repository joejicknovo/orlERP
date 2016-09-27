var bs = zsi.bs.ctrl
    ,svn =  zsi.setValIfNull
    ,wrapSD = "<div class='input-group date'>"
    ,wrapED = "</div>"
    ,genderTypes = [ 
            {text:"Male",value:"M"}
            ,{text:"Female",value:"F"}
        ];
zsi.ready(function(){
   displayRecords();
});
$("#btnSave").click(function () {
    $("#grid").jsonSubmit({
        procedure: "employee_upd"
        ,optionalItems: ["employee_birth_date", "date_hired", "termination_date", "position_id", "user_id", "status_id"]
        ,onComplete: function (data) {
            $("#grid").clearGrid(); 
            if(data.isSuccess===true) zsi.form.showAlert("alert");
            displayRecords();
        }
    });
    
});
    
function displayRecords(){   
    var cb = bs({name:"cbFilter1",type:"checkbox"});
         $("#grid").dataBind({
	     url            : execURL + "employee_sel"
	    ,width          : 1250
	    ,height         : $(document).height() - 250
	    //,selectorType   : "checkbox"
        ,blankRowsLimit: 5
        ,isPaging : false
        ,dataRows : [
                 {text  : cb                                                , type  : "hidden"      , width : 25        , style : "text-align:left;"       
        		    , onRender      :  function(d){ 
                		                   return     bs({name:"employee_id", value: svn (d,"employee_id"), type:"hidden"})
                                                    +  (d !==null ? bs({name:"cb",type:"checkbox"}) : "" );
                            }
            }	 
            	,{text  : "First Name"      , name  : "employee_first_name"     , type  : "input"       , width : 100       , style : "text-align:left;"}
            	,{text  : "Middle Name"     , name  : "employee_middle_name"    , type  : "input"       , width : 100       , style : "text-align:left;"}
            	,{text  : "Last Name"       , name  : "employee_last_name"      , type  : "input"       , width : 100       , style : "text-align:left;"}
            	,{text  : "Gender"          , name  : "employee_gender"         , type  : "select"      , width : 75       , style : "text-align:left;"}
            	,{text  : "Birth Date"                                                                  , width : 100       , style : "text-align:left;"
        		    , onRender      : function(d){
        		            return wrapSD + bs({name:"employee_birth_date",value: svn(d,"employee_birth_date").toDateFormat()}) + wrapED;
        		    }
        		}
        		,{text  : "Hired Date"                                                                  , width : 100       , style : "text-align:left;"
        		    , onRender      : function(d){
        		            return wrapSD + bs({name:"date_hired",value: svn(d,"date_hired").toDateFormat()}) + wrapED;
        		    }
        		}
        		,{text  : "Termination"                                                                 , width : 100       , style : "text-align:left;"
        		    , onRender      : function(d){
        		            return wrapSD + bs({name:"termination_date",value: svn(d,"termination_date").toDateFormat()}) + wrapED;
        		    }
        		}
        	    ,{text  : "Position"        , name  : "position_id"             , type  : "select"      , width : 150       , style : "text-align:left;"}
        	    ,{text  : "Username"        , name  : "user_id"                 , type  : "select"      , width : 100       , style : "text-align:left;"}
        	    ,{text  : "Note"            , name  : "note"                    , type  : "input"       , width : 150       , style : "text-align:left;"}
        		,{text  : "Status"          , name  : "status_id"               , type  : "select"      , width : 100       , style : "text-align:left;"}
        
	    ]
	    ,onComplete:function(){
	            zsi.initDatePicker();
	            $("#grid").find("select[name='employee_gender']").fillSelect({data: genderTypes});
	            $("select[name='position_id']").dataBind("status_position_filter"); 
	            $("select[name='user_id']").dataBind("users"); 
	            $("select[name='status_id']").dataBind("employment_status_filter");
	    }
    });    
}
/*$("#btnDelete").click(function(){
    zsi.form.deleteData({
         code       : "sys-0002"
        ,onComplete : function(data){
                        displayRecords();
                      }
    });      
});*/                