 var bs = zsi.bs.ctrl;
var svn =  zsi.setValIfNull;
zsi.ready(function(){
   displayRecords();
});
$("#btnSave").click(function () {
    $("#grid").jsonSubmit({
        procedure: "project_upd"
        ,optionalItems: ["site_id","manager_id","supervisor_id","status_id"]
        ,onComplete: function (data) {
            $("#grid").clearGrid(); 
            displayRecords();
        }
    });
    
});
    
function displayRecords(){   
    var cb = bs({name:"cbFilter1",type:"checkbox"});
         $("#grid").dataBind({
	     url            : execURL + "project_sel"
	    ,width          : 1290
	    ,height         : $(document).height() - 250
	    //,selectorType   : "checkbox"
        ,blankRowsLimit:5
        ,isPaging : false
        ,dataRows : [
                 {text  : cb                                                , type  : "hidden"      , width : 25        , style : "text-align:left;"       
        		    , onRender      :  function(d){ 
                		                   return     bs({name:"project_id",type:"hidden",value: svn (d,"project_id")})
                                                    +  (d !==null ? bs({name:"cb",type:"checkbox"}) : "" );
                            }
            }	 
        		,{text  : "Code "           , name  : "project_code"          , type  : "input"       , width : 100       , style : "text-align:left;"}
        		,{text  : "Name"            , name  : "project_name"          , type  : "input"       , width : 200       , style : "text-align:left;"}
        		,{text  : "Site"            , name  : "site_id"               , type  : "select"      , width : 200       , style : "text-align:left;"}
        		,{text  : "Start Date"      , name  : "start_date"            , type  : "input"       , width : 100       , style : "text-align:left;"}
        		,{text  : "Completion Date" , name  : "target_end_date"       , type  : "input"       , width : 130       , style : "text-align:left;"}
        		,{text  : "Manager"         , name  : "manager_id"            , type  : "select"      , width : 180       , style : "text-align:left;"}
        		,{text  : "Supervisor"      , name  : "supervisor_id"         , type  : "select"      , width : 180       , style : "text-align:left;"}
        		,{text  : "Status"          , name  : "status_id"             , type  : "select"      , width : 100       , style : "text-align:left;"}
        
	    ]
	    ,onComplete:function(){
	          $("select[name='project_site_id']").dataBind("project_site");
	          $("select[name='manager_id']").dataBind("employee");
	          $("select[name='supervisor_id']").dataBind("employee");
	          $("select[name='status_id']").dataBind("status");
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