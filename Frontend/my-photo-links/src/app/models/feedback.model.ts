export class Feedback {
  
  constructor(
    public feedbackId: number,
    public userId: number,
    public feedbackType: string,
    public feedbackMsg: string,
    public submittedDate: Date,
    public submittedBy: string,
    public readDate: Date,
    public readBy: string,
    public resolvedDate: Date,
    public resolvedBy: string,
    public resolutionMsg: string,
  ) {}

}