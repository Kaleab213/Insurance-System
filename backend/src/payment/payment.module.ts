/* eslint-disable prettier/prettier */
import { Module } from '@nestjs/common';
import { PaymentService } from './payment.service';
import { PaymentController } from './payment.contoller';

@Module({
  controllers:[PaymentController],
  providers:[PaymentService]

})
export class PaymentModule {}
