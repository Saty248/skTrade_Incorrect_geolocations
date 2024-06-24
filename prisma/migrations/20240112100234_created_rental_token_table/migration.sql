-- CreateTable
CREATE TABLE "RentalToken" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(6) NOT NULL,
    "startTime" TIMESTAMP(3) NOT NULL,
    "endTime" TIMESTAMP(3) NOT NULL,
    "landTokenId" TEXT NOT NULL,

    CONSTRAINT "RentalToken_pkey" PRIMARY KEY ("id")
);
