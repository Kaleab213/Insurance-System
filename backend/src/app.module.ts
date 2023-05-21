/* eslint-disable prettier/prettier */
import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './Authentication/Auth.module';
import { PrismaModule } from './Prisma/prisma.module';
import { ConfigModule } from '@nestjs/config';
import { RequestModule } from './request/request.module';
import { PaymentModule } from './payment/payment.module';
import { NotificationModule } from './notification/notification.module';

@Module({
  imports: [AuthModule,PrismaModule,ConfigModule.forRoot({isGlobal:true}), RequestModule, PaymentModule, NotificationModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
