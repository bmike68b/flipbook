import { observable } from 'riot'
import { decrypt } from './util/crypto'
import generatePassword  from './util/password-generator'
import generateRandomId from './util/random-id'

export const USER_KEY_LENGHT = 64

export default observable({
  encryptedKey: false,
  key: false,

  init(database) {
    firebase.initializeApp({
      apiKey: '<@API_KEY@>',
      authDomain: '<@AUTH_DOMAIN@>',
      databaseURL: '<@DATABASE_URL@>',
      projectId: '<@PROJECT_ID@>',
      storageBucket: '<@STORAGE_BUCKET@>',
      messagingSenderId: '<@MESSAGING_SENDER_ID@>'
    })

    this.database = database
    this.database.init()

    return new Promise((resolve, reject) => {
      firebase.auth().onAuthStateChanged(user => {
        if (user) {
          this.fetchEncryptedKey()
            .then(() => resolve(user))
            .catch(e => this.showLoginFailure(e))
        } else {
          reject()
        }
      })
    })
  },

  async login() {
    const provider = new firebase.auth.GoogleAuthProvider()

    await firebase.auth().signInWithPopup(provider)

    return this.fetchEncryptedKey()
      .then(key => this.trigger('login') && key)
      .catch(e => this.showLoginFailure(e))
  },

  async logout() {
    await firebase.auth().signOut()

    this.trigger('logout')
    this.lock()
  },

  async fetchPasswords() {
    const snapshot = await this.database.account.getPasswords(this.user)

    return snapshot.val() && Object.values(snapshot.val()) || []
  },

  async setEncryptedKey(password) {
    const key = this.key || generatePassword(USER_KEY_LENGHT)

    await this.database.key.set(this.user, key, password)

    this.key = key
    this.encryptedKey = (await this.database.key.get(this.user)).val()

    this.trigger('unlock')
    return { key: key, encryptedKey: this.encryptedKey }
  },

  async unlock(password) {
    const encryptedKey = (await this.database.key.get(this.user)).val()

    if (!encryptedKey) return false

    const key = decrypt(encryptedKey, password)

    if (key) {
      this.key = key
      this.trigger('unlock')
      return true
    }
    return false
  },

  showLoginFailure(error) {
    this.openModal('error-alert', {
      error,
      solution: `Make sure your "uid" is whitelisted via firebase console.
  Or contact directly the admin to solve the issue <@ADMIN_EMAIL@>`
    })
  },

  openModal(component, data) {
    this.trigger('modal:open', component, data)
  },

  closeModal() {
    this.trigger('modal:close')
  },

  decrypt(value) {
    return decrypt(value, this.key)
  },

  lock() {
    this.key = false
    this.trigger('lock')
  },
  
  get isLocked() {
    return !this.key
  },
  get user() {
    return firebase.auth().currentUser
  }
})