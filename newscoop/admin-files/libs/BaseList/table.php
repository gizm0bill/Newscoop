<?php
/**
 * @package Campsite
 *
 * @author Petr Jasek <petr.jasek@sourcefabric.org>
 * @copyright 2010 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl.txt
 * @link http://www.sourcefabric.org
 */
?>
<div class="table">

<table id="table-<?php echo $this->id; ?>" cellpadding="0" cellspacing="0" class="datatable <?php echo strtolower(get_class($this)); ?>">
<thead>
    <tr>
        <?php foreach ($this->cols as $title) { ?>
        <?php if ($title === NULL) { ?>
        <th><input type="checkbox" /></th>
        <?php } else { ?>
        <th><?php echo $title; ?></th>
        <?php }} ?>
    </tr>
</thead>
<tbody>
<?php if ($this->items === NULL) { ?>
    <tr><td colspan="<?php echo sizeof($this->cols); ?>"><?php putGS('Loading data'); ?></td></tr>
<?php } else if (!empty($this->items)) { ?>
    <?php foreach ($this->items as $item) { ?>
    <tr>
        <?php foreach ($item as $row) { ?>
        <td><?php echo $row; ?></td>
        <?php } ?>
    </tr>
    <?php } ?>
<?php } ?>
</tbody>
</table>
</div>
<?php if (!self::$renderTable) { ?>
<script type="text/javascript"><!--
tables = [];
filters = [];
--></script>
<?php } // render ?>
<script type="text/javascript"><!--
$(document).ready(function() {
var table = $('#table-<?php echo $this->id; ?>');
tables['<?php echo $this->id; ?>'] = table.dataTable({
    'bAutoWidth': true,
    'bDestroy': true,
    'bJQueryUI': true,
    'bStateSave': true,
    'sDom': '<?php echo $this->getSDom(); ?>',
    'aaSorting': [<?php echo $this->getSorting(); ?>],
    'oLanguage': {
        'oPaginate': {
            'sNext': '<?php putGS('Next'); ?>',
            'sPrevious': '<?php putGS('Previous'); ?>',
        },
        'sZeroRecords': '<?php putGS('No records found.'); ?>',
        'sSearch': '<?php putGS('Search'); ?>:',
        'sInfo': '<?php putGS('Showing _START_ to _END_ of _TOTAL_ entries'); ?>',
        'sEmpty': '<?php putGS('No entries to show'); ?>',
        'sInfoFiltered': '<?php putGS(' - filtering from _MAX_ records'); ?>',
        'sLengthMenu': '<?php putGS('Display _MENU_ records'); ?>',
        'sInfoEmpty': '',
    },
    'aoColumnDefs': [
        { // inputs for id
            'fnRender': function(obj) {
                var id = obj.aData[0];
                return '<input type="checkbox" name="item[]" value="' + id + '" />';
            },
            'aTargets': [0]
        },
        <?php if (is_int($this->inUseColumn)) { ?>
        { // inputs for id
            'fnRender': function(obj) {
                var inUse = obj.aData[0];
                if (obj.aData[<?php echo $this->inUseColumn; ?>]) {
                    return '<span class="used"><?php putGS('Yes'); ?></span>';
                } else {
                    return '<span><?php putGS('No'); ?></span>';
                }
            },
            'bSortable': false,
            'aTargets': [<?php echo $this->inUseColumn; ?>]
        },
        <?php } ?>
        { // hide columns
            'bVisible': false,
            'aTargets': [<?php echo implode(', ', $this->hidden); ?>]
        },
        { // not sortable
            'bSortable': false,
            'aTargets': [0, <?php echo implode(', ', $this->notSortable); ?>]
        },
        { // id
            'sClass': 'id',
            'aTargets': [0]
        }
    ],
    'fnDrawCallback': function() {
        $('#table-<?php echo $this->id; ?> tbody tr').click(function(event) {
            if (event.target.type == 'checkbox') {
                return; // checkbox click, handled by it's change
            }

            var input = $('input:checkbox', $(this));
            if (input.attr('checked')) {
                input.removeAttr('checked');
            } else {
                input.attr('checked', 'checked');
            }
            input.change();
        }).each(function() {
            var tr = $(this);
            // detect locks
            if ($('.name .ui-icon-locked', tr).not('.current-user').size()) {
                tr.addClass('locked');
            }
        });

        $('#table-<?php echo $this->id; ?> tbody input:checkbox').change(function() {
            if ($(this).attr('checked')) {
                $(this).parents('tr').addClass('selected');
            } else {
                $(this).parents('tr').removeClass('selected');
            }
        });

        $('#table-<?php echo $this->id; ?> thead input:checkbox').change(function() {
            var main = $(this);
            $('#table-<?php echo $this->id; ?> tbody input:checkbox').each(function() {
                if (main.attr('checked')) {
                    $(this).attr('checked', 'checked');
                } else {
                    $(this).removeAttr('checked');
                }
                $(this).change();
            });
        });

        <?php if (!$this->clickable) { ?>
        $('#table-<?php echo $this->id; ?> tbody a').click(function() {
            $(this).closest('tr').click();
            return false;
        }).css('cursor', 'default');
        <?php } ?>
    },
	'fnCookieCallback': function (sName, oData, sExpires, sPath) {
        oData['abVisCols'] = []; // don't save visibility
		return sName + "="+JSON.stringify(oData)+"; expires=" + sExpires +"; path=" + sPath;
	},
    <?php if ($this->items !== NULL) { // display all items ?>
    'bPaging': false,
    'iDisplayLength': <?php echo sizeof($this->items); ?>,
    <?php } else { // no items - server side ?>
    'bServerSide': true,
    'sAjaxSource': '', // callServer handle
    'bPaging': true,
    'sPaginationType': 'full_numbers',
    'fnServerData': function (sSource, aoData, fnCallback) {
        callServer(['<?php echo get_class($this); ?>', 'doData'], aoData, fnCallback);
    },
    <?php } ?>
    <?php if ($this->colVis) { ?>
    'oColVis': { // disable Show/hide column
        'aiExclude': [0, 1],
        'buttonText': '<?php putGS('Show / hide columns'); ?>',
    },
    <?php } ?>
}).css('position', 'relative').css('width', '100%');

});
--></script>
