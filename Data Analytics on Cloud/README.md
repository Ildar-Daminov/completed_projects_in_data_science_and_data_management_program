# Data Analytics on Cloud (in Google Cloud Platform)

This repository shares mhtml files, representing the solution of the course project on Data Analytics on Cloud "Dx-Diagnostics Case Study". 

### Context 
Dx-diagnostics, an online medical health tracker startup is an application to enable users to measure their health indicators at regular intervals. As an analytics engineer, you'll be designing an Airflow DAG on the cloud to serve as the prototype's backend data architecture. The DAG should calculate the summary statistics of the heart rate and O2 levels of the patient every 15 mins and send a report over a Slack channel. The anomalies in these metrics need to be flagged and saved separately.

### File description 
* dag_code.mhtml  shows Python code written to create DAG object, to filter anomalies in Heart rate and O2 levels, and send a diagnostic report on [Slack](https://slack.com/intl/en-gb/)
* dag_graph.mhtml shows DAG (Directed Acyclic Graph) created for the given problem  
* slack_message.mhtml - shows an example of diagnostic report (on Heart rate and O2 level), automatically sent on [Slack](https://slack.com/intl/en-gb/) (Change the scale if last message at 21:30 is not visible)
* task_flag_anomaly.mhtml shows the log file with detected anomalities (see the text High/Low O2 level is detected  or High/Low Heart Rate is detected)  
* task_send_report.mhtml shows the log file with succesful report sending 

### Skills and Tools
GCP, Cloud Composer, MySQL Cloud DB, Airflow UI, Airflow DAG, Airflow Operators, Xcoms, Slack WebHook
