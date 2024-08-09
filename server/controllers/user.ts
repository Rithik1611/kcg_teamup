import { PrismaClient } from '@prisma/client';
import { Request, Response } from 'express';

const prisma = new PrismaClient();

export const register = async (req: Request, res: Response): Promise<void> => {
    try {
        const { email, name, password } = req.body;

        // Check if email already exists
        const emailAlreadyExists = await prisma.user.findUnique({
            where: {
                email: email,
            },
        });

        if (emailAlreadyExists) {
            res.status(400).json({ message: 'Email already exists' });
            return;
        }

        // Create a new user
        const user = await prisma.user.create({
            data: {
                email,
                name,
                password, // Ensure you hash the password before saving in a real application
                department: 'default department',
                section: 'default section',
            },
        });

        res.status(201).json(user);
    } catch (error) {
        res.status(500).json({ message: 'Internal server error', error: (error as Error).message });
    }
};
