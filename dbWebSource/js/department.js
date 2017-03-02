var bs = zsi.bs.ctrl;
var svn =  zsi.setValIfNull;


zsi.ready(function(){
    displayRecords();
});

$("#btnSave").click(function () {
    $("#grid").jsonSubmit({
              procedure  : "department_upd"
             ,optionalItems: ["department_head_id","is_active"]
             ,onComplete : function (data) {
                  $("#grid").clearGrid();
                  if(data.isSuccess===true) zsi.form.showAlert("alert");
                  displayRecords();
             }
        });    
});



 function displayRecords(){   
      var cb = bs({name:"cbFilter1",type:"checkbox"});
     $("#grid").dataBind({
	     url            : execURL + "department_sel"
	    ,width          : 650
	    ,height         : 506
	    //,selectorType   : "checkbox"
        ,blankRowsLimit:5
        ,isPaging : false
        ,dataRows : [
    	
    		   {text  : cb                                 , width : 25        , style : "text-align:left;"       
            		    , onRender      :  function(d){ 
                		              return bs({name:"department_id"   ,value: svn (d,"department_id")    ,type:"hidden"})
                		                 +  (d !==null ? bs({name:"cb",type:"checkbox"}) : "" );
                    }
                }	 
            	,{ text:"Code"      ,name:"department_code"      ,type:"input"      ,width:100       ,style:"text-align:center;"}
            	,{ text:"Name"      ,name:"department_name"      ,type:"input"      ,width:200       ,style:"text-align:center;"}
            	,{ text:"Head"      ,name:"department_head_id"   ,type:"select"     ,width:200       ,style:"text-align:center;"}
            	,{ text:"Active?"   ,name:"is_active"            ,type:"yesno"      ,width:100       ,style:"text-align:center;"    ,defaultValue:"Y"}
	    ]
	    ,onComplete:function(){
	          $("select[name='department_head_id']").dataBind("department_manager");
	    }
    });    
}

           