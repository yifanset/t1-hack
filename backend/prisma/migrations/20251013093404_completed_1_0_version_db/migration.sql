-- DropIndex
DROP INDEX "public"."metrics_name_key";

-- DropIndex
DROP INDEX "public"."recommendations_title_key";

-- AlterTable
ALTER TABLE "recommendations" ALTER COLUMN "priority" SET DEFAULT 'LOW';

-- CreateTable
CREATE TABLE "commits" (
    "commitId" SERIAL NOT NULL,
    "hash" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "developerId" INTEGER NOT NULL,
    "repositoryId" INTEGER NOT NULL,

    CONSTRAINT "commits_pkey" PRIMARY KEY ("commitId")
);

-- CreateTable
CREATE TABLE "pull_requests" (
    "prId" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL,
    "mergedAt" TIMESTAMP(3),
    "authorId" INTEGER NOT NULL,
    "repositoryId" INTEGER NOT NULL,

    CONSTRAINT "pull_requests_pkey" PRIMARY KEY ("prId")
);

-- CreateTable
CREATE TABLE "code_reviews" (
    "reviewId" SERIAL NOT NULL,
    "status" TEXT NOT NULL,
    "commentsCount" INTEGER NOT NULL DEFAULT 0,
    "authorId" INTEGER NOT NULL,
    "prId" INTEGER NOT NULL,

    CONSTRAINT "code_reviews_pkey" PRIMARY KEY ("reviewId")
);

-- CreateIndex
CREATE UNIQUE INDEX "commits_hash_key" ON "commits"("hash");

-- AddForeignKey
ALTER TABLE "commits" ADD CONSTRAINT "commits_developerId_fkey" FOREIGN KEY ("developerId") REFERENCES "developers"("developerId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "commits" ADD CONSTRAINT "commits_repositoryId_fkey" FOREIGN KEY ("repositoryId") REFERENCES "repositories"("repositoryId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pull_requests" ADD CONSTRAINT "pull_requests_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "developers"("developerId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pull_requests" ADD CONSTRAINT "pull_requests_repositoryId_fkey" FOREIGN KEY ("repositoryId") REFERENCES "repositories"("repositoryId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "code_reviews" ADD CONSTRAINT "code_reviews_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "developers"("developerId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "code_reviews" ADD CONSTRAINT "code_reviews_prId_fkey" FOREIGN KEY ("prId") REFERENCES "pull_requests"("prId") ON DELETE RESTRICT ON UPDATE CASCADE;
