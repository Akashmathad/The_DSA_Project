/*
  Warnings:

  - A unique constraint covering the columns `[usn]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `batch` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `branch` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `contact` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `password` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `usn` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "BranchType" AS ENUM ('CSE', 'ISE', 'ECE', 'EEE', 'ME', 'CE', 'AE');

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "batch" INTEGER NOT NULL,
ADD COLUMN     "branch" "BranchType" NOT NULL,
ADD COLUMN     "contact" TEXT NOT NULL,
ADD COLUMN     "isVerified" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "name" TEXT NOT NULL,
ADD COLUMN     "password" TEXT NOT NULL,
ADD COLUMN     "usn" TEXT NOT NULL;

-- CreateTable
CREATE TABLE "Profile" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,

    CONSTRAINT "Profile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DSAContest" (
    "id" TEXT NOT NULL,
    "contestNo" INTEGER NOT NULL,
    "contestName" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "batch" INTEGER NOT NULL,

    CONSTRAINT "DSAContest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DSAQuestion" (
    "id" TEXT NOT NULL,
    "question" TEXT NOT NULL,
    "inputOne" TEXT NOT NULL,
    "outputOne" TEXT NOT NULL,
    "inputTwo" TEXT NOT NULL,
    "outputTwo" TEXT NOT NULL,
    "inputThree" TEXT NOT NULL,
    "outputThree" TEXT NOT NULL,
    "contestId" TEXT NOT NULL,

    CONSTRAINT "DSAQuestion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CompletedDSAContest" (
    "id" TEXT NOT NULL,
    "dsaContestId" TEXT NOT NULL,
    "profileId" TEXT NOT NULL,

    CONSTRAINT "CompletedDSAContest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DSAResult" (
    "id" TEXT NOT NULL,
    "batch" INTEGER NOT NULL,
    "contestNo" INTEGER NOT NULL,
    "contestName" TEXT NOT NULL,
    "dsaContestId" TEXT NOT NULL,

    CONSTRAINT "DSAResult_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SubmittedDSAResults" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "usn" TEXT NOT NULL,
    "score" INTEGER NOT NULL,
    "timeLeft" INTEGER NOT NULL,
    "resultId" TEXT NOT NULL,
    "profileId" TEXT NOT NULL,

    CONSTRAINT "SubmittedDSAResults_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AptitudeContest" (
    "id" TEXT NOT NULL,
    "contestNo" INTEGER NOT NULL,
    "contestName" TEXT NOT NULL,
    "batch" INTEGER NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AptitudeContest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AptitudeQuestion" (
    "id" TEXT NOT NULL,
    "question" TEXT NOT NULL,
    "optionOne" TEXT NOT NULL,
    "optionTwo" TEXT NOT NULL,
    "optionThree" TEXT NOT NULL,
    "optionFour" TEXT NOT NULL,
    "ans" TEXT NOT NULL,
    "contestId" TEXT NOT NULL,

    CONSTRAINT "AptitudeQuestion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CompletedAptitudeContest" (
    "id" TEXT NOT NULL,
    "aptitudeContestId" TEXT NOT NULL,
    "profileId" TEXT NOT NULL,

    CONSTRAINT "CompletedAptitudeContest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AptitudeResult" (
    "id" TEXT NOT NULL,
    "contestNo" INTEGER NOT NULL,
    "contestName" TEXT NOT NULL,
    "batch" INTEGER NOT NULL,
    "aptitudeContestId" TEXT NOT NULL,

    CONSTRAINT "AptitudeResult_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SubmittedAptitudeResults" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "usn" TEXT NOT NULL,
    "score" INTEGER NOT NULL,
    "timeLeft" INTEGER NOT NULL,
    "resultId" TEXT NOT NULL,
    "profileId" TEXT NOT NULL,

    CONSTRAINT "SubmittedAptitudeResults_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Profile_userId_key" ON "Profile"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "DSAResult_dsaContestId_key" ON "DSAResult"("dsaContestId");

-- CreateIndex
CREATE UNIQUE INDEX "SubmittedDSAResults_resultId_usn_key" ON "SubmittedDSAResults"("resultId", "usn");

-- CreateIndex
CREATE UNIQUE INDEX "AptitudeResult_aptitudeContestId_key" ON "AptitudeResult"("aptitudeContestId");

-- CreateIndex
CREATE UNIQUE INDEX "SubmittedAptitudeResults_resultId_usn_key" ON "SubmittedAptitudeResults"("resultId", "usn");

-- CreateIndex
CREATE UNIQUE INDEX "User_usn_key" ON "User"("usn");

-- AddForeignKey
ALTER TABLE "Profile" ADD CONSTRAINT "Profile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DSAQuestion" ADD CONSTRAINT "DSAQuestion_contestId_fkey" FOREIGN KEY ("contestId") REFERENCES "DSAContest"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CompletedDSAContest" ADD CONSTRAINT "CompletedDSAContest_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CompletedDSAContest" ADD CONSTRAINT "CompletedDSAContest_dsaContestId_fkey" FOREIGN KEY ("dsaContestId") REFERENCES "DSAContest"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DSAResult" ADD CONSTRAINT "DSAResult_dsaContestId_fkey" FOREIGN KEY ("dsaContestId") REFERENCES "DSAContest"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SubmittedDSAResults" ADD CONSTRAINT "SubmittedDSAResults_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SubmittedDSAResults" ADD CONSTRAINT "SubmittedDSAResults_resultId_fkey" FOREIGN KEY ("resultId") REFERENCES "DSAResult"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AptitudeQuestion" ADD CONSTRAINT "AptitudeQuestion_contestId_fkey" FOREIGN KEY ("contestId") REFERENCES "AptitudeContest"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CompletedAptitudeContest" ADD CONSTRAINT "CompletedAptitudeContest_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CompletedAptitudeContest" ADD CONSTRAINT "CompletedAptitudeContest_aptitudeContestId_fkey" FOREIGN KEY ("aptitudeContestId") REFERENCES "AptitudeContest"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AptitudeResult" ADD CONSTRAINT "AptitudeResult_aptitudeContestId_fkey" FOREIGN KEY ("aptitudeContestId") REFERENCES "AptitudeContest"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SubmittedAptitudeResults" ADD CONSTRAINT "SubmittedAptitudeResults_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SubmittedAptitudeResults" ADD CONSTRAINT "SubmittedAptitudeResults_resultId_fkey" FOREIGN KEY ("resultId") REFERENCES "AptitudeResult"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
