/*
  Warnings:

  - A unique constraint covering the columns `[blockchainAddress]` on the table `users` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateEnum
CREATE TYPE "TaskType" AS ENUM ('REFERRAL_REWARD');

-- AlterTable
ALTER TABLE "referral_code" ADD COLUMN     "ownedByBonusEarned" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "usedByBonusEarned" BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE "users" ADD COLUMN     "totalPoint" DOUBLE PRECISION NOT NULL DEFAULT 0;

-- CreateTable
CREATE TABLE "reward" (
    "id" TEXT NOT NULL,
    "rewardId" TEXT NOT NULL,
    "blockchainAddress" TEXT NOT NULL,
    "taskType" "TaskType" NOT NULL,
    "point" DOUBLE PRECISION NOT NULL,
    "completed" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(6) NOT NULL,

    CONSTRAINT "reward_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "reward_rewardId_key" ON "reward"("rewardId");

-- CreateIndex
CREATE UNIQUE INDEX "users_blockchainAddress_key" ON "users"("blockchainAddress");

-- AddForeignKey
ALTER TABLE "reward" ADD CONSTRAINT "reward_blockchainAddress_fkey" FOREIGN KEY ("blockchainAddress") REFERENCES "users"("blockchainAddress") ON DELETE RESTRICT ON UPDATE CASCADE;
