import { Component } from "@angular/core";
import { BuscadorComponent } from "./buscador/buscador.component";



@Component({
  standalone: true,
  selector: "app-root",
  template: ` <main>
    <header>
      <img class="logo" src="/assets/logo.svg" alt="Logo" aria-hidden="true" />
    </header>
    <section><app-buscador></app-buscador></section>
  </main>`,
  styleUrls: ["./app.component.css"],
  imports: [BuscadorComponent]
})
export class AppComponent {
  title = "EstadoVuelos";
}
