import { Tag } from "./tag.model";
import { Role } from "./role.model";

export class User {
  
  constructor(
    public userId: number,
    public userName: string,
    public firstName: string,
    public lastName: string,
    public emailId: string,
    public blockFlag: string,
    public blockReason: string,
    public secQues: string,
    public roles: Role[],
    public tags: Tag[]
  ) {}

}
