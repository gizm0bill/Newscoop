                <article>
                    <header>
                        <p>Twitter</p>
                    </header>
                    <div class="twitter-box">
                   {{ if $where == "dialog" }}
                    
<script charset="utf-8" src="http://widgets.twimg.com/j/2/widget.js"></script>
<script>
new TWTR.Widget({
  version: 2,
  type: 'list',
  rpp: 30,
  interval: 30000,
  title: '',
  subject: 'Die Redaktion auf Twitter',
  width: 300,
  height: 400,
  theme: {
    shell: {
      background: '#008147',
      color: '#ffffff'
    },
    tweets: {
      background: '#ffffff',
      color: '#444444',
      links: '#008147'
    }
  },
  features: {
    scrollbar: true,
    loop: false,
    live: true,
    behavior: 'all'
  }
}).render().setList('tageswoche', 'team').start();
</script>                    
                  
{{ else }}                 
                    
                        <script src="http://widgets.twimg.com/j/2/widget.js"></script> 
                        <script> 
                        new TWTR.Widget({ 
                          version: 2, 
                          type: 'faves', 
                          rpp: 12, 
                          interval: 30000, 
                          title: '', 
                          subject: 'Tweets des Tages', 
                          width: 'auto', 
                          height: 300, 
                          theme: { 
                            shell: { 
                              background: '#008148', 
                              color: '#ffffff' 
                            }, 
                            tweets: { 
                              background: '#ffffff', 
                              color: '#444444', 
                              links: '#008148' 
                            } 
                          }, 
                          features: { 
                            scrollbar: true, 
                            loop: false, 
                            live: true, 
                            behavior: 'all' 
                          } 
                        }).render().setUser('tageswoche').start(); 
                        </script>
                        
{{ /if }}                        
                        
                    </div>
                </article>