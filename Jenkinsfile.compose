node('docker') {

    stage('Checkout') {
        checkout scm
    }

    stage('Build & UnitTest') {

        if (env.build_master.toString()=='true') {
            echo "Building Master branches"
            sh "export IMAGE_TAG=master && docker-compose build --build-arg sal_v=master --build-arg salobj_v=master --build-arg xml_v=master --build-arg idl_v=master --build-arg scriptqueue_v=master --build-arg config_attcs_v=master --build-arg atmcs_v=master --build-arg atdome_v=master --build-arg atdometraj_v=master --build-arg standardscripts_v=master --build-arg externalscripts_v=master develop-env_py36_salobj4"
        }

        if (env.build_develop.toString()=='true') {
            echo "Building Develop braches"
            sh "export IMAGE_TAG=develop && docker-compose build --build-arg sal_v=develop --build-arg salobj_v=develop --build-arg xml_v=develop --build-arg idl_v=develop --build-arg scriptqueue_v=develop --build-arg config_attcs_v=develop --build-arg atmcs_v=develop --build-arg atdome_v=develop --build-arg atdometraj_v=develop --build-arg standardscripts_v=develop --build-arg externalscripts_v=develop develop-env_py36_salobj4"
        }

        def run_tag = !(env.build_develop.toBoolean() || env.build_master.toBoolean())

        if (run_tag.toString()=='true') {
            echo "Building tags"
            sh "export IMAGE_TAG=b${BUILD_NUMBER} && docker-compose build --build-arg sal_v=${env.sal_v} --build-arg salobj_v=${env.salobj_v} --build-arg xml_v=${env.xml_v} --build-arg idl_v=${env.idl_v} --build-arg scriptqueue_v=${env.scriptqueue_v} --build-arg config_attcs_v=${env.config_attcs_v} --build-arg atmcs_v=${env.atmcs_v} --build-arg atdome_v=${env.atdome_v} --build-arg atdometraj_v=${env.atdometraj_v} --build-arg standardscripts_v=${env.standardscripts_v} --build-arg externalscripts_v=${env.externalscripts_v} develop-env_py36_salobj4"
        }
        else{
            echo "Not building tags."
        }
    }

    stage('Push container') {
        if (env.build_master.toString()=='true') {
            echo "Pushing master container"
            script {
                docker.withRegistry("", "dockerhub-lsstsadmin") {
                    sh "docker push lsstts/develop-env:salobj4_master"
                }
            }
        }

        if (env.build_develop.toString()=='true') {
            echo "Pushing develop container"
            script {
                docker.withRegistry("", "dockerhub-lsstsadmin") {
                    sh "docker push lsstts/develop-env:salobj4_develop"
                }
            }
        }

        def push_tag = !(env.build_develop.toBoolean() || env.build_master.toBoolean()) && env.push_tag.toBoolean()

        if (push_tag.toString()=='true') {
            echo "Pushing build tags"
            script {
                docker.withRegistry("", "dockerhub-lsstsadmin") {
                    sh "docker push lsstts/develop-env:salobj4_b${BUILD_NUMBER}"
                }
            }
        }
        else{
            echo "Not pushing tags."
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
