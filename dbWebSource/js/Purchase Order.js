 var bs = zsi.bs.ctrl
    ,svn =  zsi.setValIfNull
    ,wrapSD = "<div class='input-group date'>"
    ,wrapED = "</div>";
zsi.ready(function(){
   displayRecords();
});
$("#btnSave").click(function () {
    $("#grid").jsonSubmit({
        procedure: "status_upd"
        ,optionalItems: ["status_category_id","is_active"]
        ,onComplete: function (data) {
            $("#grid").clearGrid(); 
            displayRecords();
        }
    });
    
});
    
function displayRecords(){   
    var cb = bs({name:"cbFilter1",type:"checkbox"});
         $("#grid").dataBind({
	     url            : execURL + "purchase_order_sel"
	    ,width          : 1100
	    ,height         : $(document).height() - 250
	    //,selectorType   : "checkbox"
        ,blankRowsLimit:5
        ,isPaging : false
        ,dataRows : [
                 {text  : cb    , type  : "hidden"      , width : 25        , style : "text-align:left;"       
        		    , onRender      :  function(d){ 
		                   return     bs({name:"status_id",type:"hidden",value: svn (d,"status_id")})
                                    +  (d !==null ? bs({name:"cb",type:"checkbox"}) : "" );
                            }
            }	 
        		,{text  : "P.O. #"      , name  : "purchase_order_id"           , type  : "input"       , width : 60        , style : "text-align:left;"}
        		,{text  : "MRS No."     , name  : "mrs_id"                      , type  : "select"      , width : 150       , style : "text-align:left;"}
        		,{text  : "P.O. Date"                                                                   , width : 170       , style : "text-align:left;"
        		    , onRender      : function(d){
        		            return wrapSD + bs({name:"po_datetime",value: svn(d,"po_datetime").toDateFormat()}) + wrapED;
        		    }
        		}
                ,{text  : "Project"     , name  : "project_id"                  , type  : "select"      , width : 250       , style : "text-align:left;"}
                ,{text  : "Status"      , name  : "status_id"                   , type  : "select"      , width : 200       , style : "text-align:left;"}
                ,{text  : "Action"      , name  : "action"                      , type  : "input"       , width : 200       , style : "text-align:left;"}
	    ]
	    ,onComplete:function(){
	            zsi.initDatePicker();
	            $("select[name='status_id']").dataBind("status_po_filter");
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