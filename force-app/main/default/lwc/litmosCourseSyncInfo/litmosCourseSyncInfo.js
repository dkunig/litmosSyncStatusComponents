import { LightningElement, track } from 'lwc';
import litmosSync from '@salesforce/apex/litmosSyncController.getProgramSync';

export default class LitmosCourseSyncInfo extends LightningElement {
    columns = [
        {label: 'Name', fieldName: 'Name'},
        {label: 'Date/Time', fieldName: 'syncDate', type: 'date', typeAttributes: {year: 'numeric', month: 'long', day: '2-digit', hour: '2-digit', minute: '2-digit'}},
        {label: 'Course', fieldName: 'course'},
        {label: 'Status', fieldName: 'status'},
        {label: 'Issues', fieldName: 'issues'}
    ];
    @track sync;
    @track error;

    connectedCallback() {
        litmosSync()
        .then(result => {
            let currentData = [];
            result.forEach(row => {
                let rowData = [];
                rowData.Name = row.Name;
                rowData.syncDate = row.Date_Time_of_Sync__c;
                rowData.course = row.Course__r.Name,
                rowData.status = row.Status_of_Sync__c;
                rowData.issues = row.Sync_Issues__c;
                currentData.push(rowData);
            });
            this.sync = currentData;
            this.error = undefined;
        })
        .catch(error => {
            this.error = error;
            console.log(this.error);
            this.sync = undefined;
        })
    }
}