# Space-Tether-Project-Aerospace-Engineering-
###### Advisor: Dr.Leonard Vance
###### Project Overview:
A space tether is modeled as a long ribbon like structure, with multiple links, that can freely flutter. This project involved writing a MatLab 
function that calculates the area of each link that is blocked by all the other links at any given instant (i.e. when the space tether is in any 
random position). <br />
This code was later used in a larger program that calculated the effective drag on such a space tether connected to two cubeSats while in orbit.
###### Project Description:

This model has two main parts:<br /> <br />
=> The first part determines the right coordinate system (the orbital velocity (wind) coordinates i.e. the direction opposite to the orbital velocity is considered to be the positive x-axis) and
then using the coordinates for each link in the new coordinate system it plots a 2D projection of all the upstream links in the y-z plane. (The function
does not print out a 2D plot at ever instance. The 2D projection data and other needed information for each link is stored in a object class called “link
it uses the inbuilt Matlab polyshape object to perform calculations)<br /> <br />
=> The second part of the model uses the 2D plot to calculate the fraction of the
area of each link that is being blocked by the other links. <br />

<img width="323" alt="Screenshot 2022-10-21 at 10 12 38 PM" src="https://user-images.githubusercontent.com/92242042/197321784-4d24829b-6128-4589-8421-d0495e6ed348.png"> <br />
###### Working of the main function: <br />
The following is a simple test case that was used to test the working of the second part (blocking area calculation part) of the wind model.<br /> 
1) The first figure shows rectangles that are stacked on top of each other. The ones in the back have a darker shade in the covered region.<br /> 
2) We look at the fraction of the purple rectangle that is blocked by all the other rectangles collectively.<br />
3) In order to find the blocking area the function first plots a polygon that is the union of all the polygons except for the purple one. The image to the right shows the two polygons: the union polygon and the purple polygon (the one whose effective blocking is being calculated).<br />
<img width="619" alt="Screenshot 2022-10-21 at 10 13 11 PM" src="https://user-images.githubusercontent.com/92242042/197321952-8225ee86-d278-4304-bab1-0396565450bc.png"> <br />
4) The purple polygon is now shown as the orange one and the polygons formed from the union of all the other polygons are in blue. <br />
5) From the plot to the left we can see that the blocking area is given by the regions of overlap between the blue and the orange polygons. <br />
6) It is evident that by making union polygons we are taking care of a region that is blocked by multiple polygons. This way we don’t count the same region blocked by many polygons multiple times. <br />
7) The next plot shows just the intersection regions. <br />
8) The calculated blocked area is 4.375 units squared and the fractional blocking is 0.7778. The area is calculated using the polyshape object. <br />

<img width="609" alt="Screenshot 2022-10-21 at 10 13 41 PM" src="https://user-images.githubusercontent.com/92242042/197322052-247adccb-b312-47ee-8a35-287a63c2db7a.png"> <br />
###### Model testing:
This model was put to test by comparing the results obtained from a function that calculated the area using a brute force method. 
* The function using the brute force method plots points on the surface of each link and then stacks all the links on-top of each other in the specific
positions that they are at a given instance. <br />
* Then the function runs though the grid vertically. <br />
* If a given point coincides with the link we are looking at and at least one other upstream link then that point is blocked. <br />
* Then the function finds the ratio between such blocked points and the total number of points in a particular link and this is the fractional blocking. <br />
* Increasing the number of points makes the results better <br />
* We plot multiple graphs of the grid method vs the wind blocking method. And we see that as we increase the number of points on the grid our results get
closer and closer to the results obtained from the wind blocking method. <br />
These plots show the fractional blocking obtained from the grid method vs the wind blocking method for each link.
As we increase the number of points the results of the grid method gets closer and closer to the blocking method. This gives us a 45 degree line.
Therefore, we can verify that the blocking method works. <br />
<img width="833" alt="Screenshot 2022-10-21 at 10 14 12 PM" src="https://user-images.githubusercontent.com/92242042/197322162-0d484990-0dcc-4960-91fd-c30d5ee19986.png">





