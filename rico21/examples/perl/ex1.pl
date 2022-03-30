#!/usr/local/bin/perl

use CGI qw/:standard default_dtd/;
require 'settings.pl';
$settings=GridSettingsScript();
$menuopts=GridSettingsMenu();

$LGincludes=<<END;
Rico.loadModule('LiveGrid','LiveGridMenu');
Rico.onLoad( function() {
  var opts = {  
    $settings,
    defaultWidth : 90,
    useUnformattedColWidth: false,
    columnSpecs   : ['specQty']
  };
  var ex1=new Rico.LiveGrid ('ex1', new Rico.Buffer.Base(\$('ex1').tBodies[0]), opts);
  ex1.menu=new Rico.GridMenu($menuopts);
});
END
if ($style) {
  $LGincludes.="\nRico.include('$style.css');";
}

default_dtd('-//W3C//DTD HTML 4.01//EN', 'http://www.w3.org/TR/html4/strict.dtd');
print header( -type => "text/html" );
print start_html(-dtd=>1,
                 -title => 'Rico LiveGrid Plus-Example 1',
                 -style => '../client/css/demo.css',
                 -script=>[
                           { -language => 'JavaScript',
                             -src      => '../../src/rico.js'
                           },
                           { -language => 'JavaScript',
                             -code     => $LGincludes
                           }
                        ]
                 );


print "<table id='explanation' border='0' cellpadding='0' cellspacing='5' style='clear:both'><tr valign='top'><td>";
GridSettingsForm();

print <<END;
</td><td>This example demonstrates a pre-filled grid (no AJAX data fetches). 
LiveGrid just provides scrolling, column resizing, filtering, and sorting capabilities.
The first column sorts numerically, the others sort in text order.
</td></tr></table>
<p class="ricoBookmark"><span id="ex1_bookmark">&nbsp;</span></p>
<table id="ex1" class="ricoLiveGrid" cellspacing="0" cellpadding="0">
END

$numcol=15;
print "<thead><tr>";

for ($c=1; $c<=$numcol; $c++) {
  print "<th>Column $c</th>";
}

print "</tr></thead><tbody>";

for ($r=1; $r<=100; $r++) {
  print "<tr>";
  print "<td>$r</td>";
  for ($c=2; $c<=$numcol; $c++) {
    print "<td>Cell $r:$c</td>";
  }
  print "</tr>";
}
print "</tbody></table>";
print end_html;
