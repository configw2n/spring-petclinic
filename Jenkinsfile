pipeline {
  agent any

  tools {
    maven 'M3'
    jdk 'JDK21'
  }
  environment {
    DOCKERUB_CREDENTIALS = credentials('dockerCredential')
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
          docker build -t spring-petclinic:$BUILD_NUMBER  .
          docker tag spring-petclinic:$BUILD_NUMBER configw2n/spring-petclinic:latest
          """
        }        
      }    
    }
    //docker login
    stage ("Docker Login"){
      steps {
        sh """
        echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
        docker push configw2n/spring-petclinic:latest
        """     
      }
    }
    
    stage ('Docker Image Remove') {
      steps {
        sh """
        docker rmi spring-petclinic:$BUILD_NUMBER
        docker rmi configw2n/spring-petclinic:latest
        """   
      }    
    }
    
  }
}
  


