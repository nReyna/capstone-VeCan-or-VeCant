# Galvanize Capstone: VeCan or VeCan’t 
08.14.18

This repository holds the most current work for my Galvanize capstone project. All
code and notes on the Exploratory Data Analysis will be held here to share my findings
and overcome challenges. Your comments and questions are welcome.

1. [Goal](#1-goal-classify-businesses-by-their-review-text)
0. [Appendix](#0-appendix)

<!--- == === == === == === == === == === == === == === == === == === == == --->

---

### 1. Goal: classify dinning options by their review text to predict if they are Vegan/Vegetarian friendly

In particular, taking Yelp reviews for food establishments can we infer a classification 
for the type of cuisiine using review text. We start with a collection of 5.2 million 
reviews for a diverse set of business. After joining and subsetting we have ### 
remaining of which we can see a class balance from Fig. 1.


Figure 1: We see the different classes represented by the food related reviews 
(appendix list of categories) on the horizontal axis versus the category count.

**Balancing Classes**


### 0. Appendix
**Yelp Dataset SQL Tables**

Here is the table association and structure which can be found [link](https://www.yelp.com/dataset/documentation/sql):
![Yelp Dataset table relation](/imgs/yelp_dataset_schema.png)

In *iteration 1* of this project, we will be looking at the reviews for a small 
subset of categories of the broader food set. 

