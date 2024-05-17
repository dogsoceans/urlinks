document.addEventListener('DOMContentLoaded', function() {
        const copyButton = document.getElementById('copyButton');
        if (copyButton) {
            copyButton.addEventListener('click', function() {
                navigator.clipboard.writeText(window.location.href)
                    .then(() => {
                    })
                    .catch(err => {
                        console.error('Error copying URL: ', err);
                        alert('Failed to copy URL.');
                    });
            });
        }
});
