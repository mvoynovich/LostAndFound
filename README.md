# itws1100-Team06
# Hound
### RPI's Lost and Found Forum

Our goal is to centralize the flow of information regarding lost and found items across the RPI campus, for staff and students.

Link to group GitHub repository: [github.com/RPI-ITWS/itws1100-Team06](https://github.com/RPI-ITWS/itws1100-Team06)

- For project recap & final writeup, see /resources/Hound Final Write-up.docx.
- For project demo personas, see /resources/ITWS 1100_ Lost & Found Personas.docx.
- For project presentation, see /resources/ITWS 1100 Term Project Slides.pptx.

## Instructions

To use Hound, the first step is to open index.html on a running Apache (or equivalent) server, with MySQL or MariaDB capabilities. Development was done on the localhost via XAMPP but using a provided Azure VM works similarly, as long as the database is copied appropriately. The SQL file to the database and all relevant tables is located in this folder under /resources/Database.sql. After importing this database into the running Apache (or equivalent) server with MySQL/MariaDB, accessing the index.html file allows for access to the application. By selecting the button that either reads you've lost an item or found an item, the application will bring the user (you) to the correct page.

On the lost items page, the body will contain a list of all items marked as *discovered* by users around campus--contrarily, the found/discovered items page will show a list of all items declared lost by users on campus. At the bottom of both pages is a button to complete a form, on the lost items page allowing access to submit an item as lost or on the found items page allowing access to declare an item as found somewhere around campus. By submitting an item and then switching to the opposite form's page, the entry will be visible on the top, sorted by most recent, allowing users who've lost or found belongings to quickly filter through what's been most recently declared lost or found. 

## Information Architecture and Methodology

In order to bring Hound to fruition, several key components needed to communicate harmoniously to deliver content to the user and process and store content uploaded from the user. The Hound application consisted of three core HTML documents: one for the landing page that would link to the other two pages, one for lost items and one for found items. On the home page, contact information for our development team as well as the RPI Public Safety Office were attached, along with a mission statement and the anchored links to navigate between pages. The lost items page displayed all items currently uploaded as found around campus, with a form to submit a new lost item on the bottom. Contrarily, the found items page displayed items declared as lost by their owners and allowed form submitters to post a new listing for an item they had found on the bottom. The forms themselves allowed users to attach necessary information about themselves, where and when they had lost or found the item, an image of the item, and any additional comments.

To collect data from these HTML forms, a mixture of PHP and JavaScript was employed. The JavaScript was called on form submission and would process the data for it to then be sent and processed on the backend by PHP. The JavaScript also handled potential errors during HTTP requests and was responsible for executing functions after the request had completed. As for the PHP, the incoming form data was then processed and inserted into prepared SQL statements (to prevent SQL injection attacks) and any uploaded images were renamed and uploaded to a folder on the server. The SQL statements, when executed, stored the data in a backend, relational MySQL/MariaDB database, with a table for lost items and a table for discovered items. Similarly, when loading a page on the front-end the database would be queried for the most recently uploaded items, limiting the call to a fixed value as specified in the JavaScript.
To highlight specific areas of this project, the two main primary and secondary areas of focus were initially labeled as serving data to and from the database (project Area #5) and providing functionality and form with JavaScript (Area #2), respectively; however as the project progressed the secondary area of focus shifted to HTML and CSS page design (Area #1), due to the fact that most of the JavaScript solely sent and received data from the PHP scripts and then added content to the document dynamically.

## Looking Towards the future

In the future, we would like to further optimize and develop Hound to become the best version of itself. Alongside improvements to the general look and layout of the website, some of our quality of life changes would include having a filter option for the output of data from the database, dropdown navigation between pages, and being able to claim your items and take stuff off the database. To make sure that people do not claim items that are not theirs we will hold a log table of who picked up what items and their contact information for if they picked up the wrong item or something that was not theirs. This table would be displayed on the website, but unlike the others you would not be able to remove items from it. Additionally to make the process more secure we would add email verification on the forms. This would allow us to then send emails to people about potentially matching items. 
	If this project does end up going far enough and getting more use we would like to eventually get in contact with public safety and potentially merge it into something that RPI officially endorses and uses. We could achieve this by continuing our development by utilizing RPI’s center for open source class as a bridge between us and the Rensselaer system.
