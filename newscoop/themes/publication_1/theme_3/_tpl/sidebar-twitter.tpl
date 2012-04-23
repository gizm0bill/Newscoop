                <article>
                    <header>
                        <p>Twitter</p>
                    </header>
                    <div class="twitter-box">
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
                    </div>
                </article>