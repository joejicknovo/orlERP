 var bs = zsi.bs.ctrl;
var svn =  zsi.setValIfNull;
zsi.ready(function(){
   displayRecords();
});
$("#btnSave").click(function () {
    $("#grid").jsonSubmit({
        procedure: "role_menus_upd"
        ,optionalItems: ["is_new","is_write","is_delete"]
        ,onComplete: function (data) {
            $("#grid").clearGrid(); 
            displayRecords();
        }
    });
    
});
    
function displayRecords(){   
    var cb = bs({name:"cbFilter1",type:"checkbox"});
         $("#grid").dataBind({
	     url            : execURL + "role_menus_sel"
	    ,width          : 1290
	    ,height         : $(document).height() - 250
	    //,selectorType   : "checkbox"
        ,blankRowsLimit:5
        ,isPaging : false
        ,dataRows : [
                 {text  : cb                                                , type  : "hidden"      , width : 25        , style : "text-align:left;"       
        		    , onRender      :  function(d){ 
                		                   return     bs({name:"role_menu_id",type:"hidden",value: svn (d,"role_menu_id")})
                                                    +  (d !==null ? bs({name:"cb",type:"checkbox"}) : "" );
                            }
                 }	 
        		,{text  : "Role Name"           , name  : "role_id"         , type  : "select"      , width : 100       , style : "text-align:left;"}
        		,{text  : "Menu Name"           , name  : "menu_id"         , type  : "select"      , width : 200       , style : "text-align:left;"}
        		,{text  : "New?"                , name  : "is_new"          , type  : "yesno"       , width : 50       , style : "text-align:left;"}
        		,{text  : "Write?"              , name  : "is_write"        , type  : "yesno"       , width : 50       , style : "text-align:left;"}
        		,{text  : "Delete"              , name  : "is_delete"       , type  : "yesno"       , width : 50       , style : "text-align:left;"}
	    ]
	    ,onComplete:function(){
	        $("select[name='role_id']").dataBind( "roles");
            $("select[name='menu_id']").dataBind( "menus");
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