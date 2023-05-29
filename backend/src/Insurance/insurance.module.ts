/* eslint-disable prettier/prettier */
import { Module } from "@nestjs/common";
import { InsuranceController } from './insurance.controller';
import { InsuranceService } from "./insurance.service";
import { PhotoController } from "src/helper/photo/photo.controller";

@Module({
  controllers:[InsuranceController,PhotoController],
  providers:[InsuranceService]
})
export class InsuranceModule{}