# Posit Table Contest 2025 Submission :blue_book: :orange_book:

[TABLE LIVES HERE!](https://leoohyama.github.io/posit_table_contest_2025/eligibility_table.html)

![](https://raw.githubusercontent.com/leoohyama/posit_table_contest_2025/main/table_gif.gif)

## Coding environment and libraries used :computer: :
This table was built in a R coding environment and rendered to html with Quarto. 

### Data and data source
Data for this table uses modified and randomized versions of the data that I use and collect. But the data does represent the variance, skews, and other data characteristics one would expect to see in our actual dataset.

| Purpose / Use Case        | R packages used |
|---------------------------|----------------|
| **Data Processing**       | `dplyr`, `stringr`, `tidyr` |
| **HTML Processing**       | `htmlwidgets`, `htmltools` |
| **Tables / Interactive UI** | `reactable`, `reactablefmtr` |
| **Colors, Labels, and Formatting** | `RColorBrewer`, `wesanderson`, `scales` |

## Background/Context :book:
I work for the New Worlds Reading Program (Administed by the University of Florida). New Worlds Reading is Florida’s free at-home program that mails 9 free books to eligible VPK - 5th graders each school year. Plus, deliveries include reading activities and resources families can use to help build kids’ reading skills. Books and materials are available in English, Spanish, Haitian Creole, and braille. To be eligible, kids must be VPK - 5th graders who are not yet meeting grade level expectations in reading in Florida VPK programs, public schools, and charter schools.

## The problem :pencil:
Every year, our goal as a program is to enroll as many eligible students as possible. Given this, getting understandable and actionable information on eligibility and enrollment numbers in schools (2,400+) across 76 districts passed on to internal team members (many of whom operate remotely across the state of Florida) who engage with underserved communities is a critical data pipeline. This is especially daunting when working with ~1.35 million children.

## The answer :pencil:
To address this problem, I built an interactive 3-level table that shows information regarding eligibility and enrollment numbers at three different levels: districts, schools, and grade levels within schools. This helps our team members identify which grades within which schools within which districts are ideal for community engagement efforts for enrolling students. 

## The table :bar_chart:
* [`eligibility_table.qmd`](https://github.com/leoohyama/posit_table_contest_2025/blob/main/eligibility_table.qmd): Quarto doc with table code and some of the data processing.

Key features include:
* Scrolling ticker showing district activity in enrollments compared to the week prior
* Filters in the district filter bar that allows for multiple district names (see example in Gif below)
* Slider-based filters for 2 levels of the table that allows users to filter for schools and districts within specifc ranges of columns
* Title and images scale based on size of screen used to view the table


## Screenshots/Gifs :camera:

![Filter usage](https://raw.githubusercontent.com/leoohyama/posit_table_contest_2025/main/filter_search.gif)
The above shows the filter function for districts. The cool thing is that it allows you to filter and search for multiple district names and the names don't have to be complete case matches. Additionally the filter is dynamic so the user can keep typing while seeing the filtered districts.

![Slider filter](https://raw.githubusercontent.com/leoohyama/posit_table_contest_2025/main/slider_filter.gif)
The above shows sliding filters found across the table. These sliders allow for specific ranges to be filtered for and can combined with other column filters. 

## Key things I struggled with :grimacing:

1. The title of table and images needed to fit in multiple types of screen sizes. Initially I was dealing with the text being cut out or stacking weirdly when moving from large to smaller screens. I had to learn a little bit about CSS flexbox, the calc CSS function to scale the text. 

2. I needed to get the scrolling ticker to be inbetween the title and the table. To do this I had to play around with tagList() to combine all the components into a single list because reactable and reactablefrmtr did really support this. 

3. Figuring out the color and hue balance for a three-level interactive table. This was difficult because it's easy for someone to get lost in the nested nature of the table. Initially I was using the default slate() theme for all three levels but then ended up looking at the source code for the theme and changing things manually so that each level of tables had a slightly different shade of color to make the distinguishable. This was also important if someone needed to figure out where in the table they were. 


See if your child is eligible and apply at [`newworldsreading.com`](https://www.newworldsreading.com/en/)
