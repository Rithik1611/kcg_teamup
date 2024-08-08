import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  const data = await prisma.user.create({
    data: {
      name: 'Rich',
      email: 'hello@prisma.com',
      department: 'cse',
      section: '5a',
    },
  });

  console.log('Data',data)
}

