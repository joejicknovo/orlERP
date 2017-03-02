var bs = zsi.bs.ctrl;
var svn =  zsi.setValIfNull;

zsi.ready(function(){
    displayRecords();
});

$("#btnSave").click(function () {
    $("#grid").jsonSubmit({
              procedure  : "position_upd"
              ,optionalItems : ["department_id","is_active"]
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
	     url            : execURL + "position_sel"
	    ,width          : 950
	    ,height         : 506
	    //,selectorType   : "checkbox"
        ,blankRowsLimit:5
        ,isPaging : false
        ,dataRows : [
    		    { text      : cb                  
    		     ,width     : 25            
    		     ,style     : "text-align:left;"       
                 ,onRender  :  function(d){ 
                		                    return bs({ name:"position_id"   
                		                               ,value: svn (d,"position_id")    
                		                               ,type:"hidden"})
                		                    +  (d !==null ? bs({name:"cb",type:"checkbox"}) : "" );
                               }
                },	 
                { text          :"Code"           
                 ,name          :"position_code"     
                 ,type          :"input"
                 ,width         :100     
                 ,style         :"text-align:center;"
            	},
            	{ text          :"Position"           
                 ,name          :"position_name"     
                 ,type          :"input"
                 ,width         :200     
                 ,style         :"text-align:center;"
            	},
            	{ text          :"Job Description"    
            	 ,name          :"job_description"   
            	 ,type          :"input"
            	 ,width         :300     
            	 ,style         :"text-align:center;"
            	},
            	{ text          :"Department"    
            	 ,name          :"department_id"   
            	 ,type          :"select"
            	 ,width         :200     
            	 ,style         :"text-align:center;"
            	},
            	{ text          :"Active?"            
            	 ,name          :"is_active"         
            	 ,type          :"yesno"
            	 ,width         :100     
            	 ,style         :"text-align:center;"
            	 ,defaultValue  :"Y"
            	}
	    ]
	    ,onComplete:function(){
	          $("select[name='department_id']").dataBind("department");
	    }
    });    
}

             