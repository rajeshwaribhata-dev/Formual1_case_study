# Formula 1 – Case Study using SQL

Formula One (commonly known as **Formula 1** or **F1**) is the highest class of international open-wheel single-seater racing, sanctioned by the **Fédération Internationale de l'Automobile (FIA)**.

For this case study, the dataset has been taken from **Kaggle**.

The dataset includes complete information related to:

- Races
- Drivers
- Constructors
- Qualifying
- Circuits
- Lap times
- Pit stops
- Championships

The data ranges from **1950 to the latest 2023 season**.

Dataset link (Kaggle):
[https://www.kaggle.com/datasets/rohanrao/formula-1-world-championship-1950-2020?resource=download](https://www.kaggle.com/datasets/rohanrao/formula-1-world-championship-1950-2020?resource=download)

---

## Problem Statements

Using the given F1 dataset, solve the following problems:

1. Identify the country which has produced the most F1 drivers.
2. Which country has produced the most number of F1 circuits?
3. Which countries have produced exactly **5 constructors**?
4. List the number of races that have taken place **each year**.
5. Who is the **youngest** and **oldest** F1 driver?
6. List the number of races held each year and mention the **first** and **last** race of each season.

ER Diagram

<img width="1800" height="1408" alt="ERD" src="https://github.com/user-attachments/assets/d7f5aed1-0dc7-4e2d-9c3e-8f050948a302" />

7. Which circuit has hosted the **most number of races**? Display:

   - Circuit name
   - Number of races
   - City
   - Country

8. Display the following for the **2022 season**:

   - Year
   - Race number
   - Circuit name
   - Driver name
   - Driver race position
   - Driver race points
   - Winner flag (driver)
   - Constructor name
   - Constructor position
   - Constructor points
   - Winner flag (constructor)
   - Race status of each driver
   - Flag for the driver with the **fastest lap**
   - Total number of pit stops for each driver

9. List all **F1 champions** and the number of times they have won.

10. Who has won the **most constructor championships**?

11. How many races has **India** hosted?

12. Identify the driver who **won** the championship or was a **runner-up**, along with their team.

13. Display the **top 10 drivers** with the most wins.

14. Display the **top 3 constructors** of all time.

15. Identify the drivers who have won races with **multiple teams**.

16. How many drivers have **never won** a race?

17. Are there any constructors who **never scored a point**? If yes, mention their names and the number of races they participated in.

18. Mention the drivers who have won **more than 50 races**.

19. Identify the **podium finishers** of each race in the **2022 season**.

20. For the **2022 season**, mention the **points structure** for each finishing position.

21. How many drivers participated in the **2022 season**?

22. How many races have the **top 5 constructors** won in the last **10 years**?

23. Display the winners of every **sprint race** in F1 history.

24. Find the driver with the **most number of Did Not Qualify (DNQ)** results.

25. During the **last race of 2022**, identify the drivers who **did not finish** and the **reason** for it.

26. What is the **average lap time** for each circuit? Sort based on the **lowest lap time**.

27. Who won the **drivers championship** when **India hosted F1** for the first time?

28. Which driver has completed the **most lap times** in F1 history?

29. Identify the **top 3 drivers** with the most **podium finishes** (Top 3 race positions).

30. Which driver has the **most pole positions** (P1 in qualifying)?
