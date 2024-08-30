import { bootstrapApplication } from '@angular/platform-browser';
import { appConfig } from './app/app.config';
import { AppComponent } from './app/app.component';

bootstrapApplication(AppComponent, appConfig)
  .catch((err) => console.error(err));

  document.addEventListener('DOMContentLoaded', () => {
   const selectFileButton = document.querySelector('.select-file') as HTMLButtonElement;
   const fileInput = document.querySelector('#file') as HTMLInputElement;

   if (selectFileButton && fileInput) {
      selectFileButton.addEventListener('click', () => {
         fileInput.click();
      });

      fileInput.addEventListener('change', () => {
         const selectedFile = fileInput.files ? fileInput.files[0] : null;
         if (selectedFile) {
            console.log('Selected file:', selectedFile);
            // Perform any additional actions with the selected file
         } else {
            console.log('No file selected');
         }
      });
   } else {
      console.error('File input or select file button not found');
   }
});


//Listner for convert button click. This button click will send the uploaded file to the backend service for conversion.
  document.addEventListener('DOMContentLoaded', () => {
     const convertButton = document.querySelector('.convert') as HTMLButtonElement;
     if (convertButton) {
        convertButton.addEventListener('click', () => {
           console.log('Convert button clicked');
           // Perform any additional actions to convert the file
        });
     } else {
        console.error('Convert button not found');
     }
  });


