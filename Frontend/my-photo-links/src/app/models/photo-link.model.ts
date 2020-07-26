import { Tag } from './tag.model';

export class PhotoLink {

  constructor(
    public eventId: number,
    public event: string,
    public fromDate: Date,
    public toDate: Date,
    public photosLink: string,
    public creationTime: Date,
    public createdBy: string,
    public updationTime: Date,
    public updatedBy: string,
    public tags: Tag[]
  ) {}

}
