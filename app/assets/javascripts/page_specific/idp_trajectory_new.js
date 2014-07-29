$(function() {

    var setVillageStatus = function(){

        var isChecked = $("#idp_trajectory_alternate_village_status").is(':checked');
        if(isChecked){
          $('.idp_trajectory_village_id').addClass('blurred');
          $('.idp_trajectory_site_id').addClass('blurred');
          $('.idp_trajectory_alternate_village').removeClass('blurred');
        }
        else {
          $('.idp_trajectory_village_id').removeClass('blurred');
          $('.idp_trajectory_site_id').removeClass('blurred');
          $('.idp_trajectory_alternate_village').addClass('blurred');
        }

        $('#idp_trajectory_village_id').attr('disabled', isChecked ? "disabled" : false);
        $('#idp_trajectory_site_id').attr('disabled', isChecked ? "disabled" : false);
        $('#idp_trajectory_alternate_village').attr('disabled', isChecked ? false : "disabled");
    }
    //Toggle visibility which inputs are disabled based on the checkbox
    $('#idp_trajectory_alternate_village_status').change(setVillageStatus);
    setVillageStatus();

   	 $( "#idp_trajectory_group_id" ).change(function () {
   		    var value = $(this).val()
   		  	$.ajax({
   			     url: '/locations/groups/' + value,
   			     type: 'GET',
   			     success: function(data){
               $data = $(data)
               var villageData = $data.closest("#villages").children('option');
   			 			 $("#idp_trajectory_village_id").html(villageData);
   			     }
   		  	});
   	   });

     	 $( "#idp_trajectory_collective_id" ).change(function () {
            var value = $(this).val()
            if(!value){
              value = 0;
            }
     		  	$.ajax({
     			     url: '/locations/collectives/' + value,
     			     type: 'GET',
     			     success: function(data){
                 $data = $(data)
                 var villageData = $data.closest("#villages").children('option');
                 var groupData = $data.closest("#groups").children('option');
     			 			 $("#idp_trajectory_village_id").html(villageData);
     			 			 $("#idp_trajectory_group_id").html(groupData);
     			     }
     		  	});
     	   });

       	 $( "#idp_trajectory_territory_id" ).change(function () {
              var value = $(this).val()
              if(!value){
                value = 0;
              }
       		  	$.ajax({
       			     url: '/locations/territories/' + value,
       			     type: 'GET',
       			     success: function(data){
                   $data = $(data)
                   var villageData = $data.closest("#villages").children('option');
                   var groupData = $data.closest("#groups").children('option');
                   var collectiveData = $data.closest("#collectives").children('option');


                   $("#idp_trajectory_village_id").html(villageData);
       			 			 $("#idp_trajectory_group_id").html(groupData);
       			 			 $("#idp_trajectory_collective_id").html(collectiveData);
       			     }
       		  	});
       	   });

         	 $( "#idp_trajectory_province_id" ).change(function () {
                var value = $(this).val()
                if(!value){
                  value = 0;
                }
         		  	$.ajax({
         			     url: '/locations/provinces/' + value,
         			     type: 'GET',
         			     success: function(data){
                     $data = $(data)
                     var villageData = $data.closest("#villages").children('option');
                     var groupData = $data.closest("#groups").children('option');
                     var collectiveData = $data.closest("#collectives").children('option');
                     var territoryData = $data.closest("#territories").children('option');


                     $("#idp_trajectory_village_id").html(villageData);
         			 			 $("#idp_trajectory_group_id").html(groupData);
         			 			 $("#idp_trajectory_collective_id").html(collectiveData);
         			 			 $("#idp_trajectory_territory_id").html(territoryData);

         			     }
         		  	});
         	   });

});
