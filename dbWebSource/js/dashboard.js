$(document).ready(function(){
    loadImages("slider","dashboard");
});
      
     

 function loadImages(sliderId,subFolder){
    
    var createImg =function(subFolder,fileName){
        return "<img src='/file/viewImage?fileName=" + subFolder + "/" + fileName +"'>";
    };    
    $(".nivoSlider").css({display:"none"});
    $.get(base_url + "file/getImageFileNames?subDir="  + subFolder + "\\&searchPattern=*.jpg", function(data){
        $.each(data.files,function(){
               $("#" + sliderId).append( createImg(subFolder,this) );
        });
        setTimeout(function(){ 
            $(".nivoSlider").fadeIn();
            $("#" + sliderId).nivoSlider(); 
        }, 3000);

    });   
}  