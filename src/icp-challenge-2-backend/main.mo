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
    const response = await icp_challenge_2_backend.get_dictionary_entry(word);
    const parsedResponse = JSON.parse(response);

    const wordDetails = parsedResponse[0];
    const phonetics = wordDetails.phonetics.map(phonetic => phonetic.text ? `${phonetic.text} (${phonetic.audio})` : '').join(', ');
    const meanings = wordDetails.meanings.map(meaning => {
      return `
        <h3>${meaning.partOfSpeech}</h3>
        ${meaning.definitions.map(def => `<p>${def.definition}${def.example ? `<br><i>Example: ${def.example}</i>` : ''}</p>`).join('')}
      `;
    }).join('');

    this.dictionaryEntry = `
      <h2>${wordDetails.word}</h2>
      <p><strong>Phonetics:</strong> ${phonetics}</p>
      ${meanings}
    `;

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
        <section id="dictionaryEntry">${html([this.dictionaryEntry])}</section>
      </main>
    `;
    render(body, document.getElementById('root'));
    document
      .querySelector('form')
      .addEventListener('submit', this.#handleSubmit);
  }
}

export default App;
