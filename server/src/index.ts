import express from 'express';
import AuthRoute from '../routes/auth';


const app = express();
const port = 5000;

app.use(express.json());

app.use('/api', AuthRoute);

app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});



