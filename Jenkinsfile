node('docker') {

    stage('Checkout') {
        checkout scm
    }

    stage('Build & UnitTest') {
        sh "docker-compose build --build-arg sal_v=${env.sal_v} --build-arg salobj_v=${env.salobj_v} --build-arg xml_v=${env.xml_v} --build-arg idl_v=${env.idl_v} --build-arg scriptqueue_v=${env.scriptqueue_v} --build-arg config_attcs_v=${env.config_attcs_v} --build-arg atmcs_v=${env.atmcs_v} --build-arg atdome_v=${env.atdome_v} --build-arg atdometraj_v=${env.atdometraj_v} --build-arg standardscripts_v=${env.standardscripts_v} --build-arg externalscripts_v=${env.externalscripts_v} develop-env_py36_salobj4"
    }

    stage('Push container') {
        script {
          docker.withRegistry("", "docker-hub") {
            sh "docker push lsstts/develop-env:salobj4_b${BUILD_NUMBER}"
          }
        }
    }

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
