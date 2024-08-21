import { html, render } from 'lit-html';
import { icp_challenge_2_backend } from 'declarations/icp-challenge-2-backend';
import logo from './logo2.svg';

class App {
  dictionaryEntry = '';

  constructor() {
    this.#render();
  }

  #handleSubmit = async (e) => {
    e.preventDefault();
    const word = document.getElementById('word').value;
    this.dictionaryEntry = await icp_challenge_2_backend.get_dictionary_entry(word);
    this.#render();
  };

  #render() {
    let body = html`
      <main>
        <img src="${logo}" alt="DFINITY logo" />
        <br />
        <br />
        <form action="#">
          <label for="word">Enter a word: &nbsp;</label>
          <input id="word" alt="Word" type="text" />
          <button type="submit">Look Up!</button>
        </form>
        <section id="dictionaryEntry">${this.dictionaryEntry}</section>
      </main>
    `;
    render(body, document.getElementById('root'));
    document
      .querySelector('form')
      .addEventListener('submit', this.#handleSubmit);
  }
}

export default App;
