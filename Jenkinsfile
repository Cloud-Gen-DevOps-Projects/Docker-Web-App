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
			sh 'chmod u+x warcopy.sh'
			sh './warcopy.sh'
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