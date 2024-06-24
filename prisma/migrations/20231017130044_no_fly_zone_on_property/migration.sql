/*
  Warnings:

  - You are about to drop the column `noFlyZone` on the `layers` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "layers" DROP COLUMN "noFlyZone";

-- AlterTable
ALTER TABLE "properties" ADD COLUMN     "noFlyZone" BOOLEAN NOT NULL DEFAULT false;
