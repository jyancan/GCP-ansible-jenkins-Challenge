def call(String project) {



        
  sh 'docker build . -t jyancan/bashGCP1/tree/master/container:$Docker_tag'
		   withCredentials([string(credentialsId: 'docker_password', variable: 'docker_password')]) {
				    
				  sh 'docker login -u jyancan -p $docker_password'
				  sh 'docker push jyancan/bashGCP1/container:$Docker_tag'
			}
}
