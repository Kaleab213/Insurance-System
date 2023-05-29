/*
  Warnings:

  - You are about to drop the column `Document` on the `user_insurance` table. All the data in the column will be lost.
  - You are about to drop the column `appraisal` on the `user_insurance` table. All the data in the column will be lost.
  - You are about to drop the column `level` on the `user_insurance` table. All the data in the column will be lost.
  - You are about to drop the column `room` on the `user_insurance` table. All the data in the column will be lost.
  - You are about to drop the column `type` on the `user_insurance` table. All the data in the column will be lost.
  - Added the required column `coveragelevel` to the `User_Insurance` table without a default value. This is not possible if the table is not empty.
  - Added the required column `numberofrooms` to the `User_Insurance` table without a default value. This is not possible if the table is not empty.
  - Added the required column `ownershipdocument` to the `User_Insurance` table without a default value. This is not possible if the table is not empty.
  - Added the required column `propertytype` to the `User_Insurance` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `user_insurance` DROP COLUMN `Document`,
    DROP COLUMN `appraisal`,
    DROP COLUMN `level`,
    DROP COLUMN `room`,
    DROP COLUMN `type`,
    ADD COLUMN `coveragelevel` VARCHAR(191) NOT NULL,
    ADD COLUMN `numberofrooms` INTEGER NOT NULL,
    ADD COLUMN `ownershipdocument` VARCHAR(191) NOT NULL,
    ADD COLUMN `propertytype` VARCHAR(191) NOT NULL,
    MODIFY `size` INTEGER NOT NULL,
    MODIFY `monthly_payment` INTEGER NULL;
