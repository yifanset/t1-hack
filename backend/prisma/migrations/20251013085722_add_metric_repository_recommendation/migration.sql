/*
  Warnings:

  - The primary key for the `developers` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `createdAt` on the `developers` table. All the data in the column will be lost.
  - You are about to drop the column `developer_id` on the `developers` table. All the data in the column will be lost.
  - The primary key for the `teams` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `team_id` on the `teams` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "public"."developers" DROP CONSTRAINT "developers_teamId_fkey";

-- AlterTable
ALTER TABLE "developers" DROP CONSTRAINT "developers_pkey",
DROP COLUMN "createdAt",
DROP COLUMN "developer_id",
ADD COLUMN     "developerId" SERIAL NOT NULL,
ADD CONSTRAINT "developers_pkey" PRIMARY KEY ("developerId");

-- AlterTable
ALTER TABLE "teams" DROP CONSTRAINT "teams_pkey",
DROP COLUMN "team_id",
ADD COLUMN     "teamId" SERIAL NOT NULL,
ADD CONSTRAINT "teams_pkey" PRIMARY KEY ("teamId");

-- CreateTable
CREATE TABLE "repositories" (
    "repositoryId" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "teamId" INTEGER NOT NULL,

    CONSTRAINT "repositories_pkey" PRIMARY KEY ("repositoryId")
);

-- CreateTable
CREATE TABLE "metrics" (
    "metricId" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "value" DECIMAL(65,30) NOT NULL,
    "datetime" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "teamId" INTEGER NOT NULL,

    CONSTRAINT "metrics_pkey" PRIMARY KEY ("metricId")
);

-- CreateTable
CREATE TABLE "recommendations" (
    "recommendationId" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "priority" TEXT NOT NULL,
    "datetime" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "teamId" INTEGER NOT NULL,

    CONSTRAINT "recommendations_pkey" PRIMARY KEY ("recommendationId")
);

-- CreateIndex
CREATE UNIQUE INDEX "repositories_name_key" ON "repositories"("name");

-- CreateIndex
CREATE UNIQUE INDEX "repositories_url_key" ON "repositories"("url");

-- CreateIndex
CREATE UNIQUE INDEX "metrics_name_key" ON "metrics"("name");

-- CreateIndex
CREATE UNIQUE INDEX "recommendations_title_key" ON "recommendations"("title");

-- AddForeignKey
ALTER TABLE "developers" ADD CONSTRAINT "developers_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "teams"("teamId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "repositories" ADD CONSTRAINT "repositories_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "teams"("teamId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "metrics" ADD CONSTRAINT "metrics_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "teams"("teamId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "recommendations" ADD CONSTRAINT "recommendations_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "teams"("teamId") ON DELETE RESTRICT ON UPDATE CASCADE;
