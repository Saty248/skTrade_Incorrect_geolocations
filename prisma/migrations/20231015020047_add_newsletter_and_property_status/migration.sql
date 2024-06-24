-- AlterTable
ALTER TABLE "properties" ADD COLUMN     "propertyStatusId" INTEGER NOT NULL DEFAULT 0;

-- CreateTable
CREATE TABLE "property_status" (
    "id" SERIAL NOT NULL,
    "type" TEXT NOT NULL,

    CONSTRAINT "property_status_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "newsletters" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(6) NOT NULL,
    "title" TEXT NOT NULL,
    "text" TEXT NOT NULL,
    "link" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "newsletters_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "properties" ADD CONSTRAINT "properties_propertyStatusId_fkey" FOREIGN KEY ("propertyStatusId") REFERENCES "property_status"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
