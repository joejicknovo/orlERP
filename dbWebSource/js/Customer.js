var bs = zsi.bs.ctrl;
var svn =  zsi.setValIfNull;

zsi.ready(function(){
   displayRecords();
});

$("#btnSave").click(function () {
    $("#grid").jsonSubmit({
        procedure: "customer_upd"
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
	     url            : execURL + "customer_sel"
	    ,width          : 1650
	    ,height         : $(document).height() - 250
	    //,selectorType   : "checkbox"
        ,blankRowsLimit:5
        ,isPaging : false
        ,dataRows : [
                 {text  : cb                                                , width : 25        , style : "text-align:left;"       
        		    , onRender      :  function(d){ 
                		                   return     bs({name:"customer_id", value: svn (d,"customer_id"), type:"hidden"})
                		                           +  (d !==null ? bs({name:"cb",type:"checkbox"}) : "" );
                            }
            }	 
        		,{text  : "Code"            , name  : "customer_code"        , type  : "input"       , width : 100       , style : "text-align:left;"}
        		,{text  : "Name"            , name  : "customer_name"        , type  : "input"       , width : 300       , style : "text-align:left;"}
        		,{text  : "Contact Person"  , name  : "contact_person"       , type  : "input"       , width : 300       , style : "text-align:left;"}
        		,{text  : "Address"         , name  : "address"              , type  : "input"       , width : 300       , style : "text-align:left;"}
        		,{text  : "Mobile No."      , name  : "mobile_no"            , type  : "input"       , width : 100       , style : "text-align:left;"}
        		,{text  : "Fox No."         , name  : "fox_no"               , type  : "input"       , width : 100       , style : "text-align:left;"}
        		,{text  : "Office No."      , name  : "office_no"            , type  : "input"       , width : 100       , style : "text-align:left;"}
        		,{text  : "Email Address"   , name  : "email_address"        , type  : "input"       , width : 200       , style : "text-align:left;"}
        		,{text  : "Active?"         , name  : "is_active"            , type  : "yesno"       , width : 100       , style : "text-align:left;" , defaultValue:"Y" }
        
	    ]
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
