import { bootstrapApplication } from '@angular/platform-browser';
import { appConfig } from './app/app.config';
import { AppComponent } from './app/app.component';

bootstrapApplication(AppComponent, appConfig)
  .catch((err) => console.error(err));

document.addEventListener('DOMContentLoaded', () => {
  const selectFileButton = document.querySelector('.select-file') as HTMLButtonElement;
  const fileInput = document.querySelector('#file') as HTMLInputElement;
  const messageContainer = document.querySelector('#message-container') as HTMLDivElement;

  if (selectFileButton && fileInput) {
    selectFileButton.addEventListener('click', () => {
      fileInput.click();
    });

    fileInput.addEventListener('change', () => {
      const selectedFile = fileInput.files ? fileInput.files[0] : null;

      if (selectedFile) {
        if (selectedFile.type === 'video/quicktime') {
          // Display success message and enable Convert button
          if (messageContainer) {
            messageContainer.innerHTML = '<div class="alert alert-success">File selected successfully!</div>';
          }
          document.querySelector('.convert')?.removeAttribute('disabled');
        } else {
          // Display error message
          if (messageContainer) {
            messageContainer.innerHTML = '<div class="alert alert-danger">Invalid file type. Please select a .mov file.</div>';
          }
          fileInput.value = ''; // Clear the file input
        }
      } else {
        console.log('No file selected');
      }
    });
  } else {
    console.error('File input or select file button not found');
  }

  const convertButton = document.querySelector('.convert') as HTMLButtonElement;
  if (convertButton) {
    convertButton.addEventListener('click', () => {
      const selectedFile = fileInput.files ? fileInput.files[0] : null;

      if (selectedFile) {
        // Display progress dialog
        const progressDialog = document.querySelector('#progress-dialog') as HTMLDivElement;
        if (progressDialog) {
          progressDialog.style.display = 'block';
        }

        // Simulate file upload and conversion process
        setTimeout(() => {
          // Hide progress dialog
          if (progressDialog) {
            progressDialog.style.display = 'none';
          }

          // Display success message
          if (messageContainer) {
            messageContainer.innerHTML = '<div class="alert alert-success">File uploaded and converted successfully!</div>';
          }

          // Enable Download button
          document.querySelector('.download')?.removeAttribute('disabled');
        }, 2000); // Simulate 2 seconds delay
      } else {
        // Display error message if no file is selected
        if (messageContainer) {
          messageContainer.innerHTML = '<div class="alert alert-danger">No file selected. Please select a .mov file.</div>';
        }
      }
    });
  } else {
    console.error('Convert button not found');
  }
});
