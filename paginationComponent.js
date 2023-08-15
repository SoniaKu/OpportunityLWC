import { LightningElement, api } from 'lwc';

export default class paginationComponent extends LightningElement {
    @api currentPage = 1;
    @api totalPages = 1;

    handlePrevious() {
        if (this.currentPage > 1) {
            this.dispatchEvent(new CustomEvent('pagechange', { detail: { page: this.currentPage - 1 } }));
        }
    }

    handleNext() {
        if (this.currentPage < this.totalPages) {
            this.dispatchEvent(new CustomEvent('pagechange', { detail: { page: this.currentPage + 1 } }));
        }
    }
}
