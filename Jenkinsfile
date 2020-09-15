// 需要在jenkins的Credentials设置中配置jenkins-harbor-creds参数
pipeline {
    agent any
    environment {
        HARBOR_CREDS = credentials('jenkins-harbor-creds')
        GIT_TAG = sh(returnStdout: true,script: 'git describe --tags --always').trim()
    }
    parameters {
        string(name: 'HARBOR_HOST', defaultValue: 'chinamobile.com', description: 'harbor仓库地址')
        string(name: 'DOCKER_IMAGE', defaultValue: 'test/demo', description: 'docker镜像名')
        string(name: 'PROJECT_NAME', defaultValue: 'test', description: 'Harbor中项目名称')
        string(name: 'SERVICE_NAME', defaultValue: 'demo', description: 'Harbor中镜像名称')
		string(name: 'HOST_PORT', defaultValue: '8888', description: '应用部署端口')
    }
    stages {
        stage('Maven Build') {
            when { expression { env.GIT_TAG != null } }
            agent {
                docker {
                    image 'chinamobile.com/devops-tool/maven:3.6.3'
                    args '-v /root/.m2:/root/.m2'
                }
            }
            steps {
                sh 'mvn clean package -Dfile.encoding=UTF-8 -DskipTests=true'
                stash includes: 'target/*.jar', name: 'demo-0.0.1-SNAPSHOT'
            }

        }
        stage('Docker Build') {
            when { 
                allOf {
                    expression { env.GIT_TAG != null }
                }
            }
            agent any
            steps {
                unstash 'demo-0.0.1-SNAPSHOT'
                sh "docker login -u ${HARBOR_CREDS_USR} -p ${HARBOR_CREDS_PSW} ${params.HARBOR_HOST}"
                sh "docker build --build-arg JAR_FILE=`ls target/*.jar |cut -d '/' -f2` -t ${params.HARBOR_HOST}/${params.DOCKER_IMAGE}:${GIT_TAG} ."
                sh "docker push ${params.HARBOR_HOST}/${params.DOCKER_IMAGE}:${GIT_TAG}"
                sh "docker rmi ${params.HARBOR_HOST}/${params.DOCKER_IMAGE}:${GIT_TAG}"
            }
            
        }
		
		stage('Deploy') {
            when { 
                allOf {
                    expression { env.GIT_TAG != null }
                }
            }
            agent {
                docker {
                    image 'chinamobile.com/devops-tool/cd-ansible:1.0.1'
					args '--user root -v /root/.ssh:/root/.ssh'
                }
            }
            steps {
                sh "ansible-playbook -i ansible/backend ansible/backend.yml --extra-vars 'env=dev job_name=${JOB_NAME} build_number=${BUILD_NUMBER} project_name=${params.PROJECT_NAME} service_name=${params.SERVICE_NAME} tag=${GIT_TAG} deploy_port=${params.HOST_PORT}'" 
            }
            
        }
        
    }
}