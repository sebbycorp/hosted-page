Splash page rules

2.	Task: Build Virtual Server Application 
a.	Build and upload a maintenance webpage onto the F5.
b.	SSH into the F5 device ssh x.x.x.x
i.	Login with: root/default
c.	We will build a Maintenance page in the cli.
d.	Build this page 
i.	vi /var/tmp/splash-page.html
e.	using vi add the following text into the page.

<!doctype html>
<title>Site Maintenance</title>
<style>
  body { text-align: center; padding: 150px; }
  h1 { font-size: 50px; }
  body { font: 20px Helvetica, sans-serif; color: #333; }
  article { display: block; text-align: left; width: 650px; margin: 0 auto; }
  a { color: #dc8100; text-decoration: none; }
  a:hover { color: #333; text-decoration: none; }
</style>
<article>
    <h1>We&rsquo;ll be back soon!</h1>
    <div>
        <p>Sorry for the inconvenience but we&rsquo;re performing some maintenance at the moment. If you need to you can always <a href="mailto:#">contact us</a>, otherwise we&rsquo;ll be back online shortly!</p>
        <p>&mdash; The Team</p>
    </div>
</article>


a.	save the file and exit vi.
b.	In the CLI paged following config to add the maintenance page as f5 iFile objects.
c.	tmsh create sys file ifile maintenance-splash-page.html source-path file:/var/tmp/splash-page.html
d.	tmsh create ltm ifile maintenance-splash-page.html file-name maintenance-splash-page.html


3.	Task: Build the Maintenance page iRule. 
a.	Log back into the F5 GUI.
b.	Open Local traffic > iRules, click on Create
c.	Name: main-irule
d.	Paste the following irule into the Definition section.

when HTTP_REQUEST {
  set vsPool [LB::server pool]
  if { [active_members $vsPool] < 1 } {
   # log local0. "Client [IP::client_addr] requested [HTTP::uri] no active nodes available..."
      HTTP::respond 200 content "[ifile get  maintenance-splash-page.html]" "Content-Type" "text/html" noserver "Cache-Control" "no-store, no-cache"
      }
  }


e.	Click on Finished.

4.	Task: Apply the iRule to the virtual server
a.	Open, Local traffic > Virtual Server, and select the dvwa_vs  
b.	Click on the Resource tab
c.	Under the iRules section, click Manage.
d.	Select the main-iule, and click Finished.

