import React from 'react';
import { View } from 'react-native'
import Geolocation from 'react-native-geolocation-service';
import MapView from 'react-native-maps';
import { HStack, VStack, Button } from 'swiftui-react-native';

import { ASPECT_RATIO } from '../helpers/Screen'
import { styles } from '../Styles/Default'

export class DefaultApp extends React.Component
{
    LATITUDE_DELTA = 0.04
    LONGITUDE_DELTA = this.LATITUDE_DELTA * ASPECT_RATIO
    mapView = new MapView({
        region: {
            longitude: 0,
            latitude: 0,
            longitudeDelta: this.LONGITUDE_DELTA,
            latitudeDelta: this.LATITUDE_DELTA
        },
        style: styles.map
    })
    constructor(props: any)
    {
        super(props)
        this.getLocationPermission(() => {
            this.getLocation(async (data: any) => {
                this.mapView.animateToRegion({
                    longitude: data.coords.longitude, 
                    latitude: data.coords.latitude, 
                    latitudeDelta: this.LATITUDE_DELTA, 
                    longitudeDelta: this.LONGITUDE_DELTA})
            }, () => {
                console.warn("Fail to get the location")
            })
        }, () => {
            console.warn("Cannot get location permission")
        })
    }

    getLocationPermission(success: any, failure: any): void
    {
        try {
            Geolocation.requestAuthorization('whenInUse')
            .then(success)
            .catch(failure)
        } catch (error) {
            console.warn(error)
        }
    }

    getLocation(success: any, failure: any): void
    {
        try {
            Geolocation.getCurrentPosition(success, failure)
        } catch(error) {
            console.log(error)
        }
    }

    buttonIsPressed(): void
    {
        console.log("Button has been pressed")
    }

    render()
    {
        return (
            <View style={styles.container}>
                {this.mapView.render()}
                <HStack style={styles.item}>
                    <Button title='MyButton'></Button>
                </HStack>
            </View>
        )
    }
}