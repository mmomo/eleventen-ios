pipeline {
    agent { node { label 'ios' } }

    environment {
        PATH = "$HOME/.fastlane/bin:" +
               "$HOME/.rbenv/shims" +
               "$HOME/.rbenv/shims/ruby" +
               "$HOME/.rbenv/shims/fastlane" +
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
                sh "ruby --version && which -a ruby"
                sh "bundle install"
                sh "gem install fastlane"
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
