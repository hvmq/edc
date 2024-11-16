## The first ensure on your local machine that can build release and run the project
# The second if local machine has installed fastlane, you can ignore the step
# If fastlane is not installed, you can run the following command to install fastlane
```shell
$ sh deploys/auto_install_fastlane.sh
```
# The third, you can run the following command to build release development or production
# For build release development
```shell
$ sh deploys/deploy_manual.sh development
```
# For build release production
```shell
$ sh deploys/deploy_manual.sh production
```