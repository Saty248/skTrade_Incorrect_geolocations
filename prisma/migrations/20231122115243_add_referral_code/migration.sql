/*
  Warnings:

  - A unique constraint covering the columns `[ownedReferralCodeId]` on the table `users` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "users" ADD COLUMN     "ownedReferralCodeId" INTEGER,
ADD COLUMN     "usedReferralCodeId" INTEGER;

-- CreateTable
CREATE TABLE "referral_code" (
    "id" SERIAL NOT NULL,
    "code" TEXT NOT NULL,
    "codeChanged" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "referral_code_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "referral_code_code_key" ON "referral_code"("code");

-- CreateIndex
CREATE UNIQUE INDEX "users_ownedReferralCodeId_key" ON "users"("ownedReferralCodeId");

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_usedReferralCodeId_fkey" FOREIGN KEY ("usedReferralCodeId") REFERENCES "referral_code"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_ownedReferralCodeId_fkey" FOREIGN KEY ("ownedReferralCodeId") REFERENCES "referral_code"("id") ON DELETE SET NULL ON UPDATE CASCADE;
