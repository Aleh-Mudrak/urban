import * as express from 'express';
import 'express-async-errors';

const app = express();

app.get('*', (req: express.Request, res: express.Response) => {
  const response = {
    hostname: req.hostname,
    uptime: process.uptime(),
    podname: process.env.HOSTNAME,
  };

  res.status(200).send(response);
});

app.listen(3000, () => {
  console.log('listening on 3000');
});