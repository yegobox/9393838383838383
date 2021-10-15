import * as functions from "firebase-functions";
const admin = require('firebase-admin');
admin.initializeApp();
const db = admin.firestore();
/// const axios = require('axios');
/// const cors = require('cors')({ origin: true });
///  Start writing Firebase Functions
///  https://firebase.google.com/docs/functions/typescript
// axios.post('https://apihub.yegobox.com/v2/api/sendToAll', {
//     title: snapshot.data().title,
//     message: snapshot.data().message,
//     userId: snapshot.id
// })
//     .then((r: any) => {
//         console.log(r);
//         console.log('Sent the notification to all', snapshot.data().title, snapshot.data().message);
//     })
//     .catch(function () {
//         console.log('Failed to send notification');
//     });

exports.onMessageScheduled = functions.firestore
    .document('rooms/{roomId}/messages/{messageId}')
    .onCreate(async (snapshot, context) => {
        const roomId = snapshot.data().roomId;
        const authorId = snapshot.data().authorId;
        const text = snapshot.data().text;

        return db.collection("rooms").doc(roomId).get().then((snapshot: any) => {
            snapshot.data().userIds.forEach((topic: string) => {
                if (topic != authorId) {
                    /// send notification to all the users in the room except the author
                    console.log("topic::", topic);
                    const payload = {
                        notification: {
                            title: text,
                            body: text,
                            icon: 'https://placeimg.com/100/100/any',
                            click_action: 'https://yegobox.com'
                        }
                    };
                    return admin.messaging().sendToTopic(topic, payload);
                }
            });
            //dummy return for a function to be happy no idea of better way!
            return 22;
        }).catch((e: any) => {
            console.error('got error', e);
        })
    });
