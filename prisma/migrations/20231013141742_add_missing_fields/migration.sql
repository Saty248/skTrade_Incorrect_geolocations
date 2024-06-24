/*
  Warnings:

  - Added the required column `categoryId` to the `userss` table without a default value. This is not possible if the table is not empty.
  - Added the required column `newsletter` to the `userss` table without a default value. This is not possible if the table is not empty.
  - Added the required column `phoneNumber` to the `userss` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "userss" ADD COLUMN     "categoryId" INTEGER NOT NULL,
ADD COLUMN     "newsletter" BOOLEAN NOT NULL,
ADD COLUMN     "phoneNumber" TEXT NOT NULL;

-- CreateTable
CREATE TABLE "category" (
    "id" SERIAL NOT NULL,
    "type" TEXT NOT NULL,

    CONSTRAINT "category_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "userss" ADD CONSTRAINT "userss_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
