import { PrismaClient } from '@prisma/client'
import { error } from 'console'
import fs, { readFileSync, writeFileSync } from 'fs'
const prisma = new PrismaClient()

async function main() {
    let noMatchPropertyDetailsArray = readFileSync(
        '/home/zeher/skyTradeLinks/incorrectLocationRemoval/result/noMatch.json',
        'utf8'
    )
    let noMatchPropertyDetailsArrayParsed = JSON.parse(
        noMatchPropertyDetailsArray
    )
    console.log(noMatchPropertyDetailsArrayParsed.length)

    const updatedPRoperties = []
    noMatchPropertyDetailsArrayParsed.forEach(async (element) => {
        const updatedProperty = await prisma.property.update({
            where: {
                id: element.id,
            },
            data: {
                longitude: element.actualLongitude,
                latitude: element.actualLatitude,
            },
        })

        updatedPRoperties.push(updatedProperty)
        writeFileSync(
            '/home/zeher/skyTradeLinks/incorrectLocationRemoval/result/updatedProperties.json',
            JSON.stringify(updatedPRoperties)
        )
    })
}

main()
    .then(() => {
        console.log('getPRopertyDetailsFromDb execution success')
    })
    .catch((error) => {
        console.log('error', error)
    })
    .finally(async () => {
        prisma.$disconnect()
    })
