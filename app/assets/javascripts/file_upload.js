function fileUpload(fileInput) {
    var imagePreview = document.querySelector('.upload-preview')
    fileInput.style.display = 'none' // uppy will add its own file input
    var uppy = Uppy.Core({
        id: fileInput.id,
        autoProceed: true,
    })
        .use(Uppy.FileInput, {
            target: fileInput.parentNode,
        })
        .use(Uppy.Informer, {
            target: fileInput.parentNode,
        })
        .use(Uppy.ProgressBar, {
            target: imagePreview.parentNode,
        })
    uppy.use(Uppy.XHRUpload, {
        endpoint: '/images/upload', // Shrine's upload endpoint
        fieldName: 'file',
    })
    uppy.on('upload-success', function (file, data) {
        // show image preview
        imagePreview.src = URL.createObjectURL(file.data)
        // read uploaded file data from the upload endpoint response
        var uploadedFileData = JSON.stringify(data)
        // set hidden field value to the uploaded file data so that it's submitted with the form as the attachment
        var hiddenInput = fileInput.parentNode.querySelector('.upload-hidden')
        hiddenInput.value = uploadedFileData
    })
    return uppy
}
document.querySelectorAll('.upload-file').forEach(function (fileInput) {
    fileUpload(fileInput)
})