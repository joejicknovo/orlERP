var  bs                   = zsi.bs.ctrl
    ,tblName              = "tblProductSearchDetail"
    ,tblImageView         = "tblImageView"
    ,svn                  =  zsi.setValIfNull
    ,modalImageUser       = "modalWindowImageUser"
    ,product_id_param     = null
    ,product_code_param   = null;

zsi.ready(function(){
    displayRecords();
    getTemplate();
    getImageView();
});

function getTemplate(){
    $.get(base_url + "templates/bsDialogBox.txt",function(d){
        var template = Handlebars.compile(d);     
        
        var context = { id:"modalWindow1"
                        , title: "Product Search Details" 
                        , sizeAttr: "modal-lg"
                        //, footer:  ' <div class="pull-left"><button type="button" onclick="submitItems();" class="btn btn-primary"><span class="glyphicon glyphicon-floppy-disk"></span> Save</button></div>'
                        , body: 
                        
                        '<div><div id="' + tblName + '" class="zGrid"></div></div>'
                      };
        var html    = template(context);     
        $("body").append(html);
    });    
}

function getImageView(){
    $.get(base_url + "templates/bsDialogBox.txt",function(d){
        var template = Handlebars.compile(d);     
        
        var context = { id:"modalWindow2"
                        , title: "Product Image View" 
                        , sizeAttr: "modal-lg"
                        //, footer:  ' <div class="pull-left"><button type="button" onclick="submitItems();" class="btn btn-primary"><span class="glyphicon glyphicon-floppy-disk"></span> Save</button></div>'
                        , body: 
                        
                        '<div><div id="' + tblImageView + '" class="zGrid"></div></div>'
                      };
        var html    = template(context);     
        $("body").append(html);
    });    
}

function ProductSearchDetail(id,code){
    product_id_param = id;
    product_code_param = code;
    displayDetail(product_id_param,product_code_param);
    $(".modal-title").text("Product Search Details for » Product code: " + product_code_param);
    $('#modalWindow1').modal("show");
    if (modalWindow===0) {
        modalWindow=1;
        $("#modalWindow1").on("hide.bs.modal", function () {
                if (confirm("You are about to close this window. Continue?")) return true;
                return false;
        });
    }  
}

function showModalImage(filename){
        var m=$('#modalWindow2');
        m.modal("show");
        var img = "<img src='"  + base_url + "images/" +  filename + "'>";
        m.find('.modal-body').html(img); 
}

function displayRecords(){   
      var cb = bs({name:"cbFilter1",type:"checkbox"});
        $("#grid").dataBind({
	     url            : execURL + "product_search_sel"
	    ,width          : 980
	    ,height         : 406
	    //,selectorType   : "checkbox"
        ,blankRowsLimit:1
       // ,isPaging : false
        ,dataRows : [
                {text  : cb                                         , type  : "hidden"      , width : 25        , style : "text-align:left;"       
        		    , onRender      :  function(d){ 
                		                   return     bs({name:"product_id",type:"hidden",value: svn (d,"product_id")})
                                                    +  (d !==null ? bs({name:"cb",type:"checkbox"}) : "" );
                            }
                 }	
                ,{ text:"Product Code"            , width:100       , style:"text-align:left;"          ,name:"product_code"}
                ,{ text:"Image"                   , width:45        , style:"text-align:center;" 
        		    ,onRender : function(d){ 
                            var mouseMoveEvent= "onmouseover='mouseover(\"" +  svn(d,"image_url") + "\");' onmouseout='mouseout();'";
                              return "<a href='javascript:void(0);' " + mouseMoveEvent + " class='btn btn-sm'  onclick='showModalImage(\""+ svn(d,"image_url") +"\");'  ><span class='glyphicon glyphicon-picture'></span> </a>";
                              }
        		 }
        		,{ text:"Product"                 , width:400       , style:"text-align:left;"          ,name:"product"}
            	,{ text:"Unit"                    , width:100       , style:"text-align:center;"        ,name:"unit_of_measure_code"    ,class:"text-center"}
            	,{ text:"Latest Price"            , width:100       , style:"text-align:center;"        ,name:"latest_price"            ,class:"text-center"}
            	,{ text:"Available Stocks"        , width:120       , style:"text-align:center;"        ,name:"remaining_quantity"      ,class:"text-center"}
            	,{ text:"Reference"               , width:65        , style:"text-align:center;" 
        		    ,onRender : function(d){ return (d !== null ? "<a href='javascript:void(0);'onclick='ProductSearchDetail(" + svn(d,"product_id") + ", \"" + svn(d,"product_code","") + "\");'  ><span class='glyphicon glyphicon-list' style='font-size:12pt;' ></span> </a>" : ""); }}
            	
	    ]
	    ,onComplete:function(){
                var $rows = $('#table .zRow');
                
            	$('#product_search_code_filter').keyup(function(e) { 
            
            		text = $(this).val(); // grab search term
                        
            		if(text.length > 3) {
            		    
            		   var val = $.trim($(this).val()).replace(/ +/g, ' ').toLowerCase();

                        $rows.show().filter(function() {
                            var text = $(this).text().replace(/\s+/g, ' ').toLowerCase();
                            return !~text.indexOf(val);
                        }).hide();
            		}
            		else 
            			$rows.show(); // if no matching name is found, show all rows
            	}); 
	    }
    });    
}

function displayDetail(product_id_param){   
      var cb = bs({name:"cbFilter2",type:"checkbox",style:"margin-top: 2px;"});
     $("#" + tblName).dataBind({
	     url            : execURL + "product_search_detail_sel @product_id=" + product_id_param
	    ,width          : 845
	    ,height         : 506
	    //,selectorType   : "checkbox"
        ,blankRowsLimit:1
       // ,isPaging : false
        ,dataRows : [
                 { text:"Product Code"            , width:100       , style:"text-align:left;"          ,name:"product_code"}
    	        ,{ text:"Project"                 , width:400       , style:"text-align:left;"          ,name:"project"}
            	,{ text:"MRS No."                 , width:100       , style:"text-align:center;"        ,name:"mrs_id"}
            	,{ text:"MRS Date"                , width:100       , style:"text-align:center;"        ,name:"mrs_date"}
            	,{ text:"Unit Price"              , width:120       , style:"text-align:center;"        ,name:"unit_price"}
	    ]
	     ,onComplete : function(){
	           setToNullIfChecked(product_id);
	           $("#cbFilter2").setCheckEvent("#" + tblName + " input[name='cb']");
	     }
    });    
}

function displayImage(){   
     $("#" + tblImageView);
}

function mouseover(fileName){
 $("#user-box").css("display","block");
 var $img = $("#user-box img");
 //$img.attr("src",base_url + "file/viewImage?fileName=" +  fileName + "&isThumbNail=n");
 $img.attr("src",base_url + "images/" +  fileName);
 
 if(fileName!=="") 
    $img.attr("style","margin-left:0px;");
else
    $img.attr("style","margin-left:-106px;");
}

function mouseout(){
    $("#user-box").css("display","none");
}

function setToNullIfChecked(id){
    $("#" + tblName + " input[name='cb']").change(function(){
            var td  = this.parentNode;
            var mrs_id = $(td).find("#mrs_id");
            if(this.checked) 
                mrs_id.val(id);
            else
                mrs_id.val('');
    });
}
                            