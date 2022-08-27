require("dotenv").config()

const API_URL = process.env.API_URL //测试网络
const PUBLIC_KEY = process.env.PUBLIC_KEY //钱包地址
const PRIVATE_KEY = process.env.PRIVATE_KEY //钱包私钥

const { createAlchemyWeb3 } = require("@alch/alchemy-web3")
const web3 = createAlchemyWeb3(API_URL)


//获取合约ABI，合约的ABI（应用二进制接口）是与智能合约交互的接口，Hardhat会自动为我们生成一个ABI，并将其保存在MyNFT.json文件中
const contract = require("../artifacts/contracts/MyNFT.sol/MyNFT.json")
// console.log(JSON.stringify(contract.abi))

//MyNFT合约地址
const contractAddress = "0x52F39b939a14935cCb483F0c3536a7C4226fC445"

//创建合约实例
const nftContract = new web3.eth.Contract(contract.abi, contractAddress)

async function mintNFT(tokenURI) {
    const nonce = await web3.eth.getTransactionCount(PUBLIC_KEY, 'latest'); //get latest nonce
 
    //the transaction
    const tx = {//创建交易对象
        'from': PUBLIC_KEY, //交易发起者，这里是我们自己的钱包地址
        'to': contractAddress, //交易接收者，这里是我们希望与之交互的合约地址
        'nonce': nonce, //从我们的地址发送的交易数量，记录交易数量，防止重入攻击
        'gas': 500000, //完成交易所需的估算Gas量
        'data': nftContract.methods.mintNFT(PUBLIC_KEY, tokenURI).encodeABI() //希望在这个交易中执行的计算（功能），即我们想要调用的智能合约的函数
    }

    //用私钥给交易进行签名
    const signPromise = web3.eth.accounts.signTransaction(tx, PRIVATE_KEY)
        
    signPromise
          .then((signedTx) => {
            web3.eth.sendSignedTransaction(
              signedTx.rawTransaction,
              function (err, hash) {
                if (!err) {
                  console.log(
                    "The hash of your transaction is: ",
                    hash,
                    "\nCheck Alchemy's Mempool to view the status of your transaction!"
                  )
                } else {
                  console.log(
                    "Something went wrong when submitting your transaction:",
                    err
                  )
                }
              }
            )
    })
        .catch((err) => {
            console.log(" Promise failed:", err)
        })
}

mintNFT("ipfs://QmRuzLCTTXv63Pc96cmRqeeNJyHvCf7qSdLPEVFZjCGYnq")