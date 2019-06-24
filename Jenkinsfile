node('docker') {

    stage 'Checkout'
        checkout scm

    stage 'Build & UnitTest'
    sh "docker-compose build develop-env_py36_salobj4"

    //stage 'Pusblish UT Reports'
    //
    //    containerID = sh (
    //        script: "docker run -d accountownerapp:B${BUILD_NUMBER}",
    //    returnStdout: true
    //    ).trim()
    //    echo "Container ID is ==> ${containerID}"
    //    sh "docker cp ${containerID}:/TestResults/test_results.xml test_results.xml"
    //    sh "docker stop ${containerID}"
    //    sh "docker rm ${containerID}"
    //    step([$class: 'MSTestPublisher', failOnError: false, testResultsFile: 'test_results.xml'])

    //stage 'Integration Test'
    //    //sh 'docker-compose -f docker-compose.integration.yml up'
    //    sh "docker-compose -f docker-compose.integration.yml up --force-recreate --abort-on-container-exit"
    //    sh "docker-compose -f docker-compose.integration.yml down -v"
}
