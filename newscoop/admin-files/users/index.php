<?php
require_once($GLOBALS['g_campsiteDir']. "/$ADMIN_DIR/users/users_common.php");
require_once($GLOBALS['g_campsiteDir']. "/classes/SimplePager.php");
camp_load_translation_strings("api");

if (Input::Get('reset_search', 'string', 'false', true) == 'true') {
	reset_user_search_parameters();
}
read_user_common_parameters(); // $uType, $userOffs, $ItemsPerPage, search parameters
verify_user_type();
compute_user_rights($g_user, $canManage, $canDelete);

$typeParam = 'uType=' . urlencode($uType);
$isReader = $uType == 'Subscribers' ? 'Y' : 'N';
$orderField = Input::Get('ordfld', 'string', 'fname');
$orderDir = Input::Get('orddir', 'string', 'asc');
$orderURLs = array('fname'=>'ordfld=fname&orddir=asc', 'uname'=>'ordfld=uname&orddir=asc',
	'cdate'=>'ordfld=cdate&orddir=asc');
$orderSigns = array('fname'=>'', 'uname'=>'', 'cdate'=>'');
$orderFields = array('fname'=>'Name', 'uname'=>'UName', 'cdate'=>'time_created');
if (!array_key_exists($orderField, $orderURLs)) {
	$orderField = 'fname';
	$orderDir = 'asc';
}
foreach($orderURLs as $field=>$fieldURL) {
	$dir = ($orderField == $field ? ($orderDir == 'asc' ? 'desc' : 'asc') : 'asc');
	$orderURLs[$field] = "ordfld=$field&orddir=$dir";
	if ($dir == 'desc') {
		$orderSigns[$field] = "<img src=\"".$Campsite["ADMIN_IMAGE_BASE_URL"]."/search_order_direction_down.png\" border=\"0\">";
	} else {
		$orderSigns[$field] = "<img src=\"".$Campsite["ADMIN_IMAGE_BASE_URL"]."/search_order_direction_up.png\" border=\"0\">";
	}
}

$crumbs = array();
$crumbs[] = array(getGS("Users"), "");
if ($uType == "Staff") {
    $crumbs[] = array(getGS("Staff management"), "");
} else {
    $crumbs[] = array(getGS("Subscriber management"), "");
}
$breadcrumbs = camp_html_breadcrumbs($crumbs);
echo $breadcrumbs;
?>
<script type="text/javascript" src="<?php echo $Campsite['WEBSITE_URL']; ?>/js/campsite.js"></script>
<div class="wrapper mid-sized">

<table border="0" cellspacing="0" cellpadding="0" class="action_buttons">
<tr>
<?php
if ($canManage) {
	$addLink = "edit.php?" . get_user_urlparams(0, true, true, true);
?>
	<td valign="bottom">
		<a href="<?php echo $addLink; ?>">
		<img src="<?php echo $Campsite["ADMIN_IMAGE_BASE_URL"]; ?>/add.png" border="0">
<?php
	if ($uType == "Staff") {
		echo "<b>" . getGS("Add new staff member") . "</b></a></td>";
	} else {
		echo "<b>" . getGS("Add new subscriber") . "</b></a></td>";
	}
}
?>
        </a>
	</td>
<?php if (user_search_is_set()) { ?>
	<td style="padding-left: 20px;" valign="bottom">
		<a href="?reset_search=true&<?php echo get_user_urlparams(0, false, true, true); ?>">
		<img src="<?php echo $Campsite["ADMIN_IMAGE_BASE_URL"]; ?>/clear.png" border="0">
		<b><?php putGS("Reset search form"); ?></b>
		</a>
	</td>
<?php } ?>
</tr>
</table>

<p>
<form method="POST" action="index.php">
<input type="hidden" name="uType" value="<?php p($uType); ?>">
<input type="hidden" name="userOffs" value="0">

<div class="ui-widget-content block-shadow padded-strong user-management">
<fieldset class="plain inline-style clearfix">
<ul class="float-list">
    <li><label for="full_name"><?php putGS("Full Name"); ?></label><input type="text" name="full_name" value="<?php p(htmlspecialchars($userSearchParameters['full_name'])); ?>" class="input_text"></li>
    <li><label for="user_name"><?php putGS("Account Name"); ?></label><input type="text" name="user_name" value="<?php p(htmlspecialchars($userSearchParameters['user_name'])); ?>" class="input_text"></li>
    <li><label for="email"><?php putGS("E-Mail"); ?></label><input type="text" name="email" value="<?php p(htmlspecialchars($userSearchParameters['email'])); ?>" class="input_text"></li>
</ul>
<input type="submit" name="submit_button" value="<?php putGS("Search"); ?>" class="button right-floated">
</fieldset>
<?php if ($uType == "Subscribers") { ?>

<fieldset>
<legend><?php putGS("Subscription"); ?></legend>
		<select name="subscription_how" class="input_select" style="width: 100px;">
		<?php
		camp_html_select_option("expires", $userSearchParameters['subscription_how'], getGS("expires"));
		camp_html_select_option("starts", $userSearchParameters['subscription_how'], getGS("starts"));
		?>
		</select>
		<select name="subscription_when" class="input_select" style="width: 100px;">
		<?PHP
		camp_html_select_option("before", $userSearchParameters['subscription_when'], getGS("before"));
		camp_html_select_option("after", $userSearchParameters['subscription_when'], getGS("after"));
		camp_html_select_option("on", $userSearchParameters['subscription_when'], getGS("on"));
		?>
		</select>
		<input type="text" name="subscription_date" value="<?php p(htmlspecialchars($userSearchParameters['subscription_date'])); ?>" class="input_text" style="width: 100px;"><span class="info-text">(<?php putGS('YYYY-MM-DD'); ?>)</span><?php putGS("status"); ?>:
		<select name="subscription_status" class="input_select" style="width: 100px;">
		<option value=""></option>
		<?PHP
		camp_html_select_option("active", $userSearchParameters['subscription_status'], getGS("active"));
		camp_html_select_option("inactive", $userSearchParameters['subscription_status'], getGS("inactive"));
		?>
		</select>
</fieldset>

<fieldset>
<legend><?php putGS("IP address"); ?></legend>

		<input type="text" class="input_text" name="startIP1" size="3" maxlength="3" value="<?php if ($userSearchParameters['startIP1'] != 0) echo $userSearchParameters['startIP1']; ?>">.
		<input type="text" class="input_text" name="startIP2" size="3" maxlength="3" value="<?php if ($userSearchParameters['startIP2'] != 0) echo $userSearchParameters['startIP2']; ?>">.
		<input type="text" class="input_text" name="startIP3" size="3" maxlength="3" value="<?php if ($userSearchParameters['startIP3'] != 0) echo $userSearchParameters['startIP3']; ?>">.
		<input type="text" class="input_text" name="startIP4" size="3" maxlength="3" value="<?php if ($userSearchParameters['startIP4'] != 0) echo $userSearchParameters['startIP4']; ?>"><span class="info-text">(<?php putGS("fill in from left to right at least one input box"); ?>)</span>
</fieldset>
<?php } // if ($uType == "Subscribers") ?>

</div>
</form>

<?php
camp_html_display_msgs();

$usersSearchResult = get_users_from_search($isReader, $orderFields, $orderField, $orderDir, $totalUsers);

$pager = new SimplePager($totalUsers, $ItemsPerPage, "userOffs", "index.php?".get_user_urlparams(0, false, false, true)."&", false);

if (is_array($usersSearchResult) && sizeof($usersSearchResult) > 0) {
	$nr = sizeof($usersSearchResult);
	$last = $nr > $ItemsPerPage ? $ItemsPerPage : $nr;
	?>
	<table class="indent">
	<tr>
		<td>
			<?php echo $pager->render(); ?>
		</td>
	</tr>
	</table>
	<table border="0" cellspacing="1" cellpadding="3" class="table_list full-sized">
	<tr class="table_list_header">
		<td align="left" valign="middle">
			<table><tr>
			<td><b><a href="?<?php echo $orderURLs['fname'] . '&' . get_user_urlparams(0); ?>"><?php putGS("Full Name"); ?></a></b></td>
			<td><?php if ($orderField == 'fname') echo $orderSigns['fname']; ?></td>
			</tr></table>
		</td>
		<td align="left" valign="middle">
			<table><tr>
			<td><b><a href="?<?php echo $orderURLs['uname'] . '&' . get_user_urlparams(0); ?>"><?php putGS("Account Name"); ?></a></b></td>
			<td><?php if ($orderField == 'uname') echo $orderSigns['uname']; ?></td>
			</tr></table>
		</td>
		<td align="left" valign="middle"><b><?php putGS("E-Mail"); ?></b></td>

		<?php if ($uType == "Subscribers" && $g_user->hasPermission("ManageSubscriptions")) { ?>
		<td align="left" valign="middle"><b><?php putGS("Subscriptions"); ?></b></td>
		<?php } ?>

		<?php if ($uType == "Staff") { ?>
		<td align="left" valign="middle">
			<?php putGS("User Type"); ?>
		</td>
		<?php } ?>

		<td align="left" valign="middle">
			<table><tr>
			<td><b><a href="?<?php echo $orderURLs['cdate'] . '&' . get_user_urlparams(0); ?>"><?php putGS("Creation Date"); ?></a></b></td>
			<td><?php if ($orderField == 'cdate') echo $orderSigns['cdate']; ?></td>
			</tr></table>
		</td>
<?php if ($canDelete) { ?>
		<td align="left" valign="middle"><b><?php putGS("Delete"); ?></b></td>
<?php } ?>
	</TR>
<?php
for($loop = 0; $loop < $last; $loop++) {
        $row = $usersSearchResult[$loop];
	$userId = $row['Id'];
	$rowClass = ($loop + 1) % 2 == 0 ? "list_row_even" : "list_row_odd";
	$editUser = new User($userId);
?>
	<tr <?php echo "class=\"$rowClass\""; ?>>
		<td>
		<?php
			if ($canManage) {
				echo "<a href=\"edit.php?" . get_user_urlparams($userId, false, true, true) . "\">";
			}
			echo htmlspecialchars($row['Name']);
			if ($canManage) {
				echo "</a>";
			}
		?>
		</td>
		<td><?php echo htmlspecialchars($row['UName']); ?></TD>
		<td><?php echo htmlspecialchars($row['EMail']); ?></td>
		<?php if ($uType == "Subscribers" && $g_user->hasPermission("ManageSubscriptions")) { ?>
		<td><a href="<?php echo "/$ADMIN/users/subscriptions/?f_user_id=$userId"; ?>">
			<?php putGS("Subscriptions"); ?>
		</td>
		<?php } ?>

		<?php if ($uType == "Staff") { ?>
		<td><?php
                $userType = new UserType($editUser->getUserType());
                if ($userType) {
                    echo htmlspecialchars($userType->getName());
                }
                unset($userType);
        ?></td>
		<?php } ?>

		<td>
			<?php
				$creationDate = $row['time_created'];
				if ((int)$creationDate == 0) {
					putGS('N/A');
				} else {
					echo $creationDate;
				}
			?>
		</td>
<?php
	if ($canDelete) { ?>
		<td align="center">
			<a href="/<?php echo $ADMIN; ?>/users/do_del.php?<?php echo get_user_urlparams($userId, false, true, true) . '&' . SecurityToken::URLParameter(); ?>" onclick="return confirm('<?php putGS('Are you sure you want to delete the user account $1 ?', $row['UName']); ?>');">
				<img src="<?php echo $Campsite["ADMIN_IMAGE_BASE_URL"]; ?>/delete.png" border="0" ALT="<?php putGS('Delete user $1', $row['UName']); ?>" title="<?php putGS('Delete user $1', $row['UName']); ?>">
			</a>
		</td>
<?php
	}
?>
	</tr>
<?php
}
?>
</table>
<?php /*?>
<table class="indent">
<tr>
	<td>
		<?php echo $pager->render(); ?>
	</td>
</tr>
</table>

<?php */?>
<?php  } else { ?>
	<div class="no-table-data">
	<?php  putGS('User list is empty.'); ?>
	</div>
<?php  } ?>
</div>
<?php camp_html_copyright_notice(); ?>
