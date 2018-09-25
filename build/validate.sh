#Create a scratch org
echo "Creating the Scratch Org..."
sfdx force:org:create -f config/project-scratch-def.json -a ${CIRCLE_BRANCH} -s
#Push the code to your new scratch org & run all tests
echo "Pushing code to Scratch Org..."
sfdx force:source:push -u ${CIRCLE_BRANCH}
echo "Running all tests on Scratch Org..."
sfdx force:apex:test:run --testlevel RunLocalTests --outputdir test-results --resultformat tap --targetusername ${CIRCLE_BRANCH}