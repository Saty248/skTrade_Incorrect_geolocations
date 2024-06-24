/*
  Warnings:

  - Added the required column `isFixedTransitFee` to the `properties` table without a default value. This is not possible if the table is not empty.
  - Added the required column `latitude` to the `properties` table without a default value. This is not possible if the table is not empty.
  - Added the required column `longitude` to the `properties` table without a default value. This is not possible if the table is not empty.
  - Added the required column `timezone` to the `properties` table without a default value. This is not possible if the table is not empty.
  - Added the required column `isAvailable` to the `week_day_range` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "properties" ADD COLUMN     "isFixedTransitFee" BOOLEAN NOT NULL,
ADD COLUMN     "latitude" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "longitude" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "timezone" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "week_day_range" ADD COLUMN     "isAvailable" BOOLEAN NOT NULL;
