const { db } = require("../util/admin");
const cron = require('node-cron');

deleteExpiredEvents = () => {
    //Cron Job that runs periodically to check for expired events
    cron.schedule("0 1,13 * * *", () => {
        let now = new Date()
        let events = db.collection("events").get()
        .then(querySnapshot => {
            querySnapshot.forEach(doc => {
                //Getting all events
                if(new Date(doc.data().endTime) < now) {
                    doc.ref.delete();
                }
            })
        });
    });
}

module.exports = deleteExpiredEvents;
