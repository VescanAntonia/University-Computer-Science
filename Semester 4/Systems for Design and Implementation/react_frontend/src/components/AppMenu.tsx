import { Box, AppBar, Toolbar, IconButton, Typography, Button } from "@mui/material";
import { Link, useLocation } from "react-router-dom";
import LocalAirportIcon from '@mui/icons-material/LocalAirport';
import TravelExploreIcon from '@mui/icons-material/TravelExplore';

export const AppMenu = () => {
	const location = useLocation();
	const path = location.pathname;

	return (
		<Box sx={{ flexGrow: 1 }}>
			<AppBar position="static" sx={{ marginBottom: "20px" }}>
				<Toolbar>
					<IconButton
						component={Link}
						to="/"
						size="large"
						edge="start"
						color="inherit"
						aria-label="school"
						sx={{ mr: 2 }}>
						<LocalAirportIcon />
					</IconButton>
					<Typography variant="h6" component="div" sx={{ mr: 5 }}>
						Travel Agency management
					</Typography>
					<Button
						variant={path.startsWith("/travel") ? "outlined" : "text"}
						to="/travel"
						component={Link}
						color="inherit"
						sx={{ mr: 5 }}
						startIcon={<TravelExploreIcon />}>
						Travel Agencies
					</Button>

					<Button
                            variant={path.startsWith("/travel") ? "outlined": "text"}
                            to="/travel/filter"
                            component={Link}
                            color="inherit"
                            sx={{ mr: 5 }}
                            startIcon={<TravelExploreIcon />}>
                                Travel agencies that have more than 100 employees
                            </Button>
				</Toolbar>
			</AppBar>
		</Box>
	);
};