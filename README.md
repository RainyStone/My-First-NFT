# My-First-NFT
#### NFT开发代码实践

一、原文: https://ethereum.org/en/developers/tutorials/how-to-write-and-deploy-an-nft/

二、译文：登链社区-“NFT新手教程”系列教程：

​            NFT新手教程： 如何编写和部署NFT（第1部分)：https://learnblockchain.cn/article/3947

​            NFT新手教程：如何铸造一个NFT（第2部分)：https://learnblockchain.cn/article/3953

​            NFT 新手教程：如何在钱包中查看NFT（第3部分）：https://learnblockchain.cn/article/3965

三、开发环境准备：上述教程并没有说明开发环境，下面列出的是本项目实践过程中的开发环境

​            node v14.0.0

​            npm 6.14.4

四、教程中使用的是Ropsten测试网络上，而本项目实践使用的是Rinkeby测试网络，因此针对于本项目代码，需要领取Rinkeby测试币；并且hardhat.config.js中针对于Ropsten的配置名以及其它命令项中的Ropsten名都需修改成Rinkeby。当然，如果根据教程使用的是Ropsten测试网络，则此步忽略。

