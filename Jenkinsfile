
pipeline {
    agent any

    stages {
        stage('jieduan阶段1') {
            steps {
                echo 'git 拉取代码'
                git credentialsId: 'ea52b67e-7b2b-4551-ad0a-da92bd2c1ce2', url: 'https://gitee.com/lhch912/campus-second-hand.git'
            }
        }
         stage('jieduan2') {
            steps {
                echo 'maven 构建'
                bat 'mvn clean package'
            }
        }
          stage('jieduan阶段23') {
            steps {
                echo '部署到tomcat'
                deploy adapters: [tomcat9(credentialsId: '7a7549f6-4572-4d61-9534-fb13a8fc1450', path: '', url: 'http://localhost:8088/')], contextPath: null, war: 'target/*.war'
            }
        }
    }
}
