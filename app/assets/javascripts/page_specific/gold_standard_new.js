$(function() {

    // var $resourceSiteWebsite = $('input#resource_site_website');
//
//     $('input.required').validate(function(e) {
//         return e.val().trim() != '';
//     });
//
//     $().validate(function(e) {
//         return (!!e.val().isURL()
//             && e.val().indexOf('javascript:') == -1);
//     });
//
//     $('#save').click(function() {
//         var $invalidInputs = $('.invalid-input');
//         if ($resourceSiteWebsite.val().indexOf('http') != 0) {
//             $resourceSiteWebsite.val(
//                 'http://' + $resourceSiteWebsite.val());
//         }
//         if (!!$invalidInputs.length) {
//             $invalidInputs.addClass('force');
//             vex.dialog.alert("Please fill out the highlighted fields.");
//             return false;
//         }
//     });
//
//     var disableAvailability = function() {
//         var checked = !!($(this).is(':checked'));
//         $('.resource_site_available_date')
//                 .fadeTo('slow', (0+checked), function() {})
//                 .prop('disabled', checked);
//     };
//
//     var setDateFieldDefaultStatus = function() {
//         if (!$('#resource_site_capacity_sensitive').is(':checked')) {
//             $('.resource_site_available_date').prop('disabled', true).hide();
//         }
//     };
//
//     setDateFieldDefaultStatus();
//     $('#resource_site_capacity_sensitive').click(disableAvailability);
//
//     $('.closed-toggle').change(function() {
//         var isChecked = $(this).is(':checked');
//         $(this).parents('tr')
//             .toggleClass('inactive', isChecked)
//             .find('select.time-input').attr('disabled', isChecked ? "disabled" : false);
//     });

    var setVillageStatus = function(){

        var isChecked = $("#gold_standard_identity_alternate_village_status").is(':checked');
        if(isChecked){
          $('.gold_standard_identity_village_id').addClass('blurred');
          $('.gold_standard_identity_alternate_village').removeClass('blurred');
        }
        else {
          $('.gold_standard_identity_village_id').removeClass('blurred');
          $('.gold_standard_identity_alternate_village').addClass('blurred');
        }

        $('#gold_standard_identity_village_id').attr('disabled', isChecked ? "disabled" : false);
        $('#gold_standard_identity_alternate_village').attr('disabled', isChecked ? false : "disabled");
    }
    //Toggle visibility which inputs are disabled based on the checkbox
    $('#gold_standard_identity_alternate_village_status').change(setVillageStatus);
    setVillageStatus();

    var setHouseholdStatus = function(){
      var isChecked = $('#gold_standard_identity_head_of_household_status').is(':checked');
      if(isChecked){
        $('.gold_standard_identity_head_of_household_first_name').addClass('blurred');
        $('.gold_standard_identity_head_of_household_last_name').addClass('blurred');
        $('.gold_standard_identity_head_of_household_alternate_name').addClass('blurred');
        $('.gold_standard_identity_relation_to_head_of_household').addClass('blurred');
      }
      else {
        $('.gold_standard_identity_head_of_household_first_name').removeClass('blurred');
        $('.gold_standard_identity_head_of_household_last_name').removeClass('blurred');
        $('.gold_standard_identity_head_of_household_alternate_name').removeClass('blurred');
        $('.gold_standard_identity_relation_to_head_of_household').removeClass('blurred');

      }

      $('#gold_standard_identity_head_of_household_first_name').attr('disabled', isChecked ? "disabled" : false);
      $('#gold_standard_identity_head_of_household_last_name').attr('disabled', isChecked ? "disabled" : false);
      $('#gold_standard_identity_head_of_household_alternate_name').attr('disabled', isChecked ? "disabled" : false);
      $('#gold_standard_identity_relation_to_head_of_household').attr('disabled', isChecked ? "disabled" : false);
    };

    $('#gold_standard_identity_head_of_household_status').change(setHouseholdStatus);
    setHouseholdStatus();

   	 $( "#gold_standard_identity_group_id" ).change(function () {
   		    var value = $(this).val()
   		  	$.ajax({
   			     url: '/locations/groups/' + value,
   			     type: 'GET',
   			     success: function(data){
               $data = $(data)
               var villageData = $data.closest("#villages").children('option');
   			 			 $("#gold_standard_identity_village_id").html(villageData);
   			     }
   		  	});
   	   });

     	 $( "#gold_standard_identity_collective_id" ).change(function () {
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
     			 			 $("#gold_standard_identity_village_id").html(villageData);
     			 			 $("#gold_standard_identity_group_id").html(groupData);
     			     }
     		  	});
     	   });

       	 $( "#gold_standard_identity_territory_id" ).change(function () {
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


                   $("#gold_standard_identity_village_id").html(villageData);
       			 			 $("#gold_standard_identity_group_id").html(groupData);
       			 			 $("#gold_standard_identity_collective_id").html(collectiveData);
       			     }
       		  	});
       	   });

         	 $( "#gold_standard_identity_province_id" ).change(function () {
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


                     $("#gold_standard_identity_village_id").html(villageData);
         			 			 $("#gold_standard_identity_group_id").html(groupData);
         			 			 $("#gold_standard_identity_collective_id").html(collectiveData);
         			 			 $("#gold_standard_identity_territory_id").html(territoryData);

         			     }
         		  	});
         	   });

});
