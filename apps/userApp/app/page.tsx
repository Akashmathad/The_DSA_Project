import { db } from '@repo/db/client';

const getUser = async () => {
  const user = await db.user.findMany();
  console.log(user);
};
const page = async () => {
  await getUser();
  return <div>User app</div>;
};

export default page;
