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
                // echo sh(script: 'env|sort', returnStdout: true)
                // sh 'printenv'
                //  echo "===================================================================================Executing deleteDir()==================================================================================="
                deleteDir()
                // echo sh(script: 'env|sort', returnStdout: true)
                // sh 'printenv'
                // echo "===================================================================================Executing checkout scm==================================================================================="
                checkout scm
                // echo sh(script: 'env|sort', returnStdout: true)
                // sh 'printenv'
            }
        }
        stage("is a release"){
            when{
                expression{
                    return GIT_BRANCH.contains('release/')
                }
            }
            steps{
                script{
                    Ver_Br=sh (script: "echo $GIT_BRANCH | cut -d '/' -f2",
                    returnStdout: true).trim()
                    echo "${Ver_Br}"
                    Ver_Calc=sh (script: "base calc.sh ${Ver_Br}",
                    returnStdout: true).trim()
                    echo "${Ver_Calc}"

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