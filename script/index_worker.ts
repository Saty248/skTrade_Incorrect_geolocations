import { Worker } from 'worker_threads'

import fs, { createWriteStream, readFileSync } from 'fs'

const WORKER_THREADS = 8

let logMatch = createWriteStream(
    '/home/zeher/skyTradeLinks/incorrectLocationRemoval/result/matchResult.json',
    {
        flags: 'a',
    }
)
let logNoMatch = createWriteStream(
    '/home/zeher/skyTradeLinks/incorrectLocationRemoval/result/noMatch.json',
    { flags: 'a' }
)
let logFail = createWriteStream(
    '/home/zeher/skyTradeLinks/incorrectLocationRemoval/result/fail.txt',
    { flags: 'a' }
)

logMatch.write(JSON.stringify([]))
logNoMatch.write(JSON.stringify([]))

let propertyDetailsArray = readFileSync(
    '/home/zeher/skyTradeLinks/incorrectLocationRemoval/result/propertyDetails.json',
    'utf8'
)
let propertyDetailsArrayParsed = JSON.parse(propertyDetailsArray)

function createWorker(userData) {
    return new Promise(function (resolve, reject) {
        const worker = new Worker(
            '/home/zeher/skyTradeLinks/incorrectLocationRemoval/script/slaveWorker.mjs',
            {
                workerData: { userData },
            }
        )
        worker.on('message', (data) => {
            resolve(data)
        })
        worker.on('error', (msg) => {
            reject(`An error ocurred: ${msg}`)
        })
    })
}

async function putToWork() {
    //console.log(props[0],propsLength)
    const matchAns = []
    const noMatchAns = []
    for (
        let i = 0;
        i < propertyDetailsArrayParsed.length - WORKER_THREADS;
        i += WORKER_THREADS
    ) {
        console.log('yo', i)
        let workerPromises = []
        for (let j = i; j < i + WORKER_THREADS; j++) {
            workerPromises.push(createWorker(propertyDetailsArrayParsed[j]))
        }
        let thread_results = await Promise.all(workerPromises)
        console.log(thread_results)
        for (let k = 0; k < thread_results.length; k++) {
            if (thread_results[k].status === 'match') {
                console.log('thread match  Ans', thread_results[k].message)
                /* logSuccess.write(
                    `${JSON.stringify(thread_results[k].message)},`
                ) */
                matchAns.push(thread_results[k].message)
            } else if (thread_results[k].status === 'noMatch') {
                console.log('thread noMAtch  Ans', thread_results[k].message)
                /* logSuccess.write(
                    `${JSON.stringify(thread_results[k].message)},`
                ) */
                noMatchAns.push(thread_results[k].message)
            } else {
                console.log(
                    'thread fail Ans',
                    JSON.stringify(thread_results[k].message)
                )
                logFail.write(`${thread_results[k].message} , `)
            }
        }
    }
    logMatch.write(JSON.stringify(matchAns))
    logNoMatch.write(JSON.stringify(noMatchAns))
    console.log(
        `match = ${matchAns.length} noMAtch length = ${noMatchAns.length}`
    )
}

putToWork()
    .then(() => {})
    .catch((error) => {
        console.log(error)
    })
