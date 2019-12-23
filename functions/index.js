const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();
const fcm = admin.messaging();
const db = admin.firestore();

exports.modifyUser = functions.firestore
  .document('Users/{UserID}')
  .onUpdate((change, context) => {
    // Get an object with the current document value.
    // If the document does not exist, it has been deleted.
    const document = change.after.exists ? change.after.data() : null;

    // Get an object with the previous document value (for update or delete)
    const oldDocument = change.before.data();
    const newDocument = change.after.data();

    if (newDocument["currentStorageCapacity"] < 500) {
      console.log(newDocument["uid"] + " Uid");


      db.collection("Users").doc(newDocument["uid"]).collection("tokens").get().then(doc => {

        const tokenSnapShot = doc;
        const tokens = tokenSnapShot.docs.map(snap => snap.id);
        const currentValue = newDocument["currentStorageCapacity"];
        const notificationContent = {
          notification: {
            title: "Depoda Yeteri Kadar Mama Olmayabilir",
            body: "Deponuzda " + currentValue + "GR mama kaldı. Lütfen uygulamaya girip sipariş verin ...",
            icon: "default",
            sound: "default"

          }
        };
        const options = {
          priority: "high",
          timeToLive: 60 * 60 * 24
        };
        console.log(newDocument["uid"] + " \n uid \n");

        console.log(tokens + " \n Token \n");
        return fcm.sendToDevice(tokens, notificationContent, options);


      }).catch(err => {
        console.log('Error getting documents', err);
      });


    } else return console.log("500 üstünde");

    // perform desired operations ...
  });


exports.getDatabaseToFireStore = functions.database.ref('/devices/{deviceId}')
  .onWrite((change, context) => {

    // Grab the current value of what was written to the Realtime Database.
    const original = change.after._data;
    console.log(Number(original["weight"]));
    console.log(original["deviceID"]);

    db.collection("Devices").doc(original["deviceID"]).get().then((snapShot) => {
      var data = snapShot.data();
      console.log(data["uid"] + " uid 1");
      db.collection("Users").doc(data["uid"]).update({ "currentStorageCapacity": original["weight"]}).then((value) => {
       return console.log(value + " Value");

      }).catch(err => {
        console.log('Error setting documents', err);
      });
      return console.log("ins calisti");
    }).catch(err => {
      console.log('Error getting documents', err);
    });


    return null;
  });
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });
