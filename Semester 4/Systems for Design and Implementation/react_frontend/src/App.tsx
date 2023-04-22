import { useState } from "react";
import CssBaseline from "@mui/material/CssBaseline";
import Box from "@mui/material/Box";
import Container from "@mui/material/Container";
import * as React from "react";
import { AppBar, Toolbar, IconButton, Typography, Button } from "@mui/material";
import MenuIcon from "@mui/icons-material/Menu";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import { AppHome } from "./components/AppHome";
import { AppMenu } from "./components/AppMenu";
import { TravelAgenciesShowAll } from "./components/travelAgencies/AllAgencies";
import { TravelAgencyDetails } from "./components/travelAgencies/AgencyDetails";
import { TravelAgencyDelete } from "./components/travelAgencies/AgencyDelete";
import { TravelAgencyAdd } from "./components/travelAgencies/AgencyAdd";
import { TravelAgencyUpdate } from "./components/travelAgencies/TravelAgencyUpdate";
import { TravelAgenciesShowEmployeesMoreThan100 } from "./components/travelAgencies/AgencyShowEmployeesMoreThan100";
function App() {
	const [count, setCount] = useState(0);
	return (
		<React.Fragment>
			<Router>
				<AppMenu />

				<Routes>
					<Route path="/" element={<AppHome />} />
					<Route path="/travel/" element={<TravelAgenciesShowAll />} />
					<Route path="/travel/:travelAgencyId" element={<TravelAgencyDetails />} />
					<Route path="/travel/:travelAgencyId/edit" element={<TravelAgencyUpdate />} />
					<Route path="/travel/:travelAgencyId/delete" element={<TravelAgencyDelete />} />
					<Route path="/travel/add" element={<TravelAgencyAdd />} />
					<Route path="/travel/filter" element={<TravelAgenciesShowEmployeesMoreThan100 />} />
				</Routes>
			</Router>
		</React.Fragment>
	);
}

export default App;
