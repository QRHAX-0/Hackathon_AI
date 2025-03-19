import { Module } from '@nestjs/common';
import { ProductService } from './product.service';
import { ProductController } from './product.controller';
import { PrismaModule } from '../prisma/prisma.module';

@Module({
  imports: [PrismaModule], // Import the PrismaModule here
  controllers: [ProductController],
  providers: [ProductService],
})
export class ProductModule {}
