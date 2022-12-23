import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';
import createUser from '@salesforce/apex/handleEventClass.createUser';
export default class CreateCustomUserButton extends LightningElement 
{
    @api recordId;
    @api objectApiName;
 
    showToast(title, message, variant) 
    {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }
 
    handleSuccess ()
    {
        this.dispatchEvent(new CloseActionScreenEvent());
        this.showToast('Success!', 'The Contact record has been successfully Updated', 'Success');
    }
     handle(event)
    {
        createUser({ recordId : this.recordId})
        .then(result =>
            {
                this.showToast('Success!', 'User created Successfully', 'Success');
            })
   
        .catch(error =>
            {
                var errorMessageBody = error.body.message;
                var errorMessage = errorMessageBody.substring(errorMessageBody.indexOf(":") + 1, 
                                                              errorMessageBody.lastIndexOf(":"));
                this.showToast('ERROR!', errorMessage, 'Error');            
            });
    }

}
