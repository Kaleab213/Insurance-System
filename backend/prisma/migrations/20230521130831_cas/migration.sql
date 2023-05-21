-- DropForeignKey
ALTER TABLE `costumers` DROP FOREIGN KEY `Costumers_userId_fkey`;

-- DropForeignKey
ALTER TABLE `coverage_request` DROP FOREIGN KEY `Coverage_request_insuranceId_fkey`;

-- DropForeignKey
ALTER TABLE `notification` DROP FOREIGN KEY `Notification_insuranceId_fkey`;

-- DropForeignKey
ALTER TABLE `payment` DROP FOREIGN KEY `Payment_insuranceId_fkey`;

-- DropForeignKey
ALTER TABLE `user_insurance` DROP FOREIGN KEY `User_Insurance_costumerId_fkey`;

-- AddForeignKey
ALTER TABLE `Costumers` ADD CONSTRAINT `Costumers_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `User_Insurance` ADD CONSTRAINT `User_Insurance_costumerId_fkey` FOREIGN KEY (`costumerId`) REFERENCES `Costumers`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Payment` ADD CONSTRAINT `Payment_insuranceId_fkey` FOREIGN KEY (`insuranceId`) REFERENCES `User_Insurance`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Coverage_request` ADD CONSTRAINT `Coverage_request_insuranceId_fkey` FOREIGN KEY (`insuranceId`) REFERENCES `User_Insurance`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Notification` ADD CONSTRAINT `Notification_insuranceId_fkey` FOREIGN KEY (`insuranceId`) REFERENCES `User_Insurance`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
