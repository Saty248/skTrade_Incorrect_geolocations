/*
  Warnings:

  - You are about to drop the `userss` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `hasChargingStation` to the `properties` table without a default value. This is not possible if the table is not empty.
  - Added the required column `hasLandingDeck` to the `properties` table without a default value. This is not possible if the table is not empty.
  - Added the required column `hasStorageHub` to the `properties` table without a default value. This is not possible if the table is not empty.
  - Added the required column `isRentableAirspace` to the `properties` table without a default value. This is not possible if the table is not empty.
  - Added the required column `title` to the `properties` table without a default value. This is not possible if the table is not empty.
  - Added the required column `transitFee` to the `properties` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "properties" DROP CONSTRAINT "properties_ownerId_fkey";

-- DropForeignKey
ALTER TABLE "userss" DROP CONSTRAINT "userss_KYCStatusId_fkey";

-- DropForeignKey
ALTER TABLE "userss" DROP CONSTRAINT "userss_categoryId_fkey";

-- AlterTable
ALTER TABLE "properties" ADD COLUMN     "hasChargingStation" BOOLEAN NOT NULL,
ADD COLUMN     "hasLandingDeck" BOOLEAN NOT NULL,
ADD COLUMN     "hasStorageHub" BOOLEAN NOT NULL,
ADD COLUMN     "isRentableAirspace" BOOLEAN NOT NULL,
ADD COLUMN     "title" TEXT NOT NULL,
ADD COLUMN     "transitFee" DOUBLE PRECISION NOT NULL;

-- DropTable
DROP TABLE "userss";

-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(6) NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "blockchainAddress" TEXT NOT NULL,
    "isAdmin" BOOLEAN NOT NULL DEFAULT false,
    "newsletter" BOOLEAN NOT NULL,
    "categoryId" INTEGER NOT NULL,
    "phoneNumber" TEXT NOT NULL,
    "KYCStatusId" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "week_day_range" (
    "createdAt" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(6) NOT NULL,
    "fromTime" DOUBLE PRECISION NOT NULL,
    "toTime" DOUBLE PRECISION NOT NULL,
    "weekDayId" INTEGER NOT NULL,
    "propertyId" INTEGER NOT NULL,

    CONSTRAINT "week_day_range_pkey" PRIMARY KEY ("weekDayId","propertyId")
);

-- CreateTable
CREATE TABLE "weekdays" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "weekdays_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "weekdays_name_key" ON "weekdays"("name");

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_KYCStatusId_fkey" FOREIGN KEY ("KYCStatusId") REFERENCES "status"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "properties" ADD CONSTRAINT "properties_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "week_day_range" ADD CONSTRAINT "week_day_range_weekDayId_fkey" FOREIGN KEY ("weekDayId") REFERENCES "weekdays"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "week_day_range" ADD CONSTRAINT "week_day_range_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "properties"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
