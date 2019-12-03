# Exercise Tasks

## Exercise 0. Trigger a DAG

After following the setup instructions in the Readme, perform the following:

1. From the UI, find the dag named "run_me_first"

2. Turn this dag on using the slider in the left column.

3. Trigger the dag using the tiny play button in the far right column (it should be the first button)

4. Click on the dag, this will bring you to the Tree view for this dag.

5. Navigate to the graph view. You should see a few tasks with arrows connecting them. These arrows represent dependencies between the tasks. You may also notice that some tasks are highlighted with a light or dark green border. The light green border indicates the task is running while the dark green indicates the task completed successfully. If your tasks are not highlighted with a color, this is okay. It can take a minute for the scheduler to begin running a task. Every now and again click the refresh button in the top right of the graph view box until your tasks finish.

6. Once your tasks begin to finish, click on the "print_context" task. A modal should pop up with a few buttons. Click on "View Log".

7. This will bring you to the Airflow logs for this specific task. Here we are printing out all the context variables available to this task. You can see this starting on the line with "INFO - ("First Airflow task is running with ds:..."

8. Now try clicking the code tab (on the same row as the Graph View tab). This view shows the python code that generated this dag. This can be a helpful view for looking at other workflows and seeing how someone else set up their dag.

9. Try clicking around the UI, both in the dag tabs and the buttons on the top of the page. I recommend looking at the Docs > Documentation tab at the top of the page!

## Exercise 1. Write your first dag!

This exercise will get you started writing your first Airflow dag. Rather than start from scratch, I've created an exercise_1.py file in this folder with a bit of pre-existing code to help get you started. If at any point you feel lost or need a reference, you can look at the run_me_first.py file to see the dag we ran in Exercise 0 or at the solutions directory for finished dags for each exercise.

1. Navigate to the exercise_1.py file. There are a few methods already defined here to perform a few tasks. The first method will unzip a zip file containing US government data about the frequency of birth names in the United States. The second will scan the files from that zip file to find the most common name from 1880-2018.

2. While this file already contains some python snippets, it is missing all Airflow code! The first step is to create the DAG object in this file (imports are already included). You may want to use the run_me_first.py file as a reference.

3. Once you've created your dag, create a task for each method. Don't forget to add the tasks to the dag and give them unique names!

4. Now that you have your dag and tasks, make sure to create a dependency from the task that should run first to the one that will rely on it.

5. Go back to the Airflow homepage at localhost:8080 and find your new dag. If you don't see it right away, refresh the page until you see it or an error message towards the top. If you get an error, try to see what went wrong and fix it or ask for help.

6. Turn on your dag and run it like we did before. Click on the dag and go to the graph view and wait for your tasks to complete. You may need to refresh the graph view a few times.

7. If all your tasks are green, congratulations! You've successfully written your first Airflow dag. Now go the logs for the final task and figure out what that most common name is. If one of your tasks was red, don't fret. Go into the logs for that task and see what went wrong.

## Exercise 2. Generating Tasks in a loop

One of Airflow's greatest strengths is the ability to write your workflows as code. In this exercise we will take advantage of that functionality by creating tasks in a loop rather than having to manually create several similar tasks.

1. Navigate to exercise_2.py. Notice that this looks a lot like the previous exercise_1.py file. However, there are some slight changes to the code. Now there is a YEAR_RANGES variable and find common takes two parameters, start_year and end_year. Rather than finding the most common name across all of 1880-2018, we are going to find the most common names in each of those ranges in YEAR_RANGES.

2. Create your dag like before. Make sure it has a different name though. You can also use the same task to unzip the zip file.

3. Now create tasks for each year range in YEAR_RANGES that will run the find_common function. While you _could_ define each manually, that would defeat the point of this exercise! Instead, try to create a loop over the ranges and create a new task for each. You will want to use the op_args or op_kwargs parameter in the PythonOperator (see https://airflow.apache.org/docs/stable/_modules/airflow/operators/python_operator.html or the run_me_first.py file).

4. Once you think your dag is ready, go ahead and run it like before. Did it work? What are the most common names for each year range?

## Exercise 3. Passing information between tasks

Sometimes you'll need to pass some context information between tasks in a dag. Airflow supports this through [xcom](https://airflow.apache.org/docs/stable/concepts.html?highlight=xcom#xcoms). In this exercise, your dag will pass the most common name in each year range into one task that will print them all out together.

1. Open exercise_3.py. This time around the code you'll be starting with is identical to exercise_2.py. Feel free to copy your previous code over or just work off of exercise_2.py if you'd prefer. If you do copy your code from the last exercise, make sure to update the dag id.

2. This time we want to collect the names we've generated in each task created in the loop. To do this, you'll need to update those tasks to use the xcom push functionality.

3. Create a new python function to run xcom_pull to get each name that was pushed. Airflow provides a nice example on how to do this in the example_xcom dag. Go check out that code from the UI.

4. Make sure to set up dependencies for your new task. It might help to define that task before the loop.

5. Run your dag when you're ready. Did you get the names you were expecting?

## Finale

If you've made it this far, congrats! You've completed all the exercises I've provided for you. Go check out some of the other example dags for some ideas on other dags you can write. Maybe you could see how common your name is over different periods of time?