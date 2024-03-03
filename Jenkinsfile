pipeline {
    agent { node { label 'ios' } }

    environment {

    }

    stages {
        stage('Build') {
            steps {
                echo 'Building...'
            }
        }

        stage('Unit Tests') {
            steps {
                echo 'Testing...'
                sh "source ~/.bashrc"
                sh "export LANG='en_US.UTF-8'"
                sh "bundle install"
                sh "bundle exec fastlane unit_tests"
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying...'
            }
        }
    }
}
