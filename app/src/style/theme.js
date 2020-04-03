import { createMuiTheme } from '@material-ui/core/styles';

export default createMuiTheme({
    palette : {
        primary: {
            // light: will be calculated from palette.primary.main,
            main: '#4A2223',
            // dark: will be calculated from palette.primary.main,
            // contrastText: will be calculated to contrast with palette.primary.main
          },
          secondary: {
            main: '#AD5658',
            // dark: will be calculated from palette.secondary.main,
          },
          error : {
              main : "#F5B431"
          },
          warning : {
            main : "#A83A24"
          },
          info : {
            main: "#3B3542"
          },
          main: {
            main: "#BD986D"
          }
    }
})