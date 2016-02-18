//$.support.transition = false

$(document).ready(function() {
    $('#delete').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget) // Button that triggered the modal

        var modal = $(this)
        modal.find('.modal-title').text('Delete customer')
        modal.find('.modal-body div.alert.alert-danger').text('Are you sure you want to delete customer: ' + button.data('email'))
        modal.find('.modal-footer a.btn.btn-success').attr('href',button.data('url')).attr('data-method',button.data('method'))
    })

    $('#update').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget) // Button that triggered the modal

        var modal = $(this)
        modal.find('.modal-title').text('Update customer')
        modal.find('.modal-body div.alert.alert-danger').text('Are you sure you want to update customer: ' + button.data('email'))
        modal.find('.modal-footer button.btn.btn-success').on('click', function() {
           $("#"+button.data("form")).submit();
        });
    })
});