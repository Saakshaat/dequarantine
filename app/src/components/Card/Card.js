import React, {useEffect} from 'react';
import { makeStyles } from '@material-ui/core/styles';
import clsx from 'clsx';
import { Card, Paper } from '@material-ui/core';
import CardHeader from '@material-ui/core/CardHeader';
import CardMedia from '@material-ui/core/CardMedia';
import CardContent from '@material-ui/core/CardContent';
import CardActions from '@material-ui/core/CardActions';
import Collapse from '@material-ui/core/Collapse';
import Avatar from '@material-ui/core/Avatar';
import IconButton from '@material-ui/core/IconButton';
import Typography from '@material-ui/core/Typography';
import { red } from '@material-ui/core/colors';
import FavoriteIcon from '@material-ui/icons/Favorite';
import ShareIcon from '@material-ui/icons/Share';
import ExpandMoreIcon from '@material-ui/icons/ExpandMore';
import MoreVertIcon from '@material-ui/icons/MoreVert';
import Axios from 'axios';

const useStyles = makeStyles((theme) => ({
  root: {
    minWidth: 345,
    height: "400px",
    padding : "0.5rem"
  },
  media: {
    height: 0,
    paddingTop: '56.25%', // 16:9
  },
  expand: {
    transform: 'rotate(0deg)',
    marginLeft: 'auto',
    transition: theme.transitions.create('transform', {
      duration: theme.transitions.duration.shortest,
    }),
  },
  expandOpen: {
    transform: 'rotate(180deg)',
  },
  avatar: {
    backgroundColor: red[500],
  },
  liked : {
    fill : "red"
  },
  paper : {
    marginTop : "40px",
    padding: "30px"
  },
  typography: {
    marginLeft : '0.5rem'
  },
  header : {
    width : "100%",
    padding : theme.spacing(1)
  }
}));

export default function EventCard() {
            const classes = useStyles();
            const [expanded, setExpanded] = React.useState(false);

            const handleExpandClick = () => {
                setExpanded(!expanded);
            };
            useEffect(()=>{
            })
            return (
                <Card className={classes.root}>
                    <CardHeader
                    avatar={
                        <Avatar aria-label="recipe" className={classes.avatar}>
                        R
                        </Avatar>
                    }
                    title="Name of the social Event"
                    subheader="Date even happening"
                    className={classes.header}
                    />
                    <CardMedia
                    className={classes.media}
                    image="https://picsum.photos/200"
                    title="Paella dish"
                    />
                    <CardContent>
                    <Typography variant="body2" color="textSecondary" component="p">
                        description of the event 
                    </Typography>
                    </CardContent>
                    <CardActions disableSpacing>
                    <IconButton aria-label="add to favorites">
                        <FavoriteIcon className={classes.liked}/>
                        <Typography className={classes.typography}>
                            Going
                        </Typography>
                    </IconButton>
                    <IconButton>
                        
                    </IconButton>
                    </CardActions>
                </Card>
            );
            }