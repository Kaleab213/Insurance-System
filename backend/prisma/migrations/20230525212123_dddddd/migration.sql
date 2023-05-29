/*
  Warnings:

  - You are about to drop the column `coveragelevel` on the `user_insurance` table. All the data in the column will be lost.
  - You are about to drop the column `numberofrooms` on the `user_insurance` table. All the data in the column will be lost.
  - You are about to drop the column `ownershipdocument` on the `user_insurance` table. All the data in the column will be lost.
  - You are about to drop the column `propertytype` on the `user_insurance` table. All the data in the column will be lost.
  - You are about to alter the column `size` on the `user_insurance` table. The data in that column could be lost. The data in that column will be cast from `Int` to `Double`.
  - Added the required column `Document` to the `User_Insurance` table without a default value. This is not possible if the table is not empty.
  - Added the required column `level` to the `User_Insurance` table without a default value. This is not possible if the table is not empty.
  - Added the required column `room` to the `User_Insurance` table without a default value. This is not possible if the table is not empty.
  - Added the required column `type` to the `User_Insurance` table without a default value. This is not possible if the table is not empty.
  - Made the column `monthly_payment` on table `user_insurance` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE `user_insurance` DROP COLUMN `coveragelevel`,
    DROP COLUMN `numberofrooms`,
    DROP COLUMN `ownershipdocument`,
    DROP COLUMN `propertytype`,
    ADD COLUMN `Document` VARCHAR(191) NOT NULL,
    ADD COLUMN `appraisal` DOUBLE NULL,
    ADD COLUMN `level` DOUBLE NOT NULL,
    ADD COLUMN `room` INTEGER NOT NULL,
    ADD COLUMN `type` VARCHAR(191) NOT NULL,
    MODIFY `size` DOUBLE NOT NULL,
    MODIFY `monthly_payment` DOUBLE NOT NULL;
