import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { RouterModule } from '@angular/router'; // Import RouterModule

import { AppComponent } from './app.component';
import { HomePageComponent } from './components/home-page/home-page.component'; // Corrected path for HomePageComponent

@NgModule({
  declarations: [
    AppComponent,
    HomePageComponent // Declare your components
  ],
  imports: [
    BrowserModule,
    RouterModule.forRoot([
        { path: '', component: HomePageComponent }
      ])
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
