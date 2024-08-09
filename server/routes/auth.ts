import { register } from "../controllers/user";
import { Router } from 'express';

const router = Router();

router.post('/register', register);

export default router;
