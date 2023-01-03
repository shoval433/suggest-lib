//testsave
pipeline{
    agent any
    triggers{
        pollSCM '* * * * *'
    }
    options {
        timestamps()
        gitLabConnection('my-repo')  
    }
    tools {
        maven 'my-work-maven'
        jdk 'java-8-work'
    }
    stages{
        stage("CHEKOUT"){
            steps{
                echo "===============================================Executing CHEKOUT==============================================="
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
        stage("Building for all"){
            steps{
                 echo "===============================================Executing Building for all==============================================="
                sh "mvn verify"
            }

        }
        stage("is main"){
            when{
                expression{
                    return GIT_BRANCH.contains('main') 
                }
            }
            steps{
                 echo "===============================================Executing is main==============================================="
                echo "is main"
                configFileProvider([configFile(fileId: 'my_settings.xml', variable: 'set')]) {
                    sh "mvn -s ${set} deploy "
                    }
            }
        }
        //
        stage("is a release"){
            when{
                expression{
                    return GIT_BRANCH.contains('release/')
                }
            }
            steps{
                echo "===============================================Executing Calc==============================================="
                script{
                    Ver_Br=sh (script: "echo $GIT_BRANCH | cut -d '/' -f2",
                    returnStdout: true).trim()
                    echo "${Ver_Br}"
                    Ver_Calc=sh (script: "bash calc.sh ${Ver_Br}",
                    returnStdout: true).trim()
                    echo "${Ver_Calc}"

                }     
                
            }
           
        }
        stage("is a release2"){
            when{
                expression{
                    return GIT_BRANCH.contains('release/')
                }
            }
            
            steps{
                echo "===============================================Executing Push==============================================="
                configFileProvider([configFile(fileId: 'my_settings.xml', variable: 'set')]) {
                    sh "mvn versions:set -DnewVersion=${Ver_Calc} && mvn -s ${set} deploy "
                    }
                script{
                    withCredentials([gitUsernamePassword(credentialsId: '2053d2c3-e0ab-4686-b031-9a1970106e8d', gitToolName: 'Default')]){
                            // sh "git checkout release/${VER}"
                            sh "git tag $Ver_Calc"
                            sh "git push origin $Ver_Calc"
                    
                        }
                }


            }
           
        }
    }
    post{

        success{
            script{
                
                script{
                    emailext    recipientProviders: [culprits()],
                    subject: 'yes', body: 'ooooononononn',  
                    attachLog: true
                }     
            
            
                gitlabCommitStatus(connection: gitLabConnection(gitLabConnection: 'my-repo' , jobCredentialId: ''),name: 'report'){
                    echo "hi you"
                }
            }
        }
        failure{
            script{
                emailext   recipientProviders: [culprits()],
                subject: 'YOU ARE BETTER THEN THAT !!! ', body: 'Dear programmer, you have broken the code, you are asked to immediately sit on the chair and leave the coffee corner.',  
                attachLog: true
            }      

            gitlabCommitStatus(connection: gitLabConnection(gitLabConnection: 'my-repo' , jobCredentialId: ''),name: 'report'){
                echo "hi you"
            }

        }
    }
}