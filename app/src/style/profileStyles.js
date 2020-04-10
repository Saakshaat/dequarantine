
export default (theme=>({
    root : {
        backgroundColor : "whitesmoke",
        width: '100vw',
        height : "100vh",
        padding : theme.spacing(2)
    },
    topContainer : {
        width: "100%",
        height : "90%",
        backgroundColor : theme.palette.wh.main,
        display : 'flex',
        flexDirection : "row",
        justifyContent : "space-evenly",
        paddingTop : theme.spacing(7)
    },
    paper : {
        height : "50%",
        width : "40%"
    },
    imageContainer : {
        width : "40%",
        height : "50%"
    }
}))

