import { LightningElement, api, wire, track } from 'lwc';
import getOpportunities from '@salesforce/apex/OpportunityController.getOpportunities';
const COLUMNS = [
    {
        label: 'Opportunity name',
        fieldName: 'nameUrl',
        type: 'url',
        typeAttributes: {label: { fieldName: 'Name' }, 
        target: '_blank'},
        sortable: true
    },
    {
        label: 'Stage Name',
        fieldName: 'StageName',
        type: 'text',
        sortable: true
    },
    {
        label: 'Amount',
        fieldName: 'Amount',
        type: 'currency', 
        typeAttributes: { currencyCode: 'EUR' },
        sortable: true
    }

];

const PAGE_SIZE = 10; 

export default class relatedOpportunities extends LightningElement {
    @api recordId;

    columns = COLUMNS;
    opportunities = [];
    filteredOpportunities = [];
    displayedOpportunities = [];
    currentPage = 1;
    totalPages = 1;

    @wire(getOpportunities, { accountId: '$recordId' })
    wiredOpportunities({ error, data }) {
        if (data) {
            let nameUrl;
            this.opportunities = data.map(row => { 
                nameUrl = `/${row.Id}`;
                return {...row , nameUrl} 
            })
            this.totalPages = Math.ceil(data.length / PAGE_SIZE); 
                        this.filteredOpportunities = this.opportunities;
            this.updateDisplayedOpportunities();
        } else if (error) {
            console.error(error);
        }
    }

    handleFilterChange(event) {
        const filterValue = event.target.value.toLowerCase();

        this.filteredOpportunities = this.opportunities.filter(opportunity =>
            opportunity.Name.toLowerCase().includes(filterValue)
        );

        this.updateDisplayedOpportunities();
    }

    updateDisplayedOpportunities() {
        const startIndex = (this.currentPage - 1) * PAGE_SIZE;
        this.displayedOpportunities = this.filteredOpportunities.slice(startIndex, startIndex + PAGE_SIZE);
    }

    handlePageChange(event) {
        this.currentPage = event.detail.page;
        this.updateDisplayedOpportunities();
    }
}
