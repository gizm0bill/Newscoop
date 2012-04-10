{
  title: 'Abos',
  text:   '<b>Abo</b>',
  card:   false,
  type:   'section',
  url:    '{{ url options="publication" }}abo',
  leaf:   false,
  items: [
    {
      title:          'Abos',
      text:           {{ strip }}'
                      <div class="abo-nav-h">2-Jahresabo</div> 
                      <ul class="check-list">
                        <li>420 Franken für 2 Jahre</li>
                        <li>Jeden Freitag im Briefkasten</li>
                        <li>21% günstiger als im Einzelverkauf</li>
                      </ul>'
                      {{ /strip }},
      type:           'section',
      url:            '{{ url options="issue" }}abo/2-jahresabo',
      leaf:           false,
      items: [
        {
          title:          'Abos',
          text:           '<div class="abo-subnav-h">Jetzt online bestellen</div>',
          card:           cardPanel.aboPanel_3,
          type:           'static',
          leaf:           true,
        },
        {
          title:          'Abos',
          text:           '<div class="abo-subnav-h">Verschenken</div>',
          card:           cardPanel.aboPanel_13,
          type:           'static',
          leaf:           true,
        },
      ]
    },
    {
      title:          'Abos',
      text:           {{ strip }}'
                      <div class="abo-nav-h">1-Jahresabo</div>
                      <ul class="check-list">
                        <li>220 Franken pro Jahr</li>
                        <li>Jeden Freitag im Briefkasten</li>
                        <li>17% günstiger als im Einzelverkauf</li>
                      </ul>'
                      {{ /strip }},
      type:           'section',
      url:            '{{ url options="publication" }}abo/1-jahresabo',
      leaf:           false,
      items: [
        {
          title:          'Abos',
          text:           '<div class="abo-subnav-h">Jetzt online bestellen</div>',
          card:           cardPanel.aboPanel_2,
          type:           'static',
          leaf:           true,
        },
        {
          title:          'Abos',
          text:           '<div class="abo-subnav-h">Verschenken</div>',
          card:           cardPanel.aboPanel_12,
          type:           'static',
          leaf:           true,
        },
      ]
    },
    {
      title:          'Abos',
      text:           {{ strip }}'
                      <div class="abo-nav-h">Halbjahres-Abo</div>
                      <ul class="check-list">
                        <li>115 Franken für 6 Monate</li>
                        <li>Jeden Freitag im Briefkasten</li>
                        <li>11% günstiger als im Einzelverkauf</li>
                      </ul>'
                      {{ /strip }},
      type:           'section',
      url:            '{{ url options="publication" }}abo/halbjahresabo',
      leaf:           false,
      items: [
        {
          title:          'Abos',
          text:           '<div class="abo-subnav-h">Jetzt online bestellen</div>',
          card:           cardPanel.aboPanel_1,
          type:           'static',
          leaf:           true,
        },
        {
          title:          'Abos',
          text:           '<div class="abo-subnav-h">Verschenken</div>',
          card:           cardPanel.aboPanel_11,
          type:           'static',
          leaf:           true,
        },
      ]
    },
    {
      title:          'Abos',
      text:           {{ strip }}'
                      <div class="abo-nav-h">Für Studierende</div>
                      <ul class="check-list">
                        <li>79 Franken pro Semester (6 Monate)</li>
                        <li>Schüler, Lehrlinge, FH, Uni</li>
                        <li>Jeden Freitag im Briefkasten</li>
                      </ul>'
                      {{ /strip }},
      type:           'section',
      url:            '{{ url options="publication" }}abo/studierende',
      leaf:           false,
      items: [
        {
          title:          'Abos',
          text:           '<div class="abo-subnav-h">Jetzt online bestellen</div>',
          card:           cardPanel.aboPanel_6,
          type:           'static',
          leaf:           true,
        },
        {
          title:          'Abos',
          text:           '<div class="abo-subnav-h">Verschenken</div>',
          card:           cardPanel.aboPanel_16,
          type:           'static',
          leaf:           true,
        },
      ]
    },
    {
      title:          'Abos',
      text:           {{ strip }}'
                      <div class="abo-nav-h">Gastro, Praxen</div>
                      <ul class="check-list">
                        <li>Zwei Abos zum Preis von einem</li>
                        <li>220 Franken pro Jahr</li>
                        <li>Jeden Freitag zwei Zeitungen zum Auflegen</li>
                      </ul>'
                      {{ /strip }},
      type:           'section',
      url:            '{{ url options="publication" }}abo/gastronomie',
      leaf:           false,
      items: [
        {
          title:          'Abos',
          text:           '<div class="abo-subnav-h">Jetzt online bestellen</div>',
          card:           cardPanel.aboPanel_5,
          type:           'static',
          leaf:           true,
        },
      ]
    },
  ]
}