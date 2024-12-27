curl -LO raw.githubusercontent.com/quiccklabs/Labs_solutions/master/Set%20Up%20an%20App%20Dev%20Environment%20on%20Google%20Cloud%20Challenge%20Lab/quicklabgsp315.sh
sudo chmod +x quicklabgsp315.sh
./quicklabgsp315.sh


###Steps in the sh file

1. Print empty lines to improve readability in the terminal.

2. Prompt the user to input values for the following variables:
   - `USERNAME2` (username).
   - `ZONE` (e.g., `us-central1-a`).
   - `TOPIC_NAME` (Pub/Sub topic name).
   - `FUNCTION_NAME` (Cloud Function name).

3. Extract the region from the provided `ZONE`.

4. Enable necessary Google Cloud services for the operation.

5. Wait for 70 seconds to ensure the services are fully enabled.

6. Retrieve the project number using the current Google Cloud project ID.

7. Grant the Eventarc eventReceiver role to the Compute Engine service account.

8. Pause for 20 seconds.

9. Fetch the Cloud KMS service account for the current project.

10. Grant the Pub/Sub publisher role to the KMS service account.

11. Pause for another 20 seconds.

12. Grant the IAM serviceAccountTokenCreator role to the Pub/Sub service account.

13. Pause for 20 seconds.

14. Create a Cloud Storage bucket in the specified region.

15. Create a new Pub/Sub topic using the provided topic name.

16. Create and navigate to a new directory for the project files.

17. Generate a JavaScript file (`index.js`) containing the main logic for the Cloud Function, which processes image uploads and generates thumbnails.

18. Replace placeholder values in the generated `index.js` file with actual function and topic names.

19. Create a `package.json` file to define dependencies for the Node.js project.

20. Retrieve the project ID and configure Pub/Sub permissions for the bucket service account.

21. Define a function to deploy the Cloud Function with the specified configurations.

22. Monitor the deployment of the Cloud Run service, retrying until the service is created successfully.

23. Download a sample image and upload it to the Cloud Storage bucket.

24. Remove an IAM policy binding for the specified user (`USERNAME2`).