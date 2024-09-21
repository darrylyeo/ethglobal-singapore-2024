import { task } from "hardhat/config"
import { save } from "./utils/save"
import { verify } from "./utils/verify"

task("deploy", "📰 Deploys a contract, saves the artifact and verifies it.")
  .addParam("contract", "Name of the contract to deploy.", "MatchMaking")
  .addOptionalVariadicPositionalParam(
    "args",
    "Constructor arguments for the contract"
  )
  .addFlag("save", "Flag to indicate whether to save the contract or not")
  .addFlag("verify", "Flag to indicate whether to verify the contract or not")
  .setAction(async (args, { viem, network, run }) => {
    await run("compile")

    console.log(
      `🚀 Starting deployment process for ${args.contract} on ${network.name}...`
    )

    try {

      const sha1 = await viem.deployContract("Matchmaking.sol", [])
      // console.log(`✅ SHA1 library deployed at: ${sha1.address}`)

      // console.log(`📄 Deploying ${args.contract}...`)
      // const Contract = await viem.deployContract(args.contract, args.args, {
      // })
      // console.log(`✅ ${args.contract} deployed at: ${Contract.address}`)

      // const chainId = (await viem.getPublicClient()).chain.id

      // args.save && (await save(chainId, Contract.address, Contract.abi))
      // args.verify && (await verify(run, Contract.address, args.args))

      // console.log("🎉 Deployment process completed successfully!")

        // Get the ContractFactory of your SimpleContract
    // const SimpleContract = await hre.ethers.getContractFactory("MatchMaking");

    // // Deploy the contract
    // const contract = await SimpleContract.deploy();

    // // Wait for the deployment transaction to be mined
    // await contract.deployed();

    // console.log(`SimpleContract deployed to: ${contract.address}`);
  } catch (error) {
      console.error("❌ Deployment failed:", error)
    }
  })
