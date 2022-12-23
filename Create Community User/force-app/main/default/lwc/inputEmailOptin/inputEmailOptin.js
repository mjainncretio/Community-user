import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';
import createUser from '@salesforce/apex/handleEventClass.createUser';
 
export default class InputEmailOptin extends LightningElement {
    @api recordId;
    @api objectApiName;
  
    handleSuccess(e) {
        console.log('record id is ',this.recordId);
       // this.dispatchEvent(new CloseActionScreenEvent());
       
         // Close the modal window and display a success toast
         
       
    }
    handle(e)
    {
        createUser({ contactId : this.recordId})
        .then(result => 
        {
            this.dispatchEvent(
                new ShowToastEvent(
                {
                    title: 'Success',
                    message: ' Successfully!!',
                    variant: 'success'
                })
               
            );
        })
        .catch(error => 
            {
            this.dispatchEvent(
                new ShowToastEvent(
                {
                    title: 'ERROR',
                    message: 'Some Error has Occured!!',
                    variant: 'Error'
                })
              
            );
            console.log( error);
        });
    }
}