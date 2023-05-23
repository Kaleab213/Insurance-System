/*
  Warnings:

  - You are about to drop the column `costumerId` on the `user_insurance` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE `user_insurance` DROP FOREIGN KEY `User_Insurance_costumerId_fkey`;

-- AlterTable
ALTER TABLE `user_insurance` DROP COLUMN `costumerId`,
    MODIFY `telebirr` VARCHAR(191) NULL;
