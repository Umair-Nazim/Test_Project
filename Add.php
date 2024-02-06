<?php
pageHeaderInclude('modules/joborders/validator.js');
pageHeaderInclude('assets/i2c/js/new-joborder.js');
pageHeaderInclude('assets/i2c/js/add-job.js');

pageHeaderInclude('assets/i2c/css/add-job.css');

pageHeaderInclude('assets/i2c/css/new-job-detail.css');

pageTitle('Job Orders');

ob_start();
//echo "<pre>"; print_r($this->defaultCompanyID); die;
//echo "<pre>"; print_r($this->defaultCompanyRS); die;
global $INTERVIEW_STAGES;
 ?>

<?php
function fetchClassForLabel($label){
    if (
        strpos($label, 'DOB') !== false
        || strpos($label, 'date') !== false
    ) {
        return "dateField";
    } elseif (strpos($label, 'CNIC') !== false) {
        return "cnicField";
    }
}
?>



<form name="addJobOrderForm" id="addJobOrderForm" action="<?php echo(CATSUtility::getIndexName()); ?>?m=joborders&amp;a=add" method="post" onsubmit="return checkAddForm(document.addJobOrderForm);" autocomplete="off">
    <input type="hidden" name="postback" id="postback" value="postback" />
    <input type="hidden" name="action" id="action" value="" />
    <input type="hidden" name="contactID" id="action" value="-1" />
    <div class="toaster-message toaster-error">

        <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M10.0003 6.6665V9.99984M10.0003 13.3332H10.0087M18.3337 9.99984C18.3337 14.6022 14.6027 18.3332 10.0003 18.3332C5.39795 18.3332 1.66699 14.6022 1.66699 9.99984C1.66699 5.39746 5.39795 1.6665 10.0003 1.6665C14.6027 1.6665 18.3337 5.39746 18.3337 9.99984Z" stroke="#EE4723" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
        <p>Please Fill All Require Fields</p>
        <span id="close-toaster">
        <svg width="12" height="12" viewBox="0 0 12 12" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M11 1L1 11M1 1L11 11" stroke="#EE4723" stroke-width="1.25" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
        </span>
    </div>
    <div class="addJob-main">
        <div class="addJob-top">
            <div class="addJob-left">
                <h1>
                    New Job
                </h1>
            </div>
            <div class="addJob-right">
                <div class="customCheck2">
                    <div class="customCheck2C">
                        <input type="checkbox" id="isHot" name="isHot">
                        <span></span>
                    </div>
                    <label for="isHot">Hot</label>
                </div>
                <div class="customCheck2">
                    <div class="customCheck2C">
                        <input type="checkbox" id="public" checked name="public" >
                        <span></span>
                    </div>
                    <label for="public">Public</label>
                </div>
                <div class="customCheck2">
                    <div class="customCheck2C">
                        <input type="checkbox" id="isPinned" name="is_pinned">
                        <span></span>
                    </div>
                    <label for="isPinned">Pin</label>
                </div>
            </div>
        </div>
        <div class="addJob-btm">
            <div class="addJob-t-left">
                <div class="customJobTypeTitle">
                    <div class="form-group customTitleGroup">
                        <label>Job Title <span></span></label>
                        <input type="text" id="title" name="title" <?php if(isset($this->jobOrderSourceRS['title'])): ?>value="<?php $this->_($this->jobOrderSourceRS['title']); ?>"<?php endif; ?> class="form-control">
                    </div>
                    <div class="form-group customTitleGroup">
                        <label>Job Type <span></span></label>
                        <ul class="typeChecklist">
                            <li>
                                <div class="typeCheck">
                                    <input type="radio" name="type" value="PER" <?php if(isset($this->jobOrderSourceRS['type']) && $this->jobOrderSourceRS['type'] == 'PER') echo('checked'); ?>>
                                    <span>Permanent</span>
                                </div>
                            </li>
                            <li>
                                <div class="typeCheck">
                                    <input type="radio" name="type" value="PAR" <?php if(isset($this->jobOrderSourceRS['type']) && $this->jobOrderSourceRS['type'] == 'PAR') echo('checked'); ?>>
                                    <span>Part Time</span>
                                </div>
                            </li>
                            <li>
                                <div class="typeCheck">
                                    <input type="radio" name="type" value="REM" <?php if(isset($this->jobOrderSourceRS['type']) && $this->jobOrderSourceRS['type'] == 'REM') echo('checked'); ?>>
                                    <span>Remote</span>
                                </div>
                            </li>
                            <li>
                                <div class="typeCheck">
                                    <input type="radio" name="type" value="CON" <?php if(isset($this->jobOrderSourceRS['type']) && $this->jobOrderSourceRS['type'] == 'CON') echo('checked'); ?>>
                                    <span>Contract</span>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="customJobRequirements">
                    <h6 class="addJob-tsubtitle">Requirements</h6>
                    <div class="row">
                        <?php if(count($this->extraFieldRS) > 0){ ?>
                            <?php foreach ($this->extraFieldRS as $k => $field_ar): ?>
                                <?php $classForField = fetchClassForLabel($field_ar['fieldName']); ?>
                                <div class="col-md-6 <?php echo $classForField; ?>">
                                    <label><?php echo $field_ar['fieldName']; ?></label>
                                    <?php echo $field_ar['addHTML']; ?>
                                </div>
                            <?php endforeach; ?>
                        <?php } ?>
                    </div>
                </div>
                <div class="form-group customTitleGroup">
                    <label>Description</label>
                    <textarea class="editorinit" name="description" id="despeditor"><?php if(isset($this->jobOrderSourceRS['description'])): ?><?php $this->_($this->jobOrderSourceRS['description']); ?><?php endif; ?></textarea>
                </div>
                <div class="form-group customTitleGroup">
                    <label>Skills</label>
                    <textarea class="editorinit2" name="skills" id="skillseditor"><?php if(isset($this->jobOrderSourceRS['skills'])): ?><?php $this->_($this->jobOrderSourceRS['skills']); ?><?php endif; ?></textarea>
                </div>
                <div class="form-group customTitleGroup">
                    <label>Internal Notes</label>
                    <textarea class="form-control" name="notes" id="notes" placeholder="Enter a details..."><?php if(isset($this->jobOrderSourceRS['notes'])): ?><?php $this->_($this->jobOrderSourceRS['notes']); ?><?php endif; ?></textarea>
                </div>
            </div>
            <div class="addJob-t-right">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Company</label>
                            <?php if ($this->defaultCompanyID !== false): ?>
                                <input type="hidden" name="typeCompany" checked onchange="document.getElementById('companyName').disabled = false; if (oldCompanyID != -1) document.getElementById('companyID').value = oldCompanyID;" disabled>
                                <input type="text" name="companyName" id="companyName" value="<?php if (isset($this->defaultCompanyRS['name']) !== false) { $this->_($this->defaultCompanyRS['name']); } ?>" onFocus="suggestListActivate('getCompanyNames', 'companyName', 'CompanyResults', 'companyID', 'ajaxTextEntryHover', 0, '<?php echo($this->sessionCookie); ?>', 'helpShim');" class="form-control" disabled />
                            <?php else: ?>
                                <input type="text" name="companyName" id="companyName" value="<?php if ($this->selectedCompanyID !== false) { $this->_($this->companyRS['name']); } ?><?php if(isset($this->jobOrderSourceRS['companyName']) && $this->selectedCompanyID == false ): ?><?php $this->_($this->jobOrderSourceRS['companyName']); ?><?php endif; ?>" class="form-control" onFocus="suggestListActivate('getCompanyNames', 'companyName', 'CompanyResults', 'companyID', 'ajaxTextEntryHover', 0, '<?php echo($this->sessionCookie); ?>', 'helpShim');" <?php if ($this->selectedCompanyID !== false) { echo('disabled'); } ?> />
                            <?php endif; ?>

                            <iframe id="helpShim" src="javascript:void(0);" scrolling="no" frameborder="0" style="position:absolute; display:none;"></iframe>
                            <div id="CompanyResults" class="ajaxSearchResults w-100 border border-primary rounded mt-5"></div>

                            <?php if ($this->defaultCompanyID !== false): ?>
                                <span style="display: none;"> <input type="radio" name="typeCompany" id="defaultCompany" onchange="if(document.getElementById('companyName').disabled == false && document.getElementById('companyID').value > 0) {oldCompanyID = document.getElementById('companyID').value; } else if(document.getElementById('companyName').disabled == false) { oldCompanyID = 0; } document.getElementById('companyName').disabled = true; document.getElementById('companyID').value = '<?php echo($this->defaultCompanyID); ?>'; " disabled>&nbsp;Internal Posting</span>
                            <?php endif; ?>

                            <input type="hidden" name="companyID" id="companyID" value="<?php if (($this->defaultCompanyID !== false) && ($this->defaultCompanyID > 0)) { echo $this->defaultCompanyID; } ?>" />

                            <script type="text/javascript">
                            //    oldCompanyID = -1; watchCompanyIDChangeJO('<?php echo($this->sessionCookie); ?>');
                            </script>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Divisions  <span></span></label>
                            <select class="form-control chosen-select chosenDef" id="divisionSelect" name="divisions"  required>
                                <option value="">Select Divisions</option>
                                <?php foreach ($this->divisionsRS as $index => $division): ?>
                                    <option value="<?php $this->_($division['divisionName']); ?>"><?php $this->_($division['divisionName']); ?></option>
                                <?php endforeach; ?>
                            </select>

                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Department  <span></span></label>
                            <select class="form-control chosen-select chosenDef" id="departmentSelect" name="department" onchange="if (this.value == 'edit') { listEditor('Departments', 'departmentSelect', 'departmentsCSV', false); this.value = '(none)'; } if (this.value == 'nullline') { this.value = '(none)'; }" required>
                                <option value="">Select Department</option>
                                <?php foreach ($this->departmentsRS as $index => $department): ?>
                                    <option value="<?php $this->_($department['name']); ?>"><?php $this->_($department['name']); ?></option>
                                <?php endforeach; ?>
                            </select>
                            <input type="hidden" id="departmentsCSV" name="departmentsCSV" value="<?php if ($this->selectedCompanyID !== false): $this->_($this->selectedDepartmentsString); endif; ?>" />
                            <?php if ($this->selectedCompanyID !== false): ?>
                                <script type="text/javascript">listEditorUpdateSelectFromCSV('departmentSelect', 'departmentsCSV', true, false);</script>
                            <?php endif; ?>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Teams</label>
                            <select class="form-control chosen-select chosenDef" id="teamSelect" name="team" >
                                <option value="">Select Team</option>
                                <?php foreach ($this->teamsRS as $index => $teamR): ?>
                                    <option value="<?php $this->_($teamR['company_team_id']); ?>"><?php $this->_($teamR['team_name']); ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                    </div>

                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Salary</label>
                            <input class="form-control" type="text" id="salary" name="salary" <?php if(isset($this->jobOrderSourceRS['salary'])): ?>value="<?php $this->_($this->jobOrderSourceRS['salary']); ?>"<?php endif; ?>/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Openings <span></span></label>
<!--                            <input type="text" class="form-control" id="openings" name="openings" --><?php //if(isset($this->jobOrderSourceRS['openings'])): ?><!--value="--><?php //$this->_($this->jobOrderSourceRS['openings']); ?><!--"--><?php //else: ?><!--value="1"--><?php //endif; ?><!-- />-->
                            <select class="form-control opening-chosen chosenDef" name="openings">
                                    <option value="">Select Openings</option>
                                <?php foreach (range(0, 100) as $number):?>
                                    <option value="<?php echo $number; ?>"><?php echo $number; ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Duration</label>
                            <input class="form-control"  type="text" id="duration" name="duration" <?php if(isset($this->jobOrderSourceRS['duration'])): ?> value="<?php $this->_($this->jobOrderSourceRS['duration']); ?>"<?php endif; ?> >
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Start Date <span></span></label>
                            <input type="text" class="form-control datepicker-field" placeholder="Select date" id="startDate_Month_ID" name="startDate" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Recruiter <span></span></label>
                            <select id="recruiter" name="recruiter" class="form-control chosenimg-select chosenDef">
                                <option value="">(Select a User)</option>

                                <?php foreach ($this->usersRS as $rowNumber => $usersData): ?>
                                    <?php if ($usersData['userID'] == $this->userID): ?>
                                        <option selected value="<?php $this->_($usersData['userID']) ?>"><?php $this->_($usersData['firstName']) ?> <?php $this->_($usersData['lastName']) ?></option>
                                    <?php else: ?>
                                        <option value="<?php $this->_($usersData['userID']) ?>"><?php $this->_($usersData['firstName']) ?> <?php $this->_($usersData['lastName']) ?></option>
                                    <?php endif; ?>
                                <?php endforeach; ?>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Owner <span></span></label>
                            <select id="owner" name="owner" class="form-control chosenimg-select chosenDef">
                                <option value="">(Select a User)</option>
                                    <?php
                                    foreach ($this->usersRoot as $rowNumber => $usersData)
                                    {
                                        if ($usersData['userID'] == $this->userID)
                                        {
                                            echo "<option selected value='0:{$usersData['userID']}'>{$usersData['firstName']} {$usersData['lastName']}</option>";
                                        }
                                        else
                                        {
                                            echo "<option value='0:{$usersData['userID']}'>{$usersData['firstName']} {$usersData['lastName']}</option>";
                                        }
                                    }
                                    ?>

                            </select>
                        </div>
                    </div>
                </div>
                <h6 class="addJob-tsubtitle">Location</h6>
                <div class="form-group">
                    <label>Country <span></span></label>
                    <select id="country" class="form-control chosen-select chosenDef " name="country" onchange="updateStates(this)" >
                        <option value="" >Select Country </option>
                        <option value="1133" >Pakistan</option>
                        <option value="1031" >Canada</option>
                        <option value="1186" >USA</option>
                    </select>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>State <span></span></label>
                            <select id="state" class="form-control chosen-select chosenDef "  name="state" onchange="updateCities(this)" >
                                <option value="" >Select State</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>City <span></span></label>
                            <select id="city" class="form-control chosen-select chosenDef"  name="city">
                                <option value="">Select City</option>
                            </select>
                        </div>
                    </div>
                </div>


                <div class="addJob-box addJob-boxGray">
                    <h4>
                        <span>Questionnaire</span>
                        <a href="javascript:void()" id="addquestionnaireModalbtn" data-bs-toggle="modal" data-bs-target="#addquestionnaireModal" class="defualtQuestionBtn">Change Questionnaires</a>
                    </h4>
                    <ul class="questionnaire-form">
                        <li>
                            <div class="fileCheck">
                                <span>
                                    <i class="fileIconsvg">
                                        <svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <path class="filesvgback" opacity="0.4" d="M10.794 1.33325H5.20732C2.78065 1.33325 1.33398 2.77992 1.33398 5.20659V10.7866C1.33398 13.2199 2.78065 14.6666 5.20732 14.6666H10.7873C13.214 14.6666 14.6607 13.2199 14.6607 10.7933V5.20659C14.6673 2.77992 13.2207 1.33325 10.794 1.33325Z" fill="#8E90AA"/>
                                            <path class="filesvgfore" d="M10.5 6.5H5.5C5.22667 6.5 5 6.27333 5 6C5 5.72667 5.22667 5.5 5.5 5.5H10.5C10.7733 5.5 11 5.72667 11 6C11 6.27333 10.7733 6.5 10.5 6.5Z" fill="#8E90AA"/>
                                            <path class="filesvgfore" d="M10.5 10.5H5.5C5.22667 10.5 5 10.2733 5 10C5 9.72667 5.22667 9.5 5.5 9.5H10.5C10.7733 9.5 11 9.72667 11 10C11 10.2733 10.7733 10.5 10.5 10.5Z" fill="#8E90AA"/>
                                        </svg>
                                    </i>
                                    <span class="custom-questionnaire-title"></span>
<!--                                    <svg class="cross-box" onclick="deleteCurrElem(this)" width="10" height="10" viewBox="0 0 10 10" fill="none" xmlns="http://www.w3.org/2000/svg">-->
<!--                                        <path d="M9 1L1 9M1 1L9 9" stroke="#8E90AA" stroke-linecap="round" stroke-linejoin="round"/>-->
<!--                                    </svg>-->
                                </span>
                            </div>
                        </li>
                    </ul>
                    <input type="hidden" class="custom-questionnaire-form" name="questionnaire" value="">
                    <a href="javascript:void()" id="addquestionnaireModalbtn" data-bs-toggle="modal" data-bs-target="#addquestionnaireModal" class="btn btnBordered_cstm btnBlock customModalBtn">
                        <i class="addbtnIcon iconsax-linear isax-add"></i>
                        Add Questionnaire
                    </a>
                </div>
                <div class="form-group seo-tabs">
                    <div class="site-wrapper">
                    <section class="tabs-wrapper">
                        <div class="addJob-box addJob-boxGray">
                        <h4>SEO Details</h4>
                        <div class="innerBox">
                            <div class="form-group">
                                <label>OG Title</label>
                                <input type="text" name="ln_seo_title" class="form-control">
                            </div>
                            <div class="form-group tabs-fields">
                                <label>OG Description</label>
                                <textarea class="form-control" name="ln_seo_description" id="notes" placeholder="Enter a details..."></textarea>
                            </div>
                            <div class="form-group tabs-fields linkedintab">
                                <div class="upload-cv-wrapper">
                                    <label>OG Image</label>
                                    <div class="form-group custom-file-upload file-uplaoded">
                                        <input type="hidden" name="seo_attachment_id" class="file_id" value="">
                                        <div class="upload-file-wrapper upload_file">
                                            <div id="upload-label" class="file-upload-area">
                                                <i>
                                                    <svg width="47" height="47" viewBox="0 0 47 47" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                        <rect x="3.5" y="3.5" width="40" height="40" rx="20" fill="#F5F5FA"/>
                                                        <path d="M19.7241 26.3914C19.48 26.6355 19.48 27.0312 19.7241 27.2753C19.9682 27.5194 20.3639 27.5194 20.608 27.2753L19.7241 26.3914ZM23.4993 23.5L23.9413 23.0581C23.6972 22.814 23.3015 22.814 23.0574 23.0581L23.4993 23.5ZM26.3907 27.2753C26.6348 27.5194 27.0305 27.5194 27.2746 27.2753C27.5187 27.0312 27.5187 26.6355 27.2746 26.3914L26.3907 27.2753ZM22.8743 31C22.8743 31.3452 23.1542 31.625 23.4993 31.625C23.8445 31.625 24.1243 31.3452 24.1243 31H22.8743ZM26.8044 19.0814L27.3429 18.7641L27.3429 18.7641L26.8044 19.0814ZM29.768 26.9705C29.5019 27.1903 29.4643 27.5842 29.6841 27.8504C29.9039 28.1165 30.2979 28.1541 30.564 27.9343L29.768 26.9705ZM16.5457 27.1024C16.7894 27.3469 17.1851 27.3477 17.4296 27.104C17.6741 26.8604 17.6749 26.4647 17.4312 26.2201L16.5457 27.1024ZM20.608 27.2753L23.9413 23.9419L23.0574 23.0581L19.7241 26.3914L20.608 27.2753ZM23.0574 23.9419L26.3907 27.2753L27.2746 26.3914L23.9413 23.0581L23.0574 23.9419ZM22.8743 23.5V31H24.1243V23.5H22.8743ZM15.791 22.25C15.791 19.1434 18.3094 16.625 21.416 16.625V15.375C17.6191 15.375 14.541 18.453 14.541 22.25H15.791ZM21.416 16.625C23.4811 16.625 25.287 17.7375 26.266 19.3988L27.3429 18.7641C26.1485 16.7373 23.9417 15.375 21.416 15.375V16.625ZM27.2493 19.9583C29.4355 19.9583 31.2077 21.7305 31.2077 23.9167H32.4577C32.4577 21.0402 30.1258 18.7083 27.2493 18.7083V19.9583ZM31.2077 23.9167C31.2077 25.1456 30.6483 26.2434 29.768 26.9705L30.564 27.9343C31.7195 26.98 32.4577 25.5343 32.4577 23.9167H31.2077ZM17.4312 26.2201C16.4169 25.2021 15.791 23.7998 15.791 22.25H14.541C14.541 24.1437 15.3075 25.8597 16.5457 27.1024L17.4312 26.2201ZM26.266 19.3988C26.4736 19.751 26.8515 19.9583 27.2493 19.9583V18.7083C27.283 18.7083 27.3202 18.7256 27.3429 18.7641L26.266 19.3988Z" fill="#70728F"/>
                                                        <rect x="3.5" y="3.5" width="40" height="40" rx="20" stroke="#FAFAFC" stroke-width="6"/>
                                                    </svg>
                                                </i>
                                                <div class="click-upload">
                                                    Click to upload
                                                    <span>or drag and drop</span>
                                                </div>
                                                <span class="file-upload-info"></span>
                                            </div>
                                        </div>
                                        <!-- Preview collection of uploaded documents -->
                                        <div class="preview-container">
                                            <div id="previews">
                                                <div class="zdrop-template file-preview">
                                                <div class="file-image">
                                                    <i class="icon-document" aria-hidden="true"></i>
                                            </div>
                                            <div class="file-details">
                                                <div class="file-info">
                                                <div class="file-name-img">
                                                    <i>
                                                        <svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <path opacity="0.4" d="M28 9.33464V22.668C28 26.668 26 29.3346 21.3333 29.3346H10.6667C6 29.3346 4 26.668 4 22.668V9.33464C4 5.33464 6 2.66797 10.6667 2.66797H21.3333C26 2.66797 28 5.33464 28 9.33464Z" fill="#8E90AA"/>
                                                            <path d="M24.6673 12.3333H22.0007C19.974 12.3333 18.334 10.6933 18.334 8.66667V6C18.334 5.45333 18.7873 5 19.334 5C19.8807 5 20.334 5.45333 20.334 6V8.66667C20.334 9.58667 21.0807 10.3333 22.0007 10.3333H24.6673C25.214 10.3333 25.6673 10.7867 25.6673 11.3333C25.6673 11.88 25.214 12.3333 24.6673 12.3333Z" fill="#8E90AA"/>
                                                            <path d="M15.9993 18.332H10.666C10.1193 18.332 9.66602 17.8787 9.66602 17.332C9.66602 16.7854 10.1193 16.332 10.666 16.332H15.9993C16.546 16.332 16.9993 16.7854 16.9993 17.332C16.9993 17.8787 16.546 18.332 15.9993 18.332Z" fill="#8E90AA"/>
                                                            <path d="M21.3327 23.668H10.666C10.1193 23.668 9.66602 23.2146 9.66602 22.668C9.66602 22.1213 10.1193 21.668 10.666 21.668H21.3327C21.8793 21.668 22.3327 22.1213 22.3327 22.668C22.3327 23.2146 21.8793 23.668 21.3327 23.668Z" fill="#8E90AA"/>
                                                        </svg>
                                                    </i>
                                                    <div class="d-flex flex-column">
                                                        <strong class="file-name" data-dz-name></strong>
                                                        <span class="file-size" data-dz-size></span>
                                                    </div>
                                                </div>
                                                <button type="button" class="btn-remove" aria-label="Remove file" data-dz-remove>
                                                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                        <path d="M13.3333 4.99935V4.33268C13.3333 3.39926 13.3333 2.93255 13.1517 2.57603C12.9919 2.26243 12.7369 2.00746 12.4233 1.84767C12.0668 1.66602 11.6001 1.66602 10.6667 1.66602H9.33333C8.39991 1.66602 7.9332 1.66602 7.57668 1.84767C7.26308 2.00746 7.00811 2.26243 6.84832 2.57603C6.66667 2.93255 6.66667 3.39926 6.66667 4.33268V4.99935M8.33333 9.58268V13.7493M11.6667 9.58268V13.7493M2.5 4.99935H17.5M15.8333 4.99935V14.3327C15.8333 15.7328 15.8333 16.4329 15.5608 16.9677C15.3212 17.4381 14.9387 17.8205 14.4683 18.0602C13.9335 18.3327 13.2335 18.3327 11.8333 18.3327H8.16667C6.76654 18.3327 6.06647 18.3327 5.53169 18.0602C5.06129 17.8205 4.67883 17.4381 4.43915 16.9677C4.16667 16.4329 4.16667 15.7328 4.16667 14.3327V4.99935" stroke="#70728F" stroke-width="1.25" stroke-linecap="round" stroke-linejoin="round"></path>
                                                    </svg>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </div>
                </div>
            </div>
        </div>
        <div class="attachmentAction d-flex justify-content-between">
            <div class="mob-responsive-btns">
                <input type="button" class="btn btnBordered_cstm" name="back"   value="Cancel" onclick="javascript:goToURL('<?php echo(CATSUtility::getIndexName()); ?>?m=joborders&amp;a=listByView');" />
                <input type="reset"  class="btn btnLink_cstm" name="reset"  value="Reset" />
            </div>
            <div class="mob-responsive-btns">
                <input type="submit" class="btn btnInfo_cstm" name="submit" onclick="document.getElementById('action').value = 'Save';" value="Save & Preview" />
                <input type="submit" class="btn btnPrimary_cstm" id="publishbtn" name="submit" onclick="document.getElementById('action').value = 'Publish';" value="Publish" />
            </div>
        </div>

    </div>

    <!-- evaluation modal-->
    <div class="modal fade" id="addevaluaionModal" aria-hidden="true" aria-labelledby="addevaluaionModalLabel" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false">
        <div class="modal-dialog modal-dialog-centered modal-custom">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addevaluaionModalLabel"><i>
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <rect width="24" height="24" rx="12" fill="#EFF0F5"/>
                                <path opacity="0.4" d="M14.794 5.33325H9.20732C6.78065 5.33325 5.33398 6.77992 5.33398 9.20659V14.7866C5.33398 17.2199 6.78065 18.6666 9.20732 18.6666H14.7873C17.214 18.6666 18.6607 17.2199 18.6607 14.7933V9.20659C18.6673 6.77992 17.2207 5.33325 14.794 5.33325Z" fill="#8E90AA"/>
                                <path d="M14.5 10.5H9.5C9.22667 10.5 9 10.2733 9 10C9 9.72667 9.22667 9.5 9.5 9.5H14.5C14.7733 9.5 15 9.72667 15 10C15 10.2733 14.7733 10.5 14.5 10.5Z" fill="#8E90AA"/>
                                <path d="M14.5 14.5H9.5C9.22667 14.5 9 14.2733 9 14C9 13.7267 9.22667 13.5 9.5 13.5H14.5C14.7733 13.5 15 13.7267 15 14C15 14.2733 14.7733 14.5 14.5 14.5Z" fill="#8E90AA"/>
                            </svg>
                        </i>Evaluations</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body filtersBody">
                    <div class="form-group">
                        <div class="evRight01 evaluationStageDropPop">
                            <select class="form-control chosen-interview-stages" name="interviewStage" placeholder="Select Interview Stages For Evaluation" multiple>
                                <?php foreach ($INTERVIEW_STAGES as $status=>$stage): ?>
                                    <option value="<?=$stage?>">Stage <?=$stage?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control searchField" placeholder="Search Forms">
                    </div>
                    <ul id="displayEvaluations" class="evList">
                        <?php foreach ($this->evalutionFormRS as $rowNumber => $evalutionFormData): ?>
                            <li>
                                <div class="evName" data-id="<?php $this->_($evalutionFormData['evaluations_id']) ?>">
                                    <?php echo $evalutionFormData['title'] ?>
                                </div>
                                <div class="evRight">
                                    <div class="evRight01">
                                        <?php if($evalutionFormData['active'] == 1): ?>
                                            <span class="badgecstm badgecstm-active">Active</span>
                                        <?php else:?>
                                            <span class="badgecstm badgecstm-inactive">Inactive</span>
                                        <?php endif;?>
                                    </div>
                                    <div class="evRight02 evaluation-select">
                                        <a href="javascript:void(0)" class="custom-select btn btn-sm btnInfo_cstm">Select</a>
                                        <span class="evSelected">
                                            <a href="javascript:void(0)" class="custom-unselect">

                                            <i>
                                                <svg width="12" height="12" viewBox="0 0 12 12" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path d="M6 11C8.75 11 11 8.75 11 6C11 3.25 8.75 1 6 1C3.25 1 1 3.25 1 6C1 8.75 3.25 11 6 11Z" stroke="#097732" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path>
                                                    <path d="M3.875 5.99996L5.29 7.41496L8.125 4.58496" stroke="#097732" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path>
                                                </svg>
                                            </i>
                                            Selected
                                             </a>
                                        </span>
                                    </div>
                                </div>
                            </li>
                        <?php endforeach; ?>
                    </ul>
                </div>
                <div class="modal-footer">
                    <div class="modalfoot-btns">
                        <div class="mfb-left">
                            <a href="<?php echo(CATSUtility::getIndexName()); ?>?m=joborders&a=evaluation" class="blueLink" target="_blank">
                                <i>
                                    <svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M8 10C9.10457 10 10 9.10457 10 8C10 6.89543 9.10457 6 8 6C6.89543 6 6 6.89543 6 8C6 9.10457 6.89543 10 8 10Z" stroke="#46B0E6" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="round" stroke-linejoin="round"></path>
                                        <path d="M1.33398 8.58679V7.41345C1.33398 6.72012 1.90065 6.14679 2.60065 6.14679C3.80732 6.14679 4.30065 5.29345 3.69398 4.24679C3.34732 3.64679 3.55398 2.86679 4.16065 2.52012L5.31398 1.86012C5.84065 1.54679 6.52065 1.73345 6.83398 2.26012L6.90732 2.38679C7.50732 3.43345 8.49398 3.43345 9.10065 2.38679L9.17398 2.26012C9.48732 1.73345 10.1673 1.54679 10.694 1.86012L11.8473 2.52012C12.454 2.86679 12.6607 3.64679 12.314 4.24679C11.7073 5.29345 12.2007 6.14679 13.4073 6.14679C14.1007 6.14679 14.674 6.71345 14.674 7.41345V8.58679C14.674 9.28012 14.1073 9.85345 13.4073 9.85345C12.2007 9.85345 11.7073 10.7068 12.314 11.7535C12.6607 12.3601 12.454 13.1335 11.8473 13.4801L10.694 14.1401C10.1673 14.4535 9.48732 14.2668 9.17398 13.7401L9.10065 13.6135C8.50065 12.5668 7.51398 12.5668 6.90732 13.6135L6.83398 13.7401C6.52065 14.2668 5.84065 14.4535 5.31398 14.1401L4.16065 13.4801C3.55398 13.1335 3.34732 12.3535 3.69398 11.7535C4.30065 10.7068 3.80732 9.85345 2.60065 9.85345C1.90065 9.85345 1.33398 9.28012 1.33398 8.58679Z" stroke="#46B0E6" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="round" stroke-linejoin="round"></path>
                                    </svg>
                                </i>
                                Add New Evaluation Forms
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- questionnaire form -->
    <div class="modal fade" id="addquestionnaireModal" aria-hidden="true" aria-labelledby="addquestionnaireModalLabel" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false">
        <div class="modal-dialog modal-dialog-centered modal-custom">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addevaluaionModalLabel"><i>
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <rect width="24" height="24" rx="12" fill="#EFF0F5"/>
                                <path opacity="0.4" d="M14.794 5.33325H9.20732C6.78065 5.33325 5.33398 6.77992 5.33398 9.20659V14.7866C5.33398 17.2199 6.78065 18.6666 9.20732 18.6666H14.7873C17.214 18.6666 18.6607 17.2199 18.6607 14.7933V9.20659C18.6673 6.77992 17.2207 5.33325 14.794 5.33325Z" fill="#8E90AA"/>
                                <path d="M14.5 10.5H9.5C9.22667 10.5 9 10.2733 9 10C9 9.72667 9.22667 9.5 9.5 9.5H14.5C14.7733 9.5 15 9.72667 15 10C15 10.2733 14.7733 10.5 14.5 10.5Z" fill="#8E90AA"/>
                                <path d="M14.5 14.5H9.5C9.22667 14.5 9 14.2733 9 14C9 13.7267 9.22667 13.5 9.5 13.5H14.5C14.7733 13.5 15 13.7267 15 14C15 14.2733 14.7733 14.5 14.5 14.5Z" fill="#8E90AA"/>
                            </svg>
                        </i>Questionnaire</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body filtersBody">
                    <div class="form-group">
                        <input type="text" class="form-control searchField" placeholder="Search Forms">
                    </div>
                    <ul id="displayQuestionnaires" class="evList">
                        <?php foreach ($this->questionnaires as $questionnaire): ?>
                            <li>
                                <div class="evName" data-id="<?php echo $questionnaire['questionnaireID']; ?>">
                                    <?php echo $questionnaire['title'];  ?>
                                </div>
                                <div class="evRight">
                                    <div class="evRight01">
                                        <?php if($questionnaire['questionnaireID'] == 1): ?>
                                            <span class="badgecstm badgecstm-active">Active</span>
                                        <?php else:?>
                                            <span class="badgecstm badgecstm-inactive">Inactive</span>
                                        <?php endif;?>
                                    </div>
                                    <div class="evRight02 questionnaire-select">
                                        <a href="javascript:void(0)" class="custom-select btn btn-sm btnInfo_cstm">Select</a>
                                        <span class="evSelected">
                                          <a href="javascript:void(0)" class="custom-unselect">

                                            <i>
                                                <svg width="12" height="12" viewBox="0 0 12 12" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path d="M6 11C8.75 11 11 8.75 11 6C11 3.25 8.75 1 6 1C3.25 1 1 3.25 1 6C1 8.75 3.25 11 6 11Z" stroke="#097732" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path>
                                                    <path d="M3.875 5.99996L5.29 7.41496L8.125 4.58496" stroke="#097732" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path>
                                                </svg>
                                            </i>
                                            Selected
                                          </a>
                                        </span>
                                    </div>
                                </div>
                            </li>
                        <?php endforeach; ?>
                    </ul>
                </div>
                <div class="modal-footer">
                    <div class="modalfoot-btns">
                        <div class="mfb-left">
                            <a href="<?php echo(CATSUtility::getIndexName()); ?>?m=settings&a=careerPortalSettings" class="blueLink" target="_blank">
                                <i>
                                    <svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M8 10C9.10457 10 10 9.10457 10 8C10 6.89543 9.10457 6 8 6C6.89543 6 6 6.89543 6 8C6 9.10457 6.89543 10 8 10Z" stroke="#46B0E6" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="round" stroke-linejoin="round"></path>
                                        <path d="M1.33398 8.58679V7.41345C1.33398 6.72012 1.90065 6.14679 2.60065 6.14679C3.80732 6.14679 4.30065 5.29345 3.69398 4.24679C3.34732 3.64679 3.55398 2.86679 4.16065 2.52012L5.31398 1.86012C5.84065 1.54679 6.52065 1.73345 6.83398 2.26012L6.90732 2.38679C7.50732 3.43345 8.49398 3.43345 9.10065 2.38679L9.17398 2.26012C9.48732 1.73345 10.1673 1.54679 10.694 1.86012L11.8473 2.52012C12.454 2.86679 12.6607 3.64679 12.314 4.24679C11.7073 5.29345 12.2007 6.14679 13.4073 6.14679C14.1007 6.14679 14.674 6.71345 14.674 7.41345V8.58679C14.674 9.28012 14.1073 9.85345 13.4073 9.85345C12.2007 9.85345 11.7073 10.7068 12.314 11.7535C12.6607 12.3601 12.454 13.1335 11.8473 13.4801L10.694 14.1401C10.1673 14.4535 9.48732 14.2668 9.17398 13.7401L9.10065 13.6135C8.50065 12.5668 7.51398 12.5668 6.90732 13.6135L6.83398 13.7401C6.52065 14.2668 5.84065 14.4535 5.31398 14.1401L4.16065 13.4801C3.55398 13.1335 3.34732 12.3535 3.69398 11.7535C4.30065 10.7068 3.80732 9.85345 2.60065 9.85345C1.90065 9.85345 1.33398 9.28012 1.33398 8.58679Z" stroke="#46B0E6" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="round" stroke-linejoin="round"></path>
                                    </svg>
                                </i>
                                Manage Questionnaires
                            </a>
                        </div>
                        <div class="mfb-right">
                            <a href="<?php echo(CATSUtility::getIndexName()); ?>?m=settings&a=careerPortalQuestionnaire" class="blueLink" target="_blank">
<!--                                <i>-->
<!--                                    <svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">-->
<!--                                        <path d="M8 10C9.10457 10 10 9.10457 10 8C10 6.89543 9.10457 6 8 6C6.89543 6 6 6.89543 6 8C6 9.10457 6.89543 10 8 10Z" stroke="#46B0E6" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="round" stroke-linejoin="round"></path>-->
<!--                                        <path d="M1.33398 8.58679V7.41345C1.33398 6.72012 1.90065 6.14679 2.60065 6.14679C3.80732 6.14679 4.30065 5.29345 3.69398 4.24679C3.34732 3.64679 3.55398 2.86679 4.16065 2.52012L5.31398 1.86012C5.84065 1.54679 6.52065 1.73345 6.83398 2.26012L6.90732 2.38679C7.50732 3.43345 8.49398 3.43345 9.10065 2.38679L9.17398 2.26012C9.48732 1.73345 10.1673 1.54679 10.694 1.86012L11.8473 2.52012C12.454 2.86679 12.6607 3.64679 12.314 4.24679C11.7073 5.29345 12.2007 6.14679 13.4073 6.14679C14.1007 6.14679 14.674 6.71345 14.674 7.41345V8.58679C14.674 9.28012 14.1073 9.85345 13.4073 9.85345C12.2007 9.85345 11.7073 10.7068 12.314 11.7535C12.6607 12.3601 12.454 13.1335 11.8473 13.4801L10.694 14.1401C10.1673 14.4535 9.48732 14.2668 9.17398 13.7401L9.10065 13.6135C8.50065 12.5668 7.51398 12.5668 6.90732 13.6135L6.83398 13.7401C6.52065 14.2668 5.84065 14.4535 5.31398 14.1401L4.16065 13.4801C3.55398 13.1335 3.34732 12.3535 3.69398 11.7535C4.30065 10.7068 3.80732 9.85345 2.60065 9.85345C1.90065 9.85345 1.33398 9.28012 1.33398 8.58679Z" stroke="#46B0E6" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="round" stroke-linejoin="round"></path>-->
<!--                                    </svg>-->
<!--                                </i>-->
                                <i class="addbtnIcon iconsax-linear isax-add"></i>
                                Create Questionnaires
                            </a>
                        </div>
						
						 <div class="mfb-right1">
                            <a href="<?php echo(CATSUtility::getIndexName()); ?>?m=settings&a=careerPortalQuestionnaire" class="blueLink" target="_blank">
<!--                                <i>-->
<!--                                    <svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">-->
<!--                                        <path d="M8 10C9.10457 10 10 9.10457 10 8C10 6.89543 9.10457 6 8 6C6.89543 6 6 6.89543 6 8C6 9.10457 6.89543 10 8 10Z" stroke="#46B0E6" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="round" stroke-linejoin="round"></path>-->
<!--                                        <path d="M1.33398 8.58679V7.41345C1.33398 6.72012 1.90065 6.14679 2.60065 6.14679C3.80732 6.14679 4.30065 5.29345 3.69398 4.24679C3.34732 3.64679 3.55398 2.86679 4.16065 2.52012L5.31398 1.86012C5.84065 1.54679 6.52065 1.73345 6.83398 2.26012L6.90732 2.38679C7.50732 3.43345 8.49398 3.43345 9.10065 2.38679L9.17398 2.26012C9.48732 1.73345 10.1673 1.54679 10.694 1.86012L11.8473 2.52012C12.454 2.86679 12.6607 3.64679 12.314 4.24679C11.7073 5.29345 12.2007 6.14679 13.4073 6.14679C14.1007 6.14679 14.674 6.71345 14.674 7.41345V8.58679C14.674 9.28012 14.1073 9.85345 13.4073 9.85345C12.2007 9.85345 11.7073 10.7068 12.314 11.7535C12.6607 12.3601 12.454 13.1335 11.8473 13.4801L10.694 14.1401C10.1673 14.4535 9.48732 14.2668 9.17398 13.7401L9.10065 13.6135C8.50065 12.5668 7.51398 12.5668 6.90732 13.6135L6.83398 13.7401C6.52065 14.2668 5.84065 14.4535 5.31398 14.1401L4.16065 13.4801C3.55398 13.1335 3.34732 12.3535 3.69398 11.7535C4.30065 10.7068 3.80732 9.85345 2.60065 9.85345C1.90065 9.85345 1.33398 9.28012 1.33398 8.58679Z" stroke="#46B0E6" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="round" stroke-linejoin="round"></path>-->
<!--                                    </svg>-->
<!--                                </i>-->
                                <i class="addbtnIcon iconsax-linear isax-add"></i>
                                Create Questionnaires
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</form>
<script type="text/javascript">
    document.addJobOrderForm.title.focus();
    <?php
    /*
    if (isset($this->jobOrderSourceRS['companyID'])): ?>updateCompanyData('<?php echo($this->sessionCookie); ?>');<?php endif;
    */
    ?>
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.js"></script>


<script>
        $("#publishbtn").on("click" , function(){
            if($("#addJobOrderForm").valid() == false){
                $(".toaster-message").addClass('visible-toaster');

                setTimeout(function() {
                    $(".toaster-message").removeClass('visible-toaster');
                }, 4000);

            }
        })
        $("#close-toaster").on("click" , function (){
            $(".toaster-message").removeClass('visible-toaster');
        })

        function calendlyEnabler(){
            //console.log(jQuery('#calendlyEnable').is(':checked'))
            // console.log(jQuery(el).is(':checked'))
            //if(jQuery(el).is(':checked')) {
            if(jQuery('#calendlyEnable').is(':checked')) {
                jQuery('.addJob-box.calendly-boxGray h4').next().slideDown('fast')
                //jQuery('.employeeAutoFill').closest('.form-group').find('.chosen-container').removeClass('active-with-btn');
            }
            else {
                jQuery('.addJob-box.calendly-boxGray h4').next().slideUp('fast')
                //jQuery('.employeeAutoFill').closest('.form-group').find('.chosen-container').addClass('active-with-btn');
            }
        }
    $(document).ready(function (){


        // $('#Interviewer_1_chosen').remove();

        $('.employeeAutoFill').chosen({
            "disable_search": false
        });

        // chosen-interview-stages
        $('.chosen-interview-stages').chosen({
            "disable_search": true,
            "placeholder": "Select Interview Stages For Evaluation"
        });
        calendlyEnabler();

        // $('.employeeAutoFill').select2({
        //     width: '100%', // need to override the changed default
        //     closeOnSelect: false,
        // });

        //    form validation
         $("#addJobOrderForm").validate({
            // Specify validation rules
            rules: {
                title: "required",
                type: "required",
                openings: "required",
                department: "required",
                country: "required",
                state: "required",
                city: "required",
                recruiter: "required",
            },
            messages: {
                title: {
                    required: "Please enter job title",
                },
                type: {
                    required: "Please select job type",
                },
                openings: {
                    required: "Please select number of Openings",
                },
                department: {
                    required: "Please select department name",
                },
                country: {
                    required: "Please select country",
                },
                state: {
                    required: "Please select state",
                },
                city: {
                    required: "Please select city",
                },
                recruiter: {
                    required: "Please select Recruiter",
                },
            },

        });

        $('.opening-chosen').chosen({
            "disable_search": false
        });

        $('.questionnaire-select .custom-select').click(function (){
            $('.defualtQuestionBtn').show();
            $('.questionBtn').hide();
            $('.customModalBtn').hide();
        });

        $('.evaluation-select .custom-select').click(function (){
            $('.defualtFormBtn').show();
            $('.formBtn').hide();
        });
    });


    //    update states and cities
    <?php echo "var countries = ".json_encode($this->allCititesStatesRS['countries'])."; "; ?>
    <?php echo "var states = ".json_encode($this->allCititesStatesRS['states'])."; "; ?>
    <?php echo "var cities = ".json_encode($this->allCititesStatesRS['cities'])."; "; ?>


    function showHideEvaluationFormButton(){
        var evalBadges = $('.custom-evaluation-title');
        var showBadgesOrNot, showResetOrNot = true;
        for(let j=0; j<evalBadges.length; j++) {
            // console.log(jQuery(evalBadges[j]).find('span').html() != "")
            if (jQuery(evalBadges[j]).find('span').html() != ""){
                // alert('yes')
                console.log(jQuery(evalBadges[j]).find('span').html())
                // $('.defualtFormBtn').show();
                // $('.formBtn').hide();
                //jQuery(evalBadges[j]).closest('li').show();
                jQuery(evalBadges[j]).closest('li').css('display', 'inline-block');
                showBadgesOrNot = true;
            }
            else {
                // alert('no')
                showResetOrNot = false;
                jQuery(evalBadges[j]).closest('li').hide();
            }
        }
        if(showBadgesOrNot) {
            // alert('yes')
            $('.evaluation-form').show();
            $('.defualtFormBtn').show();
            $('.formBtn').hide();
        }
        else {
            // alert('no')
            $('.defualtFormBtn').hide();
            $('.formBtn').show();
        }
        if(showResetOrNot) {
            $('#resetEvaluationBtn').show();
            // alert('showReset')
        }
        else{
            // alert('showResetNot')
            $('#resetEvaluationBtn').hide();
        }
}
    function updateStates(el){
        var country_id = $(el).val();
        $("#state").empty();
        $("#city").empty();
        $("#state").append("<option value=''>Select State</option>");
        $.each(states[country_id], function(i, e){
            $("#state").append("<option value='" + i + "'>" + e + "</option>");
        });
        $('#state').trigger("chosen:updated");
    }
    function updateCities(el) {
        var state_id = $(el).val();
        $("#city").empty();
        $("#city").append("<option selected value=''>Select City</option>");
        $.each(cities[state_id], function (i, e) {
            $("#city").append("<option value='" + i + "'>" + e + "</option>");
        });
        $('#city').trigger("chosen:updated");
    }
    jQuery(document).ready(function(){

        if(jQuery(".linkedintab .upload_file").length > 0){
        initFileUploader(".linkedintab .upload_file");
    }

    });
    function initFileUploader(target) {
        var previewNode = document.querySelector(".linkedintab .zdrop-template");
        previewNode.id = "";
        var previewTemplate = previewNode.parentNode.innerHTML;
        previewNode.parentNode.removeChild(previewNode);


        var zdrop = new Dropzone(target, {
            url: "index.php?m=joborders&p=uploadResume",
            maxFiles:1,
            maxFilesize:30,
            previewTemplate: previewTemplate,
            previewsContainer: ".linkedintab #previews",
            clickable: ".linkedintab #upload-label",
            acceptedFiles: '.png, .jpg , .jpeg',

            success: function(file, response){
                parsedResponse = JSON.parse(response);
                //console.log(parsedResponse);

                // Success Case
                if(parsedResponse.token != 'error'){
                    $('.linkedintab #token').val(parsedResponse.token);
                    $('.linkedintab .file_id').attr('value', parsedResponse.id);

                    // Making Files retrival URL
                    var currentUrl = window.location.href;
                    var base_url =  currentUrl.substring(0,currentUrl.lastIndexOf("/"));
                    $('.linkedintab .show_file').css("display", "block");
                    $('.linkedintab .show_file').attr('href', base_url + '/' + parsedResponse.file_url);





                    }
                },
            error: function(){
                console.log("error");
            }

        });

        zdrop.on("addedfile", function(file) {
            jQuery('.linkedintab .preview-container').addClass("visible");
            jQuery(".linkedintab .upload-file-wrapper").hide();
        });

        zdrop.on("removedfile", function(file) {
            jQuery('.linkedintab .preview-container').removeClass("visible");
            jQuery(".linkedintab .upload-file-wrapper").show();
        });

        zdrop.on("totaluploadprogress", function (progress) {
            var progr = document.querySelector(".linkedintab .progress .determinate");
            if (progr === undefined || progr === null)
                return;

            progr.style.width = progress + "%";
        });

        zdrop.on('dragenter', function () {
            jQuery('.linkedintab .upload-file-wrapper').addClass("active");
        });

        zdrop.on('dragleave', function () {
            jQuery('.linkedintab .upload-file-wrapper').removeClass("active");
        });

        zdrop.on('drop', function () {
            jQuery('.linkedintab .upload-file-wrapper').removeClass("active");
        });

        // let mockFile = { name: "Filename", size: 12345 };
        // zdrop.displayExistingFile(mockFile, 'images/login-user.png');

        // let fileCountOnServer = 1; // The number of files already uploaded
        // zdrop.options.maxFiles = zdrop.options.maxFiles - fileCountOnServer;

    }

</script>

<?php
$AUIEO_CONTENT=ob_get_clean();
?>
