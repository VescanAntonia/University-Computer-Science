package com.example.citybreak.converter;
import com.example.citybreak.dto.CityBreakDTO;
import com.example.citybreak.model.CityBreak;
import org.springframework.stereotype.Component;

import java.util.Collection;
import java.util.Set;
import java.util.stream.Collectors;


@Component
public class CityBreakConverter implements Converter<CityBreak, CityBreakDTO>{

    public Set<Long> convertModelsToIDs(Set<CityBreak> models) {
        return models.stream()
                .map(model -> model.getId())
                .collect(Collectors.toSet());
    }

    public Set<Long> convertDTOsToIDs(Set<CityBreakDTO> dtos) {
        return dtos.stream()
                .map(dto -> dto.getId())
                .collect(Collectors.toSet());
    }

    public Set<CityBreakDTO> convertModelsToDtos(Collection<CityBreak> models) {
        return models.stream()
                .map(model -> convertModelToDto(model))
                .collect(Collectors.toSet());
    }

    public Set<CityBreak> convertDtosToModels(Collection<CityBreakDTO> dtos) {
        return dtos.stream()
                .map(this::convertDtoToModel)
                .collect(Collectors.toSet());
    }

    @Override
    public CityBreak convertDtoToModel(CityBreakDTO cityBreakDTO) {
        CityBreak cityBreak = new CityBreak(cityBreakDTO.getId(), cityBreakDTO.getCity(), cityBreakDTO.getCountry(), cityBreakDTO.getStartDate(), cityBreakDTO.getEndDate(), cityBreakDTO.getDescription(),cityBreakDTO.getAccommodation(),cityBreakDTO.getBudget());

        return cityBreak;
    }

    @Override
    public CityBreakDTO convertModelToDto(CityBreak cityBreak) {
        CityBreakDTO dto = new CityBreakDTO(cityBreak.getId(), cityBreak.getCity(), cityBreak.getCountry(), cityBreak.getStartDate(), cityBreak.getEndDate(), cityBreak.getDescription(),cityBreak.getAccommodation(),cityBreak.getBudget());

        return dto;
    }
}
