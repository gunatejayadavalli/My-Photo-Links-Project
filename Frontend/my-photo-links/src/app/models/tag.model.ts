export class Tag {

  constructor(
    public tagId: number,
    public tagName: string,
    public creationTime: Date,
    public createdBy: string,
    public updationTime: Date,
    public updatedBy: string
  ) {}

}
