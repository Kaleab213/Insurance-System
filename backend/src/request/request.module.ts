/* eslint-disable prettier/prettier */
import { Module } from '@nestjs/common';
import { RequestController } from './request.controller';
import { RequestService } from './request.service';
import { PaymentController } from './payment.contoller';
import { PaymentService } from './payment.service';

@Module({
    controllers: [RequestController, PaymentController],
    providers: [RequestService, PaymentService]
})
export class RequestModule {}
