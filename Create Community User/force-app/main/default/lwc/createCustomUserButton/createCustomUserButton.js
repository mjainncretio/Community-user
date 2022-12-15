import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';
import createUser from '@salesforce/apex/handleEventClass.createUser';
export default class CreateCustomUserButton extends LightningElement {
    @api recordId;
    @api objectApiName;
 
    showToast(title, message, variant) {
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
                this.showToast('Success!', 'The Contact record has been successfully Updated', 'Success');
            })
   
        .catch(error =>
            {
                //toast messages when error in creation of user
               if(error.body.message === 'Insert failed. First exception on row 0; first error: UNKNOWN_EXCEPTION, portal account owner must have a role: []')
               {
                this.showToast('ERROR!', 'Contact does not have a account associated to it !!', 'Error');
               }
               else if(error.body.message === 'Insert failed. First exception on row 0; first error: LICENSE_LIMIT_EXCEEDED, License Limit Exceeded - Customer Community: []')
               {
                this.showToast('ERROR!', 'License Limit Exceeded', 'Error');
               }
               else if(error.body.message === 'Insert failed. First exception on row 0; first error: PORTAL_USER_ALREADY_EXISTS_FOR_CONTACT, portal user already exists for contact: []')
               {
                this.showToast('ERROR!', 'portal user already exists for contact!!', 'Error');
               }
               else if(error.body.message === 'Insert failed. First exception on row 0; first error: FIELD_INTEGRITY_EXCEPTION, Username must be in the form of an email address (for example, john@acme.com): Username: [Username]')
               {
                this.showToast('ERROR!', 'contact does not have a email!!', 'Error');
               }
               else
               {
                this.showToast('ERROR!', error.body.message, 'Error');
               }
        });
    }

}