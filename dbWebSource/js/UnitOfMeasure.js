var bs = zsi.bs.ctrl;
var svn =  zsi.setValIfNull;

zsi.ready(function(){
   displayRecords();
});

$("#btnSave").click(function () {
    $("#grid").jsonSubmit({
        procedure: "unit_of_measure_upd"
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
	     url            : execURL + "unit_of_measure_sel"
	    ,width          : 550
	    ,height         : $(document).height() - 250
	    //,selectorType   : "checkbox"
        ,blankRowsLimit:5
        ,isPaging : false
        ,dataRows : [
                 {text  : cb                                                , width : 25        , style : "text-align:left;"       
        		    , onRender      :  function(d){ 
                		                   return     bs({name:"unit_of_measure_id", value: svn (d,"unit_of_measure_id"), type:"hidden"})
                		                           +  (d !==null ? bs({name:"cb",type:"checkbox"}) : "" );
                            }
            }	 
        		,{text  : "Code"            , name  : "unit_of_measure_code"        , type  : "input"       , width : 100       , style : "text-align:left;"}
        		,{text  : "Name"            , name  : "unit_of_measure_name"        , type  : "input"       , width : 300       , style : "text-align:left;"}
        		,{text  : "Active?"         , name  : "is_active"                   , type  : "yesno"       , width : 100       , style : "text-align:left;" , defaultValue:"Y" }
        
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