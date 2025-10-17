pipeline {
  agent any

  tools {
    maven 'M3'
    jdk 'JDK21'
  }

  stages {
    // GitHub Clone
    stage('Git Clone') {
      steps {
        git url: 'https://github.com/configw2n/spring-petclinic.git/', branch: 'main'
      }
    }

    // Maven Build
    stage('Maven Build') {
      steps {
        sh 'mvn -Dmaven.test.failure.ignore=true clean package'
      }
    }
  //docker image 생성
  stage('Docker Image Build'){
      steps {
        dir("${env.WORKSPACE}"){
          sh """
          docker build -t configw2n/spring-petclinic:$BUILD_NUMBER  .
          docker tag configw2n/spring-petclinic:$BUILD_NUMBER configw2n/spring-petclinic:latest
          """
        }
        
      }    
    }
        
  }
}



