pipeline
{
	agent any 
	stages{
		stage('Code Pull'){
			steps{
				git branch: 'main', url: 'https://github.com/Devops9AM/Docker-Web-App.git'
			}
		}
		stage('Code Validate'){
			steps{
				sh 'mvn validate'
			}
		}
		stage('Maven Plugins Install'){
			steps{
				sh 'mvn install'
			}
		}
		stage('Code Compile'){
			steps{
				sh 'mvn install'
			}
		}
		stage('Package'){
			steps{
				sh 'mvn package'
			}
		}
		stage('Aritifact Deploy'){
			steps{
				sh 'mvn deploy'
			}
		}


	}
}

