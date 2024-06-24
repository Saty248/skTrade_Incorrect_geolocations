import { PrismaClient } from '@prisma/client';

import { statusSeeds } from './seedData/statusSeeds';
import { categorySeeds } from './seedData/categorySeeds';
import { propertyStatusSeeds } from './seedData/propertyStatusSeeds';

import 'dotenv/config';
import { weekDaySeeds } from './seedData/weekDaySeeds';

const prisma = new PrismaClient();

async function seed() {
  await prisma.status.createMany({
    data: statusSeeds,
  });
  await prisma.category.createMany({
    data: categorySeeds,
  });

  for (const propertyStatusSeed of propertyStatusSeeds) {
    await prisma.status.upsert({
      where: { id: propertyStatusSeed.id },
      update: { type: propertyStatusSeed.type },
      create: { type: propertyStatusSeed.type, id: propertyStatusSeed.id },
    });
  }

  await prisma.weekDay.createMany({
    data: weekDaySeeds,
  });
}

seed();
