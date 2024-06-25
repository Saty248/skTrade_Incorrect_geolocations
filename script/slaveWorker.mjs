import { workerData, parentPort } from 'worker_threads'
import utf8 from 'utf8'
import { encode } from 'urlencode'
import axios from 'axios'

const countryName = 'US'
export default async function getLongitudeAndLatitude() {
    let userData = workerData.userData
    console.log('in workertheread', userData)
    try {
        let address = `${userData.address} ${countryName}`
        const initialLongitude = userData.longitude
        const initialLatitude = userData.latitude
        let utf8Address = utf8.encode(address)
        let urlAddress = encode(utf8Address)
        let res = await axios.get(
            `https://api.mapbox.com/geocoding/v5/mapbox.places/${urlAddress}.json?proximity=ip&access_token=pk.eyJ1IjoiamhlbHkiLCJhIjoiY2tjN2dpZnljMTE4YTJ1cmlta3d1ZWZqayJ9.PbXL9T_TjtWax74bAUPrRg`
        )
        let ans = res.data
        let geoLo = ans?.features[0]?.geometry?.coordinates
        /*  let insertSql = `INSERT INTO properties ( "createdAt", "updateAt", "address", "ownerId", "propertyStatusId", "hasChargingStation", "hasLandingDeck", "hasStorageHub", "isRentableAirspace", title, "transitFee", "noFlyZone", "isFixedTransitFee", latitude, longitude, timezone, "isActive") Values (current_timestamp , current_timestamp,'${address}',${1},1, false, false, false, true,'${
            userData.Title
        },'1 USD',false,false,${geoLo[1]},${geoLo[0]},"US/Central",true);\n` */
        if (
            Math.abs(geoLo[0] - initialLongitude) <= 0.01 &&
            Math.abs(geoLo[1] - initialLatitude) <= 0.01
        ) {
            parentPort.postMessage({ status: 'match', message: userData })
        } else {
            let finalData = {
                ...userData,
                actualLongitude: geoLo[0],
                actualLatitude: geoLo[1],
            }
            parentPort.postMessage({ status: 'noMatch', message: finalData })
        }
        //parentPort.postMessage({ status: 'match', message: userData })
    } catch (error) {
        console.log('eroor', error)
        parentPort.postMessage({ status: 'fail', message: `${userData.id}` })
    }
    console.log(userData.id)
    return userData.id
}
getLongitudeAndLatitude()
    .then((id) => {
        console.log(`thread for ${id} is success`)
    })
    .catch((error) => {
        console.log(`thread for  is fail`)
    })
