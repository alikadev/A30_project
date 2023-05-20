import React from 'react';
import MapView, { Marker } from 'react-native-maps';
import { StyleSheet, View, Platform, Dimensions } from 'react-native';
import Geolocation from 'react-native-geolocation-service';
import {
  HStack,
  Button,
} from 'swiftui-react-native';

function getLocationPermission(success: any, failure: any): void
{
  try {
    Geolocation.requestAuthorization('whenInUse')
    .then(success)
    .catch(failure)
  } catch (error) {
    console.warn(error)
  }
}

function getLocation(success: any, failure: any): void
{
  try {
    Geolocation.getCurrentPosition(success, failure)
  } catch(error) {
    console.log(error)
  }
}
type Coord = {
  longitude: number
  latitude: number
}

const screen = Dimensions.get('window')
const ASPECT_RATIO = screen.width / screen.height
const LATITUDE_DELTA = 0.04
const LONGITUDE_DELTA = LATITUDE_DELTA * ASPECT_RATIO


function buttonIsPressed()
{
  console.log("Button has been pressed")
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'column',
    display: 'flex'
  },
  item: {
    flex: 1
  },
  map: {
    flex: 3,
  },
});

let mapview = new MapView(
  {
    style: styles.map, 
    region: {
      latitude: 0, 
      longitude: 0, 
      latitudeDelta: LATITUDE_DELTA, 
      longitudeDelta: LONGITUDE_DELTA}});
export default function App() {

  getLocationPermission(() => {
    getLocation(async (data: any) => {
      let lat = data.coords.latitude
      let lon = data.coords.longitude
      console.log(lat, lon)
      mapview.animateToRegion({longitude: lon, latitude: lat, latitudeDelta: LATITUDE_DELTA, longitudeDelta: LONGITUDE_DELTA})
    }, () => {
    })
  }, () => {
    console.warn("Cannot get location permission")
  })
  
  return (
    <View style={styles.container}>
      {mapview.render()}
      <HStack style={styles.item}>
        <Button title='MyButton'></Button>
      </HStack>
    </View>
  )
}
