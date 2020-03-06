import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { FighterService } from './services/fighter.service';
import { ImageService } from './services/image.service';
import { ListBuildService } from './services/list-build.service';
import { ShipBuildService } from './services/ship-build.service';
import { ShipService } from './services/ship.service';
import { UpgradeTypeService } from './services/upgrade-type.service';
import { UpgradeService } from './services/upgrade.service';
import { HttpClientModule } from '@angular/common/http';
import { NavbarComponent } from './components/navbar/navbar.component';
import { HomeComponent } from './components/home/home.component';

@NgModule({
  declarations: [
    AppComponent,
    NavbarComponent,
    HomeComponent
  ],
  imports: [
    FormsModule,
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
  ],
  providers: [
    FighterService,
    ImageService,
    ListBuildService,
    ShipBuildService,
    ShipService,
    UpgradeTypeService,
    UpgradeService
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
