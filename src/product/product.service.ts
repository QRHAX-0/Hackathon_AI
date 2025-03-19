import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { Product } from '@prisma/client';

@Injectable()
export class ProductService {
  constructor(private prisma: PrismaService) {}

  async getAll(): Promise<Product[]> {
    return this.prisma.product.findMany();
  }

  async getById(id: string): Promise<Product | null> {
    return this.prisma.product.findUnique({ where: { id } });
  }

  async create(data: {
    name: string;
    description?: string;
    price: number;
  }): Promise<Product> {
    return this.prisma.product.create({ data });
  }

  async update(
    id: string,
    data: { name?: string; description?: string; price?: number },
  ): Promise<Product> {
    return this.prisma.product.update({ where: { id }, data });
  }

  async delete(id: string): Promise<Product> {
    return this.prisma.product.delete({ where: { id } });
  }
}
