/* eslint-disable prettier/prettier */
import { Module } from "@nestjs/common";
import { CustomerController } from "./customer.Controller";
import { CustomerService } from "./customer.service";

@Module({
  controllers:[CustomerController],
  providers:[CustomerService]
})
export class CustomerModule{}