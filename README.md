# Mission du "Mec Chelou" - Script FiveM

Ce script ajoute une interaction immersive avec un PNJ (personnage non joueur) mystérieux, appelé "Mec Chelou". Les joueurs peuvent recevoir des missions, obtenir des items spéciaux, et vendre des produits en échange d'argent.

---

## Fonctionnalités

- **PNJ interactif :**
  - Spawn d'un PNJ au point spécifié.
  - Interaction avec le PNJ pour recevoir des objets : un téléphone crypté et des paquets de produits à vendre.

- **Notifications interactives :**
  - Le PNJ donne des indications via des notifications et met à jour le GPS des joueurs.

- **Vente des produits :**
  - Point de vente dédié où les joueurs peuvent vendre leurs produits pour obtenir des récompenses en argent.

- **Protection des objets :**
  - Les paquets de produits ne peuvent pas être jetés pour éviter les abus.

---

## Configuration

### Requis

- **Framework ESX** (es_extended) et ses dépendances.
- **ox_inventory** pour la gestion des objets.

### Points personnalisables

- **Coordonnées du PNJ :**
  - Modifiez les valeurs dans `client.lua` :
    ```lua
    local x, y, z = 524.742859, -826.852722, 15.31140
    ```

- **Coordonnées du point de vente :**
  - Modifiez les valeurs dans `client.lua` et `server.lua` :
    ```lua
    local markerCoords = vector3(56.057144, 165.824173, 104.783936)
    ```

---

## Installation

1. **Téléchargement :**
   - Clonez ou téléchargez ce dépôt.

2. **Ajout au serveur :**
   - Placez les fichiers `client.lua` et `server.lua` dans un dossier sous `resources/`.

3. **Activation :**
   - Ajoutez le script au fichier `server.cfg` :
     ```plaintext
     ensure MecChelou
     ```

4. **Vérification des dépendances :**
   - Assurez-vous que `es_extended` et `ox_inventory` sont installés.

---

## Utilisation

- **Interactions avec le PNJ :**
  - Approchez-vous du PNJ et appuyez sur la touche `E` pour interagir.
  - Si vous n'avez pas encore reçu les objets, le PNJ vous les fournira.

- **Vente des produits :**
  - Rendez-vous au point de vente indiqué sur le GPS.
  - Appuyez sur la touche `E` pour vendre les paquets de produits.

---

## Personnalisation

- **Ajouter des récompenses :**
  - Modifiez la logique des récompenses dans `server.lua` :
    ```lua
    local reward = ShitItem.count * 10000
    ```

- **Modifier les objets donnés :**
  - Ajoutez ou modifiez les objets dans `server.lua` :
    ```lua
    exports.ox_inventory:AddItem(source, 'crypted_phone', 1)
    exports.ox_inventory:AddItem(source, 'packet_de_shit', 5)
    ```
