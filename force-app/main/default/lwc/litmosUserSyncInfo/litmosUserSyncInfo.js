import { LightningElement, track } from 'lwc';
import litmosSync from '@salesforce/apex/litmosSyncController.getUserSyncInfo';

export default class LitmosUserSyncInfo extends LightningElement {
    columns = [
        {label: 'Sync Name', fieldName: 'Name'},
        {label: 'Date/Time', fieldName: 'Date_Time_of_Sync__c', type: 'date', typeAttributes: { year: 'numeric', month: 'long', day: '2-digit', hour: '2-digit', minute: '2-digit'}},
        {label: 'User', fieldName: 'userName'},
        {label: 'Status', fieldName: 'Status_of_Sync__c'},
        {label: 'Issues', fieldName: 'Sync_Issues__c'}
    ];
    @track sync;
    @track error;

    connectedCallback() {
        litmosSync()
        .then(result => {
            let currentData = [];
            result.forEach((row) => {
                let rowData = {};
                rowData.Name = row.Name;
                rowData.Date_Time_of_Sync__c = row.Date_Time_of_Sync__c;
                rowData.userName = row.User__r.Name;
                rowData.Status_of_Sync__c = row.Status_of_Sync__c;
                rowData.Sync_Issues__c = row.Sync_Issues__c;

                currentData.push(rowData);
            });
            this.sync = currentData;
        })
        .catch(error => {
            this.error = error;
            this.sync = undefined;
            console.log('error: ' + this.error);
        });
    }
}