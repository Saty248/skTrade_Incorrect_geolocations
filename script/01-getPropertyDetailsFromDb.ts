import { PrismaClient } from '@prisma/client'
import { error } from 'console'
import fs, { readFileSync, writeFileSync } from 'fs'
const prisma = new PrismaClient()

async function main() {
    writeFileSync(
        '/home/zeher/skyTradeLinks/incorrectLocationRemoval/result/propertyDetails.json',
        JSON.stringify([])
    )
    const ans = await prisma.property.findMany({
        select: { id: true, address: true, longitude: true, latitude: true },
        where: { ownerId: 528, propertyStatusId: 1 },
    })
    console.log(ans.length)
    writeFileSync(
        '/home/zeher/skyTradeLinks/incorrectLocationRemoval/result/propertyDetails.json',
        JSON.stringify(ans)
    )
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
