pipeline {
    agent any
	
	environment {
		registry = "sinhakgaurav/devops"
		registryCredential = 'dockerhub'
	}
	
    stages {
        
        stage('Maven is Compiling Application') {
            steps{
                withMaven(maven :'maven'){
                    echo 'compiling application step'
                    bat 'mvn clean compile'
                }
            }

        } 
        stage('Junit is Performing Test') {
            steps {
                withMaven(maven :'maven'){
                    echo 'scripts to run tests...'
                    bat 'mvn test'
                }    
            }
        }
        stage('Sonar is Analysing Code') {
            steps {
                withMaven(maven :'maven'){
                    echo 'Running code check....'
                    bat 'mvn sonar:sonar'
                }
            }
        }
        stage ('Deploying Artifacts'){
            steps{
				echo "deploying artifacts and capturing build information"
				script {
					def server = Artifactory.server 'default' 
					
					def rtMaven = Artifactory.newMavenBuild()
					rtMaven.tool = 'maven'
					rtMaven.opts = '-Xms1024m -Xmx4096m'
					
					
					
					rtMaven.deployer server: server, releaseRepo: 'libs-release-local', snapshotRepo: 'libs-snapshot-local'
					def buildInfo1 = rtMaven.run pom: 'pom.xml', goals: 'clean install'
					
					//Publishing build info to Artifactory - Method 2
					def buildInfo = Artifactory.newBuildInfo()
					 
					//Capturing Environment variables
					buildInfo.env.capture = true
					buildInfo.env.collect()
					
					buildInfo.append buildInfo1
					
					buildInfo.retention maxBuilds: 10, maxDays: 7, deleteBuildArtifacts: true
					server.publishBuildInfo buildInfo


					echo "Build Completed Successfully"
				}
                
            }
        }
		stage('Building Docker Image') {
			steps {
			    bat 'docker build -t dockerim .'
				
				}
		}
		stage('Deploy to Dockerhub') {
			steps {
				script {
					withDockerRegistry([credentialsId: 'dockerhub', url: '']) {
						bat 'docker tag dockerim sinhakgaurav/devops_task:dockerim'  
						bat 'docker push sinhakgaurav/devops_task:dockerim'
					}
				}
			}
			
			
		}
		stage('Start the web app') {
			steps {
				
			    bat 'docker run -d -p 6778:8080 dockerim'
				
				}
		}
		stage('Configuring Dashboards and Starting app') {
			steps {
			    bat 'docker-compose up -d'
				
				}
		}
	}
}


