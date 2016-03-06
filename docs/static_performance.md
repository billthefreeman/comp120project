###**1. The optimization techniques we used:**
####**1.1 Expiry**   

**Purpose:** Avoids unnecessary HTTP requests on subsequent page views and static content.

**Implementation:** In the show page, we added cache control and expiry headers for incident’s image. Caching images improves the user experience and reduces S3 costs. It improves the user’s experience because web pages load quicker as images are already cached and it reduces S3 costs since you have fewer transfers. In the index page, we have static component: background image which is stored in public folder. Rails uses ActionDispatch::Static to serve /public. This middleware is active when config.serve_static_assets is true. And it takes one argument: the value for the Cache-Control header. After activating the middleware and setting cache control header, all requests to components in public folder are publicly cached with a far future expire. 

####**1.2 Content delivery network (CDN)**

**Purpose:** Deploying content across multiple, geographically dispersed servers to make pages load faster from the user's perspective.

**Implementation:** We use the Google Hosted Libraries content delivery network to serve jQuery to users directly from Google’s network of datacenters; we used MaxCDN to serve bootstrap.

####**1.3 JavaScript at the bottom & CSS at the top of pages**

**Purpose:** make sure our HTML content and css of our page loaded first, so our users don't have to wait for a script to finish downloading before they see something in our application.

**Implementation:** We moved all our JS code to the bottom of each view page.

####**1.4 JavaScript and CSS minification**

**Purpose:** Reduce the size of our resources by removing unnecessary or redundant code.

**Implementation:** We used a minifying tool, called “HTML Minifier” to minify our HTML and some CSS and JS included in our markup.

####**1.5 gzip:**

**Purpose:** Enabling gzip compression can reduce the size of the transferred response, which can significantly reduce the amount of time to download the resource, reduce data usage for the client, and improve the time to first render of pages.

**Implementation:** We installed a gem “heroku_rails_deflate” from https://github.com/mattolson/heroku_rails_deflate

###**2. The tools we used to test the performance of our product before and after optimizations made:**

We used ‘YSlow’ to test the performance of our product because it provides us with comprehensive test rules (23 of 34 rules that Yahoo!'s Exceptional Performance team has identified affecting web page performance)
We also use ‘Audits in Google Developer Tools’ and ‘PageSpeed Insights’ to confirm our inprovement. 

###**3. The performance aspects have been improved:**
####**3.1 YSlow:**

Before optimization, our overall performance score in YSlow is 88(B). The grade for some aspects that need to be improved are as follows: 
Use a Content Delivery Network: F

Add Expires headers: F

Compress component with gzip: B

Put CSS at top, Put Javascript at buttom, Minify Javascript and CSS: A (but there are several comments about the issues we need to fix)

![image](https://github.com/FanyingYe/FanyingYe.github.io/raw/master/images/comp120/Picture88.png)

1) After using Expiry technic, the grade for Add Expires headers improved to D and the overall performance score improved to 92(A).

![image](https://github.com/FanyingYe/FanyingYe.github.io/raw/master/images/comp120/Picture92.png)

2) After using Content Delivery Network, the grade for Use a Content Delivery Network improved to A, the grade for Add Expires headers improved to A. The the overall performance score improved to 97(A).

![image](https://github.com/FanyingYe/FanyingYe.github.io/raw/master/images/comp120/97.png)

3) There was issue about expired header of our background img. After fixing that and using gzip technic, the grade for Compress component with gzip improved to A and the overall performance score improved to 98(A). 

![image](https://github.com/FanyingYe/FanyingYe.github.io/raw/master/images/comp120/Picture98.png)

4) After putting CSS at the top and put Javascript at the buttom, the overall performance score improved to 99(A).

![image](https://github.com/FanyingYe/FanyingYe.github.io/raw/master/images/comp120/Picture99.png) 
 
5) Finally, after minifying Javascript and CSS, the overall performance score improved to 100(A). 

![image](https://github.com/FanyingYe/FanyingYe.github.io/raw/master/images/comp120/Picture100.png)

####**3.2 PageSpeed Insights:**

Before optimization, our overall performance score in PageSpeed is 88. 

After optimizaion, the score increases to 89. Although there is only 1 point difference, we eliminated several warnings, such as “Consider Fixing: Enable compression”, “Consider Fixing: Leverage browser caching” and “Minify HTML”. The relatively low score is because we could not “Eliminate render-blocking JavaScript and CSS in above-the-fold content”, which we will discuss in part 4. This is the only issue PageSpeed reported but it took lots of ponits off.

![image](https://github.com/FanyingYe/FanyingYe.github.io/raw/master/images/comp120/pagespeed1.jpg)

![image](https://github.com/FanyingYe/FanyingYe.github.io/raw/master/images/comp120/pagespeed2.jpg)

#####**3.3 Audits in Google Developer Tools**

Before optimization, there is a problem with putting css in the document head.

After we did the fifth step in 3.1 and reduced some unused CSS rules, we fixed this problem and got fewer unused CSS rules.

![image](https://github.com/FanyingYe/FanyingYe.github.io/raw/master/images/comp120/before.png)

![image](https://github.com/FanyingYe/FanyingYe.github.io/raw/master/images/comp120/after.png)

###**4. The lingering potential performance issues:**

PageSpeed reported an issue that “Your page has 2 blocking CSS resources. This causes a delay in rendering your page.” This is due to the following URL in our HTML files: https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css
Our page has to wait for the resource to load before rendering. But we cannot fix it by simply inlining the CSS file, because inlining large data URIs can cause the size of our above-the-fold HTML to be larger, which will slow down page render time. So we decided to leave as it is.
