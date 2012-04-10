{{ assign var="lastupdate" value=`$gimme->article->last_update` }}
{{ php }}
$lastupdate = $this->getTemplateVars('lastupdate');

echo "Vor ". LetzterUpdate($lastupdate);

function LetzterUpdate($start, $end=null) {
    if(!($start instanceof DateTime)) {
        $start = new DateTime($start);
    }

    if($end === null) {
        $end = new DateTime();
    }
   
    if(!($end instanceof DateTime)) {
        $end = new DateTime($start);
    }
   
    $interval = $end->diff($start);
    // adds plurals
    $doPlural = function($nb,$str,$plural="s"){return $nb>1?$str.$plural:$str;}; // adds plurals
   
    $format = array();
    if($interval->y !== 0) {
        $format[] = "%y ".$doPlural($interval->y, "Jahr", "e");
    }
    if($interval->m !== 0) {
        $format[] = "%m ".$doPlural($interval->m, "Monat", "e");
    }
    if($interval->d !== 0) {
        $format[] = "%d ".$doPlural($interval->d, "Tag", "e");
    }
    if($interval->h !== 0) {
        $format[] = "%h ".$doPlural($interval->h, "Stunde", "n");
    }
    if($interval->i !== 0) {
        $format[] = "%i ".$doPlural($interval->i, "Minute", "n");
    }
    if($interval->s !== 0) {
        if(!count($format)) {
            return "Vor weniger als einer Minute";
        } else {
            $format[] = "%s ".$doPlural($interval->s, "Sekunde", "n");
        }
    }
   
    // We use the two biggest parts
    if(count($format) > 1) {
        $format = array_shift($format)." und ".array_shift($format);
    } else {
        $format = array_pop($format);
    }
   
    // Prepend 'since ' or whatever you like
    return $interval->format($format);
} 
{{ /php }}
