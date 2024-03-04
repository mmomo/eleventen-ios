pipeline {
    agent { node { label 'ios' } }

    environment {
        PATH = "$HOME/.fastlane/bin:" +
            "/Users/mmomo/.rbenv/shims/fastlane" +
            "/usr/local/bin:" +
            "$PATH"

        LC_ALL = 'en_US.UTF-8'
        LANG = 'en_US.UTF-8'
        LANGUAGE = 'en_US.UTF-8'
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
