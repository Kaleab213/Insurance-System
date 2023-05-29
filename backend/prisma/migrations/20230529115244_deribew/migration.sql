/*
  Warnings:

  - You are about to drop the column `date` on the `coverage_request` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `user_insurance` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `user_insurance` table. All the data in the column will be lost.
  - Added the required column `updatedAt` to the `Coverage_request` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `notification` DROP FOREIGN KEY `Notification_userId_fkey`;

-- AlterTable
ALTER TABLE `coverage_request` DROP COLUMN `date`,
    ADD COLUMN `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `updatedAt` DATETIME(3) NOT NULL,
    MODIFY `insured_payment` DOUBLE NULL,
    MODIFY `loss` DOUBLE NULL;

-- AlterTable
ALTER TABLE `user_insurance` DROP COLUMN `createdAt`,
    DROP COLUMN `updatedAt`;

-- AddForeignKey
ALTER TABLE `Notification` ADD CONSTRAINT `Notification_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
