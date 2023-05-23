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
import { CustomerModule } from './customers/customer.module';
import { InsuranceModule } from './Insurance/insurance.module';


@Module({
  imports: [NotificationModule, PaymentModule, RequestModule, AuthModule,PrismaModule,InsuranceModule,CustomerModule,ConfigModule.forRoot({isGlobal:true})],

  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
