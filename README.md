<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a name="readme-top"></a>



<!-- ABOUT THE PROJECT -->
## Vividarts

VividArt Studios is at a pivotal moment in its photography journey, acknowledging challenges in current photo editing tools, particularly during the photo upload phase. The need for seamless transformations has led the studio to seek innovative solutions that align with its growth. Recognizing the importance of exceeding client expectations, the studio emphasizes the necessity for a robust system to enhance the editing experience and ensure a smooth workflow. The scalability of the current infrastructure is a focus, with occasional performance hiccups hindering consistent, high-quality services. VividArt Studios invites contributors to join in creating a modern system that anticipates future needs, emphasizing collaboration and innovation to shape the studio's success.

Goals:
- Containerization: Seamless deployment of applications across different environments using containerization
- Automated Photo Editing Workflow: Automated workflow for photo editing that enhances the efficiency of the editing tools with serverless functions triggered by photo uploads.
- Cloud Storage for Accessibility: Cloud storage solutions, to store and manage photos.
- User-Friendly Interfaces: Intuitive and user-friendly interfaces for both photographers and clients.
- Infrastructure as Code (IaC): Infrastructure as Code to automate the provisioning and management of infrastructure resources.
- Monitoring and Analytics: Gather insights for continuous improvement
- Continuous Integration/Continuous Deployment (CI/CD): CI/CD pipelines to automate the testing and deployment of changes, ensuring a rapid and reliable release cycle.

### Collaborations
This is a hand-on cloud engineering project delivered by the Azubi Africa Group 4 team in 2023. After 6 months of AWS cloud training and front-end development, we got a chance to work on some realife cloud projects. 
The team members were:
 1. Emmanuel Akolbire [Linkedin](https://www.linkedin.com/in/emmanuel-akolbire)
 2. Prince Adama Aryee
 3. Joseph Nsiah
 4. Jerono  Bargotio
 5. Ogbomo Festus
 6. Segla Gislain
 7. Temesgen Teshome

## Project Overview
#### Technologies
- Python 3.10
- Flask
- Pillow
- Docker
- Kubernetes
- Terraform
- AWS

#### Application
The application is a web page served by a Flask webserver running in a Kubernetes cluster behind a load balancer. The application sends to requests to the API to process an image and polls for the result.

#### API
The API served by an AWS API gateway which routes requests to AWS lambda functions which invoke transformer functions to process and save the image in an S3 bucket for retrieval

### The Architecture
<a href="https://github.com/DeXtreme/Vividarts">
    <img src="architecture.png" alt="Logo" width="auto" height="450">
</a>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

##
```sh
   1. Creating an s3 bucket through the AWS console
```
You need to have a an AWS account, you can get a freetire account which basically means you get a free 1 year to use some AWS resources. In our case, we have that setup and we will be using the s3 service.
* Go to the s3 service
* click on "create bucket" :  a bucket is where we will put our files.
* click on "objects" : obejects are files that can go into the bucket.
##
```sh
   2. Setup Website hosting for S3
```
Webhosting is what allows o a webfile to be served to the internet. AWS offers a free option to host a static website (static is something that doesnt use data from a database).
* Go to your s3 bucket
* Go to the properties tab
* Scroll down to Static Web Hosting and enable this.
##
```sh
   3. Launch your website on s3
```
We have a bucket and its now hosting ready, all we need to do is add our files and we can access the site.
* Go to your s3 bucket and upload "objects". these are your webfiles from your computer
* Go to the s3 bucket properties tab
* Scroll down to Static Web Hosting and you should now see a url.
*click on the url and access your site.



## Showcase a simple Architecture diagram
<!-- setup a link to your images folder -->
<a href="[https://github.com/lawrencemuema/Cloud_project02](https://github.com/lawrencemuema/Cloud_project02/blob/main/images/fargate_arch.png)">
    <img src="images/fargate_arch.png" alt="Logo" width="auto" height="150">
</a>

<p align="right">(<a href="#readme-top">back to top</a>)</p>




<!-- GETTING STARTED -->
## Getting Started

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.


### Installation

_Below is an example of how you can instruct your audience on installing and setting up your app. This template doesn't rely on any external dependencies or services._

1. Clone the repo
   ```sh
   git clone https://github.com/your_username_/Project-Name.git
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Your Name - [@my_twitter](https://twitter.com/your_username) - email@example.com

Project Link: [https://github.com/your_username/repo_name](https://github.com/your_username/repo_name)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- References -->
## References

Use this space to list resources you find helpful and would like to give credit to. I've included a few of my favorites to kick things off!

* [GitHub Emoji Cheat Sheet](https://www.webpagefx.com/tools/emoji-cheat-sheet)
* [Malven's Flexbox Cheatsheet](https://flexbox.malven.co/)
* [Malven's Grid Cheatsheet](https://grid.malven.co/)
* [Img Shields](https://shields.io)
* [GitHub Pages](https://pages.github.com)

<p align="right">(<a href="#readme-top">back to top</a>)</p>
