pipeline
{
	agent any
	tools
	{
	maven "maven"
	}
	stages{
		stage('Code Checkout'){
			steps{
				git branch: 'main', url: 'https://github.com/Devops9AM/Docker-Web-App.git'

			}
		}
		stage('Execute Maven'){
			steps{
				sh 'mvn package'
			}
		}
		stage("Copying the War file to Job Location"){
			steps{
				sh 'cp /root/.jenkins/workspace/docker-image-build/target/*.war /root/.jenkins/workspace/docker-image-build' 

		}
	}
		stage("Docker Image Build"){
			steps{
			sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID . '
			}
	             }
			stage("Docker Image taging"){
			steps{
			sh 'docker image tag $JOB_NAME:v1.$BUILD_ID thanish/$JOB_NAME:v1.$BUILD_ID'
			
		}

		}
		stage("push Image: DOCKERHUB"){
             steps{
                withCredentials([string(credentialsId: 'DockerPassword', variable: 'DockerPassword')]) {
                sh "docker login -u thanish -p ${DockerPassword}"
                sh 'docker image push thanish/$JOB_NAME:v1.$BUILD_ID'
                sh 'docker image rm thanish/$JOB_NAME:latest'
              }
             }
         }
	}
}

