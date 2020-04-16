import React from "react";
import Box from "@material-ui/core/Box";
import { makeStyles } from "@material-ui/core/styles";
import { Paper, Container, Button, Grid } from "@material-ui/core";
import GridList from "@material-ui/core/GridList";
import GridListTile from "@material-ui/core/GridListTile";
import PropTypes from "prop-types";
import AppBar from "@material-ui/core/AppBar";
import CssBaseline from "@material-ui/core/CssBaseline";
import Divider from "@material-ui/core/Divider";
import Drawer from "@material-ui/core/Drawer";
import Hidden from "@material-ui/core/Hidden";
import IconButton from "@material-ui/core/IconButton";
import InboxIcon from "@material-ui/icons/MoveToInbox";
import List from "@material-ui/core/List";
import ListItem from "@material-ui/core/ListItem";
import ListItemIcon from "@material-ui/core/ListItemIcon";
import ListItemText from "@material-ui/core/ListItemText";
import MailIcon from "@material-ui/icons/Mail";
import MenuIcon from "@material-ui/icons/Menu";
import Toolbar from "@material-ui/core/Toolbar";
import Typography from "@material-ui/core/Typography";
import { useTheme } from "@material-ui/core/styles";
import Attending from "./Attending";
import axios from "axios";
import EventCard from "./EventCard";
import eventResults from "./eventResults";
import "../style/Homepage.scss";

class HomePage extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      EventsList: []
    };
  }

  calltoCheck(text) {
    var list_to = [];
    console.log('Arg' + text);
    axios
      .get(`https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/events/category/${text}`)
      .then(res => {
        alert(text);
        this.setState({ EventsList: res.data });
      });

    console.log(this.state.EventsList);
  }

  checkNumber() {
    console.log(this.state.EventsList);
  }

  render() {
    return (
      <div>
        <div className="Hero">
          <h1 align="center" padding="5">
            {" "}
            Dequarantine{" "}
          </h1>
        </div>

        <Container elevation={3} className="bCon">
          <List class="ButtonList">
            {["Entertainment", "Professional"].map(
              (text, index) => (
                <Button
                  onClick={() => {
                    this.calltoCheck(text);
                  }}
                  color="Primary"
                  class="ButtonS"
                >
                  <ListItemText primary={text} />
                </Button>
              )
            )}
          </List>
        </Container>

        <GridList row="3">
          {this.state.EventsList.map((text, index) => (
            <EventCard
              title={this.state.EventsList[index]["name"]}
              description={this.state.EventsList[index]['description']}
              img={this.state.EventsList[index]['imageUrl']}
            ></EventCard>
          ))}
        </GridList>
      </div>
    );
  }
}

export default HomePage;
