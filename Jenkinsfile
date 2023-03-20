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
				git branch: 'main', url: 'https://github.com/CloudGen0007/Maven7AM.git'

			}
		}
		stage('Execute Maven'){
			steps{
				sh 'mvn package'
			}
		}
		stage("Copying the War file to Job Location"){
			steps{
			sh 'mv /root/.jenkins/workspace/docker-image-build/target/CloudGen-1.war Cloud-DevOps_1-1.0-SNAPSHOT.war'
			sh 'cp /root/.jenkins/workspace/docker-image-build/target/Cloud-DevOps_1-1.0-SNAPSHOT.war    /root/.jenkins/workspace/docker-image-build' 
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
			sh 'docker image tag $JOB_NAME:v1:$BUILD_ID thanish/$JOB_NAME:latest'
		}

		}
	}
}