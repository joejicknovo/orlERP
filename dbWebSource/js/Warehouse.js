var bs = zsi.bs.ctrl;
var svn =  zsi.setValIfNull;

zsi.ready(function(){
   displayRecords();
});

$("#btnSave").click(function () {
    $("#grid").jsonSubmit({
        procedure: "warehouse_upd"
        ,optionalItems: ["is_active"]
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
	     url            : execURL + "warehouse_sel"
	    ,width          : 1250
	    ,height         : $(document).height() - 250
	    //,selectorType   : "checkbox"
        ,blankRowsLimit:5
        ,isPaging : false
        ,dataRows : [
                 {text  : cb                                                , width : 25        , style : "text-align:left;"       
        		    , onRender      :  function(d){ 
                		                   return     bs({name:"warehouse_id", value: svn (d,"warehouse_id"), type:"hidden"})
                		                           +  (d !==null ? bs({name:"cb",type:"checkbox"}) : "" );
                            }
            }	 
        		,{text  : "Code"            , name  : "warehouse_code"                  , type  : "input"       , width : 100       , style : "text-align:left;"}
        		,{text  : "Name"            , name  : "warehouse_name"                  , type  : "input"       , width : 200       , style : "text-align:left;"}
        		,{text  : "Location"        , name  : "warehouse_location"              , type  : "input"       , width : 200       , style : "text-align:left;"}
        		,{text  : "Address"         , name  : "warehouse_address"               , type  : "input"       , width : 300       , style : "text-align:left;"}
        		,{text  : "Contact No."     , name  : "warehouse_contact_no"            , type  : "input"       , width : 100       , style : "text-align:left;"}
        		,{text  : "Contact Person"  , name  : "warehouse_contact_person_id"     , type  : "select"      , width : 200       , style : "text-align:left;"}
        		,{text  : "Active?"         , name  : "is_active"                       , type  : "yesno"       , width : 100       , style : "text-align:left;" , defaultValue:"Y" }
        
	    ]
	    ,onComplete:function(){
	          $("select[name='warehouse_contact_person_id']").dataBind("employees");
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