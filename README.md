# Galvanize Capstone: VeCan or VeCan’t 
08.24.18

This repository holds the most current work for my Galvanize capstone project. 
All code and notes including the exploratory data analysis, modeling and visualization
will be held here to share my findings and some example of how I overcome challenges. 

Your comments and questions are welcome.

1. [Motivation](#1-motivation)
2. [Modeling](#2-modeling)
3. [Appendix Data](#3-Appendix-Data-Extraction)
4. [Appendix Text](#4-Appendix-Processing-Text)
<!--- == === == === == === == === == === == === == === == === == === == == --->

---
### 1. Motivation:
It's been a good week at work and I haven't seen my friends all week. It's time 
to share a meal together. However, given dietary restrictions of the gang we have 
to jump on Yelp and start our search for a restaurant that could meet all of our 
requirements. 

*Why not just use the filter using a 'Vegan' or 'Vegetarian' tag?* Well one thing
that we have come to find is that in our area the tags are not very accurate nor 
complete.

In fact, we have enjoyed memories and great meals at restaurants that do not 
have tags but indeed do offer options for all of our requirements.

#### Goal: Can I classify dinning options as Vegan/Vegetarian friendly given their review text?

I started with a collection of 5.2 million reviews for a diverse set of business,
gathered from [Yelp Challenge](https://www.yelp.com/dataset/documentation/sql) data set.


<!--- Can I create a redirected link to Elliot's Medium post so I can get recognition/paid? --->

<!--- == === == === == === == === == === == === == === == === == === == == --->

For this project I created an AWS ECS instance and extracted about one million
reviews for 5 cuisines: Mexican, Chinese, Indian, Italian, and Thai. Also I 
kept tags for the reviews regarding whether or not they were Vegan or Vegetarian.

I defined having either of these tags as being **'Veggie Friendly'** and this
became my target. There was 20% of the reviews from my samply that were labeled
as being Veggie Friendly.

One interesting thing that I discovered was an obvious class imbalance. 
For example, in figure 1 we see that of the restaurants that were labeled Mexican 
about 30% were actually labeled as being Veggie Friendly, but for Indian 
restaurants we only have about 6%. This raised a flag immediately as most Indian 
restaurants are vegetarian. This also demonstrates the lack of accuracy of the 
tags on restaurants.

![Class Balance for Veggie Friendly restaurants](/imgs/CuisinesFull.png)
Figure 1: Proportion of Veggie Friendly restaruants given a cuisine.

**Balancing Classes**

<!--- == === == === == === == === Modeling  === == === == === == === == == --->

### 2. Modeling:
For the completion of my natural language processing (NLP) I used several different
machine learning models but here I will talk about two in particular:
-  Naive Bayes
-  Random Forest


#### a. Naïve Bayes

![NB Confusion Matrix](/imgs/MNB-CountVect-CMat.png)
![Naive Bayes ROC curve](/imgs/MNB_357StWds_full_countV.png)

<!--- == === == === == === == === == === == === == === == === == === == == --->


#### b. Random Forest

![RF Confusion Matrix](/imgs/RF-CountVect-CMat.png)
![Random Forest ROC curve](/imgs/RF_357StWds_full_countV_SVD.png)

<!--- == === == === == === == === Appendix A === == === == === == === == == --->

### 3. Appendix: Data Extraction
**Yelp Dataset SQL Tables**

Thanks to the [Yelp Challenge](https://www.yelp.com/dataset/documentation/sql) data 
set, I was able to work on this fun NLP problem. However, extracting the data was 
not very straightforward.

The data is given as a *'data dump'* which I was not able to load even after following
instructions in the documenataion. Instead, I had to create a MySQL Database on my
Amazon Web Services EC2 instance and I loaded the all of tables there. 

The table association and structure which can be found 
[here](https://www.yelp.com/dataset/documentation/sql) and looked like this:
![Yelp Dataset table relation](/imgs/yelp_dataset_schema.png)

In the [Connection Test](/ConnectionTest-Review-with-VegColumns.ipynb) notebook
you'll be able to see how I used the OS and PyMySQL modules in Python to create
a connection to the database and submitted queires to tables I created. It was 
here where I further filtered the reviews to only be for restaurants from the US.

I places a US only restriction on the reviews to try and avoid the having multiple
languages in my reviews, so as to not have a very high dimensional vector when
I would vectorize my reviews. (This did not really help. There were still many
reviews from a quick inspection that were in Chinese, Korean, Japanese, 
Spanish and French.)

There were about twenty thousand reviews with primarily Asian characters. For 
this project there were dropped as I was interested in only English based text.

<!--- == === == === == === == === == === == === == === == === == === == == --->

<!--- == === == === == === == === Appendix B === == === == === == === == == --->

### 4. Appendix: Processing Text

The pipeline used to process the review text consisted of
-  Removing stop words:
*  This removed words that are typically found in English text such as, 'the', 
'a', 'is'... from review text. Also, there are some very passionate reveiwers
on Yelp so I removed instances of words that did not seem very helpful: 'reeeeally',
'aaaamazing', 'aaaaaaaaaaaaaaaaaaaamazing'. As one can probably infer having
words such as these in reviews really only increased my dimensionality when 
it came time to vectorize. There was a total of 357 stopwords I removed from 
the review text vocabulary. 
-  Removing numbers:
*  There were many reviews that had numbered items, or spoke about the menu item
numbers and some even elaborated on the quantity of dishes enjoyed. For the goal
that I had in mind numbers did not really seem to offer much signal when trying 
to predict if a restaurant's review was Veggie Friendly or not.
-  Vectorizing the review text:
*  This process entails creating a 'bag of words' from reviews and then creating 
vector representations to use in out Machine Learning models. For example, 
1.  The dog is brown.
2.  The cat is brown. 
if we remove stopwords we end up with a bag containing [brown, cat, dog] so our
representations of the sentences would be:
1.  [1, 0, 1]
2.  [1, 1, 0]
so you can see as our bag of words gets larger the dimensionality of the problem 
gets large as well. 

Other things that were also tackled were:
-  Keeping only ascii characters
-  Dimensionality reduction

Both were investigated but did not offer much in tearms of tuning our modeling 
techniques to a stronger signal. 