import React, { useState } from 'react'
import {AppBar, Toolbar, Tabs, Tab} from '@material-ui/core'
import { makeStyles, Paper } from '@material-ui/core'
import styles from '../style/theme'

const useStyles = makeStyles(theme=>({
    tabsContainer : {
        marginLeft : "auto",
        display : "flex",
        flexDirection : "row",
        justifyContent : "space-evenly"
    },
    tab : {
        background : "#ffffff",
        padding: "0px",
        fontSize : "1.3rem",
        textTransform : "none",
        margin : "4px",
        width : "10px"
    }
}))

const Menu = () => {
    const classes = useStyles()
    const [value, setValue] = useState(0)
    const handleChange = (e, newValue) =>{
        setValue(newValue);
    }
    return (
        <AppBar className={classes.root}>
            <Toolbar>
                <Paper className={classes.root}>
                    <Tabs
                        value={value}
                        onChange={handleChange}
                        indicatorColor="primary"
                        textColor="primary"
                        centered
                    >
                        <Tab label="Item One" />
                        <Tab label="Item Two" />
                        <Tab label="Item Three" />
                    </Tabs>
                </Paper>
            </Toolbar>
        </AppBar>
    )
}

export default Menu
