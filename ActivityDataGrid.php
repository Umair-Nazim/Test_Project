<?php

pageHeaderInclude('assets/def/js/highlightrows.js');
pageHeaderInclude('assets/def/js/sweetTitles.js');
pageHeaderInclude('assets/def/js/dataGrid.js');
pageHeaderInclude('assets/i2c/css/buttons.bootstrap5.css');

pageHeaderInclude('assets/i2c/css/add-job.css');

pageHeaderInclude('assets/i2c/js/new-joborder.js');

pageTitle('Activities');
ob_start();
?>

    <div class="jumbotronHead">
        <h1>Activities</h1>
        <div class="jumbotron-right activitesNavContent">
            <ul class="activity-day-filter-holder">
                <?php echo($this->quickLinks); ?>
            </ul>
            <?php $this->dataGrid->drawShowFilterControl(); ?>
        </div>
    </div>

    <div class="d-none">Activities - Page <?php echo($this->dataGrid->getCurrentPageHTML()); ?></div>
    <?php $this->dataGrid->drawFilterArea();
        //$totalRecords = $this->dataGrid['_totalEntries'];
        $totalRecords = $this->dataGrid->_totalEntries;
        //echo $totalRecords.'Hello Count';
        //die;
        $hideGrid = 'd-none';
        $showNoRecord = 'd-flex';
        if ( $totalRecords > 0 ){
            $hideGrid = '';
            $showNoRecord = 'd-none';
        }

    ?>
        <div class="custom-filter-style"></div>

        <div class="custom-table-wrapper <?php echo $hideGrid;?>" id="activity-grid-wrapper">
            <?php $this->dataGrid->draw();  ?>
        </div>
        <div class="grid-table-bottom <?php echo $hideGrid;?>">
            <div class="grid-table-dropdown">
                <?php $this->dataGrid->drawRowsPerPageSelector(); ?>
            </div>
            <?php $this->dataGrid->printNavigation(false); ?>
        </div>

        <div class="noData-sect <?php echo $showNoRecord;  ?>">
            <i class="iconsax-linear isax-info-circle"></i>
            <span>There are no Activities available.</span>
        </div>

    <script>
        jQuery(document).ready(function() {

            var length = <?php echo $totalRecords;?>;
            var tbodyLength  = $(".custom-style-table  tbody").length;
            if (length < 15){
                $(".grid-table-bottom").css("display", "none");
            }else{
                $(".grid-table-bottom").css("display", "flex");
            }
            if (!tbodyLength){
                $(".custom-style-table table").append("<tbody><tr><td colspan='5' class='text-center'>There are no activities found.</td></tr></tbody>");
                $(".custom-style-table table").addClass('roundedTable');
            }else{
            }

            var movwidth = jQuery(window).width();
            if ( movwidth < 767) {

                $activitiesSelect = '<div class="dropdown"><button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">Dropdown button</button><ul class="dropdown-menu dropdown-menu-end">';

                $('.activity-day-filter-holder li a ').each(function(){
                    $href = $(this).attr('href');
                    $text = $(this).text();
                    $activitiesSelect += '<li><a class="dropdown-item" href="'+$href+'">'+$text+'</a></li>';
                });


                $activitiesSelect += '</ul></div>';

                $('.activitesNavContent').prepend($activitiesSelect );

                var navmenuTxt = $(".activitesNavContent li a.active").text();
                $(".activitesNavContent .dropdown button").text(navmenuTxt);
                $(".activitesNavContent .dropdown button").append('<i class="iconsax-linear isax-arrow-down-2"></i>');
            }
        });
    </script>
<?php
$AUIEO_CONTENT=ob_get_clean();
?>