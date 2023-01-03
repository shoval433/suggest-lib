pipeline{
    agent any

    options {
        timestamps()
        gitLabConnection('my-repo') 
      
    }
    stages{
        stage("CHEKOUT"){
            steps{
                echo "===================================================================================Executing CHEKOUT==================================================================================="
                echo sh(script: 'env|sort', returnStdout: true)
                sh 'printenv'
                 echo "===================================================================================Executing deleteDir()==================================================================================="
                deleteDir()
                echo sh(script: 'env|sort', returnStdout: true)
                sh 'printenv'
                echo "===================================================================================Executing checkout scm==================================================================================="
                checkout scm
                echo sh(script: 'env|sort', returnStdout: true)
                sh 'printenv'
            }
        }
        stage("A"){
            steps{
                echo "========executing A========"
            }
            post{
                always{
                    echo "========always========"
                }
                success{
                    echo "========A executed successfully========"
                }
                failure{
                    echo "========A execution failed========"
                }
            }
        }
    }
    post{
        always{
            echo "========always========"
        }
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}